defmodule ClickhouseMagic do
  @moduledoc """
  Documentation for `ClickhouseMagic`.
  """

  def print_mysql_tables_as_postgres_tables do
    ClickhouseMagic.Convert.convert_all(
      &ClickhouseMagic.MySql.get_tables/0,
      &ClickhouseMagic.MySql.get_columns/1,
      &ClickhouseMagic.Convert.format_mysql_to_postgres/2
    )
  end

  def print_mysql_tables_as_clickhouse_tables(table_postfix \\ "") do
    ClickhouseMagic.Convert.convert_all(
      &ClickhouseMagic.MySql.get_tables/0,
      &ClickhouseMagic.MySql.get_columns/1,
      &ClickhouseMagic.Convert.format_mysql_to_clickhouse(&1 <> table_postfix, &2)
    )
  end
end
