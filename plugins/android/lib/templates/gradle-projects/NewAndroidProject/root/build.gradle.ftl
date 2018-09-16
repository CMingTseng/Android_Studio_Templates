// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    <#if includeKotlinSupport!false>ext.kotlin_version = '${kotlinVersion}'</#if>
    repositories {
        ext {
            javasource = JavaVersion.VERSION_1_8
            javatarget = JavaVersion.VERSION_1_8
            kotlin_version = '1.2.70'
            compileVersion = 27
            targetVersion = 27
            minVersion = 21
            buildVersion = '28.0.2'
            supportLibVersion = '27.1.1'
            lifecycleLibVersion = '1.1.1'
            runnerVersion = '0.5'
            rulesVersion = '0.5'
            UiAutomatorLibVersion = '2.1.2'
            FirebaseLibVersion = '11.8.0'
            versionName = '0.0.0'
            protobufVersion = '3.6.1'
            grpcVersion = '1.14.0' // CURRENT_GRPC_VERSION
            nettyTcNativeVersion = '2.0.7.Final'
        }
        maven { url "https://maven.google.com" }
        google()
        jcenter()
        mavenCentral()
        maven { // The google mirror is less flaky than mavenCentral()
            url "https://maven-central.storage-download.googleapis.com/repos/central/data/"
        }
        jcenter()
        maven { url "https://plugins.gradle.org/m2/" }
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:${gradlePluginVersion}'
        <#if includeKotlinSupport!false>classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"</#if>

        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

allprojects {
    repositories {
        maven { url "https://maven.google.com" }
        google()
        jcenter()
        maven { // The google mirror is less flaky than mavenCentral()
            url "https://maven-central.storage-download.googleapis.com/repos/central/data/"
        }
        mavenLocal()
        mavenCentral()
        maven { url "https://jitpack.io" }
        maven { url 'http://oss.jfrog.org/artifactory/oss-snapshot-local' }
    }
}

def buildTime() {
    return new Date().format("yyyyMMdd", TimeZone.getTimeZone("UTC"))
}

ext {
    javasource = JavaVersion.VERSION_1_8
    javatarget = JavaVersion.VERSION_1_8
    kotlin_version = '1.2.61'
    compileVersion = 27
    targetVersion = 27
    minVersion = 21
    buildVersion = '28.0.2'
    supportLibVersion = '27.1.1'
    lifecycleLibVersion = '1.1.1'
    runnerVersion = '0.5'
    rulesVersion = '0.5'
    UiAutomatorLibVersion = '2.1.2'
    FirebaseLibVersion = '11.8.0'
    versionName = '0.0.0'
    protobufVersion = '3.6.1'
    grpcVersion = '1.14.0' // CURRENT_GRPC_VERSION
    nettyTcNativeVersion = '2.0.7.Final'
    appbuildTime = buildTime()
}

task clean(type: Delete) {
    delete rootProject.buildDir
}