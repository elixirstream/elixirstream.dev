defmodule ElixirStream.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_stream,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {ElixirStream.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto_sql, "~> 3.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:guardian, "~> 2.0"},
      {:phoenix, "~> 1.5.7"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:phoenix_live_view, "~> 0.15.0"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:ueberauth, "~> 0.6"},
      {:ueberauth_github, "~> 0.7"},
      {:ueberauth_twitter, "~> 0.3"},
      # Test/Dev
      {:ex_machina, "~> 2.6.0", only: :test},
      {:floki, ">= 0.27.0", only: :test},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
