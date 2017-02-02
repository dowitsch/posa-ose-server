defmodule Posa.OrganizationControllerTest do
  use Posa.ConnCase

  alias Posa.Organization
  @valid_attrs %{avatar_url: "some content", blog: "some content", created_at: "2010-04-17 14:00:00", description: "some content", email: "some content", events_url: "some content", followers: 42, following: 42, github_id: 42, hooks_url: "some content", html_url: "some content", issues_url: "some content", location: "some content", login: "some content", members_url: "some content", name: "some content", public_gists: 42, public_members_url: "some content", public_repos: 42, repos_url: "some content", type: "some content", updated_at: "2010-04-17 14:00:00", url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, organization_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    organization = Repo.insert! %Organization{}
    conn = get conn, organization_path(conn, :show, organization)
    assert json_response(conn, 200)["data"] == %{"id" => organization.id,
      "login" => organization.login,
      "github_id" => organization.github_id,
      "url" => organization.url,
      "repos_url" => organization.repos_url,
      "events_url" => organization.events_url,
      "hooks_url" => organization.hooks_url,
      "issues_url" => organization.issues_url,
      "members_url" => organization.members_url,
      "public_members_url" => organization.public_members_url,
      "avatar_url" => organization.avatar_url,
      "description" => organization.description,
      "name" => organization.name,
      "blog" => organization.blog,
      "location" => organization.location,
      "email" => organization.email,
      "public_repos" => organization.public_repos,
      "public_gists" => organization.public_gists,
      "followers" => organization.followers,
      "following" => organization.following,
      "html_url" => organization.html_url,
      "created_at" => organization.created_at,
      "updated_at" => organization.updated_at,
      "type" => organization.type}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, organization_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, organization_path(conn, :create), organization: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Organization, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, organization_path(conn, :create), organization: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    organization = Repo.insert! %Organization{}
    conn = put conn, organization_path(conn, :update, organization), organization: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Organization, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    organization = Repo.insert! %Organization{}
    conn = put conn, organization_path(conn, :update, organization), organization: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    organization = Repo.insert! %Organization{}
    conn = delete conn, organization_path(conn, :delete, organization)
    assert response(conn, 204)
    refute Repo.get(Organization, organization.id)
  end
end
