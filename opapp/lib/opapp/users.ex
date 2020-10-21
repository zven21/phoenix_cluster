defmodule Opapp.Users do
  @moduledoc """
  The Topics context.
  """

  import Ecto.Query, warn: false
  alias Opapp.Repo

  alias Opapp.Users.User
  alias OpappWeb.Endpoint

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%user{}, ...]

  """
  def list_users do
    User
    |> Repo.all()
    |> Enum.map(fn x -> Map.merge(x, %{online: false}) end)
  end

  def make_user_online(id) do
    user =
      User
      |> Repo.get(id)
      |> Map.put_new(:online, true)

    Endpoint.broadcast("users", "user_online_updated", %{user: user})
    # broadcast({:ok, user}, :user_online_updated)
  end

  def make_user_offline(id) do
    user =
      User
      |> Repo.get!(id)
      |> Map.put_new(:online, false)

    Endpoint.broadcast("users", "user_online_updated", %{user: user})
    # broadcast({:ok, user}, :user_online_updated)
  end

  # def subscribe do
  #   Phoenix.PubSub.subscribe(Opapp.PubSub, "users")
  # end

  # def unsubscribe do
  #   Phoenix.PubSub.unsubscribe(Opapp.PubSub, "users")
  # end

  # defp broadcast({:error, _reason} = error, _event), do: error

  # defp broadcast({:ok, user}, event) do
  #   Phoenix.PubSub.broadcast(Opapp.PubSub, "users", {event, user})
  # end
end
