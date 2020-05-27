property currentCount : missing value
property displayCount : missing value
property clamshell : missing value

displayStatus()
copy displayCount to currentCount

repeat
	displayStatus()
	
	if displayCount is greater than currentCount and clamshell is 1 then -- open/new monitor - "ask"
		activate
		set answer to button returned of (display dialog "New Monitor Detected" buttons {"Enable Sleep", "Disable Sleep"} default button "Disable Sleep")
		if answer is "Disable Sleep" then
			do shell script "pmset -a disablesleep 1" with administrator privileges
			-- add [user name "me" password "mypassword" with administrator privileges] to skip admin prompt
		else
			do shell script "pmset -a disablesleep 0" with administrator privileges
			-- add [user name "me" password "mypassword" with administrator privileges] to skip admin prompt
		end if
		copy displayCount to currentCount
		
	else if displayCount is less than currentCount and clamshell is 1 then -- open, unplugged - "sleep enabled"
		do shell script "pmset -a disablesleep 0" with administrator privileges
		-- add [user name "me" password "mypassword" with administrator privileges] to skip admin prompt
		
		(* activate
		set answer to button returned of (display dialog "Monitor Unplugged, Sleep Enabled" buttons {"Stop Monitoring", "Continue Monitoring"} default button "Continue Monitoring")
		if answer is "Stop Monitoring" then
			quit me
		end if *)
		copy displayCount to currentCount
		
	else if displayCount is 0 and clamshell is 0 then -- closed, no monitor - "sleep enabled"
		do shell script "pmset -a disablesleep 0" with administrator privileges
		-- add [user name "me" password "mypassword" with administrator privileges] to skip admin prompt
		quit me
		
	end if
	
	delay 3 -- repeat every 3 sec
	
end repeat

on displayStatus()
	tell application "Image Events"
		set displayCount to count displays
	end tell
	
	try
		do shell script "ioreg -r -k AppleClamshellState | grep '\\\"AppleClamshellState\\\" = Yes'"
		set clamshell to 0 -- closed laptop
	on error
		set clamshell to 1 -- opened laptop
	end try
end displayStatus