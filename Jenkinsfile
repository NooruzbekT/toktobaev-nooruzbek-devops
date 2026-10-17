// CI/CD pipeline for the DevOps student application
// Student: Nooruzbek Toktobaev, Group "IT-2 2313", ID 38422
pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Nooruzbek'
        STUDENT_SURNAME = 'Toktobaev'
        STUDENT_GROUP   = 'IT-2 2313'
        STUDENT_ID      = '38422'
        IMAGE_NAME      = 'toktobaev-nooruzbek-devops'
        CONTAINER_NAME  = 'toktobaev-nooruzbek-container'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'git log -1 --oneline'
                echo "Student: ${env.STUDENT_NAME} ${env.STUDENT_SURNAME}"
                echo "Group: ${env.STUDENT_GROUP}"
                echo "Student ID: ${env.STUDENT_ID}"
            }
        }

        stage('Build') {
            steps {
                sh '''
                    echo "Checking project structure..."
                    for d in app scripts config tests; do
                        test -d "$d" || { echo "Missing directory: $d"; exit 1; }
                    done
                    for f in Toktobaev_Nooruzbek_info.txt Dockerfile app/app.py scripts/Toktobaev_Nooruzbek_system.sh; do
                        test -f "$f" || { echo "Missing file: $f"; exit 1; }
                    done
                    bash -n scripts/Toktobaev_Nooruzbek_system.sh
                    chmod +x scripts/Toktobaev_Nooruzbek_system.sh
                    python3 -m py_compile app/app.py
                    echo "Build checks passed"
                '''
            }
        }

        stage('Test') {
            steps {
                sh 'python3 -m unittest discover -s tests -v'
                sh './scripts/Toktobaev_Nooruzbek_system.sh'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t "${IMAGE_NAME}:${BUILD_NUMBER}" -t "${IMAGE_NAME}:latest" .'
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker rm -f "$CONTAINER_NAME" || true
                    docker run --name "$CONTAINER_NAME" \
                        -e RUN_ONCE=true \
                        -e STUDENT_NAME="$STUDENT_NAME" \
                        -e STUDENT_SURNAME="$STUDENT_SURNAME" \
                        -e STUDENT_GROUP="$STUDENT_GROUP" \
                        -e STUDENT_ID="$STUDENT_ID" \
                        "${IMAGE_NAME}:latest"
                    echo "----- docker logs $CONTAINER_NAME -----"
                    docker logs "$CONTAINER_NAME"
                    echo "----- docker images -----"
                    docker images | grep "$IMAGE_NAME"
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline finished successfully for ${env.STUDENT_NAME} ${env.STUDENT_SURNAME} (${env.STUDENT_ID})"
        }
        failure {
            echo "Pipeline FAILED for ${env.STUDENT_NAME} ${env.STUDENT_SURNAME}. Check the Console Output of the failed stage."
        }
    }
}
