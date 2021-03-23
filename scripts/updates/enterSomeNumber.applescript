global dialogTitle
set dialogTitle to "Get a number"

tell application id "com.figure53.QLab.4"
	set myPost to my enterSomeNumber("What number?", "1", false)
    display dialog myPost
end tell

-- [Shared subroutine] - based on enterSomeText from - Rich Walsh - allthatyouhear.com	
on enterSomeNumber(thePrompt, defaultAnswer, emptyAllowed)
	tell application id "com.figure53.QLab.4"
		set theAnswer to ""
		repeat until theAnswer is not ""
			try
				set theAnswer to (text returned of (display dialog thePrompt with title dialogTitle default answer defaultAnswer buttons {"Cancel", "OK"} default button "OK" cancel button "Cancel")) as number
				if emptyAllowed is true then exit repeat
			on error
				if emptyAllowed is true then exit repeat
				display dialog "Not a valid number, press 'cancel' to exit."
			end try
		end repeat
		return theAnswer
	end tell
end enterSomeNumber
