
decfrac	= decfrac' 0
		where decfrac' n = (show n) ++ (decfrac' (n+1))

