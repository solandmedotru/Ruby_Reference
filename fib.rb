def fib n
  n.zero? || n == 1 ? n : fib(n - 1) + fib(n - 2)
end

#(0..10).each { |i| puts fib i }