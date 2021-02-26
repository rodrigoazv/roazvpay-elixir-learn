defmodule RocketpayWeb.AccountView do

  alias Rocketpay.Account

  alias Rocketpay.Account.Transaction.Response, as: TransactionResponse

  def render("update.json", %{account: %Account{balance: balance}}) do
    %{
      message: "Operation sucessfully !",
      user: %{
        balance: balance
      }
    }
  end

  def render("transaction.json", %{
      transaction: %TransactionResponse{to_account: to_account, from_account: from_account}
    }) do
    %{
      message: "Transaction sucessfully !",
      transaction: %{
        to_account: %{
          id: to_account.id,
          balance: to_account.balance
        },
        from_account: %{
          id: from_account.id,
          balance: from_account.balance
        },
      }
    }
  end

end
