# Database Setup Commands

## Create Databases

```sql
CREATE DATABASE local_csnp_mobile OWNER local;
```

## Run Migrations

```bash
./gradlew :migrations:credential-migrations:flywayMigrate
./gradlew :migrations:notification-migrations:flywayMigrate
```

## Setup Instructions

1. **Create the databases** - Execute the SQL commands to create the credential and notification databases with `local` as the owner
2. **Run migrations** - Execute the Gradle commands to apply Flyway migrations for both databases

## Notes

- Ensure PostgreSQL is running and the `local` user exists with appropriate permissions
- Make sure Gradle wrapper is executable and the migration modules are properly configured
- Run these commands from the project root directory
