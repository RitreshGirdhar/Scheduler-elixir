defmodule Demo.Scheduler2 do
  @moduledoc false
  use GenServer

  require Logger

  @scheduler_frequency :timer.minutes(1)

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok)
  end

  @impl true
  def init(:ok) do
    poll()
    {:ok, :ok}
  end

  @impl true
  def handle_info(:refresh, _state) do
    execute_task
    poll()
    {:noreply, :ok}
  end

  def execute_task do
    Logger.info("Demo Scheduler2 started")
    # do something
    Logger.info("Demo Scheduler2 Finished")
  end

  defp poll do
    Process.send_after(self(), :refresh, @scheduler_frequency)
  end
end