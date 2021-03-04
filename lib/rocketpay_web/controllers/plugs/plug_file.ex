defmodule Plug.ValidateFile do
  use RocketpayWeb, :controller
  @mime_types ["image/jpg", "image/png"]
  def validate_file(conn, _opts) do
    file_type = conn.body_params["upload"].content_type

    if accepted_mime?(file_type, @mime_types) do
      conn
    else
      conn
        |> Plug.Conn.put_status(400)
        |> json(%{error_code: "400", reason_given: "Invalid file type #{file_type}"})
        |> halt()
    end

  end

  defp accepted_mime?(mime, pass) do
    mime_type = String.split(mime, "/")
    type = Enum.at(mime_type, 0)
    subtype = Enum.at(mime_type, 1)
    "#{type}/#{subtype}" in pass || "#{type}/*" in pass
  end
end
