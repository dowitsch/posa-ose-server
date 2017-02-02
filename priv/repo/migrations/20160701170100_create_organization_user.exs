defmodule Posa.Repo.Migrations.CreateOrganizationUser do
  use Ecto.Migration

  def change do
    create table(:organization_users) do
      add :user_id, references(:users), primary_key: true
      add :organization_id, references(:organizations), primary_key: true
    end

    create index(:organization_users, [:organization_id])
    create index(:organization_users, [:user_id])

  end
end
