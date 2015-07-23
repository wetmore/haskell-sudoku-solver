# Backtracking Sudoku Solver

Probably a project most people try when learning to use lazy lists to represent non-determinism and backtracking. The solver accepts 9 lines of input, where each line is a 9-character string. Characters besides 1 through 9 are taken to mean an empty space. Then the program outputs the solution. For example:

```
matt$ ./Main
--4-76---
------3-5
8--3-94--
7---81---
1-84-72-3
---53---7
--57-3--4
4-1------
---61-7--
```

outputs

```
+ - - - + - - - + - - - +
| 5 3 4 | 2 7 6 | 9 8 1 |
| 2 6 9 | 1 4 8 | 3 7 5 |
| 8 1 7 | 3 5 9 | 4 6 2 |
+ - - - + - - - + - - - +
| 7 2 3 | 9 8 1 | 5 4 6 |
| 1 5 8 | 4 6 7 | 2 9 3 |
| 9 4 6 | 5 3 2 | 8 1 7 |
+ - - - + - - - + - - - +
| 6 8 5 | 7 9 3 | 1 2 4 |
| 4 7 1 | 8 2 5 | 6 3 9 |
| 3 9 2 | 6 1 4 | 7 5 8 |
+ - - - + - - - + - - - +
```