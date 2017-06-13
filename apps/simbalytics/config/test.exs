use Mix.Config

# Configure your database
config :simbalytics, Simbalytics.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "simbalytics_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
