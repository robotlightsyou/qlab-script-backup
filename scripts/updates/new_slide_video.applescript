--Shft+Op+V Make new slide with fades
global dialogTitle
set dialogTitle to "Make New Video Sequence"

tell application id "com.figure53.qlab.4" to tell front workspace
	
	set surf to my enterSomeText("Which surface?", "1", false)
	set qNum to my enterSomeText("What Q number?", "1", false)
	
	make type "Video"
	set newQ to last item of (selected as list)
	set properties of newQ to {opacity:0, continue mode:auto_continue, q color:"purple", q number:qNum, notes:"Surface " & surf}
	
	set fadeIn to my make_fade("in", newQ, surf, qNum)
	
	make type "Group"
	set groupQ to last item of (selected as list)
	set q number of groupQ to "P" & qNum
	set notes of groupQ to "Surface " & surf
	set myQs to {newQ, cue id fadeIn}
	repeat with eachQ in myQs
		tell parent of eachQ
			set eachQID to uniqueID of eachQ
			move cue id eachQID to end of groupQ
		end tell
	end repeat
	
	set outCue to my make_fade("out", newQ, surf, qNum)
	set cue target of cue id outCue to groupQ
	
	tell current cue list
		set playback position to newQ
	end tell
	
end tell

on make_fade(fadeType, targetCue, mySurface, myQnum)
	
	tell application id "com.figure53.qlab.4" to tell front workspace
		make type "Fade"
		set fadeCue to last item of (selected as list)
		set properties of fadeCue to {do opacity:true, cue target:targetCue, q color:"purple", notes:"Surface " & mySurface}
		if fadeType is "in" then
			set opacity of fadeCue to 100
			set q number of fadeCue to "In" & myQnum
		else
			set stop target when done of fadeCue to true
			set opacity of fadeCue to 0
			set q number of fadeCue to "Out" & myQnum
		end if
		
		return uniqueID of fadeCue
	end tell
end make_fade

--subroutines
-- this is the main part to copy if you reuse it, but don't forget the dialogTitle
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
