#!/bin/sh

#////////////////////////////
#Server/Remote Configuration
cvsServerHostname="cvs";
cvsServerBase="/var/cvsroot/applications/"
cvsServerMethod="pserver"

#Client/Local Configuration
userName=`whoami`
cvsLocalBase=~/cvs;

#Project Configuration
projectName="php/"
#CVS Commands
commandDirectory="-d"
#////////////////////////////

setProjectName (){
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
projectName=$(dialog --inputbox "Project/Module Name in $cvsServerBase" 10 70 "$projectName" 2>&1 1>&3)
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

#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
cvsServerHostname=$(dialog --inputbox "Enter the cvs hostname" 10 70 $cvsServerHostname 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
cvsServerBase=$(dialog --inputbox "Enter the server's repository path" 10 70 $cvsServerBase 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
userName=$(dialog --inputbox "Enter your CVS username" 10 70 $userName 2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

export CVSROOT=:$cvsServerMethod:$userName@$cvsServerHostname:$cvsServerBase

#exec 3>&1
#$(cvs login 2>&1 1>&3)
#exec 3>&-
cvs login

dialog --msgbox "CVS Wizzard Eyes\n Instructions:" 10 70 


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
exec 3>&1
userMenu=$(dialog --menu "CVS Wizzard Eyes Main Menu" 15 70 4 \
		"Import"	"Create a new project from directory" \
		"Checkout"	"Download Source into directory" \
		"Update"	"Download source updates (distructive)." \
		"Checkin"	"Upload Source from directory" \
	2>&1 1>&3)
exec 3>&-
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

################################################################################
if [ "$userMenu" = "New" ] # strings are equal #################################
################################################################################
then
	echo "Creating new project";
	#dialog --form "Create a New Project" 30 60 6 \
	#"label" 1 1 "User" 1 10 10 0 \
	#"label" 2 1 "labl2" 2 10 15 0 \
	
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
	echo Using CVSROOT=$CVSROOT
	tree -d
	#cvs import $commandDirectory $cvsServerBase



################################################################################
elif [ "$userMenu" = "Checkout" ] ##############################################
################################################################################
then
dialog --msgbox "About to checkout" 20 30
setProjectName
mkdir -p $cvsLocalBase
cd $cvsLocalBase
cvs checkout $projectName
echo ---------------------------------------------------------------------------
echo ===========================================================================
echo ---------------------------------------------------------------------------
echo `pwd`
tree -d | grep -v "── CVS"
echo "Project @ $cvsServerBase$projectName should now be checked out.";
################################################################################
elif [ "$userMenu" = "Update" ] ################################################
################################################################################
then
echo "Updating project";
################################################################################
elif [ "$userMenu" = "Checkin" ] ###############################################
################################################################################
then
dialog --msgbox "About to checkin" 20 30
setProjectName
cd $cvsLocalBase/$projectName
cvs commit $projectName
echo ---------------------------------------------------------------------------
echo ===========================================================================
echo ---------------------------------------------------------------------------
echo `pwd`
tree -d | grep -v "── CVS"
echo "Project @ $cvsServerBase$projectName should now be checked in.";
fi


