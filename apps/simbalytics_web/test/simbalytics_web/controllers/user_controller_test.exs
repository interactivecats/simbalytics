defmodule Simbalytics.Web.UserControllerTest do
  use Simbalytics.Web.ConnCase

  alias Simbalytics.Accounts

  @create_attrs %{email: "dave@gmail.com", name: "some name", password: "some_password"}
  @invalid_attrs_1 %{email: nil, name: nil, password_hash: nil}
  @invalid_attrs_2 %{email: "ben", name: "some name", password: "some_password"}
  @invalid_attrs_3 %{email: "dave@gmail.com", name: "some name", password: "s"}

  def fixture(:user) do
    user = insert(:user, email: "dave@gmail.com")
    user
  end

  test "renders form for new users", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New User"
  end

  test "creates user and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @create_attrs
    assert redirected_to(conn) == session_path(conn, :new)

    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Login"
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs_1
    assert html_response(conn, 200) =~ "New User"
  end

  test "does not create user when email exists", %{conn: conn} do
    user_1 = fixture(:user)
    conn = post conn, user_path(conn, :create), user: @create_attrs
    assert html_response(conn, 200) =~ "has already been taken"
  end

  test "does not create user when password is too short", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs_3
    assert html_response(conn, 200) =~ "should be at least 6 character(s)"
  end

end
