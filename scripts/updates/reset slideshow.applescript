(*
Tested with QLab v4.6.9 Mar 2021
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"

How to delete cue with applescript:
https://groups.google.com/g/qlab/c/0GHE4sPD7QU?pli=1
*)

tell application id "com.figure53.QLab.4" to tell front workspace
	repeat with eachCue in (selected as list)
		if q type of eachCue is "Start" or q type of eachCue is "Fade" then
			set eachCueID to uniqueID of eachCue
			delete cue id eachCueID of parent of eachCue
		else if q type of eachCue is "Video" then
			set properties of eachCue to {q color:"None", continue mode:do_not_continue, opacity:100}
		end if
	end repeat
	set myVids to cues of current cue list whose q type is "video"
	set selected to myVids
end tell
