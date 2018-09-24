<#import "./shared_macros.ftl" as shared>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<#if isInstantApp>
apply plugin: 'com.android.feature'
<#else>
  <#if isLibraryProject>
apply plugin: 'com.android.library'
  <#else>
apply plugin: 'com.android.application'
  </#if>
</#if>
<@kt.addKotlinPlugins />

<@shared.androidConfig hasApplicationId=isApplicationProject applicationId=packageName isBaseFeature=isBaseFeature hasTests=true canHaveCpp=true/>

dependencies {
    ${getConfigurationName("compile")} fileTree(dir: 'libs', include: ['*.jar','*.aar'])
    <#if !improvedTestDeps>
    ${getConfigurationName("androidTestCompile")}('com.android.support.test.espresso:espresso-core:${espressoVersion!"+"}', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })
    </#if>
    implementation "com.android.support:support-annotations:$supportLibVersion"
    implementation "com.android.support:support-core-utils:$supportLibVersion"
    implementation "com.android.support:support-v4:$supportLibVersion"
    implementation "com.android.support:design:$supportLibVersion"
    implementation "com.android.support:cardview-v7:$supportLibVersion"
    implementation "com.android.support:recyclerview-v7:$supportLibVersion"
    implementation "com.android.support:gridlayout-v7:$supportLibVersion"
    implementation "com.android.support:support-v13:$supportLibVersion"
    implementation "com.android.support:support-vector-drawable:$supportLibVersion"
    implementation "com.android.support:support-core-ui:$supportLibVersion"
    implementation "com.android.support:support-compat:$supportLibVersion"
    implementation "com.android.support:support-core-utils:$supportLibVersion"

    implementation "com.android.support:palette-v7:$supportLibVersion"
    implementation "com.android.support:exifinterface:$supportLibVersion"

    <@kt.addKotlinDependencies />
<#if isInstantApp>
  <#if isBaseFeature>
    <#if monolithicModuleName?has_content>
    application project(':${monolithicModuleName}')
    <#else>
    // TODO: Add dependency to the main application.
    // application project(':app')
    </#if>
  <#else>
    implementation project(':${baseFeatureName}')
  </#if>
<#else>
  <@shared.watchProjectDependencies/>
</#if>
}
