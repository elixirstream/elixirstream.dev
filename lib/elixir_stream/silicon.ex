defmodule ElixirStream.Silicon do
  require Logger
  @silicon_bin "bin/silicon.sh"

  def generate(tip, opts \\ []) do
    theme = Keyword.get(opts, :theme, "Monokai Extended Bright")
    extension = Keyword.get(opts, :extension, "ex")
    tmp_id = :crypto.hash(:md5, tip.code) |> Base.encode64 |> String.replace("/", "")

    @silicon_bin
    |> path_for()
    |> Path.expand()
    |> System.cmd([tip.code, theme, extension])
    |> case do
      {filepath, 0} ->
        ElixirStream.Storage.put(tip.id || "tmp-#{tmp_id}", String.trim(filepath))
      {output, _} ->
        Logger.error(output)
        {:error, "could not generate image"}
    end
  end

  def path_for(relative_path) do
    if Application.get_env(:elixir_stream, :app_env) == :prod do
      relative_path
    else
      Path.join(["rel", "overlays", relative_path])
    end
  end
end