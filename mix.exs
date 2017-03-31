defmodule EctoPgExtras.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ecto_pg_extras,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:postgrex, "~> 0.13.0"},
      {:ecto, "~> 2.1"}
    ]
  end
end
