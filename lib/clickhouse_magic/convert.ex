defmodule ClickhouseMagic.Convert do
  def convert_all(table_function, column_function, format_function) do
    case table_function.() do
      {:ok, tables} ->
        Enum.reduce_while(tables, {:ok, []}, fn table_name, {:ok, acc} ->
          case column_function.(table_name) do
            {:ok, columns} ->
              {:cont, {:ok, [{table_name, format_function.(table_name, columns)} | acc]}}

            {:error, error} ->
              {:halt, {:error, error}}
          end
        end)

      error ->
        error
    end
  end

  def format_mysql_to_postgres(table_name, mysql_columns_info) do
    sorted_columns = Enum.sort_by(mysql_columns_info, & &1["ORDINAL_POSITION"])

    mapped_columns =
      Enum.map_join(sorted_columns, ",\n  ", &__MODULE__.MySql.format_to_postgres_sql/1)

    "CREATE TABLE #{table_name} (\n  #{mapped_columns}\n)"
  end

  def format_mysql_to_clickhouse(table_name, mysql_columns_info) do
    sorted_columns = Enum.sort_by(mysql_columns_info, & &1["ORDINAL_POSITION"])

    mapped_columns =
      Enum.map_join(sorted_columns, ",\n  ", &__MODULE__.MySql.format_to_clickhouse_sql/1)

    "CREATE TABLE #{table_name} (\n  #{mapped_columns}\n)"
  end
end
