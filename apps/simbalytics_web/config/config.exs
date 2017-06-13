# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :simbalytics_web,
  namespace: Simbalytics.Web,
  ecto_repos: [Simbalytics.Repo]

# Configures the endpoint
config :simbalytics_web, Simbalytics.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q5BS1YZkpNeaRN5qmOuTZ1tjkbIeUTpN3lcG1ffeEUtL0O3mt1+db2Ab5AmyEV6m",
  render_errors: [view: Simbalytics.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Simbalytics.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :simbalytics_web, :generators,
  context_app: :simbalytics

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
