cd ~/devops/toktobaev_nooruzbek       # project folder
pwd                                   # where am I
ls                                    # list files
ls -la                                # all files with permissions
cd scripts                            # go to scripts
cd ..                                 # back
mkdir demo                            # new folder
touch demo/test.txt                   # new empty file
cp demo/test.txt demo/copy.txt        # copy
mv demo/copy.txt demo/renamed.txt     # rename
ls demo
rm -r demo                            # delete folder
cat Toktobaev_Nooruzbek_info.txt      # show file
head -n 3 logs/application.log        # first lines
tail -n 3 logs/application.log        # last lines

find ~/devops -name application.log   # find file
grep ERROR logs/application.log       # errors
grep WARNING logs/application.log     # warnings
grep -c ERROR logs/application.log    # count errors
tail -n 5 logs/application.log        # last 5 lines

ls -l private.txt public.txt          # permissions
chmod 600 private.txt                 # only me
chmod 644 public.txt                  # everyone can read
chmod 755 scripts/Toktobaev_Nooruzbek_system.sh   # everyone can run
ls -l private.txt public.txt scripts/

./scripts/Toktobaev_Nooruzbek_system.sh

ps                                    # my processes
ps aux                                # all processes
ps aux | grep bash                    # find a process
ps aux | grep dockerd
top                                   # live monitor, q to quit
