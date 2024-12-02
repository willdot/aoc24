require Integer

{:ok, contents} = File.read("input.txt")

# split contents by the `"   "` white space between each number and then by newlines "\n"
# This will return a list but if you print that list it looks like it's all one long string 🤦‍♂️
filterContents = contents |> String.split(["   ", "\n"], trim: true)

# split that list into another list of a tuple (index, value)
valuesWithIndex =
  Enum.with_index(
    filterContents,
    fn x, y ->
      {y, String.to_integer(x)}
    end
  )

# sort those values into odd and even lists
evens =
  Enum.sort(
    Enum.map(
      # filter based on if the index is divisble by 2
      Enum.filter(
        valuesWithIndex,
        fn x -> rem(elem(x, 0), 2) == 0 end
      ),
      fn x -> elem(x, 1) end
    )
  )

odds =
  Enum.sort(
    Enum.map(
      # filter based on if the index is divisble by 2
      Enum.filter(
        valuesWithIndex,
        fn x -> rem(elem(x, 0), 2) != 0 end
      ),
      fn x -> elem(x, 1) end
    )
  )

# for each in the evens check how many times it appears in the odds
scores =
  Enum.map(evens, fn x ->
    x * Enum.count(odds, &(&1 == x))
  end)

IO.puts(Enum.sum(scores))
