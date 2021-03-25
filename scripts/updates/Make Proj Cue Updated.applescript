--Op+P Make Proj Cue ask Input
(*
Tested with QLab v4.6.9 Mar 2021
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"
*)

global dialogTitle
set dialogTitle to "Make Projector Cues"

tell application id "com.figure53.QLab.4" to tell front workspace
	
	set actionsList to {"AVUnMute ", "AvMute ", "Inpt ", "PowerOn ", "PowerOff "}

	set whichAction	to my enterSomeText("Which action would you like to perform? Please enter the number from below:
	
	1 - AV UnMute
	2 - AV Mute
	3 - Change Input
	4 - Power On
	5 - Power Off", "1", false)

	set userChoice to item whichAction of actionsList

	set projectors to my enterSomeText("Which projectors? You can separate multiple entries with spaces.", "1", false)
	
	--next block converts user input to functional data --Rich Walsh allthatyouhear.com
	set currentTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to space
	set projWords to text items of projectors
	set howManyProjs to count projWords
	set AppleScript's text item delimiters to "\\"
	set backToText to projWords as text
	set projArray to text items of backToText
	set countProjArray to count projArray
	set AppleScript's text item delimiters to currentTIDs
	
	repeat with i from 1 to countProjArray by "1"
		set myOutput to (item i of projArray)
		my makeNewScript(userChoice, myOutput)
	end repeat
end tell


on makeNewScript(myCue, output)
	tell application id "com.figure53.QLab.4" to tell front workspace
		set preamble to "tell application \"ProjectorManager\"
"
		
		set ending to "
end tell"
		make type "Script"
		set newQ to last item of (selected as list)
		set scriptText to preamble & myCue & output & ending
		set the properties of newQ to {q name:(myCue & output as string), script source:scriptText}
		
	end tell
end makeNewScript


on enterSomeText(thePrompt, defaultAnswer, emptyAllowed) -- [Shared subroutine] --Rich Walsh allthatyouhear.com
	tell application id "com.figure53.QLab.4"
		set theAnswer to ""
		repeat until theAnswer is not ""
			set theAnswer to text returned of (display dialog thePrompt with title dialogTitle default answer defaultAnswer buttons {"Cancel", "OK"} default button "OK" cancel button "Cancel")
			if emptyAllowed is true then exit repeat
		end repeat
		return theAnswer
	end tell
end enterSomeText

