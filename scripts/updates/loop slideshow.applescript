--Ctrl+S LOOP PHOTO SLIDESHOW
(*
Tested with QLab v3.2.14 Oct 2018
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 3 template issues"
*)

-- Create slideshow from selected cues
-- Tim Rogers <timmrogers@gmail.com>

global dialogTitle, finalPostWait
set dialogTitle to "Photo Slideshow"
set finalPostWait to "0"

tell application id "com.figure53.QLab.4" to tell front workspace
	
	set myPostWait to my enterSomeText("Enter the number of seconds between cues:", "10", false)	
	
	set mySelected to (selected as list)
	set myCount to (count mySelected)
	set loopStartTarget to first item of mySelected
	
	repeat with myCurrentCue in mySelected
		
		-- Get the uniqueID of the current cue
		set myID to uniqueID of myCurrentCue
		
		-- Move the selection to the current cue        
		tell the current cue list
			set playback position to cue id myID
		end tell
		
		-- Set opacity and continue mode of the current cue
		set opacity of myCurrentCue to 0
		set continue mode of myCurrentCue to auto_continue
		
		if myCurrentCue's contents is the first item of mySelected then
			
			
			-- Make new fade cue
			make type "Fade"
			-- and find its name
			set myNewCueList to selected
			set myNewCue to last item of myNewCueList
			-- and set its target, opacity, and post wait
			display dialog myCurrentCue
			set cue target of myNewCue to myCurrentCue
			set opacity of myNewCue to 100
			set do opacity of myNewCue to true
			set post wait of myNewCue to myPostWait
			set continue mode of myNewCue to auto_continue
			-- Set previous cue
			set myPreviousCue to myCurrentCue
			set myCount to myCount - 1
			
			-- Otherwise
			
		else if myCount is 1 then
			-- Make new fade cue
			make type "Fade"
			-- and find its name
			set myNewCueList to selected
			set myNewCue to last item of myNewCueList
			-- and set its target and opacity
			set cue target of myNewCue to myCurrentCue
			set opacity of myNewCue to 100
			set do opacity of myNewCue to true
			set continue mode of myNewCue to auto_continue
			
			
			-- Make new fade-and-stop cue
			
			make type "Fade"
			-- and find its name
			set myNewCueList to selected
			set myNewCue to last item of myNewCueList
			-- and set its target, opacity, post wait, and stop
			set cue target of myNewCue to myPreviousCue
			set opacity of myNewCue to 0
			set do opacity of myNewCue to true
			set post wait of myNewCue to myPostWait
			set stop target when done of myNewCue to true
			set continue mode of myNewCue to auto_continue
			-- Set previous cue
			set myPreviousCue to myCurrentCue
			set myCount to myCount - 1
			
			--make last fade and stop
			make type "Fade"
			-- and find its name
			set myNewCueList to selected
			set myNewCue to last item of myNewCueList
			-- and set its target, opacity, post wait, and stop
			set cue target of myNewCue to myPreviousCue
			set opacity of myNewCue to 0
			set do opacity of myNewCue to true
			set post wait of myNewCue to finalPostWait
			set stop target when done of myNewCue to true
			set continue mode of myNewCue to auto_continue
			-- Set previous cue
			set myPreviousCue to myCurrentCue
			set myCount to myCount - 1
			
			
		else
			display dialog (q name of myCurrentCue)
			set origOpacity to opacity of myCurrentCue
			set newCue to my makeNewFades(myCurrentCue, selected as list)
			set opacity of myNewCue to origOpacity
			set do opacity of myNewCue to true
			(*)
			-- Make new fade cue
			make type "Fade"
			-- and find its name
			set myNewCueList to selected
			set myNewCue to last item of myNewCueList
			-- and set its target and opacity
			set cue target of myNewCue to myCurrentCue
			set opacity of myNewCue to 100
			set do opacity of myNewCue to true
			set continue mode of myNewCue to auto_continue
			-- Make new fade-and-stop cue
		*)	
			make type "Fade"
			-- and find its name
			set myNewCueList to selected
			set myNewCue to last item of myNewCueList
			-- and set its target, opacity, post wait, and stop
			set cue target of myNewCue to myPreviousCue
			set opacity of myNewCue to 0
			set do opacity of myNewCue to true
			set post wait of myNewCue to myPostWait
			set stop target when done of myNewCue to true
			set continue mode of myNewCue to auto_continue
			-- Set previous cue
			set myPreviousCue to myCurrentCue
			set myCount to myCount - 1
			
			
		end if
		
		
	end repeat
	
	make type "Start"
	set loopStart to last item of (selected as list)
	set cue target of loopStart to loopStartTarget
	
end tell

on makeNewFades(currentQ, selectedQs)
	tell application id "com.figure53.QLab.4" to tell front workspace
		-- Make new fade in cue
		make type "Fade"
		-- and find its name
		set myNewCueList to selectedQs
		set myNewCue to last item of myNewCueList
		-- and set its target and opacity
		set cue target of myNewCue to currentQ
		set continue mode of myNewCue to auto_continue
		display dialog q name of currentQ
		return myNewCue
		(*
		-- Make new fade-and-stop cue
		make type "Fade"
		-- and find its name
		set myNewCueList to selected
		set myNewCue to last item of myNewCueList
		-- and set its target, opacity, post wait, and stop
		set cue target of myNewCue to myPreviousCue
		set opacity of myNewCue to 0
		set do opacity of myNewCue to true
		set post wait of myNewCue to myPostWait
		set stop target when done of myNewCue to true
		set continue mode of myNewCue to auto_continue
		-- Set previous cue
		set myPreviousCue to myCurrentCue
		set myCount to myCount - 1
		*)
	end tell	
end makeNewFades

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