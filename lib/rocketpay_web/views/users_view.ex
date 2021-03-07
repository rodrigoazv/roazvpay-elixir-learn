defmodule RocketpayWeb.UsersView do

  alias Rocketpay.User

  def render("create.json", %{user: %User{id: id, name: name, nickname: nickname}}) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname
      }
    }
  end

  def render("jwt.json", %{message: message}) do
    %{message: message}
  end

  def render("upload.json", %{upload: upload}) do
    %{upload: upload}
  end
end
