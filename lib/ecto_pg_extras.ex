defmodule EctoPgExtras do
  @moduledoc """
  Documentation for EctoPgExtras.
  """

  @doc """
  Use SQL's coalesce function to return the first argument that is not null.
  This works with two arguments.
  """
  defmacro coalesce(left, right) do
    quote do
      fragment("coalesce(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  Use SQL's coalesce function to return the first argument that is not null.
  This works with a list of arguments.
  """
  defmacro coalesce(operands) do
    fragment_str = "coalesce(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  @doc """
  Use SQL's nullif function to return null if the two arguments are equal.
  """
  defmacro nullif(left, right) do
    quote do
      fragment("nullif(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  Use SQL's greatest function to return the larger of the two arguments.
  This works with two arguments.
  """
  defmacro greatest(left, right) do
    quote do
      fragment("greatest(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  Use SQL's greatest function to return the larger of the arguments.
  This works with a list of arguments.
  """
  defmacro greatest(operands) do
    fragment_str = "greatest(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  @doc """
  Use SQL's least function to return the smaller of the two arguments.
  This works with two arguments.
  """
  defmacro least(left, right) do
    quote do
      fragment("least(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  Use SQL's least function to return the smaller of the arguments.
  This works with a list of arguments.
  """
  defmacro least(operands) do
    fragment_str = "least(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  @doc """
  User SQL's lower function to lowercase a given string. This works like
  Elixir's `String.downcase/1` function allowing string manipulation within
  a query.
  """
  defmacro lower(operand) do
    quote do
      fragment("lower(?)", unquote(operand))
    end
  end

  @doc """
  User SQL's upper function to uppercase a given string. This works like
  Elixir's `String.upcase/1` function allowing string manipulation within
  a query.
  """
  defmacro upper(operand) do
    quote do
      fragment("upper(?)", unquote(operand))
    end
  end

  @doc """
  Use SQL's between predicate to perform a range test for the first argument
  against the second (lower bound) and third argument (upper bound). Returns
  true if the value falls in the given range. False otherwise.
  """
  defmacro between(value, lower, upper) do
    quote do
      fragment("? between ? and ?",
               unquote(value),
               unquote(lower),
               unquote(upper))
    end
  end

  @doc """
  Use SQL's not between predicate to perform a range test for the first
  argument against the second (lower bound) and third argument (upper
  bound). Returns true if the value does not fall in the given range. False
  otherwise.
  """
  defmacro not_between(value, lower, upper) do
    quote do
      fragment("? not between ? and ?",
               unquote(value),
               unquote(lower),
               unquote(upper))
    end
  end

  defp generate_question_marks(list) do
    list
    |> Enum.map(fn(_) -> "?" end)
    |> Enum.join(", ")
  end
end
