--Shift+Op+\ RESET CROSSPOINTS STEREO
(*
Tested with QLab v3.2.14 Oct 2018
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 3 template issues"
*)

global dialogTitle
set dialogTitle to "Reset crosspoints to stereo"

tell application id "com.figure53.QLab.4" to tell front workspace
	
	repeat with targetQ in (selected as list)
		--set numInputs to my enterSomeText("How many outputs?", "2", false)
		set numInputs to "10"
		
		set output to "1"
		set chan to "1"
		
		--this section clears current crosspoints
		repeat with i from 1 to numInputs by 1
			set myOSC to "/cue/" & (q number of targetQ) & "/level/" & chan & "/" & i & " {}"
			do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
			set chan to chan + "1"
			
			set myOSC to "/cue/" & (q number of targetQ) & "/level/" & chan & "/" & i & " {}"
			do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
			set chan to "1"
			set output to output + "1"
			
		end repeat
		
		--this section applies stereo output to crosspoints
		repeat with i from 1 to 2 by 2
			set output to "1"
			set chan to "1"
			set myOSC to "/cue/" & (q number of targetQ) & "/level/" & chan & "/" & i & " 0"
			do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
		end repeat
		set chan to chan + "1"
		
		repeat with i from 2 to 2 by 2
			set myOSC to "/cue/" & (q number of targetQ) & "/level/" & chan & "/" & i & " 0"
			do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
		end repeat
		
		--this section adds sub for DV theatre
		
		set chan to "1"
		set myOSC to "/cue/" & (q number of targetQ) & "/level/" & chan & "/7 0"
		do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
		set chan to chan + "1"
		set myOSC to "/cue/" & (q number of targetQ) & "/level/" & chan & "/7 0"
		do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
		
		
	end repeat
end tell

--subroutines
on enterSomeText(thePrompt, defaultAnswer, emptyAllowed) -- [Shared subroutine]
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