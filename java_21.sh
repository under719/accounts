export JAVA_HOME=/usr/local/java21
export PATH=${JAVA_HOME}/bin:${PATH}


chmod +x ./gradlew
./gradlew clean build
