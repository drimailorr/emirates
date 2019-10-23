podTemplate(label: "java-mvn",
             cloud: "openshift",
             inheritFrom: "maven",
             containers: [
     containerTemplate(name: "jnlp",
                       image: "openshift/jenkins-slave-maven-centos7:v3.9",
                       resourceRequestMemory: "256Mi",
                       resourceLimitMemory: "712Mi",
                       envVars: [
       envVar(key: "CONTAINER_HEAP_PERCENT", value: "0.25")
     ])
   ]) {
   try {
     timeout(time: 20, unit: 'MINUTES') {
       node("java-mvn") {

         // To save resources
         stage("Cleanup") {
           sh "oc scale dc/app --replicas=0"
         }

         stage("Checkout") {
           git url: "https://github.com/drimailorr/emirates.git", branch: "master"
         }

         stage("Build app artifact") {
           sh "./mvnw -Pprod clean verify"
           // stash name:"jar", includes:"target/*.jar"
         }

         stage("Build Image stream") {
           sh "oc start-build --wait --follow app-docker --from-file target/umsl-0.0.1-SNAPSHOT.jar"
         }

         stage("Scale up") {
           sh "oc scale dc/app --replicas=1"
         }
      }
    }
  } catch (err) {
   echo "Caught: ${err}"
   currentBuild.result = 'FAILURE'
   throw err
  }
}
