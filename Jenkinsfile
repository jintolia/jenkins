pipeline {
    agent {label 'node1'}
    stages {
        stage('Clone Git Repo') {
            steps {
                git credentialsId: 'b2922652-0478-4a1d-8072-7083a8ef79f8', url: 'git@github.com:ppavlov28/17.Project.git'
            }
        }
        stage('init environment') {
            steps {
                script{
                load "${env.WORKSPACE}/my-vars.groovy"
                }
            }
        }
        stage('checkout to backup') {
            when {
                equals expected: "restore", actual: "${params.START_JOB}"
            }
            steps {
                script {
                    if ( !params.BACKUP_TAG ) {
                        BT = sh (
                            script: "git tag --sort=taggerdate | tail -n1",
                            returnStdout: true
                    ).trim()
                    echo "BT = ${BT}"
                    } else {
                        BT = "${params.BACKUP_TAG}"
                        echo "BACKUP_TAG = ${params.BACKUP_TAG}"
                    }
                    sh "git checkout ${BT}"
                }
            }
        }
        stage('restore database') {
            when {
                equals expected: "restore", actual: "${params.START_JOB}"
            }
            steps {
                sh """
                docker exec -i mysql sh -c 'exec mysql wordpress -uwordpress -pwordpress' < wordpress.sql
                """
            }
        }
        stage('backup database') {
