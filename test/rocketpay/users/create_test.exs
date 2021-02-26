defmodule Rockepay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create


  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        name: "Rafael",
        password: "123456",
        nickname: "rafa1",
        email: "rafa@gamil.com",
        age: 18
      }

      {:ok, %User{id: user_id}}  = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "Rafael", age: 18, id: ^user_id} = user
    end
  end

end
