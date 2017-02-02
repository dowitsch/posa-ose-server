defmodule Posa.EventController do
  use Posa.Web, :controller

  import Ecto.Query

  alias Posa.Event
  alias Posa.OrganizationUser

  plug :assigns

  def index(conn, params) do
    events = get_events(params, conn.assigns)
             |> Repo.paginate(params["page"])

    render(conn, data: events, opts: [
      meta: Repo.get_page_meta(events)
    ])
  end

  defp get_events(params, %{organization_id: organization_id}) do
    get_events(params)
    |> join(
      :inner,
      [u],
      ou in OrganizationUser,
      ou.organization_id == ^organization_id and ou.user_id == u.user_id
    )
  end

  defp get_events(params, %{user_id: user_id}) do
    get_events(params)
    |> where([e], e.user_id == ^user_id)
  end

  defp get_events(params, _assigns \\ :empty) do
    from(
      e in Event,
      join: u in assoc(e, :user),
      preload: [user: u],
      order_by: [desc: e.created_at]
    )
  end


  def show(conn, %{"id" => id}) do
    event = Repo.one! from(
      e in Event,
      where: e.id == ^id,
      join: u in assoc(e, :user),
      preload: [user: u]
    )

    render(conn, data: event)
  end

  defp assigns(conn, _opts) do
    case conn.params do
      %{"organization_id" => organization_id} ->
        assign(conn, :organization_id, organization_id)
      %{"user_id" => user_id} ->
        assign(conn, :user_id, user_id)
      _ ->
        conn
    end
  end
end
