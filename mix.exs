defmodule Els.Mixfile do
  use Mix.Project

  def project do
    [
      app: :els,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Els.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      cowboy: "~> 1.0.1",
      httpoison: "~> 0.11.1",
      poison: "~> 3.1",
      gproc: "~> 0.5.0"
    ]
  end
end
