#!/usr/bin/ruby

require_relative 'lib/prime_util'

n = ARGV[0].to_i

if n < 1
  puts "Please specify an integer between 1..n. Exiting..."
  exit
end

# find first n primes
primes = PrimeUtil.first(n)
# print multiplication table
PrimeUtil.print_multiplication_table(primes)
