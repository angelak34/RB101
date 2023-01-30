require 'yaml'
MESSAGES = YAML.load_file('loan_calculator.yml')

def prompt(string)
  puts "=> #{string}"
end

def prompt_name
  prompt(MESSAGES['name'])
  loop do
    name = gets.chomp.capitalize
    if name.empty?
      prompt(MESSAGES['valid_name'])
    else
      return name
    end
  end
end

def display_name(name)
  prompt("Hello " + name + "! We are going to collect some information" \
  "from you to calculate your monthly loan payments. Let's get started!")
  prompt("")
end

def valid_input?(num)
  num.to_i > 0 || num.to_f > 0.0
end

def valid_apr?(num)
  num == '0' || num.to_f > 0.0 || num.to_i > 0
end

def prompt_loan_amount
  prompt(MESSAGES['loan_amount'])
  loop do
    loan_amount = gets.chomp

    if valid_input?(loan_amount)
      return loan_amount.to_f
    else
      prompt(MESSAGES['invalid_entry'])
    end
  end
end

def prompt_loan_duration
  prompt(MESSAGES['loan_duration'])
  loop do
    loan_duration = gets.chomp

    if valid_input?(loan_duration)
      return loan_duration.to_f
    else
      prompt(MESSAGES['invalid_entry'])
    end
  end
end

def prompt_loan_apr
  prompt(MESSAGES['loan_apr'])
  loop do
    loan_apr = gets.chomp

    if valid_apr?(loan_apr)
      return loan_apr.to_f
    else
      prompt(MESSAGES['invalid_entry'])
    end
  end
end

def ready_to_calculate(name)
  prompt("We're good to go " + name + "! Please wait while we calculate...")
  prompt("")
end

def calculate_monthly_payment(loan_apr, loan_amount, loan_duration)
  monthly_interest_rate = (loan_apr / 100) / 12
  monthly_duration = loan_duration * 12

  if monthly_interest_rate == 0.0
    monthly_payment = loan_amount / monthly_duration
  else
    monthly_payment = loan_amount * (monthly_interest_rate / (
      1 - (1 + monthly_interest_rate)**(-monthly_duration)))
  end
  format('%.2f', monthly_payment)
end

def display_monthly_payment(loan_amount, loan_apr, monthly_payment)
  prompt("With a mortgage loan of $" + loan_amount.to_s + " and an APR of " +
  loan_apr.to_s + "%, your monthly payment is $" + monthly_payment.to_s + ".")
  prompt("")
end

def continue?
  prompt(MESSAGES['repeat'])
  repeat = gets.chomp.downcase
  repeat.start_with?('y')
end

system('clear')

prompt(MESSAGES['welcome'])

sleep(1.5)

name = prompt_name
display_name(name)

sleep(2.5)

loop do
  loan_amount = prompt_loan_amount
  loan_duration = prompt_loan_duration
  loan_apr = prompt_loan_apr

  ready_to_calculate(name)

  sleep(2)

  monthly_payment =
    calculate_monthly_payment(loan_apr, loan_amount, loan_duration)

  display_monthly_payment(loan_amount, loan_apr, monthly_payment)

  sleep(3.5)

  break unless continue?

  system('clear')
end

prompt("")
prompt(MESSAGES['goodbye'])
