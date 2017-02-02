defmodule Posa.Organization do
  use Posa.Web, :model

  schema "organizations" do
    field :login, :string
    field :github_id, :integer
    field :url, :string
    field :repos_url, :string
    field :events_url, :string
    field :hooks_url, :string
    field :issues_url, :string
    field :members_url, :string
    field :public_members_url, :string
    field :avatar_url, :string
    field :description, :string
    field :name, :string
    field :blog, :string
    field :location, :string
    field :email, :string
    field :public_repos, :integer
    field :public_gists, :integer
    field :followers, :integer
    field :following, :integer
    field :html_url, :string
    field :created_at, Ecto.DateTime
    field :type, :string

    timestamps inserted_at: :imported_at
  end

  @required_fields ~w(login github_id url repos_url events_url hooks_url issues_url members_url public_members_url avatar_url description name blog location email public_repos public_gists followers following html_url created_at type)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:login)
  end
end
