#!/bin/bash

# Function to get memory usage in percentage
get_mem_usage() {
    mem_data=$(free | grep Mem)
    used_mem=$(echo $mem_data | awk '{print $3}')
    total_mem=$(echo $mem_data | awk '{print $2}')
    mem_percent=$((100 * used_mem / total_mem))
    echo $mem_percent
}

# Function to get CPU usage in percentage (average over 1 second)
get_cpu_usage() {
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $4}' | awk '{print $1}')
    cpu_usage=$(echo "100 - $cpu_idle" | bc)
    cpu_usage_int=$(printf "%.0f" $cpu_usage)
    echo $cpu_usage_int
}


# Function to get disk usage in percentage (root partition)
get_disk_usage() {
    disk_percent=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    echo $disk_percent
}

mem_usage=$(get_mem_usage)
cpu_usage=$(get_cpu_usage)
disk_usage=$(get_disk_usage)

is_healthy=true
details=""

if [ "$mem_usage" -gt 60 ]; then
    is_healthy=false
    details+="Memory usage is $mem_usage%, which is above the 60% threshold.\n"
else
    details+="Memory usage is $mem_usage%, which is below the 60% threshold.\n"
fi

if [ "$cpu_usage" -gt 60 ]; then
    is_healthy=false
    details+="CPU usage is $cpu_usage%, which is above the 60% threshold.\n"
else
    details+="CPU usage is $cpu_usage%, which is below the 60% threshold.\n"
fi

if [ "$disk_usage" -gt 60 ]; then
    is_healthy=false
    details+="Disk usage is $disk_usage%, which is above the 60% threshold.\n"
else
    details+="Disk usage is $disk_usage%, which is below the 60% threshold.\n"
fi

if [ "$is_healthy" = true ]; then
    status="healthy"
else
    status="unhealthy"
fi

if [ "$1" == "explain" ]; then
    echo -e "Virtual Machine Health Check: $status"
    echo -e $details
else
    echo "Virtual Machine Health Check: $status"
fi
