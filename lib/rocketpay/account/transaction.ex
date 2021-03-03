defmodule Rocketpay.Account.Transaction do

  alias Ecto.Multi

  alias Rocketpay.Account.Transaction.Response, as: TransactionResponse
  alias Rocketpay.{Repo}

  alias Rocketpay.Account.Operations

  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    withdraw_params = build_params(from_id, value)
    deposit_params = build_params(to_id, value)

    Multi.new()
    |> Multi.merge(fn _changes -> Operations.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operations.call(deposit_params, :deposit) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: to_account, withdraw: from_account}} -> {:ok, TransactionResponse.build(from_account, to_account)}
    end
  end
end
