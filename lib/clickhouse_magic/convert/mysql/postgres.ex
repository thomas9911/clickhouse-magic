defmodule ClickhouseMagic.Convert.MySql.Postgres do
  # out of scope: foreign keys, default functions

  @legacy_timestamp true

  def format_to_sql(%{"DATA_TYPE" => "int", "COLUMN_NAME" => column_name} = column) do
    "#{column_name} integer#{format_postfix(column)}"
  end

  def format_to_sql(
        %{
          "DATA_TYPE" => "varchar",
          "COLUMN_NAME" => column_name,
          "CHARACTER_MAXIMUM_LENGTH" => length
        } = column
      )
      when is_integer(length) do
    "#{column_name} varchar(#{length})#{format_postfix(column)}"
  end

  def format_to_sql(%{"DATA_TYPE" => "binary", "COLUMN_NAME" => column_name} = column) do
    "#{column_name} bytea#{format_postfix(column)}"
  end

  def format_to_sql(%{"DATA_TYPE" => "text", "COLUMN_NAME" => column_name} = column) do
    "#{column_name} text#{format_postfix(column)}"
  end

  def format_to_sql(%{"DATA_TYPE" => "timestamp", "COLUMN_NAME" => column_name} = column) do
    if @legacy_timestamp do
      "#{column_name} timestamp#{format_postfix(column)}"
    else
      "#{column_name} timestamptz#{format_postfix(column)}"
    end
  end

  def format_to_sql(%{"DATA_TYPE" => "datetime", "COLUMN_NAME" => column_name} = column) do
    "#{column_name} timestamp#{format_postfix(column)}"
  end

  defp format_postfix(%{"COLUMN_KEY" => "PRI"}), do: " primary key"

  defp format_postfix(%{"COLUMN_KEY" => "UNI"} = x) do
    format_postfix(Map.delete(x, "COLUMN_KEY")) <> " UNIQUE"
  end

  defp format_postfix(%{"IS_NULLABLE" => "NO"}), do: " NOT NULL"
  defp format_postfix(_), do: ""
end
