defmodule EctoPgExtras do
  import Ecto.Query
  @moduledoc """
  Documentation for EctoPgExtras.
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

  defmacro nullif(left, right) do
    quote do
      fragment("nullif(?, ?)", unquote(left), unquote(right))
    end
  end

  defmacro greatest(left, right) do
    quote do
      fragment("greatest(?, ?)", unquote(left), unquote(right))
    end
  end
  defmacro greatest(operands) do
    fragment_str = "greatest(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  defmacro least(left, right) do
    quote do
      fragment("least(?, ?)", unquote(left), unquote(right))
    end
  end
  defmacro least(operands) do
    fragment_str = "least(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  defmacro lower(operand) do
    quote do
      fragment("lower(?)", unquote(operand))
    end
  end

  defmacro upper(operand) do
    quote do
      fragment("upper(?)", unquote(operand))
    end
  end

  defp generate_question_marks(list) do
    list
    |> Enum.map(fn(_) -> "?" end)
    |> Enum.join(", ")
  end
end
