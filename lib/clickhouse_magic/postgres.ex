defmodule ClickhouseMagic.Postgres do
  def query(sql, params \\ []) do
    Postgrex.query(:postgrex, sql, params)
  end

  def execute(sql, params \\ []) do
    Postgrex.prepare_execute(:postgrex, "", sql, params)
  end

  def get_tables do
    case query("select tablename from pg_catalog.pg_tables where schemaname='public'") do
      {:ok, %{rows: rows}} -> {:ok, List.flatten(rows)}
      error -> error
    end
  end

  def create_mysql_tables do
    {:ok, tables} = ClickhouseMagic.print_mysql_tables_as_postgres_tables()

    tables |> Enum.map(&elem(&1, 1)) |> Enum.map(&query/1)
  end
end
