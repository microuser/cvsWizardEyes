CVSWizardEyes
=============

CVS (Concurrent Versioning System) Wizard Eyes is a dialog box driven wizard 
which prompts the user for information required for the CVS commands:
Checkout, Checkin, Login, Update, Commit, Add, Insert

CVSWizardEyes is a command line (terminal) tool, capable of operation through SSH (Secure Shell).
Designed and tested on Linux Mint 15 (olivia), a derivative of Ubuntu (raring), a derivative of Debian.
This program detects and installs its own dependency programs through apt-get: cvs, tree, dialog.



Installation Instructions:

  sudo mv ~/Downloads/cvsWizard.sh /usr/bin/cvsWizardEyes
  
  sudo chmod +x /usr/bin/cvsWizardEyes
  
  sudo chown root:root /usr/bin/cvsWizardEyes
  
  
