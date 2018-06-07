# cis
Computer Inventory Script (CIS). Collects inventory details of a computer and dumps it to a csv file!

Version:		1.0 (06/7/2018)
Tested OS:		Windows (XP, Vista, 7, 8, 8.1, 10) HP Machines
Written By:		Esmeil Naqeeb (blog.esmeilnaqeeb.com)
Contributions By: David Breese

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

	Edit line 23, 26, 33 and 151:

	Line 23:		Change it to the path to a network share (assumes that the network share is mounted with write permissions when you run this script)
	Line 26: 		Change it to your school/parish or prompt user (line 29)
	Line 33:		Change it to the room you are working in, or prompt user (line 36)
	Line 151:	Change it to your name (without spaces: Esmeil-Naqeeb), or you can use the prompt user method (line 150)

The CSV file is date stamped e.g: inventory_YEAR-MONTH-DATE.csv

Running the script:

Just double click the main.bat file and follow the instructions.

**** Please review inventory data before you submit it! ****

You can comment out the timeouts to make the script faster. (::timeout 3)

Enjoy!
