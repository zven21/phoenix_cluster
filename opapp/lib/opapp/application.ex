defmodule Opapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = [
      example: [
        strategy: Cluster.Strategy.Epmd,
        config: [hosts: [:"webapp@127.0.0.1", :"opapp@127.0.0.1"]],
      ]
    ]

    children = [
      # Start the Ecto repository
      Opapp.Repo,
      # Start the Telemetry supervisor
      OpappWeb.Telemetry,

      # Start the PubSub system
      {Phoenix.PubSub, name: Opapp.PubSub},
      # Start the Endpoint (http/https)
      OpappWeb.Endpoint,
      # Start a worker by calling: Opapp.Worker.start_link(arg)
      # {Opapp.Worker, arg}
      {Cluster.Supervisor, [topologies, [name: Webapp.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Opapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OpappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
