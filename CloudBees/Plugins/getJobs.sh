#!/bin/bash
#set -x
host=viva.beescloud.com
number=1
while getopts "s:d:f:o:h:n" opt; do
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
    h) echo """The script required 
	1) xpath tool on console
	2) session connection to CloudBees CD server
	The Scripts returns the list of job links for flow server
	-s: Server of ClodBees CD by default viva.beescloud.com
	-d: Date of of start the search build of plugins
	-f: file Name with list of plugins in line separated format
	-o: output file with results
	-n: number of build per Plugin
	"""
	exit;
	;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
last=""
host="https://${host}/"
rm "$fileOut" || true
startDate="${startDate}T00:00:00.000Z"
echo "Start date is: ${startDate}"
echo "File with List of Plugins: ${fileIn}"
while IFS= read -r pluginName || [[ -n "$pluginName" ]]; do
	pluginName=${pluginName//[$'\t\r\n']}
    echo "Plugin Name: $pluginName"
	ectool findObjects job --filters "[{ propertyName => 'projectName', operator => 'equals', operand1 => 'Github Plugins' },{ propertyName => 'procedureName', operator => 'equals', operand1 => 'Build GCP' },{ propertyName => 'outcome', operator => 'equals', operand1 => 'success' },{ propertyName => 'createTime', operator => 'greaterOrEqual', operand1 => '${startDate}' },{ propertyName => 'jobName', operator => 'contains', operand1 => '${pluginName}' },{ propertyName => 'jobName', operator => 'notLike', operand1 => '%preflight%' }]" > "${pluginName}.xml"
	last=`xpath -q -e '/response/object/job/finish/text()' "${pluginName}.xml" | sort -nr | head -n"${number}"`
	echo "${last}"
	xpath -q -e "/response/object/job[finish='${last}']" "${pluginName}.xml"
	jobId=`xpath -q -e "/response/object/job[finish='${last}']/jobId/text()" "${pluginName}.xml"`
	jobLink="${host}/commander/link/jobDetails/jobs/${jobId}"
	echo "${jobLink}"
	echo "${pluginName} JobLink: $jobLink" >> "$fileOut"
done < "${fileIn}"

