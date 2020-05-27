# Awake

This script will allow you to prevent macbooks from sleeping when a new monitor is plugged in. It will also enable sleep automatically when external monitor is unplugged.

### Tweaks

* You can edit the script so that it will not ask you for admin rights everytime it attempts to enable/disable sleep.

simply replace `do shell script "pmset -a disablesleep 1" with administrator privileges` with `do shell script "pmset -a disablesleep 1" user name "me" password "mypassword" with administrator privileges` 
check out more: [source](https://developer.apple.com/library/archive/technotes/tn2065/_index.html)

* You can ask the app to ask if you want it to continue monitoring after enabling sleep back.

simply remove the comments from these lines:

```
(* activate
	set answer to button returned of (display dialog "Monitor Unplugged, Sleep Enabled" buttons {"Stop Monitoring", "Continue Monitoring"} default button "Continue Monitoring")
	if answer is "Stop Monitoring" then
		quit me
	end if *)

```

### Usage

1. Clone this repository
2. Open "awake.applescript" using "Script Editor" on your mac (edit the script if you need to)
3. Export the script as application

*Disclaimer:* The app, when run in background, will have an energy impact of 0.1 ~ 0.5 in Activity Monitor


