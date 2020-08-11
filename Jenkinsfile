pipeline {
  environment {
    registry = "neha2602/Angular-ShoppingCart"
    registryCredential = 'docker_hub_neha2602'
    dockerImage = ''
  }
  agent any
  stages{
    stage('Git Checkout'){
      steps{
        git 'https://github.com/Neha2602/Angular-ShoppingCart.git'
      }
    }
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
        sh "docker run -d --name=shopping-cart -p 4201:4200 neha2602/angular-shoppingcart"
      }
    }
  }
}
