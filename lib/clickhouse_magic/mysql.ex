defmodule ClickhouseMagic.MySql do
  @column_fields [
    "COLUMN_NAME",
    "DATA_TYPE",
    "COLUMN_DEFAULT",
    "COLUMN_KEY",
    "IS_NULLABLE",
    "TABLE_NAME",
    "TABLE_SCHEMA",
    "CHARACTER_MAXIMUM_LENGTH",
    "NUMERIC_PRECISION",
    "NUMERIC_SCALE",
    "ORDINAL_POSITION"
  ]

  def query(sql, params \\ []) do
    MyXQL.query(:myxql, sql, params)
  end

  def execute(sql, params \\ []) do
    MyXQL.prepare_execute(:myxql, "", sql, params)
  end

  def get_tables do
    case query("show tables") do
      {:ok, %{rows: rows}} -> {:ok, List.flatten(rows)}
      error -> error
    end
  end

  def get_columns(table) do
    case query(
           "select #{Enum.join(@column_fields, ", ")} from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = ?",
           [table]
         ) do
      {:ok, result} -> {:ok, Enum.map(result.rows, &load_columns_result(result.columns, &1))}
      error -> error
    end
  end

  defp load_columns_result(columns, row) do
    columns
    |> Enum.zip(row)
    |> Map.new()
  end
end
