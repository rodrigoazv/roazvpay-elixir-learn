defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, file}) do
    lista = String.split(file, ",")
    Enum.map(lista, fn number -> String.to_integer(number) end)
  end
  defp handle_file({:error, _reason}), do: {:error, "invalid file!"}
end
