use Mix.Config

config :simbalytics, ecto_repos: [Simbalytics.Repo]

import_config "#{Mix.env}.exs"
