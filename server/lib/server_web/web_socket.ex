defmodule ServerWeb.WebSocket do
  alias Phoenix.PubSub

  @type state :: %{username: String.t(), user_id: String.t()}

  @spec init(nil | [user: String.t()]) :: {:ok, state()}
  def init(options) do
    PubSub.subscribe(Server.PubSub, "all")
    {:ok, %{username: options[:user], user_id: UUID.uuid4()}}
  end

  def handle_in({message, [opcode: :text]}, %{username: username, user_id: user_id} = state) do
    payload =
      Jason.decode!(message)
      |> Map.put("username", username)
      |> Map.put("user_id", user_id)
      |> Map.put("id", UUID.uuid4())

    PubSub.broadcast(
      Server.PubSub,
      "all",
      {:broadcast, payload}
    )

    {:ok, state}
  end

  def handle_info({:broadcast, message}, %{user_id: user_id} = state) do
    if message["user_id"] == user_id do
      {:ok, state}
    else
      {:push, {:text, Jason.encode!(message)}, state}
    end
  end

  def terminate(_, state) do
    {:ok, state}
  end
end
