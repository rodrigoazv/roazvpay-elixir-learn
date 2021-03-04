defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User
  alias Rocketpay.Guardian

  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user)do
      conn
      |> put_status(:created)
      |> render("jwt.json", token: token)
    end
  end

  def upload_image(conn, %{"upload" => %Plug.Upload{} = upload}) do
    conn
    |> put_status(:ok)
    |> render("upload.json", upload: "Ok")
  end
  def sign_in(conn, params) do
    with {:ok, token, _claims} <- Rocketpay.sign_in(params) do
      conn
        |> put_status(:created)
        |> render("jwt.json", token: token)
    end
    #put_resp_cookie(conn, "my-cookie", "%{user_id: user.id}", sign: true)
  end

end
