# exercise1. Gets user input and calls a series of validation rules to validate the DLN,
# Either prints a series of errors if user provided DLN is invalid
# Or prints a series of user details for the provided DLN
def exercise1
  input_dln = get_input
	errors = []
	errors << "Invalid length dln \nneeds to be length 9\nwas length #{input_dln.length}" unless input_dln.length == 9

	if errors.empty?
		errors.concat(validate_dln_surname(input_dln[0, 4]))
		errors.concat(validate_dln_year(input_dln[4, 2]))
		errors.concat(validate_dln_month(input_dln[6, 2]))
		errors.concat(validate_dln_forename(input_dln[-1]))
	end

	if errors.empty?
		surname, year_of_birth, month_of_birth, forename = generate_user_details(input_dln)
		puts "\nthe dln's details are \n Surname: #{surname} \n Birth year: #{year_of_birth} \n Birth month: #{month_of_birth} \n Forename: #{forename}"
	else
		puts "\nYour submitted DLN raised the following errors:"
		puts errors
	end
end
  
# get_input. gets user input DLN to check validity
# @return [String]. A String containing the user input DLN to be validated
def get_input
	puts 'Please enter your dln'
	gets.chomp
end
  
# validate_dln_surname. Checks to see if the provided surname part of DLN is valid
# @param [String] surname. Four character surname section of input dln to be checked for validity
# @return [Array] errors. An array of the error messages generated or empty array if surname is valid
def validate_dln_surname(surname)
	errors = []
	errors << 'Invalid Surname part: Any alpha characters must be upper case' unless surname.upcase == surname
	errors << 'Invalid Surname part: Surname must be alpha characters or *' if surname.upcase.split('').any? { |character| character.match?(/[^A-Z\*]/) }
	if errors.empty? && !surname.match?(/[A-Z]{4}|[A-Z]{3}\*|[A-Z]{2}\*{2}|[A-Z]\*{3}/)
		errors << 'Invalid Surname part: Surname must follow A*** AA** AAA* or AAAA where A is any alpha character'
	end
	errors
end

# validate_dln_year. Checks to see if the provided year part of DLN is valid
# @param [String] year_part. Two character year section of input dln to be checked for validity
# @return [Array] errors. An array of the error messages generated or empty array if year_part is valid
def validate_dln_year(year_part)
	errors = []
	errors << 'Invalid Year part: year must be two numeric characters' unless year_part.match?(/\d{2}/)
	errors
end

# validate_dln_month. Checks to see if the provided month part of DLN is valid
# @param [String] month_part. Two character month section of input dln to be checked for validity
# @return [Array] errors. An array of the error messages generated or empty array if month_part is valid
def validate_dln_month(month_part)
	errors = []
	errors << 'Invalid Month part: month must be two numeric characters' unless month_part.match?(/\d{2}/)
	if errors.empty? && !month_part.match?(/0[1-9]|1[012]/)
		errors << "Invalid Month part: #{month_part} is an invalid month of the year"
	end
	errors
end

# validate_dln_forename. Checks to see if the provided forename part of DLN is valid
# @param [String] forename. Single character forename section of input dln to be checked for validity
# @return [Array] errors. An array of the error messages generated or empty array if forename is valid
def validate_dln_forename(forename)
	errors = []
	errors << 'Invalid Forename part: Must be uppercase alpha character' unless forename.match?(/[A-Z]/)
	errors
end

# generate_user_details. Calculates the user details based on the provided DLN
# @param [String] input_dln. 9 character DLN from which to extract personal details
# @return [Array<(String, String, String, String)>]. An array of surname, year_of_birth, month_of_birth and forename extracted from the input_dln
def generate_user_details(input_dln)
	surname = input_dln[0, 4].delete('*')
	year_of_birth = input_dln[4, 2].to_i < 50 ? "20#{input_dln[4, 2]}" : "19#{input_dln[4, 2]}"
	month_of_birth = input_dln[6, 2]
	forename = input_dln[-1]
	[surname, year_of_birth, month_of_birth, forename]
end

exercise1