# cis
Computer Inventory Script (CIS). Collects inventory details of a computer and submits it to a Google form using curl or dumps it to a csv file!

Version:		1.0 (06/12/2017)
Tested OS:		Windows (XP, Vista, 7, 8, 8.1, 10) HP Machines
Written By:		Esmeil Naqeeb (blog.esmeilnaqeeb.com)

This script captures the following attributes of a computer/server:

Computer Name
Model
Product Number
OS Version
Processor
Total Physical Memory
Total Disk Space
Free Disk Space
Serial-No
Asset-Tag
Architecture

Instructions on how to use this script:

	Customizing the script for your use:

	Edit line 18, 25 and 147 to 149:

	Line 18: 		Change it to your school/parish or prompt user (line 21)
	Line 25:		Change it to the room you are working in, or prompt user (line 28)
	Line 147 to 149:	Change it to your name (without spaces: Esmeil-Naqeeb), or you can use the prompt user method (line 144 to 146)

The CSV file is date stamped e.g: inventory_YEAR-MONTH-DATE.csv

Running the script:

Just double click the main.bat file and follow the instructions.

**** Please review inventory data before you submit it! ****

Notes:
You can dump all inventory data to a file instead of sending it to a Google from by defining the network path on line 20. (assumes that the network share is mounted with write permissions)

You can comment out the timeouts to make the script faster. (::timeout 3)

Enjoy!

Last but not the least, link to the google sheet where you can see your inventory if you chose option 1 or 3 on the script: (Requires login to view the file)
https://docs.google.com/a/sbtcsupport.org/spreadsheets/d/your-google-form-id-goes-here/
