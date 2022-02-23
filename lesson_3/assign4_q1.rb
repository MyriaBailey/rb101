# Assignment 4: Question 1

=begin
For this practice problem, write a one-line program that creates the following output 10 times, 
with the subsequent line indented 1 space to the right:

The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock!
=end

10.times { |idx| puts (' ' * idx) + "The Flintstones Rock!" }