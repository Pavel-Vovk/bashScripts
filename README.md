# bashScripts
## git/update_git_repos.sh
Copy the file to the dir/folder where your list of the repos are storing.
chnage the current location to the target dir/folder
for example:
```
-<GitStorage>
--<repo1>
--<repo2>
--...
```
run:
```
<user>@<host>:/path/to/GitStorage$ ./update_git_repos.sh master
```
## /CloudBees/Flow/setup.sh
Prepare the Ubuntu machine to run and install the CloudBees Flow

## /CloudBees/Plugins/getJobs.sh
Gathering the information about Plugins Build job runs from CloudBees CD server based on the plugins list - collect the versions and jobs run
