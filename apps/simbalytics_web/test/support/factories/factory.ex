defmodule Simbalytics.Web.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Simbalytics.Repo


  def user_factory do
    %Simbalytics.Accounts.User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "1234567",
      password_hash: Comeonin.Bcrypt.hashpwsalt("1234567")
    }
  end
end
