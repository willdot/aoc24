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

# now combine them together so that we have an odd and even match (ie index 0 and index 1 will be a combined into a tuple, index 2 and 3 etc...)
combined = Enum.zip(evens, odds)

# for each pair calculate the distance between them (odds - evens)
distances =
  Enum.map(
    combined,
    fn x -> abs(elem(x, 1) - elem(x, 0)) end
  )

# add each entry in the list up and print the value
IO.puts(
  Enum.reduce(
    distances,
    0,
    fn x, acc -> x + acc end
  )
)
