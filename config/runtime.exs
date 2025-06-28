import Config
import Dotenvy

source!([
  ".env",
  System.get_env()
])

config :clickhouse_magic,
  start_db_pools: true,
  postgres_user: env!("POSTGRES_USER"),
  postgres_password: env!("POSTGRES_PASSWORD"),
  postgres_db: env!("POSTGRES_DB"),
  clickhouse_db: env!("CLICKHOUSE_DB"),
  clickhouse_user: env!("CLICKHOUSE_USER"),
  clickhouse_password: env!("CLICKHOUSE_PASSWORD"),
  clickhouse_connection_string: "http://#{env!("CLICKHOUSE_USER")}:#{env!("CLICKHOUSE_PASSWORD")}@localhost:8123/#{env!("CLICKHOUSE_DB")}",
  mysql_database: env!("MYSQL_DATABASE"),
  mysql_user: env!("MYSQL_USER"),
  mysql_password: env!("MYSQL_PASSWORD"),
  mysql_root_password: env!("MYSQL_ROOT_PASSWORD")
