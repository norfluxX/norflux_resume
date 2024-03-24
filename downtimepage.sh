#!/bin/bash

# Define the file path of your Apache configuration file
config_file=""

# Define the start and end time of the maintenance window in HHMM format
read -p "Enter maintenance start_time: " start_time
read -p "Enter maintenance end_time: " end_time

# Generate the RewriteCond lines for the maintenance window
start_condition="RewriteCond %{TIME_HOUR}%{TIME_MIN} >${start_time}"
end_condition="RewriteCond %{TIME_HOUR}%{TIME_MIN} <${end_time}"

# Modify the Apache configuration file with the new conditions
sed -i "s|RewriteCond %{TIME_HOUR}%{TIME_MIN} >[0-9]*|${start_condition}|" $config_file
sed -i "s|RewriteCond %{TIME_HOUR}%{TIME_MIN} <[0-9]*|${end_condition}|" $config_file

# Restart Apache to apply the changes
#sudo systemctl restart apache2