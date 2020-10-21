# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :opapp,
  ecto_repos: [Opapp.Repo]

# Configures the endpoint
config :opapp, OpappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kLq7P/KOudBvrI0xYzy4yV2Pu1RwdxVsyMX1AfiYM/B8MOUmZNw/EJHJmtvW/HJ0",
  render_errors: [view: OpappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Opapp.PubSub,
  live_view: [signing_salt: "QOINHmPJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
