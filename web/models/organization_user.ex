defmodule Posa.OrganizationUser do
  use Posa.Web, :model

  schema "organization_users" do
    belongs_to :organization, Posa.Organization
    belongs_to :user, Posa.User
  end

  @required_fields ~w(organization_id user_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
