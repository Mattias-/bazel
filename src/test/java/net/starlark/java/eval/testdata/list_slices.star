# Without step
assert_eq([0, 1, 2, 3][0:-1], [0, 1, 2])
assert_eq([0, 1, 2, 3, 4, 5][2:4], [2, 3])
assert_eq([0, 1, 2, 3, 4, 5][-2:-1], [4])
assert_eq([][1:2], [])
assert_eq([0, 1, 2, 3][-10:10], [0, 1, 2, 3])

# With step
assert_eq([1, 2, 3, 4, 5][::1], [1, 2, 3, 4, 5])
assert_eq([1, 2, 3, 4, 5][1::1], [2, 3, 4, 5])
assert_eq([1, 2, 3, 4, 5][:2:1], [1, 2])
assert_eq([1, 2, 3, 4, 5][1:3:1], [2, 3])
assert_eq([1, 2, 3, 4, 5][-4:-2:1], [2, 3])
assert_eq([1, 2, 3, 4, 5][-10:10:1], [1, 2, 3, 4, 5])
assert_eq([1, 2, 3, 4, 5][::42], [1])
assert_eq([][::1], [])
assert_eq([][::-1], [])
assert_eq([1, 2, 3, 4, 5, 6, 7][::3], [1, 4, 7])
assert_eq([1, 2, 3, 4, 5, 6, 7, 8, 9][1:7:3], [2, 5])
assert_eq([1, 2, 3][3:1:1], [])
assert_eq([1, 2, 3][1:3:-1], [])

# Negative step
assert_eq([1, 2, 3, 4, 5][::-1], [5, 4, 3, 2, 1])
assert_eq([1, 2, 3, 4, 5][4::-1], [5, 4, 3, 2, 1])
assert_eq([1, 2, 3, 4, 5][:0:-1], [5, 4, 3, 2])
assert_eq([1, 2, 3, 4, 5][3:1:-1], [4, 3])
assert_eq([1, 2, 3, 4, 5][::-2], [5, 3, 1])
assert_eq([1, 2, 3, 4, 5][::-10], [5])

# None
assert_eq([1, 2, 3][None:None:None], [1, 2, 3])
assert_eq([1, 2, 3][None:None], [1, 2, 3])
assert_eq([1, 2, 3][None:2:None], [1, 2])

# Tuples
assert_eq(()[1:2], ())
assert_eq(()[::1], ())
assert_eq((0, 1, 2, 3)[0:-1], (0, 1, 2))
assert_eq((0, 1, 2, 3, 4, 5)[2:4], (2, 3))
assert_eq((0, 1, 2, 3)[-10:10], (0, 1, 2, 3))
assert_eq((1, 2, 3, 4, 5)[-10:10:1], (1, 2, 3, 4, 5))
assert_eq((1, 2, 3, 4, 5, 6, 7, 8, 9)[1:7:3], (2, 5))
assert_eq((1, 2, 3, 4, 5)[::-1], (5, 4, 3, 2, 1))
assert_eq((1, 2, 3, 4, 5)[3:1:-1], (4, 3))
assert_eq((1, 2, 3, 4, 5)[::-2], (5, 3, 1))
assert_eq((1, 2, 3, 4, 5)[::-10], (5,))

# index
assert_eq(['a', 'b', 'c', 'd'][0], 'a')
assert_eq(['a', 'b', 'c', 'd'][1], 'b')
assert_eq(['a', 'b', 'c', 'd'][-1], 'd')
assert_eq(['a', 'b', 'c', 'd'][-2], 'c')
assert_eq([0, 1, 2][-3], 0)
assert_eq([0, 1, 2][-2], 1)
assert_eq([0, 1, 2][-1], 2)
assert_eq([0, 1, 2][0], 0)


# list.index
bananas = ["b", "a", "n", "a", "n", "a", "s"]
assert_eq(bananas.index("a"), 1)  # bAnanas
bananas.index("d") ### not found in list
---
bananas = ["b", "a", "n", "a", "n", "a", "s"]

# start
assert_eq(bananas.index("a", -1000), 1)  # bAnanas
assert_eq(bananas.index("a", 0), 1)  # bAnanas
assert_eq(bananas.index("a", 1), 1)  # bAnanas
assert_eq(bananas.index("a", 2), 3)  # banAnas
assert_eq(bananas.index("a", 3), 3)  # banAnas
assert_eq(bananas.index("b", 0), 0)  # Bananas
assert_eq(bananas.index("n", -3), 4)  # banaNas
assert_eq(bananas.index("s", -2), 6)  # bananaS

bananas.index("n", -2) ### not found in list
---
bananas = ["b", "a", "n", "a", "n", "a", "s"]
bananas.index("b", 1) ### not found in list
---
bananas = ["b", "a", "n", "a", "n", "a", "s"]

# start, end
assert_eq(bananas.index("s", -1000, 7), 6)  # bananaS
bananas.index("s", -1000, 6) ### not found in list
---
bananas = ["b", "a", "n", "a", "n", "a", "s"]
bananas.index("d", -1000, 1000) ### not found in list


---
'123'['a'::] ### got string for start index, want int
---
'123'[:'b':] ### got string for stop index, want int
---
(1, 2, 3)[1::0] ### slice step cannot be zero
---
[1, 2, 3][::0] ### slice step cannot be zero
---
[1, 2, 3][1::0] ### slice step cannot be zero
---
[1, 2, 3][:3:0] ### slice step cannot be zero
---
[1, 2, 3][1:3:0] ### slice step cannot be zero
---
[[1], [2]]['a'] ### got string for sequence index, want int
---
[0, 1, 2][3] ### index out of range \(index is 3, but sequence has 3 elements\)
---
[0, 1, 2][-4] ### index out of range \(index is -4, but sequence has 3 elements\)
---
[0][-2] ### index out of range \(index is -2, but sequence has 1 elements\)
---
[0][1] ### index out of range \(index is 1, but sequence has 1 elements\)
---
[][1] ### index out of range \(index is 1, but sequence has 0 elements\)
