defmodule Posa.Repo do
  use Ecto.Repo, otp_app: :posa
  use Scrivener, page_size: 20

  def get_page_meta(paginated) do
    %{
       pagination: %{
         "page-number" => paginated.page_number,
         "page-size" => paginated.page_size,
         "total-pages" => paginated.total_pages,
         "total-entries" => paginated.total_entries
       }
    }
  end
end
