defmodule LineWebhook.Mixfile do
  use Mix.Project

  def project do
    [app: :line_webhook,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :cowboy, :plug],
     mod: {LineWebhook.Application, []}]
  end

  defp deps do
    [{:cowboy, "~> 1.1.2"},
     {:plug, "~> 1.3.4"}]
  end
end
