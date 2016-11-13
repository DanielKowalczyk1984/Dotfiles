#!/bin/bash
batinf='acpi -b'
perc0=$(acpi -b | ag "Battery 0" | awk '{print $4;}' | sed 's/%//g' | sed 's/,//g')
perc1=$(acpi -b | ag "Battery 1" | awk '{print $4;}' | sed 's/%//g' | sed 's/,//g')
perc=$(acpi -b | awk '{print $4;}' | sed 's/%//g' | sed 's/,//g')
charging0=$(acpi -b | ag "Battery 0" | grep -c 'Discharging\|Unknown')
charging1=$(acpi -b | ag "Battery 1" | grep -c 'Discharging\|Unknown')
bat0="1:   $perc0"
bat1="2:   $perc1"

if [ ! $charging0 -eq 1 ]
then bat0="  $perc0%"
elif (( $perc0 > '75'))
then bat0="  $perc0%"
elif (( $perc0 > '50' ))
then bat0="  $perc0%"
elif (( $perc0 > '25' ))
then bat0="  $perc0%"
elif  (( $perc0 > '10' ))
then bat0="  $perc0%"
fi

if [ ! $charging1 -eq 1 ]
then bat1="  $perc1%"
elif (( $perc1 > '75'))
then bat1="  $perc1%"
elif (( $perc1 > '50' ))
then bat1="  $perc1%"
elif (( $perc1 > '25' ))
then bat1="  $perc1%"
elif  (( $perc1 > '10' ))
then bat1="  $perc1%"
fi

echo $bat0 $bat1
case $BLOCK_BUTTON in
	3) mate-power-statistics ;;
esac
