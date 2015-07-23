module Solver where

import Data.Array
import Data.List
import Data.Maybe
import Data.Ord

type Coord = (Int, Int)
type Board = Array Coord (Maybe Int)

emptyBoard :: Board
emptyBoard =
  array ((1, 1), (9, 9)) [ ((i,j), Nothing) | i <- [1..9], j <- [1..9]]

(|->) :: Coord -> Int -> (Coord, Maybe Int)
(|->) x y = (x, Just y)

testBoard = emptyBoard //
  [ (1, 1) |-> 2 
  , (5, 1) |-> 3
  , (9, 1) |-> 7
  , (2, 2) |-> 9
  , (5, 2) |-> 6
  , (8, 2) |-> 1
  , (3, 3) |-> 4
  , (5, 3) |-> 8
  , (7, 3) |-> 6
  , (4, 4) |-> 2
  , (6, 4) |-> 6
  , (1, 5) |-> 9
  , (2, 5) |-> 5
  , (3, 5) |-> 6
  , (7, 5) |-> 2
  , (8, 5) |-> 7
  , (9, 5) |-> 3
  , (4, 6) |-> 3
  , (6, 6) |-> 7
  , (3, 7) |-> 8
  , (5, 7) |-> 1
  , (7, 7) |-> 5
  , (2, 8) |-> 1
  , (5, 8) |-> 2
  , (8, 8) |-> 9
  , (1, 9) |-> 3
  , (5, 9) |-> 7
  , (9, 9) |-> 2 
  ]

available :: Board -> Coord -> [Int]
available board coord = [1..9] \\ taken
  where
    coords = section coord `union` hLine coord `union` vLine coord
    taken  = catMaybes . map (board !) $ coords

section :: Coord -> [Coord]
section (i, j) = do
  let (n, m) = ((i - 1) `div` 3, (j - 1) `div` 3)
  x <- [1..3]
  y <- [1..3]
  return (3 * n + x, 3 * m + y)

hLine :: Coord -> [Coord]
hLine (_, j) = [ (i, j) | i <- [1..9]]

vLine :: Coord -> [Coord]
vLine (i, _) = [ (i, j) | j <- [1..9]]

unfilled :: Board -> [Coord]
unfilled = map fst . filter (isNothing . snd) . assocs

fillSpot :: (Board, [Coord], [Board]) -> [(Board, [Coord], [Board])]
fillSpot (b, coords, bs) = case colors of
    [] -> []
    xs -> map (\x -> (b // [(c, Just x)], cs, b:bs)) colors
  where
    c:_    = sortBy (comparing $ length . available b) coords
    cs     = coords \\ [c]
    colors = available b c

fst3 (a,_,_) = a
snd3 (_,a,_) = a
trd3 (_,_,a) = a

solve' tuple = do
  x <- fillSpot tuple
  if snd3 x == [] then return $ fst3 x else solve' x 

solve board = head $ solve' (board, unfilled board, [board])