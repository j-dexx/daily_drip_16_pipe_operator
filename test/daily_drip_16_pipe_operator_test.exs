defmodule PipeOperatorTest do
  use ExUnit.Case
  #doctest Unix

  test "ps_ax outputs some processes" do
    output = """
PID TTY      STAT   TIME COMMAND
8544 ?        S      0:00 [kworker/u:1]
10919 pts/4    Sl+    0:14 vim 016_Pipe_Operator.markdown
10941 pts/5    Ss     0:00 -bash
13936 pts/5    Sl+    0:00 vim test/pipe_operator_playground_test.exs
14422 ?        S      0:00 sleep 3
    """

    assert Unix.ps_ax == output
  end

  test "grep(lines, thing) returns lines that match 'thing'" do
    lines = """
    foo
    bar
    thing foo
    baz
    thing qux
    """
    output = ["thing foo", "thing qux"]

    assert Unix.grep(lines, ~r/thing/) == output
  end

  test "awk(input, 1) splits on whitespace and returns the first column" do
    input = ["foo bar", " baz    qux"]
    output = ["foo", "baz"]

    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    assert (Unix.ps_ax |> Unix.grep(~r/vim/) |> Unix.awk(1)) == ["10919", "13936"]
  end
end
