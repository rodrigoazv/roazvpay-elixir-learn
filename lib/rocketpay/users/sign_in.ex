defmodule Rocketpay.Users.Signin do
  alias Rocketpay.{Repo, User}
  alias Rocketpay.Guardian

  def call(%{"email" => email, "password" => password}) do
    case email_password_auth(email, password) do
      {:ok, user} -> Guardian.encode_and_sign(user)
      {:error, reason} -> {:error, reason}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
    do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email)do
      nil ->
        {:error, :user_not_found}
      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

end
