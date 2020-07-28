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
###Example of run
```aidl
./getJobs.sh -d 2020-07-01 -f plugins.txt -o BD-CD_10.0.1
```
Date format: YYYY-MM-DD (-d flag)


## /CloudBees/Plugins/getJobs.sh
Gathering the information about Plugins Build job runs from CloudBees CD server based on the plugins list - collect the versions and jobs run
Example  plugins.txt
```
EC-Chef
EC-CloudFoundry
EC-Core
EC-Docker
EC-Dynatrace
```
Example of output
```
EC-Chef, Version: 1.2.4.2020061702,  JobLink:  <Link>
EC-CloudFoundry, Version: 1.6.0.2020060301,  JobLink:  <Link>
EC-Core, Version: 1.2.9.2020050702,  JobLink:  <Link>
EC-Docker, Version: 1.6.1.2020060301,  JobLink:  <Link>
EC-Dynatrace, Version: 1.2.1.2020060301,  JobLink:  <Link>

```
and
```
|11|EC-Chef | 1.2.4.2020061702 | <Link> |
|12|EC-CloudFoundry | 1.6.0.2020060301 | <Link> |
|13|EC-Core | 1.2.9.2020050702 | <Link> |
|14|EC-Docker | 1.6.1.2020060301 | <Link> |
|15|EC-Dynatrace | 1.2.1.2020060301 | <Link> |
```
