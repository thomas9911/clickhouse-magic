defmodule Mix.Tasks.RollbackClickhouse do
  use Mix.Task

  @shortdoc "Rollback one migrations"

  def run(_args) do
    # Start any necessary applications
    Application.ensure_all_started(:pillar)
    Application.ensure_all_started(:clickhouse_magic)
    Mix.Tasks.App.Config.run([])

    clickhouse_connection_string = Application.fetch_env!(:clickhouse_magic, :clickhouse_connection_string)

    # Get connection details from your application config
    conn = Pillar.Connection.new(clickhouse_connection_string)

    # Run the migrations
    Pillar.Migrations.rollback(conn)
    |> Enum.each(fn file ->
      Mix.shell().info("rollback #{file}")
    end)
  end
end
