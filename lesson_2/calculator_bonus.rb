# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(string)
  Kernel.puts("=> #{string}")
end

def integer?(num)
  num.to_i().to_s() == num
end

def float?(num)
  num.to_f().to_s() == num
end

def number?(num)
  integer?(num) || float?(num)
end

def operation_to_message(operator)
  word =  case operator
          when '1'
            'Adding'
          when '2'
            'Subracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
          end
  word
end

prompt(messages('welcome', LANGUAGE))
name = ''
loop do
  name = Kernel.gets().chomp().capitalize()
  if name.empty?()
    prompt(messages('valid_name', LANGUAGE))
  else
    break
  end
end
prompt("Hello #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt(messages('first_number', LANGUAGE))
    number1 = Kernel.gets().chomp()

    if number?(number1)
      break
    else
      prompt(messages('invalid_number', LANGUAGE))
    end
  end

  number2 = ''
  loop do
    prompt(messages('second_number', LANGUAGE))
    number2 = Kernel.gets().chomp()

    if number?(number2)
      break
    else
      prompt(messages('invalid_number', LANGUAGE))
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?:
    1) Add
    2) Subtract
    3) Multiply
    4) Divide
  MSG
  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('invalid_operator', LANGUAGE))
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result =  case operator
            when '1'
              number1.to_i() + number2.to_i()
            when '2'
              number1.to_i() - number2.to_i()
            when '3'
              number1.to_i() * number2.to_i()
            when '4'
              number1.to_f() / number2.to_f()
            end

  prompt("The result is #{result}.")

  prompt(messages('repeat', LANGUAGE))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(messages('goodbye', LANGUAGE))
