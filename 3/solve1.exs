raw_data = File.read!("puzzle.txt")
diagnostics = raw_data |> String.split("\n", trim: true)

element_len = String.length(Enum.at(diagnostics, 0))

# get diagnostics
gamma = Enum.map(0..element_len-1, fn idx ->
  Library.diag_criterion(diagnostics, idx, &Library.min_function/1)
end)
  |> Library.bitstrl_to_int


epsilon = Enum.map(0..element_len-1, fn idx ->
  Library.diag_criterion(diagnostics, idx, &Library.max_function/1)
end)
  |> Library.bitstrl_to_int

IO.puts("Solution #{gamma * epsilon}")
