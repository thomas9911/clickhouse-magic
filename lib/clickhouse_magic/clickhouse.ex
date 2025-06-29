defmodule ClickhouseMagic.ClickHouse do
  use Pillar,
    connection_strings: [
      Application.get_env(:clickhouse_magic, :clickhouse_connection_string, "")
    ],
    name: __MODULE__,
    pool_size: 15

  @mysql_table_postfix "_mysql"
  @postgres_table_postfix "_postgres"

  def connect_mysql_postgres do
    # instead of doing this, it is also possible to use table functions:
    # https://clickhouse.com/docs/sql-reference/table-functions/mysql
    # https://clickhouse.com/docs/sql-reference/table-functions/postgresql

    {:ok, mysql_tables} =
      ClickhouseMagic.print_mysql_tables_as_clickhouse_tables(@mysql_table_postfix)

    {:ok, postgres_tables} =
      ClickhouseMagic.print_mysql_tables_as_clickhouse_tables(@postgres_table_postfix)

    mysql_tables = Enum.map(mysql_tables, &append_engine_mysql/1)
    postgres_tables = Enum.map(postgres_tables, &append_engine_postgres/1)

    to_create = Enum.concat(mysql_tables, postgres_tables)

    Enum.map(to_create, &query/1)
  end

  def migrate_mysql_to_postgres do
    {:ok, mysql_tables} = ClickhouseMagic.MySql.get_tables()
    {:ok, postgres_tables} = ClickhouseMagic.Postgres.get_tables()

    mysql_tables = Map.new(mysql_tables, &{&1, &1 <> @mysql_table_postfix})
    postgres_tables = Map.new(postgres_tables, &{&1, &1 <> @postgres_table_postfix})

    inserts =
      mysql_tables
      |> Enum.sort()
      |> Enum.map(fn {table_name, mysql_table_name} ->
        postgres_table_name = Map.fetch!(postgres_tables, table_name)

        """
        insert into #{postgres_table_name} select * from #{mysql_table_name};
        """
      end)

    Enum.map(inserts, &query/1)
  end

  defp append_engine_mysql({table_name, table_create}) do
    mysql_location = "mysql:3306"
    mysql_database = Application.fetch_env!(:clickhouse_magic, :mysql_database)
    mysql_user = Application.fetch_env!(:clickhouse_magic, :mysql_user)
    mysql_password = Application.fetch_env!(:clickhouse_magic, :mysql_password)

    engine_settings = """

    ENGINE = MySQL('#{mysql_location}', '#{mysql_database}', '#{table_name}', '#{mysql_user}', '#{mysql_password}');
    """

    table_create <> engine_settings
  end

  defp append_engine_postgres({table_name, table_create}) do
    postgres_location = "postgres:5432"
    postgres_db = Application.fetch_env!(:clickhouse_magic, :postgres_db)
    postgres_user = Application.fetch_env!(:clickhouse_magic, :postgres_user)
    postgres_password = Application.fetch_env!(:clickhouse_magic, :postgres_password)

    engine_settings = """

    ENGINE = PostgreSQL('#{postgres_location}', '#{postgres_db}', '#{table_name}', '#{postgres_user}', '#{postgres_password}');
    """

    table_create <> engine_settings
  end
end
