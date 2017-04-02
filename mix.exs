defmodule EctoPgExtras.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ecto_pg_extras,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:postgrex, "~> 0.13.0"},
      {:ecto, "~> 2.1"},
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end

  defp description do
    """
    A collection of custom functions for PostgreSQL features in Ecto.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Josh Branchaud", "Hashrocket"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/hashrocket/ecto_pg_extras"
      }
    ]
  end
end
