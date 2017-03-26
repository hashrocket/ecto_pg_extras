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
  defmacro coalesce(operands) do
    fragment_str = "coalesce(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  def generate_question_marks(list) do
    list
    |> Enum.map(fn(_) -> "?" end)
    |> Enum.join(", ")
  end
end
