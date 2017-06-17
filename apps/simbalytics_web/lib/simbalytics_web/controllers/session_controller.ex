defmodule Simbalytics.Web.SessionController do
  use Simbalytics.Web, :controller

   @doc """
    Login page with email form.
  """
  def new(conn, _params) do
    render(conn, "new.html")
  end

  @doc """
    Generates and sends magic login token if the user can be found.
  """

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Simbalytics.Web.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} -> conn
        |> redirect(to: page_path(conn, :react_app))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password")
        |> render("new.html")
    end
    #case TokenAuthentication.provide_token(email) do
    #  {:ok, user} ->
  #      conn
  #      |> put_flash(:info, "We have sent you a link for signing in via email to #{email}.")
  #      |> redirect(to: page_path(conn, :index))
  #    {:error, :not_found} ->
  #      conn
  #      |> put_flash(:login_error, "No account found with that email address")
  #      |> redirect(to: session_path(conn, :new))
  #  end
  end


  @doc """
    Ends the current session.
  """

  def delete(conn, _) do
    conn
    |> Simbalytics.Web.Auth.logout()
    |> put_flash(:info, "You logged out successfully. Enjoy your day!")
    |> redirect(to: page_path(conn, :index))
  end
end
