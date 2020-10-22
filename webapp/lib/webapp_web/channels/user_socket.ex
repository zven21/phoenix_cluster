defmodule WebappWeb.UserSocket do
  use Phoenix.Socket
  require Logger

  ## Channels
  # channel "room:*", WebappWeb.RoomChannel
  channel "page:*", WebappWeb.PageChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(%{"token" => token}, socket, _connect_info) do
    case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_000_000) do
      {:ok, user_id} ->
        user = Webapp.Repo.get(Webapp.Users.User, user_id)

        socket =
          socket
          |> assign(:current_user, %{email: user.email, id: user.id})

        {:ok, socket}

      {:error, reason} ->
        Logger.error("Error connecting websocket, reason: #{inspect(reason)}")
        :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     WebappWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(socket), do: "user_socket:#{socket.assigns.current_user.id}"
  # def id(socket), do: nil
end
