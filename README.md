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
  
  
The MIT License (MIT)

Copyright (c) 2013 microuser pauleagle@gmail.com

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
