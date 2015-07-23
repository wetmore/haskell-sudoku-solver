module Main where

import Solver
import Data.Array
import Data.List

drawBoard :: Board -> IO ()
drawBoard board = mapM_ printRow rows
  where
    rows' = map Just [ [ board ! (i, row) | i <- [1..9]]  | row <- [1..9]]
    rows  = addLines [Nothing] rows'
    addLines l [] = l
    addLines l xs = concat [l, take 3 xs, addLines l $ drop 3 xs]
    printRow (Just x) = putStrLn . concat . intersperse " " . addLines ["|"] . map (maybe "_" show) $ x
    printRow Nothing = putStrLn "+ - - - + - - - + - - - +"

readRows :: IO [[((Int, Int), Maybe Int)]]
readRows = flip mapM [1..9] $ \n -> do
  row <- getLine
  readRow row n

readRow :: String -> Int -> IO [(Coord, Maybe Int)]
readRow row n
  | length row == 9 = return $ zip (zip [1..9] $ repeat n) (map parseChar row)
  | otherwise       = fail "Incorrectly-formatted row"
  where
    parseChar c
      | c `elem` ['1'..'9'] = Just $ (read [c] :: Int)
      | otherwise           = Nothing

main :: IO ()
main = do
  rows <- readRows
  let board = emptyBoard // (foldl union [] rows)
  drawBoard $ solve board
