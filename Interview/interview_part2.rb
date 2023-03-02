require 'i18n'
require 'date'
I18n.config.available_locales = :en

# exercise2. Gets user input and calls series of validation rules to validate input for generating a DLN,
# Either prints a series of errors if user provided information is invalid for generating a DLN
# Or prints a DLN generated from the user details
def exercise2
  first_name, surname, date_of_birth = get_inputs
  errors = []

  # initial basic length and regex validations
  errors << 'First name needs to contain at least 1 character' if first_name.empty?
  errors << 'Surname needs to contain at least 1 character' if surname.empty?
  errors << 'date of birth in incorrect format, needs to be DD/MM/YYYY' unless date_of_birth.match?(/\d{2}\/\d{2}\/\d{4}/)

  if errors.empty?
    first_name = format_name(first_name)
    surname = format_name(surname)
    # more indepth data validation
    errors.concat(validate_first_name(first_name))
    errors.concat(validate_surname(surname))
    errors.concat(validate_date_of_birth(date_of_birth))
  end

  if errors.empty?
    dln = generate_dln(first_name, surname, date_of_birth)
    puts "\nYour generated dln: #{dln}"
  else
    puts "\nYour submitted data raised the following errors:"
    puts errors
  end
end

# get_input. gets user input details needed to generate a DLN
# @return [Array<(String, String, String)>]. An Array containing the user input first_name, surname and date_of_birth to be validated
def get_inputs
  puts 'enter your first name'
  first_name = gets.chomp
  puts 'enter your surname'
  surname = gets.chomp
  puts 'enter your date of birth in DD/MM/YYYY format'
  date_of_birth = gets.chomp
  [first_name, surname, date_of_birth]
end

# format_name. Formats the input string into latin characters
# @param [String] name. String input name to be formatted into closest latin characters e.g. Æ -> AE and removing other special characters e.g.' -
# @return [String]. String of formatted name
def format_name(name)
  name = I18n.transliterate(name)
						 .split('')
      		   .select { |letter| letter if letter.match?(/[A-z]/) }
             .join
             .upcase
end

# validate_first_name. Checks to see if the formatted first name details provided are valid
# @param [String] first_name. String of characters for first_name to be checked for validity
# @return [Array] errors. An array of the error messages generated or empty array if first_name is valid
def validate_first_name(first_name)
  errors = []
  errors << 'First name only contains invalid characters' if first_name.empty?
  errors
end

# validate_surname. Checks to see if the formatted surname details provided are valid
# @param [String] surname. String of characters for surname to be checked for validity
# @return [Array] errors. An array of the error messages generated or empty array if surname is valid
def validate_surname(surname)
  errors = []
  errors << 'Surname only contains invalid characters' if surname.empty?
  errors
end

# validate_date_of_birth. Checks to see if the provided date of birth string is valid
# @param [String] date_of_birth. String representation of date of birth to be checked for validity
# @return [Array] errors. An array of the error messages generated or empty array if date_of_birth is valid
def validate_date_of_birth(date_of_birth)
  errors = []
  day_of_birth, month_of_birth, year_of_birth = date_of_birth.split('/')
  errors << 'invalid Date submitted' unless Date.valid_date?(year_of_birth.to_i, month_of_birth.to_i, day_of_birth.to_i)
  errors << "Sorry, your birth year #{year_of_birth} is too far in the past so we can't represent it" if year_of_birth.to_i < 1950
  errors << "Sorry, your birth year #{year_of_birth} is too far in the future so we can't represent it" if year_of_birth.to_i > 2049
  errors
end


# generate_dln. Calculates the DLN based on the user provided details
# @param [String] first_name. String of formatted characters for first_name to be used in DLN generation
# @param [String] surname. String of formatted characters for surname to be used in DLN generation
# @param [String] date_of_birth. String representation for date_of_birth to be used in DLN generation
# @return [String]. 9 character string representing the DLN generated for the provided user details
def generate_dln(first_name, surname, date_of_birth)
  pad = '*'
  surname = if surname.length < 4
              surname + (pad * (4 - surname.length))
            else
              surname[0, 4]
            end
  surname + date_of_birth[8, 2] + date_of_birth[3, 2] + first_name[0]
end

exercise2