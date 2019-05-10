#!/bin/bash
#Locate Process, Stop, Remove App, Report to JAMF
#For any "<>" in this document replace with appropriate text

#Set Variables
WIFI=(
	'<wifi1'
	'<wifi2>'
  '<wifi3>'
	)
PROCESS=(
	'<process1>'
	'<process2>'
	)
APP="<appname>"
LOGFILE="vpnkiller.log"
NOW="$(Date +"%m/%d/%Y %H:%M")"

#Set Function - scan networks
atSchool ()
{
WifiAvailable=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -s | grep "<wifi>" | awk '{print $1}'`
# test to see if the Asset is at school by scanning for school networks and see if one is the school
for ScannedNetworks in $WifiAvailable
    do
        for SchoolNetwork in $WIFI
            do
                if [ "$SchoolNetwork" != "$ScannedNetworks" ]
                    then
                        AssetAtSchool="No"
                        echo "The Device is not at school" >> /var/log/"$LOGFILE"
                        echo "Exiting..." >> /var/log/"$LOGFILE"
                        exit 1
                fi
            done
    done
AssetAtSchool="YES"
echo "Asset is at school" >> /var/log/"$LOGFILE"
}


#Set Output Log
touch /var/log/"$LOGFILE"
echo "vpnremove script starting - $NOW" >> /var/log/"$LOGFILE"

#Run Function
atSchool

#Find PID for Process in array, Print to output, then Stop Process
for p in "${PROCESS[@]}"
do
	PID="$(pgrep $p) "
	echo "$p PID = $PID" >> /var/log/"$LOGFILE"
	kill -9 $PID
done

echo "Processes Stopped" >> /var/log/"$LOGFILE"

#Removing Application
rm -rf /Applications/"$APP"
echo "Application Removed" >> /var/log/"$LOGFILE"

#Report to JAMF
jamf recon
echo "Reported to JAMF" >> /var/log/"$LOGFILE"


#Script Finished
echo "vpnkiller script complete" >> /var/log/"$LOGFILE"

exit 0
