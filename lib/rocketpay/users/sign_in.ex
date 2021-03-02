defmodule Rocketpay.Users.Signin do
  alias Rocketpay.{Repo, User, Account}
  alias Rocketpay.Guardian

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} -> Guardian.encode_and_sign(user)
      _ -> {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
    do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email)do
      nil ->
        {:error, "User not found"}
      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    user
    |> Bcrypt.check_pass(password)
  end
end
