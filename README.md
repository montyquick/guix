# GNU Guix

This will be an attempt to explain how to get an installed system for the Official GNU Guix installer ISO with a Linux kernel

There are many other attempts at this on Github, however (of the ones I've seen) they attempt to create an ISO to get the system installed.
This is not that type of project. I'm not interested in maintaining an ISO.

The basic experiment is - can you take the GNU Guix ISO, add a channels file, edit the config.scm and use guix commands to install everything - I think so.

If my understanding is correct, the commands will update the in memory, live ISO version of GNU Guix, and then apply it to the mounted drives.

Notes and potentially scripts for installing GNU Guix

First pull the files from this repo
  - nongnu-channels.scm https://github.com/montyquick/guix/blob/92e03e34ae0d85f412360e89045ae7c7841ef457/nongnu-channels.scm#L1-L9
  - substitues.scm
  - <more files to add>
Next pull the signing-key from [https://substitutes.nonguix.org/signing-key.pub](https://substitutes.nonguix.org/signing-key.pub), the key is not hosted here to avoid issues if the nongnu team change the key. 

Starting the cow-store creates the guix store for the installation. The cow-store creates the /gnu/store and is needed before files are pulled. This store is ultimately copied to the system in the final step.
```bash
herd start cow-store
```
Get guix to update the channel data, a guix describe command first will show 1 channel, the main guix.gnu.org.
```bash
guix pull -C nongnu-channels.scm
```
After the pull, a re-run of guix describe should show 2 channels, guix.gnu.org and nonguix.org
```bash
guix describe
```
Follow the on screen message to update the GUIX_PROFILE
```bash
echo 'GUIX_PROFILE=/root/
```
