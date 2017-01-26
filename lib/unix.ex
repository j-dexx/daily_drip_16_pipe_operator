defmodule Unix do
  def ps_ax do
    """
PID TTY      STAT   TIME COMMAND
8544 ?        S      0:00 [kworker/u:1]
10919 pts/4    Sl+    0:14 vim 016_Pipe_Operator.markdown
10941 pts/5    Ss     0:00 -bash
13936 pts/5    Sl+    0:00 vim test/pipe_operator_playground_test.exs
14422 ?        S      0:00 sleep 3
    """
  end

  def grep(input, match) do
    String.split(input, "\n") |> Enum.filter(fn(line) -> Regex.match?(match, line) end)
  end

  def awk(lines, column) do
    Enum.map(lines, fn(line) ->
      stripped = String.strip(line)
      Regex.split(~r/ /, stripped, trim: true) |> Enum.at(column-1)
    end)
  end
end
