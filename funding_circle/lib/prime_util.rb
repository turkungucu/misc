class PrimeUtil
  # checks if a number is prime
  def self.prime?(num)
    # separate number into digits: 123 -> [1,2,3]
    digits = to_digits(num)
    
    # Run through some basic prime checks before executing
    # a more brute force method
    return false if [0, 1].include?(num)
    return true if [2, 3].include?(num)
    
    # for at least 2 digit numbers
    if digits.size > 1
      # number is not a prime if ones digit is 0,2,4,5,6,8
      return false if [0,2,4,5,6,8].include?(digits.last)
    
      # not a prime if sum of digits is divisible by 3
      return false if digits.inject {|sum, i| sum += i} % 3 == 0
    end
    
    # A brute approach but only need to iterate up to n/2
    for i in 2..num/2 do
      return false if num % i == 0
    end
    
    true
  end
  
  # returns an array of first n primes
  def self.first(n)
    primes = []
    i = 1
    
    while primes.size < n
      primes << i if self.prime?(i)
      i += 1
    end
    
    primes
  end
  
  # pretty prints multiplication table
  def self.print_multiplication_table(primes)
    n = primes.size - 1
    max_digit_size = (primes[n] * primes[n]).to_s.size + 1
  
    # first row with some formatting
    formatted_row = primes.map.with_index do |p, i|
      delim = " " * (max_digit_size - p.to_s.size)
      i == 0 ? "#{delim}#{delim} #{p}" : "#{delim}#{p}"
    end
    puts formatted_row.join('')
    
    # prints first column and then computes cells
    for row in 0..n
      # first column
      delim = " " * (max_digit_size - primes[row].to_s.size)
      s = "#{delim}#{primes[row]}"
      
      # cells
      for col in 0..n
        val = primes[row] * primes[col]
        delim = " " * (max_digit_size - val.to_s.size)
        s << "#{delim}#{val}"
      end
    
      puts s
    end
  end
  
  def self.to_digits(num)
    num.to_s.split(//).map!(&:to_i)
  end
  private_class_method :to_digits
end
