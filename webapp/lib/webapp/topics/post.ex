defmodule Webapp.Topics.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :enabled, :boolean, default: false
    field :title, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :enabled, :body, :user_id])
    |> validate_required([:title, :enabled, :body, :user_id])
  end
end
