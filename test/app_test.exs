defmodule AppTest do
  use ExUnit.Case
  doctest App
  import Issues.CLI, only: [parse_args: 1]

  test "-h and --help work" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "empty args return help" do
    assert parse_args([]) == :help
  end

  @tag :external
  test "the truth" do
    assert 1 + 1 == 2
  end
end
