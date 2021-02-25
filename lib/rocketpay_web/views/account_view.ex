defmodule RocketpayWeb.AccountView do

  alias Rocketpay.Account

  def render("update.json", %{account: %Account{balance: balance}}) do
    %{
      message: "Deposit sucessfully !",
      user: %{
        balance: balance
      }
    }
  end
end
