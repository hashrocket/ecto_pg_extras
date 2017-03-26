defmodule PgExtras do
  import Ecto.Query
  @moduledoc """
  Documentation for PgExtras.
  """

  @doc """
  Use SQL's coalesce function to return the first argument that is not null.
  """
  defmacro coalesce(left, right) do
    quote do
      fragment("coalesce(?, ?)", unquote(left), unquote(right))
    end
  end
end
