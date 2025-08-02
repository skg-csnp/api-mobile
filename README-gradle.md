https://gradle.org/install/#manually
.\gradlew :migrations:credential-migrations:bootRun --info
.\gradlew :migrations:credential-migrations:bootRun --stacktrace
.\gradlew :migrations:credential-migrations:bootRun
.\gradlew :migrations:credential-migrations:liquibaseGenerateChangeLog

✅ Chạy lệnh sau để generate changelog từ entity:
./gradlew :migrations:credential-migrations:update
./gradlew :migrations:credential-migrations:generateChangeLog
./gradlew :migrations:credential-migrations:diffChangeLog

Nhưng nếu bạn muốn generate hoàn toàn từ Hibernate Entity, hãy dùng:
./gradlew :migrations:credential-migrations:liquibaseGenerateChangeLog -PrunList=hibernate
