require 'minitest/autorun'
require 'minitest/benchmark'
require_relative '../lib/prime_util'

class TestPrimeUtil < MiniTest::Unit::TestCase
  def test_that_zero_is_not_a_prime
    assert_equal false, PrimeUtil.prime?(0)
  end
  
  def test_that_one_is_not_a_prime
    assert_equal false, PrimeUtil.prime?(1)
  end
  
  def test_that_two_is_a_prime
    assert_equal true, PrimeUtil.prime?(2)
  end
  
  def test_that_ninety_seven_is_a_prime
    assert_equal true, PrimeUtil.prime?(97)
  end
  
  def test_first_ten_primes
    ten_primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    assert_equal ten_primes, PrimeUtil.first(10)
  end
  
  def bench_first_n_primes
    assert_performance_linear 0.99 do |n|
      n.times do
        PrimeUtil.first(10)
      end
    end
  end
end