use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :simbalytics_web, Simbalytics.Web.Endpoint,
  http: [port: 4001],
  server: false

config :guardian, Guardian,
  secret_key: "1G35olcy7lVTGikH4xYbh75aSeIFWx1+npkHLvM34g+XjsZM7HbMEP7jk5QDr7P9"
