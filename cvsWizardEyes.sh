#!/bin/sh

#  The MIT License (MIT)
#  Copyright (c) 2013 microuser pauleagle@gmail.com
#  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#References:
#http://www.ucolick.org/~de/CVSbeginner.html

#////////////////////////////
#Server/Remote Configuration
cvsServerHostname="cvs";
cvsServerBase="/var/cvsroot/applications/"
cvsServerMethod="pserver"

#Client/Local Configuration
userName=`whoami`
cvsLocalBase=~/cvs;
venderTag="VenderName";
releaseTag="R0_1";
#Project Configuration
projectName="php/"
#CVS Commands
commandDirectory="-d"
commandComment="-m"
#////////////////////////////

setProjectName (){
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
projectName=$(dialog --inputbox "Project/Module Name in $cvsServerBase" 10 70 "$projectName" 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

setHostname () {
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
cvsServerHostname=$(dialog --inputbox "Enter the cvs hostname" 10 70 $cvsServerHostname 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
setCvsServerBase () {
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
cvsServerBase=$(dialog --inputbox "Enter the server's repository path" 10 70 $cvsServerBase 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
setUserName(){
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
userName=$(dialog --inputbox "Enter your CVS username" 10 70 $userName 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
setUserComment(){
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
userComment=$(dialog --inputbox "Enter a comment" 10 70 "$(date)" 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

checkDependenciesAndInstall () {
#if cvs is installed, try cvs, redirect errors to stdout and count the lines matching notfound.
appname="$1"
markAppnameForInstall="$($1 2>&1 | grep "not found" | wc -l)" 
if [ "$markAppnameForInstall" -eq "1" ] 
then
echo Installing $1
sudo apt-get install $1 -y
fi
} #//End checkDependenciesAndSInstall

checkDependenciesAndInstall dialog
checkDependenciesAndInstall cvs
checkDependenciesAndInstall tree

echo .
echo .
echo .
echo .
echo .
echo .
echo "CVS Manager with Wizzard Eyes";

setHostname
setCvsServerBase
setUserName

export CVSROOT=:$cvsServerMethod:$userName@$cvsServerHostname:$cvsServerBase

#exec 3>&1
#$(cvs login 2>&1 1>&3)
#exec 3>&-
cvs login

dialog --msgbox "CVS Wizzard Eyes\n Instructions:" 10 70 


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
userMenu=$(dialog --menu "CVS Wizzard Eyes Main Menu" 15 70 6 \
		"Show Modified" "Print a listing of modified files"\
		"Checkout"	"Download Source into directory" \
		"Update"	"Download source updates (distructive)." \
		"Checkin"	"Upload Source from directory" \
		"Import"	"Create a new project from directory" \
	2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

################################################################################
if [ "$userMenu" = "Import" ] # strings are equal #################################
################################################################################
then
	setProjectName
	setUserComment
		
	#Make the directory if not exist
	mkdir -p $cvsLocalBase/$projectName
	
	#Set current directory for CVS
	cd $cvsLocalBase/$projectName

	#Print the items of current directory
	ls
	
	venderTag="VENDER_TAG"
	releaseTag="RELEASE_TAG"
	#Create Project
	export CVSROOT=:$cvsServerMethod:$userName@$cvsServerHostname:$cvsServerBase
	echo Using Remote CVSROOT=$CVSROOT
	echo Using Local $cvsLocalBase/$projectName

	tree -d

	cvs import $commandComment "$userComment" "$projectName" $venderTag $releaseTag
	sleep 1



################################################################################
elif [ "$userMenu" = "Checkout" ] ##############################################
################################################################################
then
dialog --msgbox "About to checkout" 20 30
setProjectName
mkdir -p $cvsLocalBase
cd $cvsLocalBase
cvs checkout $projectName
sleep 1
echo ---------------------------------------------------------------------------
echo ===========================================================================
echo ---------------------------------------------------------------------------
echo `pwd`
tree -d | grep -v "── CVS"
echo "Project @ $cvsServerBase$projectName should now be checked out, but scroll up, and verify.";
################################################################################
elif [ "$userMenu" = "Update" ] ################################################
then
dialog --msgbox "CVS Update overwrites the local files with the repository version. \n\n A-Add file or directory may be updated from the server to your comptuer.  \n\n A-Add-Will be added to repository\n\n D-Delete-Will be deleted from repository\n\n M-Modified-Will be diffed, after diff will add file\n\n Unable to Merge indicates a more recent version on server." 20 80 

setProjectName
cd $cvsLocalBase/$projectName
cvs update

################################################################################
echo "Updating project";
################################################################################
elif [ "$userMenu" = "Checkin" ] ###############################################
################################################################################
then
dialog --msgbox "About to checkin" 20 30
setProjectName
cd $cvsLocalBase/$projectName
cvs commit #$cvsLocalBase/$projectName
sleep 1
echo ---------------------------------------------------------------------------
echo ===========================================================================
echo ---------------------------------------------------------------------------
echo `pwd`
tree -d | grep -v "── CVS"
echo "Project @ $cvsServerBase$projectName should now be checked in, but scroll up, and verify.";


################################################################################
elif [ "$userMenu" = "Show Modified" ] #########################################
################################################################################
then
setProjectName
cd $cvsLocalBase/$projectName
echo
echo
echo 
echo 
echo ============================================================================
echo Locally Modified File ======================================================
echo ============================================================================

#Get the line and the three lines after when matched to: "Locally Modified"
#Remove the text: "File:"
#Remove the text: "Status: Locally Modified"
#Remove the text: ",v"
cvs status 2>/dev/null | grep -A3 "Locally Modified" | sed 's/File: //g' | sed 's/Status: Locally Modified//g' | sed 's/,v//g'| sed "s^$cvsServerBase^^g"

echo 
echo 
echo
echo 
echo ============================================================================
echo Needs Patching =============================================================
echo ============================================================================
#Get the line and the three lines after when matched to: "Needs Patch"
#Remove the text: "File:"
#Remove the text: "Status: Needs Patch"
#Remove the text: ",v"
cvs status 2>/dev/null | grep -A3 "Needs Patch" | sed 's/File: //g' | sed 's/Status: Needs Patch//g' | sed 's/,v//g' | sed "s^$cvsServerBase^^g" |  sed 's/^M//g'

echo
echo
echo 
echo 
echo ============================================================================
echo Other ======================================================================
echo ============================================================================
#cvs status 2>/dev/null | grep File: |grep -v Up-to-date | grep -v "Needs Patch" | grep -v "Locally Modified" | sed 's/File: //g' | sed "s^$cvsServerBase^^g"

#Remove Lines matching: "Locally Modified"
#Remove Lines matching "Needs Patch"
#Remove Lines matching "Up-to-date"
#Get the line and three lines after when not matched to "Status:"
#Remove the text matching the variable $cvsServerBase

cvs status 2>/dev/null | grep -v "Locally Modified" | grep -v " Needs Patch" | grep -v "Up-to-date" | grep -A3 "File:" | sed "s^$cvsServerBase^^g" 
#| grep "Repository revision" | sed 's/Repository revision:\t//g' 
fi


