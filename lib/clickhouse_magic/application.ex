defmodule ClickhouseMagic.Application do
  use Application

  def start(_type, _args) do
    children = [] ++ db_pools(Application.get_env(:clickhouse_magic, :start_db_pools, false))

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp db_pools(true) do
    [
      {MyXQL, mysql_config()},
      {Postgrex, postgres_config()},
      {ClickhouseMagic.ClickHouse, []}
    ]
  end

  defp db_pools(false), do: []

  defp mysql_config do
    [
      name: :myxql,
      hostname: "localhost",
      database: Application.fetch_env!(:clickhouse_magic, :mysql_database),
      username: Application.fetch_env!(:clickhouse_magic, :mysql_user),
      password: Application.fetch_env!(:clickhouse_magic, :mysql_password)
    ]
  end

  defp postgres_config do
    [
      name: :postgrex,
      hostname: "localhost",
      database: Application.fetch_env!(:clickhouse_magic, :postgres_db),
      username: Application.fetch_env!(:clickhouse_magic, :postgres_user),
      password: Application.fetch_env!(:clickhouse_magic, :postgres_password),
      pool: DBConnection.ConnectionPool2
    ]
  end
end
