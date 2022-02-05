# Mortgage Calculator

# Note to self: Come back to this program later to refactor the validate method.
# Works fine, but is too complex and can be simplified into multiple, easier to read methods.


# Determines if a given input is a valid number
def validate(input)
  # First test: Is this a number?
  if input.to_f.to_s == input || input.to_i.to_s == input
    # Second test: Is this number NOT 0?
    if input.to_f != 0
      # Third test: Is this number positive?
      if input.to_f > 0
        return true
      else
        puts "Please enter a positive value."
      end
    else
      puts "Please enter a non-zero value."
    end
  else
    puts "Please input a numerical value."
  end
end

# Asks a question, obtains a response, and loops until a valid response is given
def prompt(question)
  loop do
    puts "=> " + question
    input = gets.chomp
    input.delete_suffix!("%")
    input.delete_prefix!("$")
    return input.to_f if validate(input)
  end
end

puts "=> Welcome to Mortgage Calculator!"

loan_amount = prompt("How much is the loan for in dollars?")
apr = prompt("What is the loan's APR as a percentage?") * 0.01
duration_months = prompt("What is the duration of the loan in months?")

monthly_interest = apr / 12.0

monthly_payment = loan_amount * (monthly_interest /
                  (1 - (1 + monthly_interest)**(-duration_months)))

puts "The monthly payment for this loan is $#{monthly_payment.ceil(2)}"
