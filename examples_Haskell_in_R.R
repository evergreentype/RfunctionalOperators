# NOTE: Haskell in R rewritten using functional operators
# Reference: https://nevrome.medium.com/haskell-in-r-an-experiment-with-the-r-package-lambda-r-78f21c0f9fe6
source('funcOperators.R')
source('funcUtilities.R')


# MARK: Main
FruitSet("LAS") %:=% "LAS"
FruitSet("SAS") %:=% "SAS"
FruitSet("OFS") %:=% "OFS"

fsMerge(a,     b,     intersect) %::% FruitSet : FruitSet : logical : FruitSet
fsMerge("LAS", "LAS", intersect) %:=% FruitSet("LAS")
fsMerge("SAS", "SAS", intersect) %:=% FruitSet("SAS")
fsMerge("OFS", b,     intersect) %:=% FruitSet("OFS")
fsMerge(a,     "OFS", intersect) %:=% FruitSet("OFS")
fsMerge("LAS", "SAS", TRUE     ) %:=% FruitSet("SAS")
fsMerge("SAS", "LAS", TRUE     ) %:=% FruitSet("SAS")
fsMerge("LAS", "SAS", FALSE    ) %:=% FruitSet("LAS")
fsMerge("SAS", "LAS", FALSE    ) %:=% FruitSet("LAS")

fsMergeList(xs, intersect) %::% Array : logical : FruitSet
fsMergeList(xs, intersect) %when% {
    xs@Element %isa% FruitSet
} %:=% { reduce1 : (\(a, b) fsMerge : a : b : intersect) : xs }

fsMergeList : Array(FruitSet : "LAS") : TRUE # LAS
fsMergeList : Array(FruitSet : "LAS", FruitSet : "LAS") : TRUE # LAS
fsMergeList : Array(FruitSet : "LAS", FruitSet : "LAS", FruitSet : "SAS") : TRUE # SAS
fsMergeList : Array(FruitSet : "LAS", FruitSet : "LAS", FruitSet : "SAS") : FALSE # LAS
fsMergeList : Array(FruitSet : "LAS", FruitSet : "LAS", FruitSet : "OFS") : FALSE # OFS