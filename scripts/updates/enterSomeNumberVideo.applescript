global dialogTitle
set dialogTitle to "Subroutine Demo"

-- the following block is only for demo purposes, though you can use the set someText line
-- as a prototype for calling this function
tell application id "com.figure53.QLab.4" to tell front workspace
	set someText to my enterSomeText("Please enter a number.", "1", false)
	display dialog someText
end tell

--subroutines
-- this is the main part to copy if you reuse it, but don't forget the dialogTitle
on enterSomeText(thePrompt, defaultAnswer, emptyAllowed) -- [Shared subroutine] - Rich Walsh - allthatyouhear.com
	tell application id "com.figure53.QLab.4"
		set theAnswer to ""
		repeat until theAnswer is not ""
			set theAnswer to text returned of (display dialog thePrompt with title dialogTitle default answer defaultAnswer buttons {"Cancel", "OK"} default button "OK" cancel button "Cancel")
			if theAnswer is not "" then
				try
					set theAnswer to theAnswer as number
				on error
					if emptyAllowed is true then exit repeat    
					display dialog "That was not a valid number, please try again."
					set theAnswer to ""
				end try
			end if
			if emptyAllowed is true then exit repeat
		end repeat
		return theAnswer
	end tell
end enterSomeText
