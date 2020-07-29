#!/bin/bash
#set -x
host=viva.beescloud.com
number=1
outcome="success"
while getopts "s:d:f:o:h:n:r" opt; do
  case $opt in
    s) host="$OPTARG"
	;;
	d) startDate="$OPTARG"
    ;;
    f) fileIn="$OPTARG"
	;;
	o) fileOut="$OPTARG"
    ;;
	n) number="$OPTARG"
	;;
	r) outcome="$OPTARG"
	;;
    h) echo """The script required
	1) xpath tool on console
	2) session connection to CloudBees CD server
	The Scripts returns the list of job links for flow server
	-s: Server of ClodBees CD by default viva.beescloud.com
	-d: Date of of start the search build of plugins
	-f: file Name with list of plugins in line separated format
	-o: output file with results, formatted-<output file name> - formatted file for JIRA table
	-n: number of build per Plugin
	-r: outcome Result ('success', 'error')
	"""
	exit;
	;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

#intialize vars
count1=0
count2=0
host="https://${host}/"
rm "$fileOut" || true
rm "formatted-${fileOut}" || true
startDate="${startDate}T00:00:00.000Z"
echo "Start date is: ${startDate}"
echo "File with List of Plugins: ${fileIn}"
while IFS= read -r pluginName || [[ -n "$pluginName" ]]; do
    #intialize vars
	last=""
	jobId=""
	version="Not Found"
	makVersion="Not Found"
	skippedTests=0
	totalTests=0
	failedTests=0
	passedTests=0
	#counting
	((count1++))

	#remove redundant chars in the end of line
	pluginName=${pluginName//[$'\t\r\n']}
    echo "Plugin Name: $pluginName"

    #find objects on target Server
	ectool findObjects job --filters "[{ propertyName => 'projectName', operator => 'equals', operand1 => 'Github Plugins' },{ propertyName => 'procedureName', operator => 'equals', operand1 => 'Build GCP' },{ propertyName => 'outcome', operator => 'equals', operand1 => '${outcome}' },{ propertyName => 'createTime', operator => 'greaterOrEqual', operand1 => '${startDate}' },{ propertyName => 'jobName', operator => 'contains', operand1 => '${pluginName}-' },{ propertyName => 'jobName', operator => 'notLike', operand1 => '%preflight%' }]" > "${pluginName}.xml"

	#find last value by finish time
	last=`xpath -q -e '/response/object/job/finish/text()' "${pluginName}.xml" | sort -nr | head -n"${number}"`
	echo "${last}"

	#find jobId for latest finished job run
	xpath -q -e "/response/object/job[finish='${last}']" "${pluginName}.xml"
	jobId=`xpath -q -e "/response/object/job[finish='${last}']/jobId/text()" "${pluginName}.xml"`
	echo "${jobId}"

	#if jobId contains some id - get the version for Plugin
	if [[ $jobId != "" ]]
	then
		((count2++))
		version=`ectool getProperty --jobId ${jobId} --propertyName version`
		#plugins.mak view version creation
	    makVersion=`echo $version | grep -o -P "[0-9]\.[0-9]\."`
	    makVersion="${makVersion}*"
	    #collect tests information for Analyses
	    skippedTests=`ectool getProperty --jobId ${jobId} --propertyName skippedSystemtests`
		totalTests=`ectool getProperty --jobId ${jobId} --propertyName totalSystemtests`
		failedTests=`ectool getProperty --jobId ${jobId} --propertyName failedSystemtests`
		passedTests=`expr $totalTests - $failedTests`
		passedTests=`expr $totalTests - $skippedTests`
		echo "|${count2}|${pluginName} | ${version} | Total: ${totalTests} Tests Passed | ${jobLink} |" >> "formatted-forJIRA-WithoutNotFound-${fileOut}"
	fi

	#link to job creation
	jobLink="${host}/commander/link/jobDetails/jobs/${jobId}"
	echo "${jobLink}"
	#fining the files
	echo "${pluginName}, Version: ${version},  JobLink:  $jobLink" >> "$fileOut"
	if [[ $totalTests != 0 ]]
	then
		echo "|${count1}|${pluginName} | ${version} | Total: ${totalTests} Tests Passed | ${jobLink} | (/) |" >> "formatted-forJIRA-${fileOut}"
	else
		echo "|${count1}|${pluginName} | ${version} | Total: ${totalTests} Tests Passed | ${jobLink} |" >> "formatted-forJIRA-${fileOut}"
	fi
	#echo "|${count1}|${pluginName} | ${version} | ${jobLink} |" >> "formatted-forJIRA-${fileOut}"
	echo "${pluginName}:${makVersion}" >> "formatted-forPlugins.mak-${fileOut}"

	#deletion of temporary xml files with responces from CloudBees Server
	rm "${pluginName}.xml" || true
done < "${fileIn}"