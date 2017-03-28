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

    flush()

    execute """
      create table persons(
        id serial primary key,
        first_name varchar,
        last_name varchar,
        email varchar not null
      );
    """

    flush()

    execute """
      insert into persons (first_name, last_name, email)
      values
        ('Liz', 'Lemon', 'liz.lemon@nbc.com'),
        ('Tracy', 'Jordan', 'tracy.jordan@nbc.com'),
        (null, null, 'kenneth.parcell@nbc.com'),
        ('Jack', 'Donaghy', 'jack.donaghy@nbc.com'),
        ('Toofer', null, 'toofer.spurlock@nbc.com'),
        (null, 'Lutz', 'johnny.aardvark@nbc.com')
      ;
    """
  end

  def down do
    execute """
      drop table buckets, persons;
    """
  end
end
