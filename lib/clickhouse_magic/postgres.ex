defmodule ClickhouseMagic.Postgres do
  def query(sql, params \\ []) do
    Postgrex.query(:postgrex, sql, params)
  end

  def execute(sql, params \\ []) do
    Postgrex.prepare_execute(:postgrex, "", sql, params)
  end
end
