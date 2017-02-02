defmodule Github.API do
  use HTTPotion.Base

  def process_url(url) do
    "https://api.github.com/" <> String.replace_leading(url, "/", "")
  end

  def process_request_headers(headers) do
    Dict.put headers, :"User-Agent", "posa"
  end

  def process_options(options) do
    Keyword.put(options, :query,
     Keyword.get(options, :query, [])
     |> Keyword.put_new(:client_id, "6acfa492fa2cd7cedf08")
     |> Keyword.put_new(:client_secret, "e0d7c89585157873cac3a06d8a853738237cba6d")
    )
  end

  def process_response_body(body) do
    body
    |> IO.iodata_to_binary
    |> :jsx.decode([{:labels, :atom}, :return_maps])
  end
end
