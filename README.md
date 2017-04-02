# ecto_pg_extras

> A collection of custom functions for PostgreSQL features in Ecto

```elixir
def deps do
  [{:ecto_pg_extras, "~> 0.1.0"}]
end
```

## Usage

Import `ecto_pg_extras` in any module where you want access to the custom
functions for use with Ecto queries.

```elixir
import EctoPgExtras
```

Then use any of the functions as part of a query as you would anything else
defined in `Ecto.Query.API`. For example, here is the `coalesce` function in
action:

```elixir
from(posts in Posts,
where: posts.id == 1,
select: {
  posts.title,
  coalesce(posts.description, posts.short_description, "N/A")
})
```

## About

[![Hashrocket logo](https://hashrocket.com/hashrocket_logo.svg)](https://hashrocket.com)

EctoPgExtras is supported by the team at [Hashrocket](https://hashrocket.com), a multidisciplinary design & development consultancy. If you'd like to [work with us](https://hashrocket.com/contact-us/hire-us) or [join our team](https://hashrocket.com/contact-us/jobs), don't hesitate to get in touch.
