# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :webapp,
  ecto_repos: [Webapp.Repo]

# Configures the endpoint
config :webapp, WebappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0/ISb/etEEjCB/02qF3f1Q5d9v2MgxDqRGDsw7BYfcyjDcyN/4ynDeS49GijHyUF",
  render_errors: [view: WebappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Webapp.PubSub,
  live_view: [signing_salt: "hXvPyVLK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :webapp, :pow,
  user: Webapp.Users.User,
  repo: Webapp.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
