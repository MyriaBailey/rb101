# Problem 1
# Sort by descending numeric value
arr = ['10', '11', '9', '7', '8']

arr.sort do |a, b|
  b.to_i <=> a.to_i
end

# Problem 2
# Order the array of hashes based on publication of each book
#   from earliest to latest
books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by do |book|
  book[:published]
end

# Problem 3
# For each collection object, demonstrate how you would reference the
#   letter 'g'

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
hsh2[:third].key(0)

# Problem 4
# For each collection object, where the value '3' occurs,
#   demonstrate how you would change it to '4'

arr1 = [1, [2, 3], 4]
arr1[1][1] = 4

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4

# Problem 5
# Determine the total age of just the male members of the family
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

age_sum = 0
munsters.each_value do |details|
  if details["gender"] == "male"
    age_sum += details["age"]
  end
end

# Problem 6
# Print out the name age and gender of each family member such as:
# (Name) is a (age)-year-old (male or female).

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, details|
  puts "#{name} is a #{details["age"]}-year-old #{details["gender"]}."
end

# Problem 7
# What would be the final values of 'a' and 'b'?

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

# a = 2
# b = [3, 8]

# Problem 8
# Using the `each` method, write some code to output all of the vowels
#   from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = 'aeiou'

hsh.each do |_, words|
  words.each do |word|
    word.chars.each do |char|
      puts char if vowels.include?(char)
    end
  end
end

# Problem 9
# Return a new array of the same structure, but with the sub arrays being
#   ordered alphabetically or numerically in DESCENDING order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |sub_arr|
  sub_arr.sort {|a, b| b <=> a }
end

# Problem 10
# Without modifying the orriginal array, use the map method to
#   return a new array identical in structure, but where the val
#   of each integer is incremented by 1

arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr2 = arr.map do |hsh|
  hsh.transform_values {|val| val + 1 }
end

p arr2

# Problem 11
# Use a combination of methods including either the select or reject method
#   to return a new array identical in structure but only containing
#   the integers that are multiples of 3

arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

arr.map do |sub_arr|
  sub_arr.select {|val| (val % 3) == 0 }
end

# Problem 12
# WITHOUT using `Array#to_h` method, write code to return a hash where the
#   key is the first item in each sub array and the value is the 2nd item

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

hsh = {}
arr.each do |sub_arr|
  hsh[sub_arr[0]] = sub_arr[1]
end

# Problem 13
# Return a new arr containing the same sub-arrays but ordered logically
#   by only taking consideration of the ODD numbers they contain

arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

arr.sort_by do |item|
  item.select {|val| val.odd? }
end

# Problem 14
# Return an array containing the colors of the fruits, and the sizes
#   of the vegetables.
# The sizes should be uppercase and the colors should be capitalized

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

hsh.map do |_, data|
  if data[:type] == 'fruit'
    data[:colors].map {|color| color.capitalize }
  else
    data[:size].upcase
  end
end

# map can be called on hashes to return an array :)

# Problem 15
# Return an array which contains only the hashes where ALL the integers
#   are even

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

arr.select do |hsh|
  hsh.all? do |_, arr|
    arr.all? {|int| int.even? }
  end
end

# Problem 16
# Write a method that returns one UUID when called with no parameters
# Consists of 32 hexadecimal characters
# In 5 sections like 8-4-4-4-12
# Looks like: `f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91`

def uuid_gen()
  sections = [8, 4, 4, 4, 12]
  chars = []
  ('a'..'f').each {|chr| chars << chr }
  ('0'..'9').each {|num| chars << num }
  uuid = ''

  sections.each do |length|
    length.times do
      uuid << chars.sample
    end
    uuid << '-' if length != 12
  end
  p uuid
end

uuid_gen
