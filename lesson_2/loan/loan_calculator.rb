require 'yaml'
MESSAGES = YAML.load_file('loan_calculator.yml')

def prompt(string)
  puts "=> #{string}"
end

def valid_input?(num)
  num.to_i != 0 || num.to_f != 0.0
end

def valid_apr?(num)
  num == '0' || num.to_f.to_s == num || num.to_i.to_s == num
end

system('clear')

prompt(MESSAGES['welcome'])

sleep(1.5)

name = ''
loop do
  prompt(MESSAGES['name'])
  name = gets.chomp.capitalize
  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

intro = <<-MSG
  Hello #{name}! We are going to collect some information from you to calculate your monthly loan payments. Let's get started!
MSG
prompt(intro)

sleep(2.5)

loop do
  loan_amount = ''
  loop do
    prompt(MESSAGES['loan_amount'])
    loan_amount = gets.chomp

    if valid_input?(loan_amount)
      break
    else
      prompt(MESSAGES['invalid_entry'])
    end
  end

  loan_duration = ''
  loop do
    prompt(MESSAGES['loan_duration'])
    loan_duration = gets.chomp

    if valid_input?(loan_duration)
      break
    else
      prompt(MESSAGES['invalid_entry'])
    end
  end

  loan_apr = ''
  loop do
    prompt(MESSAGES['loan_apr'])
    loan_apr = gets.chomp

    if valid_apr?(loan_apr)
      break
    else
      prompt(MESSAGES['invalid_entry'])
    end
  end

  prompt("We're good to go #{name}! Please wait while we calculate...")
  prompt("")

  sleep(2)

  monthly_interest_rate = (loan_apr.to_f / 100) / 12
  monthly_duration = loan_duration.to_f * 12

  if monthly_interest_rate == 0.0
    monthly_payment = loan_amount.to_f / monthly_duration
  else
    monthly_payment = loan_amount.to_f * (monthly_interest_rate / (
      1 - (1 + monthly_interest_rate)**(-monthly_duration)))
  end

  prompt("With a mortgage loan of $#{loan_amount} and an APR of #{loan_apr}%,"\
  " your monthly payment is $#{format('%.2f', monthly_payment)}.")
  prompt("")

  sleep(3.5)

  prompt(MESSAGES['repeat'])
  repeat = gets.chomp.downcase
  break unless repeat.start_with?('y')

  system('clear')
end

prompt("")
prompt(MESSAGES['goodbye'])
