defmodule PgExtras do
  import Ecto.Query
  @moduledoc """
  Documentation for PgExtras.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PgExtras.hello
      :world

  """
  # def hello do
  #   :world
  # end

  @doc """
  Use SQL's coalesce function to return the first argument that is not null.
  """
  defmacro coalesce(left, right) do
    quote do
      fragment("coalesce(?, ?)", unquote(left), unquote(right))
    end
  end
end
