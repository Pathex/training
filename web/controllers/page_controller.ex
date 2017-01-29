defmodule Training.PageController do
  use Training.Web, :controller

  def index(conn, _params) do
    IO.puts "Page Index"
    render conn, "index.html"
  end
end
