--Shift+Op+C SET COLOR BY TYPE
(*
Tested with QLab v4.6.9 Mar 2021
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"

This script intednded to add cue colors to all selected cues based on the type of cue.
*)

tell application id "com.figure53.QLab.4" to tell front workspace
    set startTime to (do shell script "date +%s") as integer
	set selectedCues to (selected as list)
    set allTypesList to {{"group"}, {"network", "midi", "midi file", "timecode", "script"}, {"audio", "video", "camera", "text", "mic", "fade", "light"}, {"target", "stop", "start", "goto", "devamp", "load", "pause", "reset"}, {"arm", "disarm", "wait"}, {"memo"}}	
    set colorList to {"green", "blue", "purple", "grey", "orange", "yellow"}
	repeat with targetQ in selectedCues
		set colorQ to uniqueID of targetQ
        set myCount to 1
		if q color of targetQ is "red" then
			my setColor(colorQ, "red")
		else	
            repeat with thisList in allTypesList
                if q type of targetQ is in thisList then
                    my setColor(colorQ, item myCount of colorList)
                    exit repeat
                end if
                set myCount to myCount + 1
            end repeat
        end if
        set myCount to 0
    end repeat
    set endTime to (do shell script "date +%s") as integer
    display dialog endTime - startTime
end tell


on setColor(userCue, userColor)
	tell application id "com.figure53.QLab.4" to tell front workspace
		set q color of cue id userCue to userColor
	end tell
end setColor

(*)
on setColor(userCue, userColor)
	set myColor to "green"
	set myOSC to "/cue_id/{" & userCue & "}/colorName " & userColor
	do shell script "echo " & myOSC & " | nc -u -w 0 127.0.0.1 53535"
end setColor
*)
