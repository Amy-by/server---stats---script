#!/bin/bash

# 输出 CPU 总使用率
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.2f%%", 100 - $8}')
echo "CPU Total Usage: $cpu_usage"

# 输出内存使用情况
mem_info=$(free -m | grep "Mem:" | awk '{total=$2; used=$3; free=$4; usage=(used*100)/total; printf "Total Memory: %d MB, Used: %d MB, Free: %d MB, Usage: %.2f%%", total, used, free, usage}')
echo "$mem_info"

# 输出磁盘使用情况（以根目录 / 为例）
disk_info=$(df -m / | grep "/" | awk '{total=$2; used=$3; free=$4; usage=(used*100)/total; printf "Total Disk: %d MB, Used: %d MB, Free: %d MB, Usage: %.2f%%", total, used, free, usage}')
echo "$disk_info"

# 输出 CPU 使用率前五的进程
echo "Top 5 CPU Processes:"
ps aux --sort=-%cpu | head -n6 | tail -n5 | awk '{printf "PID: %d, CPU: %.2f%%, Command: %s\n", $2, $3, $11}'

# 输出内存使用率前五的进程
echo "Top 5 Memory Processes:"
ps aux --sort=-%mem | head -n6 | tail -n5 | awk '{printf "PID: %d, Memory: %.2f%%, Command: %s\n", $2, $4, $11}'