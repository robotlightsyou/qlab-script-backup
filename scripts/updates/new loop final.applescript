--Ctrl+S LOOP PHOTO SLIDESHOW
(*
Tested with QLab v4.6.9 Mar 2021
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"

-- Original by:
   Figure53 Scripts and Macros Page
   Create slideshow from selected cues 
   Tim Rogers <timmrogers@gmail.com>
*)

global dialogTitle, myPreviousCue, myColor, myPostWait

set dialogTitle to "Make Looping Slideshow"
set myPreviousCue to 0
set myColor to "purple"

tell application id "com.figure53.QLab.4" to tell front workspace
	
	set myPostWait to my enterSomeText("Enter the number of seconds between slides:", "10", false)
	
	set myCues to (selected as list)
	set myCount to (count myCues)
	set loopStartTarget to first item of myCues
	
	repeat with eachCue in myCues
		set myID to uniqueID of eachCue
		
		tell the current cue list
			set playback position to cue id myID
		end tell
		
		-- for the first cue we only want to make the fade in
		if eachCue's contents is the first item of myCues then
			my make_fade("in", eachCue)
		else if myCount is 1 then
			-- make second to last fade out, last fade in, last fade out
			my make_fade("out", myPreviousCue)
			my make_fade("in", eachCue)
			my make_fade("out", myPreviousCue)
		else
			-- make every other fade out, fade in
			my make_fade("out", myPreviousCue)
			my make_fade("in", eachCue)
		end if
		
		set properties of eachCue to {q color:myColor, opacity:0, continue mode:auto_continue}
		set myCount to myCount - 1
	end repeat
	
	make type "Start"
	set startLoop to last item of (selected as list)
    set properties of startLoop to {cue target:loopStartTarget, q color:myColor}
	set cue target of startLoop to loopStartTarget
	
end tell

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

on make_fade(fadeType, targetCue)
	
	tell application id "com.figure53.qlab.4" to tell front workspace
		make type "Fade"
		set fadeCue to last item of (selected as list)
		set properties of fadeCue to {do opacity:true, cue target:targetCue, q color:myColor, q number:"", continue mode:auto_continue}
		if fadeType is "in" then
			set opacity of fadeCue to opacity of targetCue
			set post wait of fadeCue to MyPostWait
            set myPreviousCue to targetCue
		else
			set stop target when done of fadeCue to true
			set opacity of fadeCue to 0
		end if
	end tell
end make_fade