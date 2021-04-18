defmodule Recurcao do
  def print_multiple_times(n) when n >= 10 do
    IO.puts n
  end

  def print_multiple_times(n) do
    IO.puts n
    print_multiple_times(n + 1)
  end
end
