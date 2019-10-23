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
   node("java-mvn") {
     sh """
         git clone https://github.com/drimailorr/emirates.git .
         ./mvnw -Pprod clean verify
         oc start-build --wait --follow app-docker --from-file target/umsl-0.0.1-SNAPSHOT.jar
         openshift.withCluster() {
           openshift.withProject() {
             def dc = openshift.selector('dc', "app")
             dc.rollout().status()
           }
         }
     """
   }
}
