CVSWizardEyes
=============

CVS (Concurrent Versioning System) Wizard Eyes is a dialog box driven wizard 
which prompts the user for information required for the CVS commands:
Checkout, Checkin/Commit, Login, Update, , Add, Insert.
- [ ] Add - Tell CVS of a new file or directory to track
- [x] Checkout - download all the files within this directory. 
- [x] Commit - upload files that have changed within this directory
- [x] Update - Destroy all local files and download all new.
- [ ] History - Query information about a user's checkout status
- [ ] Insert - Recursivly update and add new files or directories if required.
- [ ] rdiff - Specify two revisions for a diff
- [ ] release - Tell CVS to stop tracking
- [ ] remove - delete from the repository
- [ ] status - status about revision
- [ ] tag - add a tag to a checked out version

CVSWizardEyes is a command line (terminal) tool, capable of operation through SSH (Secure Shell).
Designed and tested on Linux Mint 15 (olivia), a derivative of Ubuntu (raring), a derivative of Debian.
CVSWizardEyes detects and installs its own dependency programs through apt-get: cvs, tree, dialog. 
CVSWizardEyes assumes no previous cvs configuration, and runs providing its own $CVSROOT and login operation. 


Installation Instructions:

  sudo mv ~/Downloads/cvsWizardEyes.sh /usr/bin/cvsWizardEyes
  
  sudo chmod +x /usr/bin/cvsWizardEyes
  
  sudo chown root:root /usr/bin/cvsWizardEyes
  
Useage Instructions: 

  cvsWizardEyes
  
  
  

  
  
The MIT License (MIT)

Copyright (c) 2013 microuser.github.com pauleagle@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
