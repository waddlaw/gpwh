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