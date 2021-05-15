
module Enigma where

import Control.Monad.State.Lazy
import Data.Char
import Data.List (elemIndex)

{--
TODO:
  * proper rotor bumping - not just on laps
  * plugboard
--}

type RotorWiring = [Int] -- list representing the offsets of output wiring for each input letter A-Z
data Rotor = Rotor RotorWiring deriving Show
type RotorOffset = Int
type LetterOffset = Int
type RotorState = (RotorOffset, RotorOffset, RotorOffset)

data EnigmaMachine = Machine {  reflector :: Rotor,
                                rotorA    :: Rotor,
                                rotorB    :: Rotor,
                                rotorC    :: Rotor
                             } deriving Show

defaultMachine = Machine reflectorC rotorI rotorI rotorI

-- Characters are encoded using their ord value, offset from 'A'.
charToOffset :: Char -> LetterOffset
charToOffset c = ord c - ord 'A'

offsetToChar :: LetterOffset -> Char
offsetToChar o = chr $ o + ord 'A'

makeRotor :: String -> Rotor
makeRotor t
  | length t == 26 = Rotor $ map charToOffset t
  | otherwise = error "Rotor must be wired for 26 characters"

{-- Rotor definitions --}
reflectorC  = makeRotor "FVPJIAOYEDRZXWGCTKUQSBNMHL"
rotorI      = makeRotor "EKMFLGDQVZNTOWYHXUSPAIBRCJ"
rotorII     = makeRotor "AJDKSIRUXBLHWTMCQGZNPYFVOE"
rotorIII    = makeRotor "BDFHJLCPRTXVZNYEIWGAKMUSQO"

{-- Machinary --}
substituteForwards :: Rotor -> RotorOffset -> LetterOffset -> LetterOffset
substituteForwards (Rotor wiring) offset i =
  let inputOffset = (i + offset) `mod` 26
  in  wiring !! inputOffset - offset

-- The input encoding for a given output when run forwards uses the position of the result
-- to invert the operation. This is less time efficient than it could be, but fairly negligible.
substituteBackwards :: Rotor -> RotorOffset -> LetterOffset -> LetterOffset
substituteBackwards (Rotor wiring) offset i =
  case elemIndex (i + offset) wiring of Nothing  -> 0
                                        Just x   -> (26 + x - offset) `mod` 26 -- add 26 to ensure we don't underflow. it gets modded anyway.

-- bump a rotor if the previous rotor's notch is about to engage
bumpRotor :: RotorOffset -> RotorOffset -> RotorOffset
bumpRotor 25 offset = (offset + 1) `mod` 26
bumpRotor _  offset = offset

stepRotors :: RotorState -> RotorState
stepRotors (a, b, c) = let a' = bumpRotor  b a
                           b' = bumpRotor  c b
                           c' = bumpRotor 25 c -- always bump the last rotor by sending previous offset as 25 TODO: make less icky
                       in (a', b', c')

stepMachine :: EnigmaMachine -> Char -> State RotorState Char
stepMachine machine c = do oldOffsets <- get
                           let (offsetA, offsetB, offsetC) = stepRotors oldOffsets
                           put (offsetA, offsetB, offsetC)
                           let step1  = substituteForwards  (rotorC machine)     offsetC (charToOffset c)
                           let step2  = substituteForwards  (rotorB machine)     offsetB step1
                           let step3  = substituteForwards  (rotorA machine)     offsetA step2
                           let step4  = substituteForwards  (reflector machine)  0       step3
                           let step5  = substituteBackwards (rotorA machine)     offsetA step4
                           let step6  = substituteBackwards (rotorB machine)     offsetB step5
                           let step7  = substituteBackwards (rotorC machine)     offsetC step6
                           return (offsetToChar step7)

reinsertSpaces :: String -> String -> String
reinsertSpaces [] _ = []
reinsertSpaces _ [] = []
reinsertSpaces (x:xs) (y:ys)
  | isSpace x = ' ' : reinsertSpaces xs (y:ys)
  | otherwise = y : reinsertSpaces xs ys

runEnigma :: EnigmaMachine -> String -> String
runEnigma machine input = reinsertSpaces input output
  where output = reverse $ evalState (runEnigma' machine sanitisedInput "") (0,0,0)
        runEnigma'       _  [] result = return result
        runEnigma' machine (x:xs) result = do c <- stepMachine machine x
                                              runEnigma' machine xs (c:result)
        sanitisedInput = map toUpper $ filter isAlpha input

