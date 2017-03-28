defmodule PgExtrasTest do
  use PgExtras.TestCase
  doctest PgExtras

  import Ecto.Query
  import PgExtras

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
end
