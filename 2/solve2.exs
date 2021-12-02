raw_data = File.read!("puzzle.txt")
directions = raw_data
  |> String.split("\n", trim: true)
  |> Enum.map(&String.split/1)
  |> Enum.map(fn rowl -> {Enum.at(rowl, 0), String.to_integer(Enum.at(rowl, 1))} end)

{horizontal, depth, _} = Enum.reduce(directions, {0, 0, 0}, fn dir, {h, d, a} ->
  case dir do
    {"up", v} ->
      {h, d, a - v}
    {"down", v} ->
      {h, d, a + v}
    {"forward", v} ->
      {h + v, d + (a * v), a}
  end
end)


IO.puts("Solution: #{horizontal * depth}")
