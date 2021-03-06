defmodule EctoPgExtrasTest do
  use EctoPgExtras.TestCase
  doctest EctoPgExtras

  import Ecto.Query
  import EctoPgExtras

  alias Ecto.Integration.TestRepo

  test "coalesce two values" do
    results =
      from(buckets in "buckets",
      select: coalesce(buckets.a, buckets.b))
      |> TestRepo.all

    assert results == [1, 2, nil, nil, 2]
  end

  test "coalesce a list of values" do
    results =
      from(buckets in "buckets",
      select: coalesce([buckets.a, buckets.b, buckets.c]))
      |> TestRepo.all

    assert results == [1, 2, 3, nil, 2]
  end

  test "nullif two values" do
    results =
      from(buckets in "buckets",
      where: buckets.id == 1,
      select: {
        nullif(buckets.a, 2),
        nullif(buckets.b, 2),
        nullif(buckets.c, 2)
      })
      |> TestRepo.all

    assert results == [{1, nil, 3}]
  end

  test "greatest of two values" do
    results =
      from(buckets in "buckets",
      select: {
        greatest(buckets.a, buckets.b),
        greatest(buckets.b, buckets.c)
      })
      |> TestRepo.all

    assert results == [
      {2, 3},
      {2, 3},
      {nil, 3},
      {nil, nil},
      {2, 2}
    ]
  end

  test "greatest of a list of values" do
    results =
      from(buckets in "buckets",
      select: greatest([buckets.a, buckets.b, buckets.c]))
      |> TestRepo.all

    assert results == [3, 3, 3, nil, 2]
  end

  test "least of two values" do
    results =
      from(buckets in "buckets",
      select: {
        least(buckets.a, buckets.b),
        least(buckets.b, buckets.c)
      })
      |> TestRepo.all

    assert results == [
      {1, 2},
      {2, 2},
      {nil, 3},
      {nil, nil},
      {2, 2}
    ]
  end

  test "least of a list of values" do
    results =
      from(buckets in "buckets",
      select: least([buckets.a, buckets.b, buckets.c]))
      |> TestRepo.all

    assert results == [1, 2, 3, nil, 2]
  end

  test "lower a string" do
    results =
      from(persons in "persons",
      select: {
        lower(persons.first_name),
        lower(persons.last_name)
      })
      |> TestRepo.all

    assert results == [
      {"liz", "lemon"},
      {"tracy", "jordan"},
      {nil, nil},
      {"jack", "donaghy"},
      {"toofer", nil},
      {nil, "lutz"}
    ]
  end

  test "upper a string" do
    results =
      from(persons in "persons",
      select: {
        upper(persons.first_name),
        upper(persons.last_name)
      })
      |> TestRepo.all

    assert results == [
      {"LIZ", "LEMON"},
      {"TRACY", "JORDAN"},
      {nil, nil},
      {"JACK", "DONAGHY"},
      {"TOOFER", nil},
      {nil, "LUTZ"}
    ]
  end

  test "between two timestamps" do
    lower_timestamp = Ecto.DateTime.cast!({{2016,5,10},{0,0,0}})
    upper_timestamp = Ecto.DateTime.cast!({{2016,5,20},{0,0,0}})

    results =
      from(posts in "posts",
      where: between(posts.published_at,
                     ^lower_timestamp,
                     ^upper_timestamp),
      select: posts.id
      )
      |> TestRepo.all()

    assert results == [1]
  end

  test "not between two timestamps" do
    lower_timestamp = Ecto.DateTime.cast!({{2016,5,10},{0,0,0}})
    upper_timestamp = Ecto.DateTime.cast!({{2016,5,20},{0,0,0}})

    results =
      from(posts in "posts",
      where: not_between(posts.published_at,
                         ^lower_timestamp,
                         ^upper_timestamp),
      select: posts.id
      )
      |> TestRepo.all()

    assert results == [2]
  end
end
