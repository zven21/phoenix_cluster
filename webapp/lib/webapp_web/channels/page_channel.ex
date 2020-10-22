defmodule WebappWeb.PageChannel do
  use WebappWeb, :channel

  alias WebappWeb.Presence

  def join("page:index", payload, socket) do
    if authorized?(payload) do
      send(self(), :on_user_join)

      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload), do: true

  # defp authorized?(payload)

  def handle_info(:on_user_join, socket) do
    user = current_user(socket)
    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} =
      Presence.track(
        socket,
        user.id,
        user
      )

    {:noreply, socket}
  end

  def terminate({:shutdown, :closed}, socket) do
    %{current_user: current_user} = socket.assigns

    :ok =
      Presence.untrack(
        socket,
        current_user.id
      )

    WebappWeb.Endpoint.broadcast("users", "user_online_updated", %{user: current_user |> Map.put(:online, false)})
    broadcast!(socket, "disconnect", %{user: current_user})
  end

  def handle_in("user:focus", focus, socket) do
    %{current_user: current_user} = socket.assigns

    {:ok, _} =
      Presence.update(
        socket,
        current_user.id,
        fn user ->
          %{user | focus: focus}
        end
      )

    WebappWeb.Endpoint.broadcast("users", "user_online_updated", %{user: current_user |> Map.put(:online, true)})

    {:noreply, socket}
  end

  defp current_user(socket) do
    socket.assigns
    |> Map.get(:current_user)
    |> Map.take([:email, :id])
    |> Map.put(:focus, nil)
  end
end
