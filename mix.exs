defmodule TravelClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :travel_client,
      version: "0.1.0",
      escript: escript_config(),
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :timex]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      httpoison: "~> 0.10.0",
      poison: "~> 3.0",
      timex: "~> 3.0",
      tzdata: "~> 0.1.8"
    ]
  end

  defp escript_config do
    [ main_module: TravelClient.CLI ]
  end
end
