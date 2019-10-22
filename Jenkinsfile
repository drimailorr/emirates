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
         #./mvnw -Pprod clean verify
         #sleep 100
         oc start-build --wait --follow app-docker
     """
   }
}
