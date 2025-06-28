defmodule ClickhouseMagic.MySql do
  def query(sql, params \\ []) do
    MyXQL.query(:myxql, sql, params)
  end

  def execute(sql, params \\ []) do
    MyXQL.prepare_execute(:myxql, "", sql, params)
  end
end
