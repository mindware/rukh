Rukh
======

![Rukh](/app/assets/images/179px-Edward_Julius_Detmold49.jpg)

Project originally devised as a way to keep track of bounced checks. The accounting of these is typically held outside the normal accounting to allow for the closing of the fiscal year. Originally the bounced checks have been kept track on a Excel file on a single computer. 

This project has as it's goals the following:

1. Create a persistent database store for the accounting of bounced checks.
2. Allow easy monitoring of said debts.
3. Allow for importing of data (from csv exported from excel file)
4. Present an API for other agencies (particularly the permit agency) to connect.

A further goal is:

- Automatic generation of Mailers for collection efforts.

Due to the expertise found on the EQB (Environmental Quality Board) was limited to Windows this app needed to run on Windows<sup>1</sup>, thus a jruby/java/tomcat7 stack was used.

__Status__
Presently the application creates a persistent database for accounting of debts, exporting of data to CSV and Excel & generates mailers. The API and the import function are pending.

__Set Up__
The application contains documentation on how it was set up including the whole stack and even a proxy for using https. These instructions are under the route `/dev` off the main application. You can also search for the Markdown files in `app/views/static_pages`.

__Testing Emails__

The gem [MailCatcher](mailcatcher.me) was used to test email sending locally. It doesn't work on jruby. But you can started from normal Ruby using RVM. I highly recommend using an RVM gemset and wrapper for MailCatcher as it tends con conflict with gems required by Rails.

__Name__
Rukh was originally 'RucPoc -- registro único de cuentas por cobrar' but now it's just a meaningless-name associated with the [Rukh](http://en.wikipedia.org/wiki/Roc_(mythology)) from Arabian Nights. 


__License:__
The code is under GPL v3.

<sup>1</sup> While Rukh works on a Windows stack a JRuby(`TCPSocket.open('ipaddrss', 25)`) bug prevented email delivery using SMTP. The final application was hosted on Linux, Windows was used as a test bed. An issue with the bug was opened on JRuby github page.
image: [wikimedia commons](http://en.wikipedia.org/wiki/File:Edward_Julius_Detmold49.jpg): Charles Maurice Detmold (1883-1908)

