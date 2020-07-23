node {
         stage ('Checkout SCM'){
                    git branch: 'master',url: 'https://github.com/Neha2602/Shopping_Cart.git'
         }
         
         stage('Install node modules'){
                      bat "npm install"
         }
         stage('Build'){
                     bat "npm run ng -- build --prod"
         }
         stage('Deploy'){
                      bat "pm2 restart all"
         }
     }
