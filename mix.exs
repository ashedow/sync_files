defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "0.1.0",
      elixir: "~> 1.10",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      docs: docs(),
      deps: deps(),
      escript: escript(),
      aliases: aliases(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ssh],
      mod: {App.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:file_system, "~> 0.2"},
      {:httpoison, "~> 0.13"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
    ]
  end

  @doc """
  Run as CLI
  """
  defp escript do
    [main_module: App.CLI]
  end

  @doc """
  Define aliases for run app, tests, tests for child app
  """
  def aliases do
    [
      # like mix child_app_name_test test/child_app_name_test.exs
      child_app_name_test: "cmd --app child_app_name mix test --color"
    ]

end
