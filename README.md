CVSWizardEyes
=============

CVS (Concurrent Versioning System) Wizard Eyes is a dialog box driven wizard 
which prompts the user for information required for the CVS commands:
Checkout, Checkin, Login, Update, Commit, Add, Insert

CVSWizardEyes is a command line (terminal) tool, capable of operation through SSH (Secure Shell).
Designed and tested on Linux Mint 15 (olivia), a derivative of Ubuntu (raring), a derivative of Debian.
This program detects and installs its own dependency programs through apt-get: cvs, tree, dialog.



Installation Instructions:

//Create the working directory:

  mkdir ~/cvs

//Copy the script

  sudo mv ~/Downloads/cvsWizard.sh /usr/share/
  
  sudo chmod +x /usr/bin/cvsWizard.sh
  
  sudo chown root:root /usr/bin/cvsWizard.sh
  
  sudo ln -s /usr/bin/cvsWizard.sh /usr/bin/cvsWizard
  
