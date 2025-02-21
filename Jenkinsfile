pipeline {
    agent any
    environment {
        REGISTRY = "k8s-vga-worker1:5000"
        IMAGE_NAME = "demo-img-team5-account"
        IMAGE_TAG = "latest"
        NAMESPACE = "under76-test"
        JAVA_HOME = "/usr/local/java21"
        PATH="${JAVA_HOME}/bin:${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                sh 'java -version'
                sh 'mvn -version'
                // Git 저장소에서 소스 코드 체크아웃 (branch 지정 master 또는 main)
                git branch: 'main', url: 'https://github.com/under719/accounts.git'
            }
        }
        stage('Build with Maven') {
            steps {
                script {
                    //sh 'chmod +x ./java_21.sh'
                    //sh './java_21.sh'
                    // Gradle 실행권한
                    // sh 'chmod +x ./gradlew'
                    // Gradle 빌드 실행
                    // sh './gradlew clean build'
                    // Maven 빌드 실행
                    sh 'mvn clean package -DskipTests'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Docker 이미지를 Registry Server에 푸시
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Deploy and Service to Kubernetes') {
            steps {
                script {
                    // Kubernetes Deployment and Service 적용 (demo-app.yaml)
                    sh "kubectl apply -f ./yarm/demo-accounts.yaml -n ${NAMESPACE}"
                }
            }
        }
        stage('Deployment Image to Update') {
            steps {
                script {
                    // Kubenetes에서 특정 Deployment의 컨테이너 이미지를 업데이트
                    sh "kubectl set image deployment/demo-app-team5-account-deployment demo-app-team5-account=${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} --namespace=${NAMESPACE}"
                }
            }
        }
    }
}
