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

  alias App.Monitor.Worker

  test "can be started and stopped" do
    assert {:ok, pid} = Worker.start_link( &id/1, :ok, 10_000 )
    assert pid |> Process.alive?
    Worker.stop( pid )
    :timer.sleep 2
    refute pid |> Process.alive?
  end

  it "periodically sends the results to the parent process" do
    {:ok, pid} = Worker.start_link( &inc/1, 0, 10 )
    refute_receive _, 9
    assert_receive 1, 2
    refute_receive _, 9
    assert_receive 2, 2
    refute_receive _, 9
    assert_receive 3, 2
    refute_receive _, 9
    assert_receive 4, 2
    Worker.stop( pid )
  end

  @tag :external
  test "the truth" do
    assert 1 + 1 == 2
  end
end
