fact :: Int -> Integer
fact =
    let fact' 0 = 1
        fact' 1 = 1
        fact' n = n * (fact' $ n -1)
    in  (map fact' [0..] !!)


n !\ r	| r <= n = (fact n) `div` ((fact r) * (fact (n - r)))
		| otherwise = 0

result = length [i | i <- [n !\ r | n <- [1..100], r <- [1..100]], i > 1000000]
