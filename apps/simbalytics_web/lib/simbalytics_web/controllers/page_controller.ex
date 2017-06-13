defmodule Simbalytics.Web.PageController do
  use Simbalytics.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
