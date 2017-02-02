defmodule Posa.Event do
  use Posa.Web, :model

  schema "events" do
    belongs_to :user, Posa.User

    field :github_id, :string
    field :type, :string
    #field :actor, :map
    field :repo, :map
    field :payload, :map
    field :public, :boolean, default: false
    field :created_at, Ecto.DateTime

    timestamps inserted_at: :imported_at
  end

  @required_fields ~w(user_id github_id type repo payload public created_at)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
