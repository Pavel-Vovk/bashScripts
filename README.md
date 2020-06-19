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
EC-Chef, Version: 1.2.4.2020061702,  JobLink:  https://viva.beescloud.com//commander/link/jobDetails/jobs/4a62329c-b090-11ea-beb3-42010ac90206
EC-CloudFoundry, Version: 1.6.0.2020060301,  JobLink:  https://viva.beescloud.com//commander/link/jobDetails/jobs/200127b1-a598-11ea-aae4-42010ac90206
EC-Core, Version: 1.2.9.2020050702,  JobLink:  https://viva.beescloud.com//commander/link/jobDetails/jobs/d019a2d4-906c-11ea-a96a-42010ac90206
EC-Docker, Version: 1.6.1.2020060301,  JobLink:  https://viva.beescloud.com//commander/link/jobDetails/jobs/d05de578-a5a6-11ea-bcd9-42010ac90206
EC-Dynatrace, Version: 1.2.1.2020060301,  JobLink:  https://viva.beescloud.com//commander/link/jobDetails/jobs/21eeeded-a598-11ea-97ae-42010ac90206

```
and
```
|11|EC-Chef | 1.2.4.2020061702 | https://viva.beescloud.com//commander/link/jobDetails/jobs/4a62329c-b090-11ea-beb3-42010ac90206 |
|12|EC-CloudFoundry | 1.6.0.2020060301 | https://viva.beescloud.com//commander/link/jobDetails/jobs/200127b1-a598-11ea-aae4-42010ac90206 |
|13|EC-Core | 1.2.9.2020050702 | https://viva.beescloud.com//commander/link/jobDetails/jobs/d019a2d4-906c-11ea-a96a-42010ac90206 |
|14|EC-Docker | 1.6.1.2020060301 | https://viva.beescloud.com//commander/link/jobDetails/jobs/d05de578-a5a6-11ea-bcd9-42010ac90206 |
|15|EC-Dynatrace | 1.2.1.2020060301 | https://viva.beescloud.com//commander/link/jobDetails/jobs/21eeeded-a598-11ea-97ae-42010ac90206 |
```
