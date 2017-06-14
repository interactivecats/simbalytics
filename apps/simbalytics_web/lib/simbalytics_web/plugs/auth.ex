defmodule Simbalytics.Web.Auth do
  @moduledoc """
  A plug to add, remove and/or check for user session details
  """
    import Plug.Conn
    import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    alias Simbalytics.Accounts

    def init(default), do: default

    def call(conn, _default) do
        user_id = get_session(conn, :user_id)

        cond do
            user = conn.assigns[:current_user] -> put_current_user(conn, user)
            user = user_id && Accounts.get_user(user_id) -> put_current_user(conn, user)
            true -> assign(conn, :current_user, nil)
        end
    end

    def login(conn, user) do
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
    end

    def login_by_email_and_pass(conn, email, pass) do
      user = Accounts.get_user_by_email(email)

      cond do
        user && checkpw(pass, user.password_hash) ->
          {:ok, login(conn, user)}
        user ->
            {:error, :not_found, conn}
        true ->
            dummy_checkpw()
            {:error, :not_found, conn}
      end
    end

    def logout(conn) do
        configure_session(conn, drop: true)
    end

    defp put_current_user(conn, user) do
        new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
        jwt = Guardian.Plug.current_token(new_conn)

        conn
        |> assign(:current_user, user)
        |> assign(:user_token, jwt)
    end

    import Phoenix.Controller
    alias Simbalytics.Web.Router.Helpers

    def authenticate_user(conn, _opts) do
        if conn.assigns.current_user do
            conn
        else
            conn
            |> put_flash(:error, "You must be logged in to access that page")
            |> redirect(to: Helpers.page_path(conn, :index))
            |> halt()
        end
    end

end
