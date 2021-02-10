# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_mon,
  ecto_repos: [ExMon.Repo]

# Configures the endpoint
config :ex_mon, ExMonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Mwd8K5Yaczhxb89q9RiaJMTZQmL4fAxYLh0MQf69H6BQoHMepMEeggcrkIF8E6M4",
  render_errors: [view: ExMonWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExMon.PubSub,
  live_view: [signing_salt: "Lvh7c9fV"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ex_mon, ExMonWeb.Auth.Guardian,
  issuer: "ex_mon",
  secret_key: "665k1xyNGifgI//19Cx2Wwyy/YzgPtBj4Lm9USsm+AoJaEBGcooT6ItFjVQ7HNEy"

config :ex_mon, ExMonWeb.Auth.Pipeline,
  module: ExMonWeb.Auth.Guardian,
  error_handler: ExMonWeb.Auth.ErrorHandler
