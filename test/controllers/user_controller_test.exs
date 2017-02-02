defmodule Posa.UserControllerTest do
  use Posa.ConnCase

  alias Posa.User
  @valid_attrs %{avatar_url: "some content", events_url: "some content", followers_url: "some content", following_url: "some content", gists_url: "some content", github_id: 42, gravatar_id: "some content", html_url: "some content", login: "some content", organizations_url: "some content", received_events_url: "some content", repos_url: "some content", site_admin: true, starred_url: "some content", subscriptions_url: "some content", type: "some content", url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get conn, user_path(conn, :show, user)
    assert json_response(conn, 200)["data"] == %{"id" => user.id,
      "login" => user.login,
      "github_id" => user.github_id,
      "avatar_url" => user.avatar_url,
      "gravatar_id" => user.gravatar_id,
      "url" => user.url,
      "html_url" => user.html_url,
      "followers_url" => user.followers_url,
      "following_url" => user.following_url,
      "gists_url" => user.gists_url,
      "starred_url" => user.starred_url,
      "subscriptions_url" => user.subscriptions_url,
      "organizations_url" => user.organizations_url,
      "repos_url" => user.repos_url,
      "events_url" => user.events_url,
      "received_events_url" => user.received_events_url,
      "type" => user.type,
      "site_admin" => user.site_admin}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end
end
