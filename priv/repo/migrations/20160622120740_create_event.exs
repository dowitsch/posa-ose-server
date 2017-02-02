defmodule Posa.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :user_id, references(:users)

      add :github_id, :string
      add :type, :string
      add :repo, :map
      add :payload, :map
      add :public, :boolean, default: false
      add :created_at, :datetime

      timestamps inserted_at: :imported_at
    end

    create index(:events, [:user_id])
    create index(:events, ["created_at DESC"])

  end
end
