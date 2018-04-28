#UseHook
#InstallMouseHook
#InstallKeybdHook

; Generally a good idea to keep a panic button
$f1::ExitApp

$f4::
		Send, {LControl Down}
		SLEEP, 75

		Send, {Tab}  ; exosuit
		SLEEP, 75 
		Send, {Tab}  ;  multitool
		SLEEP, 75 

		Send, {LControl Up}
		SLEEP, 75

		Send, {Tab} ; do this 5 times to get to generate
		SLEEP, 75
		Send, {Tab}
		SLEEP, 75
		Send, {Tab}
		SLEEP, 75
		Send, {Tab}
		SLEEP, 75
		Send, {Tab}
		SLEEP, 150
		
		Send, {Space}
		Sleep, 150

return

$f3::
;prep the loop!
	heep:=!heep
	while (heep=1)
	{
		LastClip := clipboard  ; Define string variable "LastClip" with the value of the current clipboard
		tooltip, starting script
		WinActivate, ahk_class SunAwtFrame ahk_exe java.exe  ; Activate Save editor window, your cursor should already be placed at the end of the seed before the script runs
		Sleep, 75
		tooltip, We are at screen one - let's go to ships screen

		Send, {LControl Down}
		SLEEP, 75

		Send, {Tab}  ; exosuit
		SLEEP, 75 
		Send, {Tab}  ;  multitool
		SLEEP, 75 

		Send, {LControl Up}
		SLEEP, 75

		Send, {Tab} ; do this 3 times to get to generate
		SLEEP, 75
		Send, {Tab}
		SLEEP, 75
		Send, {Tab}
		SLEEP, 75
		
		Send, {Space}
		Sleep, 150

		Send, {LShift Down}
		SLEEP, 75
		Send, {Tab} ; get to seed window
		SLEEP, 75
		Send, {LShift Up}
		SLEEP, 75

		;copy the seed
		Send, {LControl Down}
		SLEEP, 75
		Send, {a}
		SLEEP, 150
		Send, {c}
		SLEEP, 150
		;added 2018-04-28
		oldboard := % clipboard
		Send, {LControl Up}
		SLEEP, 75

		;now lets name the ship with the seed
		Send, {LShift Down}
		SLEEP, 75
		Send, {Tab} ; get to name window
		SLEEP, 75
		Send, {Tab} ; get to name window
		SLEEP, 75
		Send, {LShift Up}
		SLEEP, 75

		;now ctrl+a then ctrl+v
		;paste the seed
		Send, {LControl Down}
		SLEEP, 75
		Send, {a}
		SLEEP, 150
		Send, {v}
		SLEEP, 150
		Send, {LControl Up}
		SLEEP, 75

		;Send, {LAlt}  ; deselect seed text box. the new seed is not applied until your cursor leaves the box by design of the save editor.
		;SLEEP, 75
		;Send, {LAlt}  ; reselect seed text box. the new seed is not applied until your cursor leaves the box by design of the save editor.
		;SLEEP, 75

		Send, {LControl Down}  ; hold ctrl
		SLEEP, 75
		tooltip, save button
		Send, {s}  ; press s (save)
		SLEEP, 75
		Send, {LControl Up}  ; release ctrl
		SLEEP, 75
		Send, {LControl Down}  ; hold ctrl
		SLEEP, 75
		Send, {a}  ; press a (select all)
		SLEEP, 75
		Send, {LControl Up}  ; release ctrl
		SLEEP, 75
		Send, {LControl Down}  ; hold ctrl
		SLEEP, 75
		Send, {c}  ; press c (copy to clipboard)
		SLEEP, 75
		Send, {LControl Up}  ; release ctrl
		Sleep, 1000
		tooltip, CTRL may not always work press it to release
		;If Clipboard = %LastClip%  ; checks to make sure a new seed was copied. occasionally a system stutter can make the ctrl c operation not go through. this continues with the script as long as the current clipboard doesn't match the one before a new seed was supposed to be copied. otherwise, it restarts the script and tries again
		;{
		;	tooltip, it broke
		;}
		;Else
		;{
			IfWinNotExist, No Man's Sky ahk_exe NMS.exe  ; if the game isn't currentlty running, begins restarting the game
			{
				tooltip, game not loaded - loading it now
				Run, "F:\SHTEEM\steamapps\common\No Man's Sky\Binaries\NMS.exe"  ; starts the game
				Sleep, 2500  ; wait this many milliseconds for the game to launch before continuing
				WinActivate, No Man's Sky ahk_exe NMS.exe  ; switch to game window, just in case. irrelevant if the game window was already the focus
				Sleep, 11000  ; wait this many milliseconds for the game to load before continuing
				Click, Left, , Down  ; hold the left mouse button down to click on first save
				Sleep, 800  ; hold the left mouse button down for this many milliseconds
				Click, Left, , Up  ; release the left mouse button
				Sleep, 30000  ; wait this many milliseconds for the save to load before continuing
			}
			Else  ; skips to here if the game was already running
			{
				tooltip, giving focus to game now
				WinActivate, No Man's Sky ahk_exe NMS.exe  ; focus on the game window
				WinActivate, No Man's Sky ahk_exe NMS.exe  ; focus on the game window
				WinActivate, No Man's Sky ahk_exe NMS.exe  ; focus on the game window
				WinActivate, No Man's Sky ahk_exe NMS.exe  ; focus on the game window
				Sleep, 2500  ; wait 2.half a second for the game window to regain focus
				Send, {Escape Down}  ; escape down, then up to open options menu in-game
				Sleep, 75
				Send, {Escape Up}
				Sleep, 500
				Click, Left, , Down  ; left click down, then up on the first save to load it
				Sleep, 800  ; hold left mouse button for this long for the cursor circle to complete rotation in-game
				Click, Left, , Up
				Sleep, 11000  ; wait this many milliseconds for the game to load
			}
			send, {Tab down}
			sleep, 2500
			send, {F12}
			sleep, 750
			send, {Tab up}
			sleep, 75
			send, {Tab down}
			sleep, 2500
			send, {Tab up}
			sleep, 75
			FormatTime, timestamp, T8, MMM-dd@H.m.s  ; define time-stamp formatting to match NMS photo mode output timestamps. no reason to mess with this
			FileAppend, %clipboard% - %timestamp%`r`n, "F:\SHTEEM\steamapps\common\No Man's Sky\No-Mans-Sky-Save-Editor\seed_log.txt"  ; add the current clipboard text (which is the current seed) and the time stamp, then add a line break, to the log located at this location
			Sleep, 750  ; wait a second and a half for the photot to finish being taken
			Click, Left, , Up
			Sleep, 750  ; wait a second and a half for the photo file to finish being written to the hard drive before proceeding. just a precaution.

			;added 2018-04-28
			;now lets work some magic on the file and rename it to the seed value
			path := "F:\SHTEEM\userdata\62816360\760\remote\275850\screenshots\*.jpg"
			rootpath := "F:\SHTEEM\userdata\62816360\760\remote\275850\screenshots\"
			runwait, %comspec% /c dir %path% /S /B /O-D | clip,, hide
			mostrecentfile := StrSplit(clipboard,"`n","`r")[1]
			;Msgbox % mostrecentfile
			;Msgbox % oldboard
			NooName = %rootpath%%oldboard%.jpg
			;Msgbox % NooName
			FileMove %mostrecentfile%, %NooName%
			;repeat process for thumbnails
			path := "F:\SHTEEM\userdata\62816360\760\remote\275850\screenshots\thumbnails\*.jpg"
			rootpath := "F:\SHTEEM\userdata\62816360\760\remote\275850\screenshots\thumbnails\"
			runwait, %comspec% /c dir %path% /S /B /O-D | clip,, hide
			mostrecentfile := StrSplit(clipboard,"`n","`r")[1]
			;Msgbox % mostrecentfile
			;Msgbox % oldboard
			NooName = %rootpath%%oldboard%.jpg
			;Msgbox % NooName
			FileMove %mostrecentfile%, %NooName%
			;}
		
	;random 500 ms delay so that we can escape from the loop when we need to
	sleep, 500
	}
	
return
