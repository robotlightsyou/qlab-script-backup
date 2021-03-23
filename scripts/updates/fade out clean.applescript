--Shift+Ctrl+F FADE OUT SELECTED Q 
(*
Tested with QLab v4.6.9 Mar 2021
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"

*** Naming may not function correctly if you have not set a name for selected cue in QLab, mostly seen when importing but not renaming audio files though it may occur elsewhere. Fading functionality not affected.

*)

tell application id "com.figure53.QLab.4" to tell front workspace
    
    -- select cue to be copied, check that it is appopriate type
	set originalCue to last item of (selected as list)
	set originalCueType to q type of originalCue
	if originalCueType is in {"Group", "Audio", "Video", "Fade"} then

        -- copy the parameters of the target cue
        if originalCueType is not "Fade" then
            set cueTarget to originalCue
            set qnameStr to "Fade out: " & q name of originalCue
        else
            set cueTarget to cue target of originalCue
            set qnameStr to "Fade out: " & q name of cue target of originalCue
        end if 
        set userDuration to 5
            
        -- make new fade and apply parameters
        make type "Fade"
        set newCue to last item of (selected as list)
        set properties of newCue to {cue target:cueTarget, duration:userDuration, q name:qnameStr, q number:"", stop target when done:true}
        newCue setLevel row 0 column 0 db "-INF"
        
        -- test for video to prevent errors
        if originalCueType is "Video" then
            set opacity of newCue to 0
            set do opacity of newCue to true
        end if

	end if
end tell
