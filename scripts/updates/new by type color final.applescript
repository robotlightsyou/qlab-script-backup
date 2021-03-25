--Shift+Op+C SET COLOR BY TYPE
(*
Tested with QLab v3.2.14 Oct 2018
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 3 template issues"
*)

(*
This script intednded to add cue colors to all selected cues based on the type of cue.

NEEDS:
1. Currently applying to all cue lists, not selected cues
2. add test for if color red do nothing to not lose misplaced cues
*)

tell application id "com.figure53.QLab.4" to tell front workspace
	set selectedCues to (selected as list)
	repeat with targetQ in selectedCues
		set colorQ to uniqueID of targetQ
		
		if q color of targetQ is "red" then
			my setColor(colorQ, "red")
			
		else if q type of targetQ is "group" then
			my setColor(colorQ, "green")
			
		else if q type of targetQ is in {"network", "midi", "midi file", "timecode", "script"} then
			my setColor(colorQ, "blue")
			
		else if q type of targetQ is in {"audio", "video", "camera", "text", "mic", "fade", "light"} then
			my setColor(colorQ, "purple")
			
		else if q type of targetQ is in {"target", "stop", "start", "goto", "devamp", "load", "pause", "reset"} then
			my setColor(colorQ, "grey")
			
		else if q type of targetQ is in {"arm", "disarm", "wait"} then
			my setColor(colorQ, "orange")
			
		else if q type of targetQ is "memo" then
			my setColor(colorQ, "yellow")
			
		end if
	end repeat
	
end tell
(*)
on setColor(userCue, userColor)
	set myColor to "green"
	set myOSC to "/cue_id/{" & UserCue & "}/colorName " & userColor
	do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
end setColor
*)

on setColor(userCue, userColor)
	tell application id "com.figure53.QLab.4" to tell front workspace
		set q color of cue id userCue to userColor
	end tell
end setColor