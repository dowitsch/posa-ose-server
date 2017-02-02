defmodule Posa.OrganizationTest do
  use Posa.ModelCase

  alias Posa.Organization

  @valid_attrs %{avatar_url: "some content", blog: "some content", created_at: "2010-04-17 14:00:00", description: "some content", email: "some content", events_url: "some content", followers: 42, following: 42, github_id: 42, hooks_url: "some content", html_url: "some content", issues_url: "some content", location: "some content", login: "some content", members_url: "some content", name: "some content", public_gists: 42, public_members_url: "some content", public_repos: 42, repos_url: "some content", type: "some content", updated_at: "2010-04-17 14:00:00", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Organization.changeset(%Organization{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Organization.changeset(%Organization{}, @invalid_attrs)
    refute changeset.valid?
  end
end
