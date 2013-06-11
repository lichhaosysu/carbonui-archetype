@echo off

rem ---------------------------------------------------------------------------
rem Generate Carbon UI Bundle Project Archetype
rem ---------------------------------------------------------------------------

:checkJava
if "%JAVA_HOME%" == "" goto noJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto noJavaHome
goto checkMaven

:noJavaHome
echo "You must correctly set the JAVA_HOME variable before running this script!"
goto end

:checkMaven
call mvn -version 2>&1 > NUL
if ERRORLEVEL 0 goto getProjectName
goto noM2Home

:noM2Home
echo "You must correctly set the M2_HOME variable before running this script!"
goto end

:getProjectName
SET /p projectname=Please input the name of your Carbon UI Bundle Project: 
echo projectname is %projectname%
if "%projectname%" == "" (
echo Empty project name!
goto getProjectName
)

:generateProject
call mvn clean install
::call mvn archetype:crawl
set pathoficon=%cd%\src\main\resources\archetype-resources\src\main\resources\web\folder_to_rename\images\comp-manager.gif
cd target && mkdir project && cd project
call mvn archetype:generate -B -DarchetypeGroupId=com.lichhao -DarchetypeArtifactId=carbonui-archetype -DarchetypeVersion=1.0.0 -DgroupId=com.gcidesign.paas -DartifactId=%projectname% -Dversion=1.0.0 -Dpackage=com.gcidesign.paas
cd .\%projectname%\src\main\resources\web && rename folder_to_rename "%projectname%"
cd ..\..\..\..\ && call mvn eclipse:eclipse
::cd %cd%\src\main\resources\web\%projectname%\images
::del comp-manager.gif
copy "%pathoficon%" "%cd%\src\main\resources\web\%projectname%\images\comp-manager.gif" >NUL
echo Project successfully create! You can find it under %cd% directory

:end
pause