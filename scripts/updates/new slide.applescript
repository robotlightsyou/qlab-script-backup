--Shft+Op+V Make new slide with fades
tell application id "com.figure53.qlab.4" to tell front workspace
	
	make type "Video"
	set newQ to last item of (selected as list)
	set opacity of newQ to 0
	set continue mode of newQ to auto_continue
	set q color of newQ to "purple"	
	
	my make_fade("in", newQ)
	my make_fade("out", newQ)
	
	tell current cue list
		set playback position to newQ
	end tell
	
end tell

on make_fade(fadeType, targetCue)
	tell application id "com.figure53.qlab.4" to tell front workspace
		make type "Fade"
		set fadeCue to last item of (selected as list)
		set properties of fadeCue to {do opacity:true, cue target:targetCue, q color:"purple", q number:""}
		set do opacity of fadeCue to true
		set cue target of fadeCue to targetCue
		if fadeType is "in" then
			set opacity of fadeCue to 100
		else
			set opacity of fadeCue to 0
			set stop target when done of fadeCue to true
		end if
		
		return uniqueID of fadeCue
	end tell
end make_fade