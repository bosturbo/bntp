-- Version 0.0.1
on run
	try
--		error number -128
		set cmd to "sudo ntpdate time.asia.apple.com."
		do shell script cmd password "" with administrator privileges
		set cmd to "sudo systemsetup -setusingnetworktime off"
		do shell script cmd password "" with administrator privileges
		set cmd to POSIX path of (path to resource "/sbin/ntpd") & " -c " & POSIX path of (path to resource "/etc/ntp.conf")
		do shell script cmd password "" with administrator privileges
	on error
		display alert "Error: stating ntpd failed." as warning
		return
	end try
end run

on quit
	try
		do shell script "pkill ntpd" password "" with administrator privileges
	on error
		display alert "Warning: stopping ntpd failed." message "the process of ntpd would remain." as warning
	end try
	continue quit
end quit
