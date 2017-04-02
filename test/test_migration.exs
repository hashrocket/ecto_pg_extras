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

    execute """
      insert into buckets (a,b,c)
      values
        (1, 2, 3),
        (null, 2, 3),
        (null, null, 3),
        (null, null, null),
        (null, 2, null);
    """

    execute """
      create table persons(
        id serial primary key,
        first_name varchar,
        last_name varchar,
        email varchar not null
      );
    """

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

    execute """
      create table posts(
        id serial primary key,
        title varchar not null,
        description text,
        short_description text,
        created_at timestamp not null default now(),
        updated_at timestamp not null default now(),
        published_at timestamp
      );
    """

    execute """
      insert into posts
      (
        title,
        description,
        short_description,
        created_at,
        updated_at,
        published_at
      )
      values
      (
        'Post 1',
        null,
        'The first of many posts',
        '2016-05-05 00:00:00'::timestamp,
        '2016-05-05 00:00:00'::timestamp,
        '2016-05-15 00:00:00'::timestamp
      ),
      (
        'Post 2',
        'This is a longer description of the post',
        'A brief description',
        '2016-05-06 00:00:00'::timestamp,
        '2016-05-06 00:00:00'::timestamp,
        '2016-05-08 00:00:00'::timestamp
      );
    """
  end

  def down do
    execute """
      drop table buckets, persons, posts;
    """
  end
end
