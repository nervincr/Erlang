-module(funcion).
-compile(export_all).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

fib(1) -> 1;
fib(2) -> 1;
fib(N) -> fib(N-1) + fib(N-2).