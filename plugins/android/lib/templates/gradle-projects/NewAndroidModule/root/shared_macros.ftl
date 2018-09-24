<#import "root://gradle-projects/common/proguard_macros.ftl" as proguard>

<#-- Some common elements used in multiple files -->
<#macro watchProjectDependencies>
<#if WearprojectName?has_content && NumberOfEnabledFormFactors?has_content && NumberOfEnabledFormFactors gt 1 && Wearincluded>
    wearApp project(':${WearprojectName}')
    ${getConfigurationName("compile")} 'com.google.android.gms:play-services-wearable:+'
</#if>
</#macro>

<#macro generateManifest packageName hasApplicationBlock=false>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="${packageName}"<#if !hasApplicationBlock>/</#if>><#if hasApplicationBlock>
    <application <#if minApiLevel gte 4 && buildApi gte 4>android:allowBackup="true"</#if>
        android:label="@string/app_name"<#if copyIcons>
        android:icon="@mipmap/ic_launcher"<#if buildApi gte 25 && targetApi gte 25>
        android:roundIcon="@mipmap/ic_launcher_round"</#if><#elseif assetName??>
        android:icon="@drawable/${assetName}"</#if><#if buildApi gte 17>
        android:supportsRtl="true"</#if>
        android:theme="@style/AppTheme"/>
</manifest></#if>
</#macro>

<#macro androidConfig hasApplicationId=false applicationId='' hasTests=false canHaveCpp=false isBaseFeature=false canUseProguard=false>
android {
//    compileSdkVersion <#if buildApiString?matches("^\\d+$")>${buildApiString}<#else>'${buildApiString}'</#if>
//    buildToolsVersion "${buildToolsVersion}"
    compileSdkVersion compileVersion
    buildToolsVersion buildVersion
    lintOptions {
           abortOnError false
           //disable "ResourceType"
           //disable 'MissingTranslation'
           checkReleaseBuilds false
    }
    <#if isBaseFeature>
    baseFeature true
    </#if>

    defaultConfig {
    <#if hasApplicationId>
        applicationId "${applicationId}"
    </#if>
       // minSdkVersion <#if minApi?matches("^\\d+$")>${minApi}<#else>'${minApi}'</#if>
      //  targetSdkVersion <#if targetApiString?matches("^\\d+$")>${targetApiString}<#else>'${targetApiString}'</#if>
        minSdkVersion minVersion
        targetSdkVersion targetVersion
        versionCode 1
        versionName "1.0"

    <#if hasTests>
        testInstrumentationRunner "${getMaterialComponentName('android.support.test.runner.AndroidJUnitRunner', useAndroidX)}"
    </#if>

    <#if canHaveCpp && (includeCppSupport!false)>
        externalNativeBuild {
            cmake {
                cppFlags "${cppFlags}"
            }
        }
    </#if>
    }
compileOptions {
        sourceCompatibility javasource
        targetCompatibility javatarget
    }

    packagingOptions {
            exclude 'META-INF/INDEX.LIST'
            exclude 'META-INF/io.netty.versions.properties'
    	    exclude 'META-INF/ASL2.0'
            exclude 'META-INF/DEPENDENCIES'
            exclude 'META-INF/dependencies.txt'
            exclude 'META-INF/DEPENDENCIES.txt'
            exclude 'META-INF/LGPL2.1'
            exclude 'META-INF/LICENSE'
            exclude 'META-INF/license.txt'
            exclude 'META-INF/LICENSE.txt'
            exclude 'META-INF/NOTICE'
            exclude 'META-INF/notice.txt'
            exclude 'META-INF/NOTICE.txt'
    }

<#if canUseProguard>
<@proguard.proguardConfig />
</#if>

<#if canHaveCpp && (includeCppSupport!false)>
    externalNativeBuild {
        cmake {
            path "CMakeLists.txt"
        }
    }
</#if>
    sourceSets {
        main {
            manifest.srcFile 'src/main/AndroidManifest.xml'
            java.srcDirs = ['src/main/java', 'src/main/kotlin/']
            aidl.srcDirs = ['src/main/aidl']
            res.srcDirs = ['src/main/res']
            assets.srcDirs = ['src/main/assets']
        }

        test {
            java {
                srcDir 'src/main/java'
                srcDir 'src/test/kotlin/'
            }
        }
        androidTest {
            java {
                srcDir 'src/androidTest/java'
                srcDir 'src/androidTest/kotlin/'
            }
        }
    }
}
</#macro>
