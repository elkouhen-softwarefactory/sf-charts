#!groovy

// pod utilisé pour la compilation du projet
podTemplate(label: 'chart-run-pod', containers: [

        // le slave jenkins
        containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave:alpine'),

        containerTemplate(name: 'helm', image: 'elkouhen/k8s-helm:2.9.1d', ttyEnabled: true, command: 'cat')],

        // montage nécessaire pour que le conteneur docker fonction (Docker In Docker)
        volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
) {

    node('chart-run-pod') {

        def charts = ['books-api', 'books-gui', 'h2', 'grav', 'jenkins-impl', 'nexus-impl', 'sonarqube-impl', 'keycloak-impl', 'elasticstack']

        properties([
                parameters([
                        choice(choices: charts, description: 'Chart à deployer', name: 'chart'),
                        string(defaultValue: '', description: 'Version du chart à deployer', name: 'version')
                ])
        ])

        stage('CHECKOUT') {
            checkout scm;
        }

        container('helm') {

            stage('HELM-RELEASE') {

                String command = "./release.sh -c ${params.chart} -v ${params.version}"

                sh "${command}"
            }
        }

        stage('RELEASE') {
            
            withCredentials([usernamePassword(credentialsId: 'elkouhen-github', usernameVariable: 'username', passwordVariable: 'password')]) {

                String command = "./commit.sh -c ${params.chart} -v ${params.version} -u ${username} -p ${password}"

                sh "${command}"

            }
        }
    }
}

Collection<String> charts() {

    def FILES_LIST = sh(script: "ls", returnStdout: true).trim()

    FILES_LIST
}