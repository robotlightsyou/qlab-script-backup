--Op+\ ISOLATE AUDIO
(*
Tested with QLab v4.6.9 Mar 2021
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"
*)

global dialogTitle
set dialogTitle to "Adjust crosspoints to isolate"

tell application id "com.figure53.QLab.4" to tell front workspace
	repeat with targetQ in (selected as list)

		set numOutputs to "10"
		set isoOutput to my enterSomeText("Isolate to which output? You can separate multiple entries with spaces.", "1", false)
		set numChan to my enterSomeText("How many channels?", "2", false)
		
		--next block converts user input to functional data
		set currentTIDs to AppleScript's text item delimiters
		set AppleScript's text item delimiters to space
		set levelsWords to text items of isoOutput
		set howManyLevels to count levelsWords
		set AppleScript's text item delimiters to "\\"
		set backToText to levelsWords as text
		set levelsArray to text items of backToText
		set countLevelsArray to count levelsArray
		set AppleScript's text item delimiters to currentTIDs
        
        --clear existing levels
        my setNewLevel(targetQ, numOutputs, numChan, "{}", levelsArray)
        --apply new values
        my setNewLevel(targetQ, numOutputs, numChan, "0", levelsArray)

	end repeat
end tell

--subroutines
on enterSomeText(thePrompt, defaultAnswer, emptyAllowed) -- [Shared subroutine] - Rich Walsh - allthatyouhear.com
	tell application id "com.figure53.QLab.4"
		set theAnswer to ""
		repeat until theAnswer is not ""
			set theAnswer to text returned of (display dialog thePrompt with title dialogTitle default answer defaultAnswer buttons {"Cancel", "OK"} default button "OK" cancel button "Cancel")
			if emptyAllowed is true then exit repeat
		end repeat
		return theAnswer
	end tell
end enterSomeText

on newChannelLevel(target, theChannel, output, theLevel)
    tell application id "com.figure53.QLab.4" to tell front workspace
        set myOSC to "/cue/" & (q number of target) & "/level/" & theChannel & "/" & output & " " & theLevel
        do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
    end tell
end newChannelLevel

on setNewLevel(target, countInputs, countChannels, myLevel, myArray)
    repeat with i from 1 to countInputs by 1
        repeat with j from 1 to countChannels
            if myLevel is equal to "{}" then
                set mySetting to i
            else
                set mySetting to (item i of myArray)
            end if
            set chan to j
            my newChannelLevel(target, chan, mySetting, myLevel)
        end repeat
    end repeat
end setNewLevel