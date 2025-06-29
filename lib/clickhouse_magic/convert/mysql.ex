defmodule ClickhouseMagic.Convert.MySql do
  defdelegate format_to_postgres_sql(column_info), to: __MODULE__.Postgres, as: :format_to_sql
  defdelegate format_to_clickhouse_sql(column_info), to: __MODULE__.Clickhouse, as: :format_to_sql
end
