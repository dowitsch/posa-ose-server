defmodule Posa.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :login, :string
      add :github_id, :integer
      add :url, :string
      add :repos_url, :string
      add :events_url, :string
      add :hooks_url, :string
      add :issues_url, :string
      add :members_url, :string
      add :public_members_url, :string
      add :avatar_url, :string
      add :description, :string
      add :name, :string
      add :blog, :string
      add :location, :string
      add :email, :string
      add :public_repos, :integer
      add :public_gists, :integer
      add :followers, :integer
      add :following, :integer
      add :html_url, :string
      add :created_at, :datetime
      add :type, :string

      timestamps inserted_at: :imported_at
    end

    create unique_index(:organizations, [:login])
  end
end
