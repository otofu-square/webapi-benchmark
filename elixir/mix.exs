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
    [extra_applications: [:logger, :trot]]
  end

  defp deps do
    [{:trot, github: "hexedpackets/trot"}]
  end
end