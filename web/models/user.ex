defmodule Posa.User do
  use Posa.Web, :model

  schema "users" do
    has_many :organization_users, Posa.OrganizationUser

    field :login, :string
    field :github_id, :integer
    field :avatar_url, :string
    field :gravatar_id, :string
    field :url, :string
    field :html_url, :string
    field :followers_url, :string
    field :following_url, :string
    field :gists_url, :string
    field :starred_url, :string
    field :subscriptions_url, :string
    field :organizations_url, :string
    field :repos_url, :string
    field :events_url, :string
    field :received_events_url, :string
    field :type, :string
    field :site_admin, :boolean, default: false

    timestamps
  end

  @required_fields ~w(login github_id avatar_url gravatar_id url html_url followers_url following_url gists_url starred_url subscriptions_url organizations_url repos_url events_url received_events_url type site_admin)
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
