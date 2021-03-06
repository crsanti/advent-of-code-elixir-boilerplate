# Advent Of Code

This is a boilerplate to solve [Advent Of Code](https://adventofcode.com) exercises using Elixir.

## How to use it

In order to run a specific day and part just use:

```bash
mix aoc day<number> [part]
```

Examples:

To run day 5, part 2:

```bash
mix aoc day5 2
```

To run day 7, part 1:

```bash
mix aoc day7 1
```

or

```bash
mix aoc day7
```

## How to add days

Just create a module in `./src/day<number>/day<number>.ex` that exports three functions:

```elixir
defmodule AdventOfCode.Day1 do
  def input do
    ""
  end

  def run1(input) do
  end

  def run2(input) do
  end
end
```

You may want to also add `./src/day<number>/day<number>.md` with the description.

---

Happy coding~🎄!
