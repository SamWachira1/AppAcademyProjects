require 'byebug'

# MAX_STACK_SIZE = 200
# tracer = proc do |event|
#   if event == 'call' && caller_locations.length > MAX_STACK_SIZE
#     fail "Probable Stack Overflow"
#   end
# end
#  set_trace_func(tracer)



#Warmup

# Recursive 
def range(min, max)
 return [] if max <= min
 range(min, max - 1) << max - 1
end

# p range(2, 9)


#Iterative
def range(min, max)
    return (min..max).to_a
end

# p range(2, 8)


# Exponentiation

# Write two versions of exponent that use two different recursions:
# this is math, not Ruby methods.

# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

def exp(base, exponent)
exponent == 0 ? 1 : base * exp(base, exponent - 1)
end

# p exp(2, 2)
# p exp(4, 5)
# p exp(100, 7)

# recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exp(base, exponent)
    return 1 if exponent == 0 

    half = exp(base, exponent / 2)

    if exponent.even?
        half * half
    else
        base * half * half 
    end
    
end

# p exp(2, 2)
# p exp(4, 5)
# p exp(100, 7)



class Array

    def deep_dup
     new_arr = []
     self.each do |el|
        new_arr << (el.is_a?(Array) ? el.deep_dup : el)
     end

     new_arr
    end

    def dd_map
        map {|el| el.is_a?(Array) ? el.dd_map : el }
    end
end

random = [1, [2], [3, [4]]]
# p random.dd_map


# Fibonacci

# Write a recursive and an iterative Fibonacci method. 
# The method should take in an integer n and return the first n 
# Fibonacci numbers in an array.

    def fib_rec(n)
        if n <= 2
            [0,1].take(n)
        else
        fib = fib_rec(n - 1)
        fib << fib[-2] + fib[-1]
        end
    end

    # p fib_rec(8)

    def fib_it(n)
        return [] if n <= 0
        return [1] if n == 1

        fibs = [0,1,1]

        while fibs.length <= n 
            fibs << fibs[-2] + fibs[-1]
        end

        fibs
    end
    # p fib_it(12)

# Binary Search

def bsearch(array, target)
    return nil if array.empty?

    mid_indx = array.length / 2

    case target <=> array[mid_indx]
    when -1 
        bsearch(array.take(mid_indx), target)
    when 0
        mid_indx
    when 1
        
        sub_ans = bsearch(array.drop(mid_indx + 1), target)
        sub_ans.nil? ? nil : (mid_indx + 1) + sub_ans
    end


end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil


# Merge Sort

# class Array

#   def merge_sort
    
#     return self if count < 2

#     mid_indx = count / 2

#     left, right = self.take(mid_indx), self.drop(mid_indx)
#     l_merge, r_merge = left.merge_sort, right.merge_sort

#     merge(l_merge, r_merge)

#   end

#   def merge(left, right)

#     new_arr = []
#     until left == [] || right == []
#         if left[0] > right[0]
#             new_arr << right.shift
#         else
#             new_arr << left.shift
#         end
#     end
#     new_arr.concat(left).concat(right)
#   end

# end

# p [1, 6, 5, 4, 1, 132, 1564, 0, 8, 75].merge_sort


# Array Subsets

class Array
  def subsets
    return [[]] if empty?
    subs = take(count - 1).subsets
    subs.concat(subs.map { |sub| sub + [last] })
  end
end

# p [1, 2, 3].subsets
# p [9, 4, 5].subsets

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]



# Permutations

def permutations(arr)
    return [arr] if  arr.length <= 1 

    first = arr.shift 
    perms = permutations(arr)

    total_perm = []
    perms.each do |perm|
        (0..perm.length).each do |i|
            total_perm << perm[0...i] + [first] + perm[i..-1]
        end
    end

    total_perm
end

# p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
                        #     [2, 1, 3], [2, 3, 1],
                        #     [3, 1, 2], [3, 2, 1]]


# Make Change

def greedy_make_change(amount, coins = [25, 10, 5, 1])
    changed_arr = []

    return changed_arr if amount == 0
    coin = coins.find {|coin| coin <= amount}
    changed_arr << coin 
    amount -= coin

    changed_arr + greedy_make_change(amount)
end

 p greedy_make_change(24, [9, 7, 1])

def make_change(target, coins)
    return [] if target == 0 
    coins.none? {|c| c <= target}

    coins.sort.reverse 

    best_change = nil
    coins.each_with_index do |coin, index|
        next if coin > target
        remainder = target - coin 
        best_remainder = make_change(remainder, coins.drop(index))
        next if best_remainder.nil?

        this_change = [coin] + best_remainder

        if best_change.nil? || this_change.count < best_change.count
            best_change = this_change
        end
    end
    best_change
end

p make_change(14, [9,7,7])





















