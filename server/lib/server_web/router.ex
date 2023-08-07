defmodule ServerWeb.Router do
  use Plug.Router

  plug :match

  plug Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason

  plug :dispatch

  get "/ws" do
    user = Map.get(conn.query_params, "user", "Anonymous")

    conn
    |> WebSockAdapter.upgrade(ServerWeb.WebSocket, [user: user], timeout: 3600_000)
    |> halt()
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
