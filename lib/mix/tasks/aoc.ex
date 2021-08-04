defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    with {flags, args, _} <- OptionParser.parse(args, aliases: [b: :bench?], strict: [bench?: :boolean]),
         {module, part} <- parse_args_without_flags(args) do
      run(module, part, flags)
    else
      :invalid ->
        IO.puts("""
        Invalid arguments #{inspect(args)}.
        Usage: `mix aoc day<number>` or `mix aoc day<number> <number>`
        Examples:
          $ mix aoc day1
          $ mix aoc day5 2
        """)
    end
  end

  defp run(module, part, flags) do
    fun = :"run#{part}"

    with {:module, module} <- Code.ensure_loaded(module),
         true <- function_exported?(module, fun, 1) do
      input = apply(module, :input, [])
      run({module, fun, [input]}, flags)
    else
      {:error, :nofile} ->
        IO.puts("#{module} does not exist")

      {:error, reason} ->
        IO.puts("#{module} could not be loaded: #{reason}")

      false ->
        IO.puts("#{module}.#{fun}/0 does not exist")
    end
  end

  defp run({mod, fun, args}, flags) do
    if flags[:bench?] do
      Benchee.run(%{"#{fun}": fn -> apply(mod, fun, args) end})
    else
      apply(mod, fun, args)
      |> IO.inspect(label: "Results")
    end
  end

  defp parse_args_without_flags([]), do: :invalid

  defp parse_args_without_flags([module]), do: {parse_module(module), 1}

  defp parse_args_without_flags([module, part]) do
    case Integer.parse(part) do
      {p, _} -> {parse_module(module), p}
      :error -> :invalid
    end
  end

  defp parse_args_without_flags([_ | _] = args), do: Enum.take(args, 2) |> parse_args_without_flags()

  defp parse_module(module), do: Module.concat(AdventOfCode, String.capitalize(module))
end
