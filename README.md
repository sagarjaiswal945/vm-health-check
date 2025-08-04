# VM Health Check Script

## Overview

This repository contains a shell script (`vm_health_check.sh`) to analyze the health of a virtual machine based on three key metrics:

- **Memory Usage**
- **CPU Usage**
- **Disk Space Usage**

## Health Criteria

- If **all three metrics** are **≤ 60%** utilized, the VM is considered **healthy**.
- If **any metric** is **> 60%** utilized, the VM is considered **unhealthy**.

## Usage

- **Basic Health Check**
  ```bash
  ./vm_health_check.sh
  ```
  This will print whether the VM is `healthy` or `unhealthy`.

- **With Explanation**
  ```bash
  ./vm_health_check.sh explain
  ```
  This mode provides detailed information about each metric and explains why the VM is classified as healthy or unhealthy.

## Details

- **Memory Usage** is calculated using the `free` command.
- **CPU Usage** is measured as average over 1 second with the `top` command.
- **Disk Usage** checks the root (`/`) partition using the `df` command.
- The script is compatible with most Linux distributions.

## Example Output

```
Virtual Machine Health Check: unhealthy
Memory usage is 61%, which is above the 60% threshold.
CPU usage is 55%, which is below the 60% threshold.
Disk usage is 40%, which is below the 60% threshold.
```

## Author

- GitHub: [sagarjaiswal945](https://github.com/sagarjaiswal945)
