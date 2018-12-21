# GET PROGRAMMING WITH HASKELL

- [book](https://www.manning.com/books/get-programming-with-haskell)
- [Errata](https://manning-content.s3.amazonaws.com/download/4/699ce32-de8b-4b62-880a-9cbd4a0a4624/Kurt_GetProgrammingwithHaskell_err3.html)

## 正誤表

### P.158 15.5

誤

```hs
message :: [FourLetterAlphabet]
message = [L1,L3,L4,L1,L1,L2]
```

正

```hs
fourLetterMessage :: [FourLetterAlphabet]
fourLetterMessage = [L1,L3,L4,L1,L1,L2]
```

### P.159 15.6

誤

```hs
fourLetterAlphabetEncoder :: [FourLetterAlphabet] -> [FourLetterAlphabet]
```

正

```hs
fourLetterEncoder :: [FourLetterAlphabet] -> [FourLetterAlphabet]
```

### P.161 15.10

誤

```hs
fourLetterAlphabetEncoder :: [FourLetterAlphabet] -> [FourLetterAlphabet]
```

正

```hs
fourLetterEncoder :: [FourLetterAlphabet] -> [FourLetterAlphabet]
```

### P.185 16.19

`description` のスペルミス

### P.219 19.3

出力結果に改行が足りない。

### P.222 19.11

`report` の型注釈に空白があった方が良いと思う

### P.229 20.6

`(Maybe a)` の括弧は無くて良い

### P.235 20.14

`(Real a)` の括弧は無くて良い

### P.237 20.15

`newFunc` の3行目の最後で、タプルの左括弧が無い

### P.237 20.15

`newFunc` の4行目の `val2` の手前は空白1つが良い

### P.242 20.20

`(Real a)` の括弧は無くて良い

### P.242 20.21

`(Real a)` の括弧は無くて良い

### P.242 20.22

`(Real a)` の括弧は無くて良い

### P.243 20.23

- `(Real a)` の括弧は無くて良い
- 基底部のイコールの左に空白欲しい

### P.259 21.12

`return` の後の空白

### P.302 25.8

`changed =` の後の空白

### P.309 26.1

図の説明で `OverlodStrings` になっている。

### P.314 26.2.1

`□rst`, `□nd` になってる。

### P.312 26.7

`]` が真ん中に余分にある

### P.365 29.6

```hs
totalPrize :: [Int]
totalPrize = pure (+) <*> doorPrize <*> boxPrize
```

### P.366 29.6

```hs
totalPrize :: [Int]
totalPrize = pure (+) <*> doorPrize <*> boxPrize
```

### P.403 32.1

`::` ではなく `..`

### P.406 32.1.1

`guard(even value)` より `guard (even value)` の方が良い

### P.407 32.3

`guard(even nSquared)` より `guard (even nSquared)` の方が良い

### P.413 33.1

`firstName :: String`

### P413 33.2

`Sophomore` が正しい

### P.415 33.5

`repl` の結果も `Sophomore`

### P.416 33.5

`Sophomore`

### P.419 33.11

`dparis` は `dpairs` の間違い

### P.419 33.12

`joinData` のカッコいらない

### P.420 33.14

`finalResult` の3行目の `.` の横に空白欲しい

### P.422 33.6

`query1` の3行目の `.` の横に空白欲しい

### P.424 33.19

`maybeQuery1` の3行目の `.` の横に空白欲しい

### P.424 33.20

`maybeQuery2` の3行目の `.` の横に空白欲しい

### P.427 33.27

`getEnrollments` の `=` の空白

### P.437 34.7

`preprcess` は `preProcess`

### P.495 38.12

`headaches-exe` が3箇所あるが、全て `primechecker-exe` の間違い

### P.521 40.20

`Metadata` に謎の空白

### P.521 40.22

`print dataName` は不必要