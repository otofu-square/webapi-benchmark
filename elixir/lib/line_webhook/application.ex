defmodule LineWebhook.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, LineWebhook, [], [port: 4000])
    ]

    opts = [strategy: :one_for_one, name: LineWebhook.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
