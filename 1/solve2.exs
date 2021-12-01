raw_data = File.read!("puzzle1.txt")
measurements = raw_data |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)

# create a 3 element sliding window,
sliding_windows_list = Enum.zip(measurements,
  Enum.zip([0]++measurements, [0,0]++measurements) |> Enum.map(&Tuple.to_list/1)
) |> Enum.map(&Tuple.to_list/1)

sliding_windows_flat = Enum.map(sliding_windows_list, &List.flatten/1)

# drop the first 2 dummy entries
sliding_windows = Enum.drop(sliding_windows_flat, 2)

increments = Enum.filter(Enum.zip(sliding_windows, [[0,0,0]]++sliding_windows), fn {aft, bef} -> Enum.sum(aft) > Enum.sum(bef) end)

# ignore the first increment, hence - 1
IO.puts("Solution: #{length(increments) - 1}")
