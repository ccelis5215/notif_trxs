#!/bin/sh
#
#       24/05/2021 Cesar Celis
#       Send email alert in absence of some transactions absence
#
echo "From: fromaddress@domain.com" > /tmp/txt.txt
echo "To: recipient@domain.com" >> /tmp/txt.txt
echo "Cc: another@domain.com; someother@domain.com" >> /tmp/txt.txt
echo "Subject: ALERT TRXS NOT RECEIPT $(date +%T)" >> /tmp/txt.txt
#
minutes=`mysql -N -hSOMESERVER -uSOMEBDUSER -pSOMESILLYPASSWORD < notif_trxs.sql`
#
if [ "$?" -eq "0" ]
then
        if [ "$minutes" -ne "0" ]
        then
                echo "The XXX APP has not received transactions for " $minutes " >> /tmp/txt.txt
                echo "This is an automated message. Do not answer." >> /tmp/txt.txt
                echo "End of notification." >> /tmp/txt.txt
                sendmail -t < /tmp/snp.txt
        fi
else
        echo "An error has ocurred trying to connect to DB" >> /tmp/txt.txt
        echo "Check server... " >> /tmp/snp.txt
        echo "This is an automated message. Do not answer." >> /tmp/txt.txt
        echo "End of notification." >> /tmp/txt.txt
        sendmail -t < /tmp/snp.txt
fi

#
exit
