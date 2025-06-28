defmodule ClickhouseMagic.MixProject do
  use Mix.Project

  def project do
    [
      app: :clickhouse_magic,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ClickhouseMagic.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:myxql, ">= 0.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:pillar, ">= 0.0.0"},
      {:tzdata, "~> 1.1"},
      {:dotenvy, "~> 1.0.0"}
    ]
  end
end
