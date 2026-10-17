#!/bin/bash
# Linux demo commands for the video (Nooruzbek Toktobaev, "IT-2 2313", 38422).
# This is a cheat sheet: copy and run the commands one by one, do not run the whole file.
exit 0

# ---------- Navigation and files ----------
cd ~/devops/toktobaev_nooruzbek       # go to the project folder
pwd                                   # print current working directory
ls                                    # list files
ls -la                                # list all files (incl. hidden) with permissions, owner, size
cd scripts                            # change directory to scripts/
cd ..                                 # go one level up
mkdir demo                            # create a directory
touch demo/test.txt                   # create an empty file
cp demo/test.txt demo/copy.txt        # copy a file
mv demo/copy.txt demo/renamed.txt     # move / rename a file
ls demo                               # check result
rm -r demo                            # remove the directory with its files
cat Toktobaev_Nooruzbek_info.txt      # print whole file
head -n 3 logs/application.log        # first 3 lines
tail -n 3 logs/application.log        # last 3 lines

# ---------- Search and logs ----------
find ~/devops -name application.log   # find a file by name
grep ERROR logs/application.log       # lines with ERROR
grep WARNING logs/application.log     # lines with WARNING
grep -c ERROR logs/application.log    # count ERROR lines
tail -n 5 logs/application.log        # last 5 log lines

# ---------- Permissions ----------
ls -l private.txt public.txt          # show permissions
chmod 600 private.txt                 # rw------- : only owner reads/writes
chmod 644 public.txt                  # rw-r--r-- : owner writes, everyone reads
chmod 755 scripts/Toktobaev_Nooruzbek_system.sh  # rwxr-xr-x : everyone can run
ls -l private.txt public.txt scripts/

# ---------- Script ----------
./scripts/Toktobaev_Nooruzbek_system.sh

# ---------- Processes ----------
ps                                    # processes of the current terminal
ps aux                                # all processes of all users
ps aux | grep bash                    # filter processes by name
ps aux | grep dockerd
top                                   # live process monitor (press q to quit)
