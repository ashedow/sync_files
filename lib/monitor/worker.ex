defmodule App.Monitor.Worker do
  @moduledoc """
  Monitor worker
  """
  use GenServer
  require App.Scripts.Logger

  @doc """
  Struct defenition for pereodic worker.
  """
  defstruct [:work_fn, :parent, :state, interval: interval]
  # defstruct [:work_fn, :parent, :state, interval: 10_000]

  alias __MODULE__, as: PW

  @type work_fn :: (any -> any)

  @doc """
  Starts a PeriodicWorker process.
  """
  @spec start_link(work_fn, any, pos_integer) :: tuple
  def start_link(function, state, interval) do
    data = %PW{
      work_fn:  function,
      parent:   self,
      state:    state,
      interval: interval,
    }
    # start the GenServer with a `name` option.
    GenServer.start_link(__MODULE__, data, name: :sync_files)
  end

  @doc """
  Stops a PeriodicWorker process.
  """
  @spec stop(pid) :: :ok
  def stop(pid) do
    GenServer.call(pid, :stop)
  end

  @doc """
  Init. Block parent process with `timeout = infinity` by default.
  So init have to be very simple and fast.
  """
  @spec init(%PW{}) :: {:ok, %PW{}}
  def init(data) do
    schedule_work(data.interval) # Schedule work to be performed at some point
    {:ok, data}
  end

  @doc """
  Worker works.
  handle_info has 4 possible answers:
    * {noreply, NewState}
    * {noreply, NewState, Timeout}
    * {noreply, NewState, hibernate}
    * {stop, Reason, NewState}
  """
  def handle_info(:work, data) do
    state = data.work_fn.(data.state)
    data  = %PW{data | state: state}
    data.parent |> send(state)
    schedule_work(data.interval) # Reschedule once more
    {:noreply, data}
  end

  @doc """
  handle_call has 8 possible answers:
    * 3 reply:
      - {reply, Reply, NewState}
      - {reply, Reply, NewState, Timeout}
      - {reply, Reply, NewState, hibernate}
    * 3 noreply:
      - {noreply, NewState}
      - {noreply, NewState, Timeout}
      - {noreply, NewState, hibernate}
    * 2 stop:
      - {stop, Reason, Reply, NewState}
      - {stop, Reason, NewState}
  """
  def handle_call(:stop, _from, _state) do
    {:stop, :normal, :ok, []}
  end


  defp schedule_work(interval) do
    Process.send_after(self, :work, interval)
  end
end
