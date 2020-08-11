pipeline {
  environment {
    registry = "akanshagiriya/shopping-cart"
    registryCredential = 'docker_hub_akanshagiriya'
    dockerImage = ''
  }
  agent any
  stages{
    stage ('Build') {
      steps{
        echo "Building Project"
        nodejs('nodejs') {
         sh 'npm install'
         sh 'npm run build'
        }
      }
    }
    stage ('Build Docker Image') {
      steps{
        echo "Building Docker Image"
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage ('Push Docker Image') {
      steps{
        echo "Pushing Docker Image"
        script {
          docker.withRegistry( '', registryCredential ) {
              dockerImage.push()
              dockerImage.push('latest')
          }
        }
      }
    }
    stage ('Deploy to Dev') {
      steps{
        echo "Deploying to Dev Environment"
        sh "docker rm -f shopping-cart || true"
        sh "docker run -d --name=shopping-cart -p 4201:4200 akanshagiriya/shopping-cart"
      }
    }
  }
}
