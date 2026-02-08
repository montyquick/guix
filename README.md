# GNU Guix

This will be an attempt to explain how to get an installed system for the Official GNU Guix installer ISO with a Linux kernel

There are many other attempts at this on Github, however (of the ones I've seen) they attempt to create an ISO to get the system installed.
This is not that type of project. I'm not interested in maintaining an ISO.

The long version is to deploy Debian or other distribution with a minimal installation. It doesn't need to be a desktop, a server install is fine.
The drive setup when using 1 hard drive will be a little odd. There is hope to use a live ISO for this but the success rate in not very high - to be explained later.
The bootstrap Linux - Debian or other will need to be partitioned in a way to allow Guix to boot after installation - hence if a live ISO becomes successful it will be easier.

- More to come.

Download the install script from guix.gnu.org - [Binary Installation](https://guix.gnu.org/manual/1.5.0/en/html_node/Binary-Installation.html)
```bash
cd /tmp
wget https://guix.gnu.org/guix-install.sh
chmod +x guix-install.sh
./guix-install.sh
```
After Guix is installed, the following actions can be taken
The basic experiment is - can you take the GNU Guix ISO, add a channels file, edit the config.scm and use guix commands to install everything - I think so.

If my understanding is correct, the commands will update the in memory, live ISO version of GNU Guix, and then apply it to the mounted drives.

Notes and potentially scripts for installing GNU Guix

First pull the files from this repo
  - nongnu-channels.scm https://github.com/montyquick/guix/blob/92e03e34ae0d85f412360e89045ae7c7841ef457/nongnu-channels.scm#L1-L9
Renaming the nongnu-channels.scm to channels.scm is advised at somepoint, as it is required for the life of the system. 
  - substitutes.scm https://github.com/montyquick/guix/blob/d5decc2a4be6283d4dbecd4bfe0d7f538529cfe4/substitutes.scm#L1-L8
  - example-config.scm https://github.com/montyquick/guix/blob/fd2bde090495788b443213ac7fc948d5e376c2ce/example-config.scm#L1-L42
 
Next pull the signing-key from [https://substitutes.nonguix.org/signing-key.pub](https://substitutes.nonguix.org/signing-key.pub), the key is not hosted here to avoid issues if the nongnu team change the key. 

Starting the cow-store creates the guix store for the installation. The cow-store creates the /gnu/store and is needed before files are pulled. This store is ultimately copied to the system in the final step.
```bash
herd start cow-store
```
Get guix to update the channel data, a guix describe command first will show 1 channel, the main guix.gnu.org.
```bash
guix pull -C nongnu-channels.scm
```
After the pull, a re-run of guix describe should show 2 channels, guix and nonguix
```bash
guix describe
```
Follow the on screen message to update the GUIX_PROFILE
```bash
echo 'GUIX_PROFILE=/root/.config/guix/current' >> ~/.bash_profile
source ~/.bash_profile
```
