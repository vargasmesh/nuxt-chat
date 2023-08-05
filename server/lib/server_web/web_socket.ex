defmodule ServerWeb.WebSocket do
  alias Phoenix.PubSub

  def init(options) do
    IO.inspect(options)
    PubSub.subscribe(Server.PubSub, "all")
    {:ok, options}
  end

  def handle_in({message, [opcode: :text]}, state) do
    PubSub.broadcast(Server.PubSub, "all", {:broadcast, message})
    {:ok, state}
  end

  def handle_info({:broadcast, message}, state) do
    {:push, {:text, message}, state}
  end

  def terminate(_, state) do
    {:ok, state}
  end
end
