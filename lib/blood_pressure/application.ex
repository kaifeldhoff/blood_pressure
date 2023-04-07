defmodule BloodPressure.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BloodPressureWeb.Telemetry,
      # Start the Ecto repository
      BloodPressure.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BloodPressure.PubSub},
      # Start the Endpoint (http/https)
      BloodPressureWeb.Endpoint
      # Start a worker by calling: BloodPressure.Worker.start_link(arg)
      # {BloodPressure.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BloodPressure.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BloodPressureWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
