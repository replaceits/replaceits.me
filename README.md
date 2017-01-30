# replaceits.me
replaceits.me is a personal website for Sidney Williams (me!). You can find my contact information, public accounts, and my resume here. My projects will be displayed here in the future when the final site is finished as well as other additional content, be sure to check back if you're interested.

## Server
The site is currently being run off of a Digital Ocean, Fedora 25, droplet. My domain name and SSL cert were obtained through Namecheap. I currently update the site through the use of `git`. In order to do this I have a bare repository folder that gets pushed to from my local machine and the `post-receive` hook puts all the required web files in their proper places. I am planning in the future to have the `post-receive` hook also minify white-space in all the files it can to help cut down on bandwith and get a faster load time, however at the moment with such small files it is not a priority.
