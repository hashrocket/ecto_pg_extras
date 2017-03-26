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
end
