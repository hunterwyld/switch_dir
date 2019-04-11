## sd
sd(**S**witch **D**irectory) is a handy bash script to switch among directories you regularly work on.

### Why

In my daily work, I often have to switch among lots of directories in shell: cd to this, cd to that... What drives me crazy is that I often forgot which directory I should cd to. 

**sd** is born for this. It allows you store directories you regularly work on in a data file, view them once you forget which directories to cd to, and remove them if you don't need any more.

### Install

`sudo ./install.sh` to install **sd** to your /usr/local/bin or /usr/bin

Please make sure install.sh and sd.sh are in the same directory.

### Usage

After installation, type `sd -h` to see helping entries

```bash
Usage: sd [-option]
   or: sd [-option] [arg...]
where options include:
   -h          show this help
   -l          list all dirs you've added
   -s [no.]    select a dir to switch to, according to seq no.
   -a .        add current dir
   -a [dir]    add absolute dir
   -r [no.]    remove absolute dir, according to seq no.
   -ri         remove invalid dirs
   -R          remove all dirs

```
