#!/bin/bash

# MySQL connection parameters
DB_HOST="host"
DB_USER="username"
DB_PASSWORD="password"
DB_NAME="dummy_database"
LOG_FILE="insert_log.txt"

# Create MySQL database if it doesn't exist
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create table schema
table_schema=$(cat << EOF
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    age INT
);
EOF
)

# Execute table creation query
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME -e "$table_schema"

# Function to generate random user data
generate_user_data() {
    name=$(faker name | sed "s/'/''/g")
    email=$(faker email | sed "s/'/''/g")
    age=$(shuf -i 18-80 -n 1)
    echo "'$name', '$email', $age"
}

# Function to count the number of records in the users table
count_users() {
    count_result=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME -s -N -e "SELECT COUNT(*) FROM users;" 2>&1)
    if [[ $? -eq 0 ]]; then
        count=$(echo "$count_result" | tail -n 1 | cut -f1)  # Extract count from query result
        echo "Total number of records in users table: $count"
    else
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Error counting users: $count_result" >> $LOG_FILE
    fi
}

# Insert 5 dummy data records into the table every 2 seconds
while true; do
    for ((i=1; i<=5; i++)); do
        user_data=$(generate_user_data)
        insert_result=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME -e "INSERT INTO users (name, email, age) VALUES ($user_data);" 2>&1)
        if [[ $? -eq 0 ]]; then
            echo "$(date +"%Y-%m-%d %H:%M:%S") - Inserted successfully" >> $LOG_FILE
		else
            echo "$(date +"%Y-%m-%d %H:%M:%S") - Error inserting data: $insert_result" >> $LOG_FILE
        fi
    done
    count_users >> $LOG_FILE
    sleep 2
done &
