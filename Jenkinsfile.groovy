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

        properties([
                parameters([
                        string(defaultValue: '', description: 'Chart à releaser', name: 'chart'),
                        choice(choices: "${charts().join('\n')}"),
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

            configFileProvider([configFile(fileId: 'jenkins-ssh-private-key', targetLocation: '/home/jenkins/.ssh/id_rsa'),
                                configFile(fileId: 'jenkins-ssh-public-key', targetLocation: '/home/jenkins/.ssh/id_rsa.pub')]) {

                withCredentials([usernamePassword(credentialsId: 'elkouhen-github', usernameVariable: 'username', passwordVariable: 'password')]) {

                    String command = "./commit.sh -c ${params.chart} -v ${params.version} -u ${username} -p ${password}"

                    sh "${command}"

                }

            }
        }
    }
}

Collection<String> charts() {

    def dirsl = []
    new File("${workspace}").eachDir() { dirs ->
        println dirs.getName()
        if (!dirs.getName().startsWith('.')) {
            dirsl.add(dirs.getName())
        }
    }

    dirsl
}