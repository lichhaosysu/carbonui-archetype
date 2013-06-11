#! /bin/sh
if [ -n "$JAVA_HOME"  ] ; then
	if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
	  # IBM's JDK on AIX uses strange locations for the executables
	  JAVACMD="$JAVA_HOME/jre/sh/java"
	else
	  JAVACMD="$JAVA_HOME/bin/java"
	fi
else
	JAVACMD=java
fi

if [ ! -x "$JAVACMD" ] ; then
  echo "Error: JAVA_HOME is not defined correctly."
  exit 1
fi

if [ -n "$M2_HOME"  ] ; then
	if [ -x "$M2_HOME/bin/mvn" ] ; then
	  # IBM's JDK on AIX uses strange locations for the executables
	  MAVENCMD="$M2_HOME/bin/mvn"
	fi
else
	MAVENCMD=mvn
fi

if [ ! -x "$MAVENCMD" ] ; then
  echo "Error: M2_HOME is not defined correctly."
  exit 1
fi
PROJECT_NAME=""
while [ "$PROJECT_NAME" = "" ]
do
  read -p "Please input the name of your Carbon UI Bundle Project: " PROJECT_NAME
  if [ "$PROJECT_NAME" = "" ] ; then
    echo "Empty project name!"
  fi
done
echo "projectname is $PROJECT_NAME"

$MAVENCMD clean install
pathoficon="`pwd`/src/main/resources/archetype-resources/src/main/resources/web/folder_to_rename/images/comp-manager.gif"
cd target && mkdir project && cd project
$MAVENCMD archetype:generate -B -DarchetypeGroupId=com.lichhao -DarchetypeArtifactId=carbonui-archetype -DarchetypeVersion=1.0.0 \
                      -DgroupId=com.gcidesign.paas -DartifactId=$PROJECT_NAME -Dversion=1.0.0 -Dpackage=com.gcidesign.paas
cd ./$PROJECT_NAME/src/main/resources/web && mv folder_to_rename $PROJECT_NAME
cd ../../../../ && $MAVENCMD eclipse:eclipse
mv -f $pathoficon "`pwd`/src/main/resources/web/$PROJECT_NAME/images/comp-manager.gif"
echo "Project successfully create! You can find it under `pwd` directory"
exit 0
