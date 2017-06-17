defmodule Simbalytics.Web.SessionControllerTest do
  use Simbalytics.Web.ConnCase

  alias Simbalytics.Accounts

  @user_attrs %{email: "dave@gmail.com", name: "Benjamin Cates", password: "some_password", password_hash: Comeonin.Bcrypt.hashpwsalt("some_password")}
  @valid_attrs %{email: "dave@gmail.com", password: "some_password"}
  @invalid_attrs_1 %{email: "ben@gmail.com", password: "some_password"}
  @invalid_attrs_2 %{email: "dave@gmail.com", password: "some_password_2"}

  setup %{conn: conn} = config do
    user = insert(:user, @user_attrs)
    {:ok, conn: conn, user: user}
  end

  test "logins user and redirects to show when data is valid", %{conn: conn, user: user} do
    conn = post conn, session_path(conn, :create), session: @valid_attrs
    assert redirected_to(conn) == page_path(conn, :auth)
    assert get_session(conn, :user_id) == user.id
  end

  test "does not login when invalid", %{conn: conn, user: user} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs_1
    assert html_response(conn, 200) =~ "Invalid email/password"
    refute get_session(conn, :user_id) == user.id

    conn = post conn, session_path(conn, :create), session: @invalid_attrs_2
    assert html_response(conn, 200) =~ "Invalid email/password"
    refute get_session(conn, :user_id) == user.id
  end

  test "Cannot access pages when not logged in", %{conn: conn, user: user} do
    conn = get conn, "/app"
    assert html_response(conn, 302)
    assert conn.halted
  end

  test "logouts user on delete", %{conn: conn, user: user} do
    conn = post conn, session_path(conn, :create), session: @valid_attrs
    assert get_session(conn, :user_id) == user.id
    conn = get conn, "/app"
    conn = delete conn, session_path(conn, :delete, user)
    conn = get conn, "/app"
    refute get_session(conn, :user_id) == user.id
  end
end
