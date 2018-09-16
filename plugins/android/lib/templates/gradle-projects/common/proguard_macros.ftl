<#macro proguardConfig>
<#if postprocessingSupported>
    buildTypes {
        release {
            postprocessing {
                removeUnusedCode false
                removeUnusedResources false
                obfuscate false
                optimizeCode false
                proguardFile 'proguard-rules.pro'
            }
        }
    }
<#else>
    buildTypes {
    debug {
            minifyEnabled false //proguard  Yes / No
            applicationIdSuffix '.debug'
            shrinkResources false
            debuggable true
            jniDebuggable true
            renderscriptDebuggable true
           proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
       }
       release {
           shrinkResources false
           minifyEnabled false //proguard  Yes / No
            zipAlignEnabled false
            debuggable false
            jniDebuggable false
            renderscriptDebuggable false
           proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
       }
    }
</#if>
</#macro>
