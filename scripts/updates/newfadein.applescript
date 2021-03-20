--Ctrl+F FADE IN SELECTED Q 
(*
Tested with QLab v4.6.9 Mar 2021
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"

*** Naming may not function correctly if you have not set a name for selected cue in QLab, mostly seen when importing but not renaming audio files though it may occur elsewhere. Fading functionality not affected.

*)

tell application id "com.figure53.QLab.4" to tell front workspace
	set originalCue to last item of (selected as list)
	set originalCueType to q type of originalCue
	if originalCueType is in {"Group", "Audio", "Video", "Fade"} then
        set qnameStr to "Fade in: " & q name of originalCue
        set userDuration to 5
        set myPreWait to pre wait of originalCue
        set continue mode of originalCue to auto_continue
            
            make type "Fade"
            set newCue to last item of (selected as list)
            set properties of newCue to {cue target:originalCue, duration:userDuration, q name:qnameStr, pre wait:myPreWait, q number:""}
            
            if q type oforiginalCue is not "Group" then
                set originalLevel to originalCue getLevel row 0 column 0
                originalCue setLevel row 0 column 0 db "-INF"
                newCue setLevel row 0 column 0 db originalLevel
            end if
            
            if originalCueType is "Video" then
                set myOpacity to opacity of originalCue
                set opacity of newCue to myOpacity
                set do opacity of newCue to true
                set opacity of originalCue to 0
            end if
	end if
end tell
