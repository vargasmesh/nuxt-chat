defmodule ServerWeb.WebSocket do
  alias Phoenix.PubSub

  @type state :: %{user: String.t(), id: String.t()}

  @spec init(nil | [user: String.t()]) :: {:ok, state()}
  def init(options) do
    PubSub.subscribe(Server.PubSub, "all")
    {:ok, %{user: options[:user], id: UUID.uuid4()}}
  end

  def handle_in({message, [opcode: :text]}, %{user: user, id: id} = state) do
    payload =
      Jason.decode!(message)
      |> Map.put("user", user)
      |> Map.put("id", id)

    PubSub.broadcast(
      Server.PubSub,
      "all",
      {:broadcast, payload}
    )

    {:ok, state}
  end

  def handle_info({:broadcast, message}, %{id: id} = state) do
    IO.inspect(message)
    IO.puts(id)

    if message["id"] == id do
      {:ok, state}
    else
      {:push, {:text, Jason.encode!(message)}, state}
    end
  end

  def terminate(_, state) do
    {:ok, state}
  end
end
