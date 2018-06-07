@echo off
cd /d %0\..
@echo.
@echo Computer Inventory Script (CIS)
@echo.
@echo.
@echo Collects inventory details of a computer and submits it to a google form using curl!
@echo Version:	1.0 (06/7/2018)
@echo Tested OS:		Windows (7, 8, 8.1,10) HP Machines
@echo Written By: Esmeil Naqeeb (blog.esmeilnaqeeb.com)
@echo Contributions By: David Breese (dabreese00@gmail.com)
@echo.
@echo.
timeout 3
set YEAR=%date:~10,4%
set MONTH=%date:~4,2%
set DATE=%date:~7,2%
set HR=%time:~0,2%
set HR=%HR: =0%
set HR=%HR: =%

::Define path to the network share: (. for current directory, S:\ for drive mounted on S:)
set network-share=.

::Set School/Parish
set location=Your-School/Parish

::Prompt user for location:
::set /p location=What is your location (STGV, SFB, CYPR, SBTC)?
::@echo Location: %location%

::Get Room Number:
::set Room-Num=208-2nd-Floor-Computer-Lab

::Prompt user for Room Number:
set /p Room-Num=What is the room number (A###)?
::@echo Room Number: %Room-Num%

set serialNo=Unknown
set model=Unknown
set sku=Unknown
set processorGen=Unknown
set assetTag=Not-Set-in-BIOS
set arch=Unknown

::Get Device Serial Number:
set getSerialNo=wmic bios get serialnumber /format:value
for /f "tokens=2 delims==" %%a in ('%getSerialNo%') do set serialNo=%%a
set serialNo=%serialNo: =-%

::Get Model Name:
set getModel=wmic ComputerSystem get Model /format:value
for /f "tokens=2 delims==" %%a in ('%getModel%') do set model=%%a
set model=%model: =-%

::Get Product Number:
for /f "tokens=2*" %%A in ('REG QUERY "HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\BIOS" /v SystemSKU') DO (
  for %%F in (%%B) do (
    set sku=%%F
    goto :break
  )
)
:break

::Get OS Version:=
set getOS=wmic os get Caption /format:value
for /f "tokens=2 delims==" %%a in ('%getOS%') do set osver=%%a
set osver=%osver: =-%
set osver=%osver:,=-%

::Get Processor Generation:
set getProcessorGen=wmic CPU get NAME /format:value
for /f "tokens=2 delims==" %%a in ('%getProcessorGen%') do set processorGen=%%a
set processorGen=%processorGen: =-%

::Get Total Physical Memory:
set getTotalPhyRam=wmic ComputerSystem get TotalPhysicalMemory /format:value
for /f "tokens=2 delims==" %%a in ('%getTotalPhyRam%') do set TotalPhyRam=%%a
set TotalPhyRam=%TotalPhyRam: =-%

::Get Total Disk Space:
::set getTotalDiskSpace=wmic logicaldisk where (drivetype='3') get size /format:value
::for /f "tokens=2 delims==" %%a in ('%getTotalDiskSpace%') do set TotalDiskSpace=%%a
set getTotalDiskSpace=wmic logicaldisk get size /format:value
for /f "tokens=2 delims==" %%a in ('%getTotalDiskSpace%') do set TotalDiskSpace=%%a & goto :break1
:break1
set TotalDiskSpace=%TotalDiskSpace: =%

::Get Free Disk Space:
::set getFreeDiskSpace=wmic logicaldisk where (drivetype='3') get freespace /format:value
::for /f "tokens=2 delims==" %%a in ('%getFreeDiskSpace%') do set FreeDiskSpace=%%a
set getFreeDiskSpace=wmic logicaldisk get freespace /format:value
for /f "tokens=2 delims==" %%a in ('%getFreeDiskSpace%') do set FreeDiskSpace=%%a & goto :break2
:break2
set FreeDiskSpace=%FreeDiskSpace: =%

::Get Asset Tag:
set getAssetTag=wmic SystemEnclosure get SMBIOSAssetTag /format:value
for /f "tokens=2 delims==" %%a in ('%getAssetTag%') do set assetTag=%%a
set assetTag=%assetTag: =-%
if not defined assetTag (set assetTag=Not-Set-in-BIOS)
if %assetTag% EQU - (set assetTag=Not-Set-in-BIOS)

::Get System Architecture:
set arch=32Bit
if defined ProgramFiles(x86) ( set arch=64Bit)
cls
color e
@echo.
@echo Let's review some inventory details before we send them out!
@echo.
@echo.
@echo School/Parish:		%location%
@echo.
@echo Room-No:		%Room-Num%
@echo.
@echo Computer-Name:		%computername%
@echo.
@echo Model:			%model%
@echo.
@echo Product Number:		%sku%
@echo.
@echo OS-Version: 		%osver%
@echo.
@echo Processor:		%processorGen%
@echo.
@echo Total Physical Memory:	%TotalPhyRam%
@echo.
@echo Total Disk Space:	%TotalDiskSpace%
@echo.
@echo Free Disk Space:	%FreeDiskSpace%
@echo.
@echo Serial-No:		%serialNo%
@echo.
@echo Asset-Tag:		%assetTag%
@echo.
@echo Architecture:		%arch%
@echo.
@echo.
@echo What do you want to do with the inventory details?
@echo.

@echo 1	Send them to the Google form
@echo 2	Write them to csv file
@echo 3	Do 1 and 2
@echo 0	Exit
@echo.
set /p sendInv=Enter your choice: 
@echo.
@echo.
if %sendInv% EQU 0 (cls & @echo Thank you for using Computer Inventory Script & @echo. & @echo Exiting... & timeout 3 & exit 0)
if %sendInv% EQU 1 (set /p techName=Please enter your name: )
if %sendInv% EQU 2 (set /p techName=Please enter your name: )
if %sendInv% EQU 3 (set /p techName=Please enter your name: )
::if %sendInv% EQU 1 (set techName=Your-Name-of-not-prompting)
::if %sendInv% EQU 2 (set techName=Your-Name-of-not-prompting)
::if %sendInv% EQU 3 (set techName=Your-Name-of-not-prompting)

if %sendInv% EQU 1 (goto:to-google-form)
if %sendInv% EQU 2 (goto:to-csv)

:to-google-form
@echo Sending data to Google form...
curl -k https://docs.google.com/forms/d/17pMgnvFIp861-RxwFRv2Yri227Bg2wGziCCNuOS-i2U/formResponse -d ifq -d entry.1478084243=%location% -d entry.434361443=%Room-Num% -d entry.411325200=%computername% -d entry.1145761944=%model% -d entry.1133893838=%sku% -d entry.1161298755=%serialNo% -d entry.145532750=%assetTag% -d entry.601550432=%osver% -d entry.2087229678=%arch% -d entry.1354495799=%processorGen% -d entry.1130188460=%TotalPhyRam% -d entry.1001225982=%TotalDiskSpace% -d entry.2052612064=%FreeDiskSpace% -d entry.128942743=%techName% -d submit=Submit
@echo.
@echo.
if %sendInv% EQU 1 (goto:end)

:to-csv
@echo Writing data to csv file...
if exist %network-share%\inventory_%YEAR%-%MONTH%-%DATE%.csv goto:write-data-only

@echo School/Parish,Room-No,Computer-Name,Model,Product-Number,OS-Version,Processor,Serial-No,Asset-Tag,Architecture,RAM,Total-Disk-Space,Free-Disk-Space,Tech-Name >> %network-share%\inventory_%YEAR%-%MONTH%-%DATE%.csv

:write-data-only
@echo %location%,%Room-Num%,%computername%,%model%,%sku%,%osver%,%processorGen%,%serialNo%,%assetTag%,%arch%,%TotalPhyRam%,%TotalDiskSpace%,%FreeDiskSpace%,%techName% >> %network-share%\inventory_%YEAR%-%MONTH%-%DATE%.csv

:end
@echo.
cls
@echo.
@echo cls & @echo Thank you for using Computer Inventory Script & @echo. & @echo Inventory completed and now exiting... & timeout 3 & exit 0
timeout 5
color
exit 0
