raw_data = File.read!("puzzle.txt")
directions = raw_data
  |> String.split("\n", trim: true)
  |> Enum.map(&String.split/1)
  |> Enum.map(fn rowl -> {Enum.at(rowl, 0), String.to_integer(Enum.at(rowl, 1))} end)

# get all that apply to the horizontal direction
horizontals = Enum.filter(directions, fn {dir, _} -> dir == "down" || dir == "up"  end)

horizontal_vals = Enum.map(horizontals, fn v ->
  case v do
    {"up", v} ->
      -v
    {"down", v} ->
      v
  end
end) |> Enum.sum()

# get all that apply to the vertical direction
depths = Enum.filter(directions, fn {dir, _} -> dir == "forward" end)
depth_vals = depths |> Enum.map(fn {_, v} -> v end) |> Enum.sum()

IO.puts("Solution: #{horizontal_vals * depth_vals}")
