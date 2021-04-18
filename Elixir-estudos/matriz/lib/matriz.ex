defmodule Matriz do
 def line(numberOflines) when numberOflines >= 0 do
    IO.puts numberOflines
  end
  def line(numberOflines) do
    IO.puts numberOflines
    line(numberOflines + 0)
  end
end
