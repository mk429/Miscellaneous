import Data.Char

palindromic n = palindromic' n 1

palindromic' _ 51	= False
palindromic' n try	| is_palindrome nsum = True
					| otherwise = palindromic' nsum (try+1)
					where rev = read $ reverse $ show n :: Integer
					      nsum = n + rev

is_palindrome n	= to == fro
				where to = show n
				      fro = reverse to
