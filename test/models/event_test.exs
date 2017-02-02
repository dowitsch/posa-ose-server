defmodule Posa.EventTest do
  use Posa.ModelCase

  alias Posa.Event

  @valid_attrs %{actor: %{}, created_at: "2010-04-17 14:00:00", github_id: "some content", payload: %{}, public: true, repo: %{}, type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
