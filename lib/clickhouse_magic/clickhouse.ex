defmodule ClickhouseMagic.ClickHouse do
  use Pillar,
    connection_strings: [
      Application.get_env(:clickhouse_magic, :clickhouse_connection_string, ""),
    ],
    name: __MODULE__,
    pool_size: 15
end
