#!/bin/bash

# List of directories to clean up (separate by spaces)
TARGET_DIRS=(
    "/root/network/backups/ACCESS_RTR"
    "/root/network/backups/CORE_RTR"
    "/root/network/backups/CORE_SWITCH"
    "/root/network/backups/HUAWEI"
    "/root/network/backups/JUNIPER"
    "/root/network/backups/NAT_RTR"
    "/root/network/backups/BDCOM"
    "/root/network/backups/VXLAN_RTR"
    "/root/network/backups/UPSTREAM_REPORT"
)

# Number of days
DAYS=14

# Loop through each directory
for DIR in "${TARGET_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "Checking $DIR..."
        
        # Check if there is any file modified within the last $DAYS days
        RECENT_FILE_COUNT=$(find "$DIR" -type f -mtime -$DAYS | wc -l)
        
        if [ "$RECENT_FILE_COUNT" -gt 0 ]; then
            echo "Recent file(s) found in $DIR. Cleaning up old files..."
            find "$DIR" -type f -mtime +$DAYS -exec rm -f {} \;
            echo "Cleanup completed for $DIR."
        else
            echo "No recent files found in $DIR. Skipping deletion."
        fi
    else
        echo "Directory $DIR does not exist. Skipping..."
    fi
done

echo "All cleanups completed."
