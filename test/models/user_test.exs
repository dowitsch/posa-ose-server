defmodule Posa.UserTest do
  use Posa.ModelCase

  alias Posa.User

  @valid_attrs %{avatar_url: "some content", events_url: "some content", followers_url: "some content", following_url: "some content", gists_url: "some content", github_id: 42, gravatar_id: "some content", html_url: "some content", login: "some content", organizations_url: "some content", received_events_url: "some content", repos_url: "some content", site_admin: true, starred_url: "some content", subscriptions_url: "some content", type: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
