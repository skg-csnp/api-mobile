@echo off
setlocal enabledelayedexpansion

:: Solution name
set PROJECT_NAME=csnp
set PACKAGE_NAME=com.csnp
set PACKAGE_PATH=%PACKAGE_NAME:.=\%

echo Creating CSNP DDD Java Spring Boot Solution Structure...
echo.

:: Root directories
set ROOT_DIR=%cd%
set SRC_DIR=%ROOT_DIR%\src
set SHARED_DIR=%ROOT_DIR%\shared
set MIGRATIONS_DIR=%ROOT_DIR%\migrations

:: Create root build.gradle
call :create_root_gradle

:: SeedWork - Foundation layers (Shared Libraries)
echo Creating SeedWork foundation layers...
call :create_java_lib %SHARED_DIR%\seedwork
call :create_package_structure %SHARED_DIR%\seedwork\src\main\java\%PACKAGE_PATH%\seedwork\domain\valueobjects
call :create_package_structure %SHARED_DIR%\seedwork\src\main\java\%PACKAGE_PATH%\seedwork\domain\events
call :create_package_structure %SHARED_DIR%\seedwork\src\main\java\%PACKAGE_PATH%\seedwork\application

:: SharedKernel - Shared domain logic
echo Creating SharedKernel shared domain logic layers...
call :create_java_lib %SHARED_DIR%\shared-kernel-domain
call :create_package_structure %SHARED_DIR%\shared-kernel-domain\src\main\java\%PACKAGE_PATH%\sharedkernel\domain\events
call :create_package_structure %SHARED_DIR%\shared-kernel-domain\src\main\java\%PACKAGE_PATH%\sharedkernel\domain\exceptions
call :create_package_structure %SHARED_DIR%\shared-kernel-domain\src\main\java\%PACKAGE_PATH%\sharedkernel\domain\rules

call :create_java_lib %SHARED_DIR%\shared-kernel-application
call :create_package_structure %SHARED_DIR%\shared-kernel-application\src\main\java\%PACKAGE_PATH%\sharedkernel\application\behaviors
call :create_package_structure %SHARED_DIR%\shared-kernel-application\src\main\java\%PACKAGE_PATH%\sharedkernel\application\commands
call :create_package_structure %SHARED_DIR%\shared-kernel-application\src\main\java\%PACKAGE_PATH%\sharedkernel\application\queries
call :create_package_structure %SHARED_DIR%\shared-kernel-application\src\main\java\%PACKAGE_PATH%\sharedkernel\application\events

call :create_java_lib %SHARED_DIR%\shared-kernel-infrastructure
call :create_package_structure %SHARED_DIR%\shared-kernel-infrastructure\src\main\java\%PACKAGE_PATH%\sharedkernel\infrastructure\events
call :create_package_structure %SHARED_DIR%\shared-kernel-infrastructure\src\main\java\%PACKAGE_PATH%\sharedkernel\infrastructure\messaging

:: Security Infrastructure - Cross-cutting utilities
echo Creating Security Infrastructure cross-cutting layer...
call :create_java_lib %SHARED_DIR%\security-infrastructure
call :create_package_structure %SHARED_DIR%\security-infrastructure\src\main\java\%PACKAGE_PATH%\security\infrastructure security

:: EventBus - Event-driven communication
echo Creating EventBus layer...
call :create_java_lib %SHARED_DIR%\event-bus
call :create_package_structure %SHARED_DIR%\event-bus\src\main\java\%PACKAGE_PATH%\eventbus\abstractions
call :create_package_structure %SHARED_DIR%\event-bus\src\main\java\%PACKAGE_PATH%\eventbus\inmemory
call :create_package_structure %SHARED_DIR%\event-bus\src\main\java\%PACKAGE_PATH%\eventbus\rabbitmq

:: Credential Bounded Context
echo Creating Credential bounded context...
call :create_spring_boot_app %SRC_DIR%\credential\credential-api

call :create_java_lib %SRC_DIR%\credential\credential-application
call :create_package_structure %SRC_DIR%\credential\credential-application\src\main\java\%PACKAGE_PATH%\credential\application\commands
call :create_package_structure %SRC_DIR%\credential\credential-application\src\main\java\%PACKAGE_PATH%\credential\application\queries
call :create_package_structure %SRC_DIR%\credential\credential-application\src\main\java\%PACKAGE_PATH%\credential\application\events
call :create_package_structure %SRC_DIR%\credential\credential-application\src\main\java\%PACKAGE_PATH%\credential\application\behaviors

call :create_java_lib %SRC_DIR%\credential\credential-domain
call :create_package_structure %SRC_DIR%\credential\credential-domain\src\main\java\%PACKAGE_PATH%\credential\domain\aggregates
call :create_package_structure %SRC_DIR%\credential\credential-domain\src\main\java\%PACKAGE_PATH%\credential\domain\events
call :create_package_structure %SRC_DIR%\credential\credential-domain\src\main\java\%PACKAGE_PATH%\credential\domain\specifications

call :create_java_lib %SRC_DIR%\credential\credential-infrastructure
call :create_package_structure %SRC_DIR%\credential\credential-infrastructure\src\main\java\%PACKAGE_PATH%\credential\infrastructure\persistence
call :create_package_structure %SRC_DIR%\credential\credential-infrastructure\src\main\java\%PACKAGE_PATH%\credential\infrastructure\external
call :create_package_structure %SRC_DIR%\credential\credential-infrastructure\src\main\java\%PACKAGE_PATH%\credential\infrastructure\services
call :create_package_structure %SRC_DIR%\credential\credential-infrastructure\src\main\java\%PACKAGE_PATH%\credential\infrastructure\events

:: Notification Bounded Context
echo Creating Notification bounded context...
call :create_spring_boot_app %SRC_DIR%\notification\notification-api

call :create_java_lib %SRC_DIR%\notification\notification-application
call :create_package_structure %SRC_DIR%\notification\notification-application\src\main\java\%PACKAGE_PATH%\notification\application\commands
call :create_package_structure %SRC_DIR%\notification\notification-application\src\main\java\%PACKAGE_PATH%\notification\application\queries
call :create_package_structure %SRC_DIR%\notification\notification-application\src\main\java\%PACKAGE_PATH%\notification\application\events
call :create_package_structure %SRC_DIR%\notification\notification-application\src\main\java\%PACKAGE_PATH%\notification\application\behaviors

call :create_java_lib %SRC_DIR%\notification\notification-domain
call :create_package_structure %SRC_DIR%\notification\notification-domain\src\main\java\%PACKAGE_PATH%\notification\domain\aggregates
call :create_package_structure %SRC_DIR%\notification\notification-domain\src\main\java\%PACKAGE_PATH%\notification\domain\events
call :create_package_structure %SRC_DIR%\notification\notification-domain\src\main\java\%PACKAGE_PATH%\notification\domain\specifications

call :create_java_lib %SRC_DIR%\notification\notification-infrastructure
call :create_package_structure %SRC_DIR%\notification\notification-infrastructure\src\main\java\%PACKAGE_PATH%\notification\infrastructure\persistence
call :create_package_structure %SRC_DIR%\notification\notification-infrastructure\src\main\java\%PACKAGE_PATH%\notification\infrastructure\external
call :create_package_structure %SRC_DIR%\notification\notification-infrastructure\src\main\java\%PACKAGE_PATH%\notification\infrastructure\services
call :create_package_structure %SRC_DIR%\notification\notification-infrastructure\src\main\java\%PACKAGE_PATH%\notification\infrastructure\events

:: Presentation
echo Creating Presentation layer...
call :create_spring_boot_app %SRC_DIR%\presentation\presentation-web

:: Migrations
echo Creating Migration projects...
call :create_java_lib %MIGRATIONS_DIR%\credential-migrations
call :create_package_structure %MIGRATIONS_DIR%\credential-migrations\src\main\java\%PACKAGE_PATH%\migrations\credential configurations
call :create_package_structure %MIGRATIONS_DIR%\credential-migrations\src\main\java\%PACKAGE_PATH%\migrations\credential seeds

call :create_java_lib %MIGRATIONS_DIR%\notification-migrations
call :create_package_structure %MIGRATIONS_DIR%\notification-migrations\src\main\java\%PACKAGE_PATH%\migrations\notification configurations
call :create_package_structure %MIGRATIONS_DIR%\notification-migrations\src\main\java\%PACKAGE_PATH%\migrations\notification seeds

:: Tests
echo Creating test projects...
call :create_test_project %SRC_DIR%\credential\credential-domain\src\test\java\%PACKAGE_PATH%\credential\domain
call :create_test_project %SRC_DIR%\credential\credential-application\src\test\java\%PACKAGE_PATH%\credential\application
call :create_test_project %SRC_DIR%\credential\credential-infrastructure\src\test\java\%PACKAGE_PATH%\credential\infrastructure
call :create_test_project %SRC_DIR%\credential\credential-api\src\test\java\%PACKAGE_PATH%\credential\api

call :create_test_project %SRC_DIR%\notification\notification-domain\src\test\java\%PACKAGE_PATH%\notification\domain
call :create_test_project %SRC_DIR%\notification\notification-application\src\test\java\%PACKAGE_PATH%\notification\application
call :create_test_project %SRC_DIR%\notification\notification-infrastructure\src\test\java\%PACKAGE_PATH%\notification\infrastructure
call :create_test_project %SRC_DIR%\notification\notification-api\src\test\java\%PACKAGE_PATH%\notification\api

:: Create settings.gradle
call :create_settings_gradle

:: Setup project references (equivalent to .NET project references)
echo Setting up project dependencies...
call :setup_project_dependencies

:: Create gradle wrapper
echo Creating Gradle wrapper...
call gradle wrapper --gradle-version 9.0

:: Create .gitignore
call :create_gitignore

echo.
echo Solution structure created successfully!
echo.
echo To build the project:
echo   gradle build
echo.
echo To run specific service:
echo   gradle :credential-api:bootRun
echo   gradle :notification-api:bootRun
echo   gradle :presentation-web:bootRun
echo.

goto :eof

:: Helper Functions
:create_root_gradle
echo plugins { > build.gradle
echo     id 'java'>> build.gradle
echo     id 'org.springframework.boot' version '3.5.4' apply false>> build.gradle
echo     id 'io.spring.dependency-management' version '1.1.7' apply false>> build.gradle
echo }>> build.gradle
echo.>> build.gradle
echo allprojects {>> build.gradle
echo     group = '%PACKAGE_NAME%'>> build.gradle
echo     version = '1.0.0'>> build.gradle
echo.>> build.gradle
echo     repositories {>> build.gradle
echo         mavenCentral()>> build.gradle
echo     }>> build.gradle
echo }>> build.gradle
echo.>> build.gradle
echo subprojects {>> build.gradle
echo     apply plugin: 'java'>> build.gradle
echo.>> build.gradle
echo     java {>> build.gradle
echo         toolchain {>> build.gradle
echo             languageVersion = JavaLanguageVersion.of(21)>> build.gradle
echo         }>> build.gradle
echo     }>> build.gradle
echo.>> build.gradle
echo     dependencies {>> build.gradle
echo         testImplementation 'org.springframework.boot:spring-boot-starter-test'>> build.gradle
echo         testImplementation 'org.junit.jupiter:junit-jupiter'>> build.gradle
echo         testImplementation 'org.mockito:mockito-core'>> build.gradle
echo         testImplementation 'org.assertj:assertj-core'>> build.gradle
echo     }>> build.gradle
echo.>> build.gradle
echo     test {>> build.gradle
echo         useJUnitPlatform()>> build.gradle
echo     }>> build.gradle
echo }>> build.gradle
goto :eof

:create_settings_gradle
echo rootProject.name = '%PROJECT_NAME%' > settings.gradle
echo.>> settings.gradle
echo // Shared libraries>> settings.gradle
echo include 'shared:seedwork'>> settings.gradle
echo include 'shared:shared-kernel-domain'>> settings.gradle
echo include 'shared:shared-kernel-application'>> settings.gradle
echo include 'shared:shared-kernel-infrastructure'>> settings.gradle
echo include 'shared:security-infrastructure'>> settings.gradle
echo include 'shared:event-bus'>> settings.gradle
echo.>> settings.gradle
echo // Credential bounded context>> settings.gradle
echo include 'src:credential:credential-domain'>> settings.gradle
echo include 'src:credential:credential-application'>> settings.gradle
echo include 'src:credential:credential-infrastructure'>> settings.gradle
echo include 'src:credential:credential-api'>> settings.gradle
echo.>> settings.gradle
echo // Notification bounded context>> settings.gradle
echo include 'src:notification:notification-domain'>> settings.gradle
echo include 'src:notification:notification-application'>> settings.gradle
echo include 'src:notification:notification-infrastructure'>> settings.gradle
echo include 'src:notification:notification-api'>> settings.gradle
echo.>> settings.gradle
echo // Presentation>> settings.gradle
echo include 'src:presentation:presentation-web'>> settings.gradle
echo.>> settings.gradle
echo // Migrations>> settings.gradle
echo include 'migrations:credential-migrations'>> settings.gradle
echo include 'migrations:notification-migrations'>> settings.gradle
echo.>> settings.gradle
echo // Project directory mapping>> settings.gradle
echo project(':shared:seedwork').projectDir = file('shared/seedwork')>> settings.gradle
echo project(':shared:shared-kernel-domain').projectDir = file('shared/shared-kernel-domain')>> settings.gradle
echo project(':shared:shared-kernel-application').projectDir = file('shared/shared-kernel-application')>> settings.gradle
echo project(':shared:shared-kernel-infrastructure').projectDir = file('shared/shared-kernel-infrastructure')>> settings.gradle
echo project(':shared:security-infrastructure').projectDir = file('shared/security-infrastructure')>> settings.gradle
echo project(':shared:event-bus').projectDir = file('shared/event-bus')>> settings.gradle
echo project(':src:credential:credential-domain').projectDir = file('src/credential/credential-domain')>> settings.gradle
echo project(':src:credential:credential-application').projectDir = file('src/credential/credential-application')>> settings.gradle
echo project(':src:credential:credential-infrastructure').projectDir = file('src/credential/credential-infrastructure')>> settings.gradle
echo project(':src:credential:credential-api').projectDir = file('src/credential/credential-api')>> settings.gradle
echo project(':src:notification:notification-domain').projectDir = file('src/notification/notification-domain')>> settings.gradle
echo project(':src:notification:notification-application').projectDir = file('src/notification/notification-application')>> settings.gradle
echo project(':src:notification:notification-infrastructure').projectDir = file('src/notification/notification-infrastructure')>> settings.gradle
echo project(':src:notification:notification-api').projectDir = file('src/notification/notification-api')>> settings.gradle
echo project(':src:presentation:presentation-web').projectDir = file('src/presentation/presentation-web')>> settings.gradle
echo project(':migrations:credential-migrations').projectDir = file('migrations/credential-migrations')>> settings.gradle
echo project(':migrations:notification-migrations').projectDir = file('migrations/notification-migrations')>> settings.gradle
goto :eof

:create_java_lib
if not exist "%1" mkdir "%1" 2>nul
if not exist "%1\src\main\java" mkdir "%1\src\main\java" 2>nul
if not exist "%1\src\main\resources" mkdir "%1\src\main\resources" 2>nul
if not exist "%1\src\test\java" mkdir "%1\src\test\java" 2>nul
if not exist "%1\src\test\resources" mkdir "%1\src\test\resources" 2>nul

echo dependencies { > "%1\build.gradle"
echo     implementation 'org.springframework:spring-context'>> "%1\build.gradle"
echo     implementation 'org.springframework:spring-core'>> "%1\build.gradle"
echo     implementation 'jakarta.validation:jakarta.validation-api'>> "%1\build.gradle"
echo     implementation 'org.slf4j:slf4j-api'>> "%1\build.gradle"
echo }>> "%1\build.gradle"
goto :eof

:create_spring_boot_app
if not exist "%1" mkdir "%1" 2>nul
if not exist "%1\src\main\java" mkdir "%1\src\main\java" 2>nul
if not exist "%1\src\main\resources" mkdir "%1\src\main\resources" 2>nul
if not exist "%1\src\test\java" mkdir "%1\src\test\java" 2>nul
if not exist "%1\src\test\resources" mkdir "%1\src\test\resources" 2>nul

echo plugins { > "%1\build.gradle"
echo     id 'org.springframework.boot'>> "%1\build.gradle"
echo     id 'io.spring.dependency-management'>> "%1\build.gradle"
echo }>> "%1\build.gradle"
echo.>> "%1\build.gradle"
echo dependencies {>> "%1\build.gradle"
echo     implementation 'org.springframework.boot:spring-boot-starter-web'>> "%1\build.gradle"
echo     implementation 'org.springframework.boot:spring-boot-starter-data-jpa'>> "%1\build.gradle"
echo     implementation 'org.springframework.boot:spring-boot-starter-validation'>> "%1\build.gradle"
echo     implementation 'org.springframework.boot:spring-boot-starter-actuator'>> "%1\build.gradle"
echo     implementation 'org.springframework.boot:spring-boot-starter-security'>> "%1\build.gradle"
echo     implementation 'com.fasterxml.jackson.core:jackson-databind'>> "%1\build.gradle"
echo     runtimeOnly 'com.h2database:h2'>> "%1\build.gradle"
echo     runtimeOnly 'org.postgresql:postgresql'>> "%1\build.gradle"
echo }>> "%1\build.gradle"

:: Create main application class
set APP_DIR=%1\src\main\java\%PACKAGE_PATH%
if not exist "%APP_DIR%" mkdir "%APP_DIR%" 2>nul
for %%f in ("%1") do set MODULE_NAME=%%~nxf
call :create_main_class "%APP_DIR%" "%MODULE_NAME%"

:: Create application.yml
echo server: > "%1\src\main\resources\application.yml"
echo   port: 8081>> "%1\src\main\resources\application.yml"
echo.>> "%1\src\main\resources\application.yml"
echo spring:>> "%1\src\main\resources\application.yml"
echo   application:>> "%1\src\main\resources\application.yml"
echo     name: %MODULE_NAME%>> "%1\src\main\resources\application.yml"
echo   datasource:>> "%1\src\main\resources\application.yml"
echo     url: jdbc:h2:mem:testdb>> "%1\src\main\resources\application.yml"
echo     driver-class-name: org.h2.Driver>> "%1\src\main\resources\application.yml"
echo   jpa:>> "%1\src\main\resources\application.yml"
echo     hibernate:>> "%1\src\main\resources\application.yml"
echo       ddl-auto: update>> "%1\src\main\resources\application.yml"
echo     show-sql: true>> "%1\src\main\resources\application.yml"
goto :eof

:create_main_class
set JAVA_FILE=%1\Application.java
echo package %PACKAGE_NAME%; > "%JAVA_FILE%"
echo.>> "%JAVA_FILE%"
echo import org.springframework.boot.SpringApplication;>> "%JAVA_FILE%"
echo import org.springframework.boot.autoconfigure.SpringBootApplication;>> "%JAVA_FILE%"
echo.>> "%JAVA_FILE%"
echo @SpringBootApplication>> "%JAVA_FILE%"
echo public class Application {>> "%JAVA_FILE%"
echo     public static void main(String[] args) {>> "%JAVA_FILE%"
echo         SpringApplication.run(Application.class, args);>> "%JAVA_FILE%"
echo     }>> "%JAVA_FILE%"
echo }>> "%JAVA_FILE%"
goto :eof

:create_package_structure
set "FULL_PATH=%~1"
if not exist "%FULL_PATH%" (
    mkdir "%FULL_PATH%" 2>nul
)
echo. > "%FULL_PATH%\.gitkeep"
goto :eof

:create_test_project
if not exist "%1" mkdir "%1" 2>nul
echo. > "%1\.gitkeep"
goto :eof

:setup_project_dependencies
echo Setting up project dependencies...

:: SharedKernel layer dependencies
echo dependencies {>> "%SHARED_DIR%\shared-kernel-domain\build.gradle"
echo     implementation project(':shared:seedwork')>> "%SHARED_DIR%\shared-kernel-domain\build.gradle"
echo }>> "%SHARED_DIR%\shared-kernel-domain\build.gradle"

echo dependencies {>> "%SHARED_DIR%\shared-kernel-application\build.gradle"
echo     implementation project(':shared:shared-kernel-domain')>> "%SHARED_DIR%\shared-kernel-application\build.gradle"
echo }>> "%SHARED_DIR%\shared-kernel-application\build.gradle"

echo dependencies {>> "%SHARED_DIR%\shared-kernel-infrastructure\build.gradle"
echo     implementation project(':shared:shared-kernel-application')>> "%SHARED_DIR%\shared-kernel-infrastructure\build.gradle"
echo }>> "%SHARED_DIR%\shared-kernel-infrastructure\build.gradle"

:: Credential bounded context references
echo dependencies {>> "%SRC_DIR%\credential\credential-api\build.gradle"
echo     implementation project(':src:credential:credential-infrastructure')>> "%SRC_DIR%\credential\credential-api\build.gradle"
echo }>> "%SRC_DIR%\credential\credential-api\build.gradle"

echo dependencies {>> "%SRC_DIR%\credential\credential-application\build.gradle"
echo     implementation project(':src:credential:credential-domain')>> "%SRC_DIR%\credential\credential-application\build.gradle"
echo     implementation project(':shared:shared-kernel-application')>> "%SRC_DIR%\credential\credential-application\build.gradle"
echo     implementation project(':shared:event-bus')>> "%SRC_DIR%\credential\credential-application\build.gradle"
echo }>> "%SRC_DIR%\credential\credential-application\build.gradle"

echo dependencies {>> "%SRC_DIR%\credential\credential-domain\build.gradle"
echo     implementation project(':shared:shared-kernel-domain')>> "%SRC_DIR%\credential\credential-domain\build.gradle"
echo }>> "%SRC_DIR%\credential\credential-domain\build.gradle"

echo dependencies {>> "%SRC_DIR%\credential\credential-infrastructure\build.gradle"
echo     implementation project(':src:credential:credential-application')>> "%SRC_DIR%\credential\credential-infrastructure\build.gradle"
echo }>> "%SRC_DIR%\credential\credential-infrastructure\build.gradle"

:: Notification bounded context references
echo dependencies {>> "%SRC_DIR%\notification\notification-api\build.gradle"
echo     implementation project(':src:notification:notification-infrastructure')>> "%SRC_DIR%\notification\notification-api\build.gradle"
echo }>> "%SRC_DIR%\notification\notification-api\build.gradle"

echo dependencies {>> "%SRC_DIR%\notification\notification-application\build.gradle"
echo     implementation project(':src:notification:notification-domain')>> "%SRC_DIR%\notification\notification-application\build.gradle"
echo     implementation project(':shared:shared-kernel-application')>> "%SRC_DIR%\notification\notification-application\build.gradle"
echo     implementation project(':shared:event-bus')>> "%SRC_DIR%\notification\notification-application\build.gradle"
echo }>> "%SRC_DIR%\notification\notification-application\build.gradle"

echo dependencies {>> "%SRC_DIR%\notification\notification-domain\build.gradle"
echo     implementation project(':shared:shared-kernel-domain')>> "%SRC_DIR%\notification\notification-domain\build.gradle"
echo }>> "%SRC_DIR%\notification\notification-domain\build.gradle"

echo dependencies {>> "%SRC_DIR%\notification\notification-infrastructure\build.gradle"
echo     implementation project(':src:notification:notification-application')>> "%SRC_DIR%\notification\notification-infrastructure\build.gradle"
echo }>> "%SRC_DIR%\notification\notification-infrastructure\build.gradle"

:: Presentation references
echo dependencies {>> "%SRC_DIR%\presentation\presentation-web\build.gradle"
echo     implementation project(':shared:security-infrastructure')>> "%SRC_DIR%\presentation\presentation-web\build.gradle"
echo }>> "%SRC_DIR%\presentation\presentation-web\build.gradle"

:: Migration projects references
echo dependencies {>> "%MIGRATIONS_DIR%\credential-migrations\build.gradle"
echo     implementation project(':src:credential:credential-infrastructure')>> "%MIGRATIONS_DIR%\credential-migrations\build.gradle"
echo }>> "%MIGRATIONS_DIR%\credential-migrations\build.gradle"

echo dependencies {>> "%MIGRATIONS_DIR%\notification-migrations\build.gradle"
echo     implementation project(':src:notification:notification-infrastructure')>> "%MIGRATIONS_DIR%\notification-migrations\build.gradle"
echo }>> "%MIGRATIONS_DIR%\notification-migrations\build.gradle"

goto :eof

:create_gitignore
echo # Gradle > .gitignore
echo .gradle/>> .gitignore
echo build/>> .gitignore
echo gradle-app.setting>> .gitignore
echo !gradle-wrapper.jar>> .gitignore
echo !gradle-wrapper.properties>> .gitignore
echo.>> .gitignore
echo # IDE>> .gitignore
echo .idea/>> .gitignore
echo *.iml>> .gitignore
echo *.ipr>> .gitignore
echo *.iws>> .gitignore
echo .vscode/>> .gitignore
echo.>> .gitignore
echo # Eclipse>> .gitignore
echo .eclipse>> .gitignore
echo .metadata>> .gitignore
echo bin/>> .gitignore
echo tmp/>> .gitignore
echo *.tmp>> .gitignore
echo *.bak>> .gitignore
echo *.swp>> .gitignore
echo *~.nib>> .gitignore
echo local.properties>> .gitignore
echo .settings/>> .gitignore
echo .loadpath>> .gitignore
echo .recommenders>> .gitignore
echo .project>> .gitignore
echo .classpath>> .gitignore
echo.>> .gitignore
echo # Java>> .gitignore
echo *.class>> .gitignore
echo *.log>> .gitignore
echo *.ctxt>> .gitignore
echo .mtj.tmp/>> .gitignore
echo hs_err_pid*>> .gitignore
echo replay_pid*>> .gitignore
echo.>> .gitignore
echo # Spring Boot>> .gitignore
echo target/>> .gitignore
echo !.mvn/wrapper/maven-wrapper.jar>> .gitignore
echo !**/src/main/**/target/>> .gitignore
echo !**/src/test/**/target/>> .gitignore
echo.>> .gitignore
echo # OS>> .gitignore
echo .DS_Store>> .gitignore
echo .DS_Store?>> .gitignore
echo ._*>> .gitignore
echo .Spotlight-V100>> .gitignore
echo .Trashes>> .gitignore
echo ehthumbs.db>> .gitignore
echo Thumbs.db>> .gitignore
echo.>> .gitignore
echo # Application specific>> .gitignore
echo logs/>> .gitignore
echo application-local.yml>> .gitignore
echo application-local.properties>> .gitignore
echo /out/>> .gitignore
goto :eof