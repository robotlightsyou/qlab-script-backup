--Ctrl+S LOOP PHOTO SLIDESHOW
(*
Tested with QLab v3.2.14 Oct 2018
Please report any issues to robotlightsyou@gmail.com with subject "QLAB 4 template issues"

-- Original by:
-- Create slideshow from selected cues
-- Tim Rogers <timmrogers@gmail.com>
*)

global finalPostWait

set finalPostWait to "0"

tell application id "com.figure53.QLab.4" to tell front workspace

    display dialog "Enter the number of seconds between slides:" default answer "10"

    try 
        set myPostWait to (text returned of result) as number
    on error
        display alert "Invalid number" message "Please enter a valid number"
        return
    end try 

    set mySelected to (selected as list)
    set myCount to (count mySelected)
    set loopStartTarget to first item of mySelected

    repeat with eachQ in mySelected

        