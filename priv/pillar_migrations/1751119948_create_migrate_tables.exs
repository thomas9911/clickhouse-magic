defmodule Pillar.Migrations.CreateMigrateTables do
  def up do
    mysql_database = Application.fetch_env!(:clickhouse_magic, :mysql_database)
    mysql_user = Application.fetch_env!(:clickhouse_magic, :mysql_user)
    mysql_password = Application.fetch_env!(:clickhouse_magic, :mysql_password)
    postgres_db = Application.fetch_env!(:clickhouse_magic, :postgres_db)
    postgres_user = Application.fetch_env!(:clickhouse_magic, :postgres_user)
    postgres_password = Application.fetch_env!(:clickhouse_magic, :postgres_password)

    [
      """
      CREATE TABLE my_database.table1_postgres
      (
          id UInt64,
          column1 String
      )
      ENGINE = PostgreSQL('postgres:5432', '#{postgres_db}', 'table1', '#{postgres_user}', '#{postgres_password}');
      """,
      """
      CREATE TABLE my_database.table1_mysql
      (
          id UInt64,
          column1 String
      )
      ENGINE = MySQL('mysql:3306', '#{mysql_database}', 'table1', '#{mysql_user}', '#{mysql_password}');
      """
    ]
  end

  def down do
    [
      "DROP TABLE my_database.table1_postgres",
      "DROP TABLE my_database.table1_mysql"
    ]
  end
end
