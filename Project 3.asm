TITLE Program Template     (template.asm)

; Author: Brad Goodlett
; Course / Project ID Date: Program 3
; Description: average of negative numbers

INCLUDE Irvine32.inc

lowerLimit = -100

.data
	intro_1					byte		"Hi, My name is Brad Goodlett", 0
	intro_2					byte		"This program is called Negative Average, and calculates",
										"the average of a list negative numbers you type in between",
										" -1 and -100", 0
	intro_3					byte		"Please enter your name: ", 0
	intro_4					byte		"Hello, ", 0
	intro_4_2 				byte		"! Please enter a Negative number between -1 and -100,",
										" then enter a non negative number to see your average.", 0
	prompt					byte		"Please enter a negative number:", 0
	outro_1					byte		"The average value you typed is ", 0
	outro_1_1				byte		" out of: ", 0
	outro_1_2				byte		" numbers.", 0
	outro_1_3				byte		"The sum of the numbers you entered was ", 0
	outro_2					byte		"Goodbye ",0
	outro_2_2				byte		"!",0
	noInputsEntered			byte		"You didn't enter any negative numbers.", 0
	userName				byte		21 DUP(0)
	inputs					dword		0
	amountOfInupts			dword		0

.code
main PROC

	;introduce myself and the program
	mov edx, offset intro_1
	call writeString
	call CrLf
	mov edx, offset intro_2
	call writeString
	call CrLf

	;has the user enter their name, stores it in the userName variable and greets them by name
	mov edx, offset intro_3			;"Please enter your name: "
	call writeString
	mov edx, offset userName
	mov ecx, 20						;take a name with 20 character max
	call readString
	call CrLf
	mov edx, offset intro_4			;"Hello, "
	call writeString
	mov edx, offset userName		;prints userName
	call writeString
	mov edx, offset intro_4_2		;"! Please enter a Negative number between -1 and -100,
	call writeString				; then enter a non negative number to see your average."
	call CrLf

	;take input over and over from the user while checking if it is within the range requested
	;if the user's input is outside of the range, discard it and return the average
	_withinRange:
	mov edx, offset prompt
	call writeString
	call readInt	
	cmp eax, 0						;check to see if the value entered is less than 0
	jl _between						;jump to the second check if the value is < 0
	jmp _returnAverage				;jump to the return average part if the value is > 0

	_between:						;check if the number is > -100
	cmp eax, lowerLimit				;compare the number to -100
	jge _add						;jump to the addition section if the number is within the range
	jmp _returnAverage				;jump to the return average part it the value is < -100

	_add:							;adds the user's input value to the total sum of values and increments the amout of values added
	add inputs,eax					;adds the value to the sum
	inc amountOfInupts				;increments the total number of values in the sum
	jmp _withinRange				;jump to the begining of the loop to take in another number

	_returnAverage:					;returns the 
	mov eax, amountOfInupts			
	cmp eax, 0						;make sure there are more than 0 inputs total
	jge _numbersEntered				;if there are inputs go to the block that returns the average
	jmp _noInputs					;if there are no inputs go to the block that tells the user there are no inputs instead of doing the math and breaking the program because of dividing by 0

	_numbersEntered:				;do the math to return the average, return the sum, and return the amount of inputs
	mov edx, offset outro_1			
	call writeString	
	mov eax, inputs					
	cdq								;still not entirely sure what this does but it made the program stop crashing and
									;some dude on stackoverflow said it would work and it did
	idiv amountOfInupts				
	call writeInt					;print the average value to the user
	mov edx, offset outro_1_1		
	call writeString	
	mov eax, amountOfInupts	
	call writedec					;print the total amount of inputs to the user
	mov edx, offset outro_1_2	
	call writeString	
	call crlf	
	mov edx, offset outro_1_3	
	call writestring	
	mov eax, inputs	
	call writeInt					;print the total sum of the values to the user
	call crlf	
	jmp _outro						;jump to the outro

	_noInputs:						;tell the user there were no inputs
	mov edx, offset noInputsEntered
	call writeString	

	_outro:							;print "Goodbye {username}!"
	mov edx, offset outro_2
	call writeString
	mov edx, offset userName
	call writeString
	mov edx, offset outro_2_2
	call writeString
	call crlf


	exit	
main ENDP
END main
