defmodule Elixir.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:cowboy, :plug]]
  end

  defp deps do
    [{:cowboy, "~> 1.1.2"},
     {:plug, "~> 1.3.4"}]  end
end
