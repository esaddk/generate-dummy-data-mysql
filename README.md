# generate-dummy-data-mysql

This script is designed to continuously insert dummy data into a MySQL database table named `users`. It also includes functionality to create the database and table if they do not already exist, as well as logging the insertion process and counting the number of records in the table.

  
## Prerequisites

- MySQL server installed and running
- MySQL user credentials with permission to create databases and tables


## Configuration

Before running the script, ensure to update the following variables in the script according to your MySQL database configuration:

- `DB_HOST`: The hostname or IP address of the MySQL server.
- `DB_USER`: The username used to connect to the MySQL server.
- `DB_PASSWORD`: The password for the MySQL user.
- `DB_NAME`: The name of the database where the `users` table will be created.
- `LOG_FILE`: The path to the log file where insertion process and errors will be logged.

  
## Usage

1. Make sure the script file has execute permissions:
```bash

chmod +x mysql_insert_script.sh

```
  
2. Run the script:
```bash

./mysql_insert_script.sh

```

  
The script will continuously insert dummy data into the `users` table every 2 seconds, with each batch inserting 5 records. It will also create the database and table if they do not already exist.

  
## Functionality

- **Database Creation**: If the specified database does not exist, the script creates it.
- **Table Creation**: The script creates a table named `users` with columns `id`, `name`, `email`, and `age`.
- **Data Insertion**: Dummy user data is generated and inserted into the `users` table in batches of 5 records every 2 seconds.
- **Logging**: The script logs the insertion process and any errors encountered during insertion to the specified log file.
- **Record Counting**: The script counts the total number of records in the `users` table and logs the count along with the insertion process.

  
## Dependencies

- [MySQL](https://www.mysql.com/): The script relies on MySQL server for database operations.
- [Faker](https://faker.readthedocs.io/en/master/): A Python library used to generate fake data.

Make sure to install the Faker library before running the script:
```bash

pip install faker

```


## License

This script is released under the [MIT License](https://opensource.org/licenses/MIT).

```
