defmodule EctoPgExtras do
  @moduledoc """
  A collection of custom functions for PostgreSQL features in Ecto
  """

  @doc """
  PostgreSQL's `coalesce` function

  Use `coalesce/2` to return the first argument that is not null.

  ```
  from(posts in "posts",
  select: {
    posts.title,
    coalesce(posts.short_description, posts.description)
  })
  ```

  """
  defmacro coalesce(left, right) do
    quote do
      fragment("coalesce(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  PostgreSQL's `coalesce` function

  Use `coalesce/1` to return the first value in the given list that is not
  null.

  ```
  from(posts in "posts",
  select: {
    posts.title,
    coalesce([posts.short_description, posts.description, "N/A"])
  })
  ```

  """
  defmacro coalesce(operands) do
    fragment_str = "coalesce(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  @doc """
  PostgreSQL's `nullif` function

  Use `nullif/2` to return null if the two arguments are equal.

  ```
  from(posts in "posts",
  select: nullif(posts.description, ""))
  ```

  This is a peculiar function, but can be handy in combination with other
  functions. For example, use it within `coalesce/1` to weed out a blank
  value and replace it with some default.

  ```
  from(posts in "posts",
  select: {
    posts.title,
    coalesce(nullif(posts.description, ""), "N/A")
  })
  ```

  """
  defmacro nullif(left, right) do
    quote do
      fragment("nullif(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  PostgreSQL's `greatest` function

  Use `greatest/2` to return the larger of two arguments. This function will
  always preference actual values over null.

  ```
  from(posts in "posts",
  select: greatest(posts.created_at, posts.published_at))
  ```
  """
  defmacro greatest(left, right) do
    quote do
      fragment("greatest(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  PostgreSQL's `greatest` function

  Use `greatest/1` to return the largest of a list of arguments. This
  function will always preference actual values over null.

  ```
  from(posts in "posts",
  select: greatest([
                     posts.created_at,
                     posts.updated_at,
                     posts.published_at
                   ]))
  ```

  """
  defmacro greatest(operands) do
    fragment_str = "greatest(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  @doc """
  PostgreSQL's `least` function

  Use `least/2` to return the smaller of the two arguments. This function
  always preferences actual values over null.

  ```
  from(posts in "posts",
  select: least(posts.created_at, posts.updated_at))
  ```

  """
  defmacro least(left, right) do
    quote do
      fragment("least(?, ?)", unquote(left), unquote(right))
    end
  end

  @doc """
  PostgreSQL's `least` function

  Use `least/1` to return the smallest of the arguments. This function
  always preferences actual values over null.

  ```
  from(posts in "posts",
  select: least([
                  posts.created_at,
                  posts.updated_at,
                  posts.published_at
                ]))
  ```

  """
  defmacro least(operands) do
    fragment_str = "least(" <> generate_question_marks(operands) <> ")"
    {:fragment, [], [fragment_str | operands]}
  end

  @doc """
  PostgreSQL's `lower` function

  Use `lower/1` to lowercase a given string. This works like Elixir's
  `String.downcase/1` function allowing string manipulation within a query.

  ```
  from(users in "users",
  select: lower(users.email))
  ```

  """
  defmacro lower(operand) do
    quote do
      fragment("lower(?)", unquote(operand))
    end
  end

  @doc """
  PostgreSQL's `upper` function

  Use `upper/1` to uppercase a given string. This works like Elixir's
  `String.upcase/1` function allowing string manipulation within a query.

  ```
  from(users in "users",
  select: upper(users.username))
  ```

  """
  defmacro upper(operand) do
    quote do
      fragment("upper(?)", unquote(operand))
    end
  end

  @doc """
  PostgreSQL's `between` predicate

  Use `between/3` to perform a range test for the first argument against the
  second (lower bound) and third argument (upper bound). Returns true if the
  value falls in the given range. False otherwise.

  ```
  from(posts in "posts",
  select: {posts.title, posts.description}
  where: between(posts.published_at,
                 ^Ecto.DateTime.cast!({{2016,5,10},{0,0,0}}),
                 ^Ecto.DateTime.cast!({{2016,5,20},{0,0,0}})))
  ```

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
  PostgreSQL's `not between` predicate

  Use `not_between/3` to perform a range test for the first argument against
  the second (lower bound) and third argument (upper bound). Returns true if
  the value does not fall in the given range. False otherwise.

  ```
  from(posts in "posts",
  select: {posts.title, posts.description}
  where: not_between(posts.published_at,
                     ^Ecto.DateTime.cast!({{2016,5,10},{0,0,0}}),
                     ^Ecto.DateTime.cast!({{2016,5,20},{0,0,0}})))
  ```

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
