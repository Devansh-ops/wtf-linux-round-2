batName=`ls /sys/class/power_supply/ | grep "BAT*"`
charge=`cat /sys/class/power_supply/$batName/capacity`
#echo $charge
status=`cat /sys/class/power_supply/$batName/status`
#echo $status

if [[ $charge -lt 30 ]]
then
    echo "Charge less than 30%"
    echo "Setting governor to Powersave"
    # enter code here
    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
elif [[ $charge -eq 100 && $status != "Charging" ]]
then
    echo "Full charge, and not on charging"
    echo "Setting governor to Conservative"
    # enter code here
    echo conservative | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
elif [[ $status = "Charging" ]]
then
    echo "AC power"
    echo "Setting governor to Performance"
    # enter code here
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
fi
