# Practice Problems: Additional Practice

# Problem 1
# Given the array:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# Turn into a hash where the names are the keys and 
#   the values are the positions in the array

flintstones_hash = {}
flintstones.each_with_index {|val, idx| flintstones_hash[val] = idx }

p flintstones_hash

# Problem 2
# Add up all the ages of the hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, 
          "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

sum = 0
ages.each_value {|val| sum += val }
p sum

# Problem 3
# Remove people with age 100 and greater in the hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.select! {|key, val| val < 100}

# Problem 4
# Pick the minimum age from the hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, 
         "Marilyn" => 22, "Spot" => 237 }

p ages.values.min

# Problem 5
# Find the index of the first name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

p flintstones.find_index {|val| val.start_with?('Be') }

# Practice Problem 6
# Change the array so that all the names are shortened to just
# the first 3 characters without creating a new array
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

p flintstones.each_with_index {|val, idx| flintstones[idx] = val[0, 3] }
# Would have been shorter to map it, which does in fact have a
#   destructive version!

# Practice Problem 7
# Create a hash that expresses the frequency of each letter in the string
statement = "The Flintstones Rock"
# For example:
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

# For each unique LETTER (case-sensitive) in the array of characters...
#   the value for that key is the count in that array
frequency = {}
statement.chars.uniq.each do |val| 
  if (('A'..'Z').to_a + ('a'..'z').to_a).include?(val)
    frequency[val] = statement.count(val)
  end
end
p frequency
# Complexity of this really just depends on the specifics of what's
#  actually being asked for.

# Problem 8
# The code:
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
# Outputs:
# 1
# 3

# The code:
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
# Outputs
# 1
# 2

# Problem 9
# Create a version of the titleize method that would turn
words = "the flintstones rock"
# into
# words = "The Flintstones Rock"

def titleize(str)
  str.gsub(/\b[a-zA-Z]/) {|match| match.upcase }
end

p titleize(words)
# Could also have split/join by ' ' and map it with the capitalize method

# Problem 10
# Given the hash
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# Give each member an additional "age_group" key such that:
# { "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  # "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  # "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  # "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  # "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }

munsters.each_pair do |key, val|
  if val["age"] < 18
    val["age_group"] = "kid"
  elsif val["age"] < 65
    val ["age_group"] = "adult"
  else
    val["age_group"] = "senior"
  end
end

p munsters
# Could also case statement the val["age"], and call when on a range instead
