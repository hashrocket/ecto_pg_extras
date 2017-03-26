defmodule TestMigration do
  use Ecto.Migration

  def up do
    execute """
      create table buckets (
        id serial primary key,
        a integer,
        b integer,
        c integer
      );
    """

    flush()

    execute """
      insert into buckets (a,b,c)
      values
        (1, 2, 3),
        (null, 2, 3),
        (null, null, 3),
        (null, null, null),
        (null, 2, null);
    """
  end

  def down do
    execute """
      drop table buckets;
    """
  end
end
