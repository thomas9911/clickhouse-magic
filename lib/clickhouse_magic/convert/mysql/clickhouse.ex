defmodule ClickhouseMagic.Convert.MySql.Clickhouse do
  def format_to_sql(%{"DATA_TYPE" => "int", "COLUMN_NAME" => column_name}) do
    "#{column_name} Int256"
  end

  def format_to_sql(%{
        "DATA_TYPE" => "varchar",
        "COLUMN_NAME" => column_name
      }) do
    "#{column_name} String"
  end

  def format_to_sql(%{"DATA_TYPE" => "binary", "COLUMN_NAME" => column_name}) do
    "#{column_name} String"
  end

  def format_to_sql(%{"DATA_TYPE" => "text", "COLUMN_NAME" => column_name}) do
    "#{column_name} String"
  end

  def format_to_sql(%{"DATA_TYPE" => "timestamp", "COLUMN_NAME" => column_name}) do
    "#{column_name} DateTime64(3)"
  end

  def format_to_sql(%{"DATA_TYPE" => "datetime", "COLUMN_NAME" => column_name}) do
    "#{column_name} DateTime"
  end
end
