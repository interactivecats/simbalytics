defmodule Simbalytics.Web.Router do
  use Simbalytics.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Simbalytics.Web.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Simbalytics.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

  end

  scope "/app", Simbalytics.Web do
    pipe_through [:browser, :authenticate_user]

    get "/", PageController, :react_app
  end
end
