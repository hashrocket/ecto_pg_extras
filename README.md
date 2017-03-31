# ecto_pg_extras

> A collection of custom functions for PostgreSQL features in Ecto

```elixir
def deps do
  [{:ecto_pg_extras, "~> 0.1.0"}]
end
```

PostgreSQL has quite a variety of useful querying constructs that are not
readily available within Ecto's DSL. For example, doing a range check in a
Postgres query can be rather elegantly accomplished with the `between`
construct:

```sql
select title, description from posts
where published_at between
  now() - '90 days'::interval and
  now() - '30 days'::interval
;
```

Achieving the same result using the Ecto querying DSL would require a query
looking something like the following:

```elixir
from(posts in "posts",
select: {posts.title, posts.description},
where: fragment("now() - '90 days'::interval < ?", posts.published_at)
where: fragment("now() - '30 days'::interval > ?", posts.published_at))
```

What if we could ...

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
