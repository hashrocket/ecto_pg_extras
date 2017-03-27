# pg_extras

```elixir
def deps do
  [{:pg_extras, "~> 0.1.0"}]
end
```

## Usage

Import `pg_extras` in any module where you want access to the custom
functions for use with Ecto queries.

```elixir
import PgExtras
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
