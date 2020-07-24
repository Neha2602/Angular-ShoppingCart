node(){
    stage('Cloning Git') {
         git branch: 'master',url: 'https://github.com/Neha2602/Angular-ShoppingCart.git'
    }
        
    stage('Install dependencies') {
        nodejs('nodejs') {
            bat 'npm install'
            echo "Modules installed"
        }
        
    }
    stage('Build') {
        nodejs('nodejs') {
            bat 'npm run ng build --prod'
            echo "Build completed"
        }
        
    }

    stage('Package Build') {
        bat "tar -zcvf bundle.tar.gz dist/shopping-cart/"
    }

    stage('Artifacts Creation') {
        fingerprint 'bundle.tar.gz'
        archiveArtifacts 'bundle.tar.gz'
        echo "Artifacts created"
    }

    stage('Stash changes') {
        stash allowEmpty: true, includes: 'bundle.tar.gz', name: 'buildArtifacts'
    }

// stage('Approval') {
            // no agent, so executors are not used up when waiting for approvals
            // agent none
        //     steps {
        //         script {
        //             def deploymentDelay = input id: 'Deploy', message: 'Deploy to production?', submitter: 'rkivisto,admin', parameters: [choice(choices: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'], description: 'Hours to delay deployment?', name: 'deploymentDelay')]
        //             sleep time: deploymentDelay.toInteger(), unit: 'HOURS'
        //         }
        //     }
        // }
}
node('awsnode') {
    echo 'Unstash'
    unstash 'buildArtifacts'
    echo 'Artifacts copied'

    echo 'Copy'
    bat "yes | sudo cp -R bundle.tar.gz /var/www/html && cd /var/www/html && sudo tar -xvf bundle.tar.gz"
    echo 'Copy completed'
}
