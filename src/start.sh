#!/bin/bash

############### CONSTANTS ###############
TERRAFORM_CONF_DIR="$(pwd)/cloud2/src/terraform"
USERNAME="admin"
TERRAFORM_REPO="https://github.com/fbnfrhm/cloud2.git"
OUTPUT=""

############ EXTRA FUNCTIONS ############
logInfo() {
    echo "[INFO] $1"
}

logWarn() {
    echo "[WARNING] $1"
}

getRepo() {
    logInfo "Remove old repository (to update the scripts)..."
    sudo rm -rd cloud2
    logInfo "Get scripts to setup infrastructure from GitHub..."
    git clone $TERRAFORM_REPO
    logInfo "Moving into the source folder of the repo..."
    cd cloud2/src
}

startMessage() {
    logWarn "############################## WARNING #####################################"
    logWarn "Please make sure that your aws_credentials are set correctly in $HOME/.aws/credentials!"
    logWarn "Please make sure the file '$HOME/.ssh/id_rsa.pub' exists."
    logWarn "If not create it using the command 'ssh-keygen' "
    logWarn "############################################################################"
    logInfo "Press ENTER to continue or CTRL+C to exit"
    read
}

checkDependencies() {
    logInfo "Checking if 'terraform' is installed..."
    which terraform > /dev/null
    if [ $? != 0 ]; then
        logWarn "Terraform is not installed!"
        logInfo "Installing Terraform..."
        sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
        wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
        gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update > /dev/null
        sudo apt-get install -y terraform
    fi
    logInfo "Checking if 'aws' is installed..."
    which aws > /dev/null
    if [ $? != 0 ]; then
        logWarn "AWS-CLI is not installed!"
        logInfo "Installing AWS-CLI..."
        sudo apt install -y awscli
        logInfo "Running initial configuration for AWS-CLI..."
        aws configure
    fi

}

applyTerraform() {
    logInfo "Applying terraform config..."
    cd $TERRAFORM_CONF_DIR
    terraform apply -auto-approve 2>&1 >/dev/null
    if [ $? != 0 ]; then
        logWarn "Terraform not initialized!"
        logInfo "Initializing Terraform..."
        terraform init > /dev/null
        logInfo "Retrying to apply terraform config..."
        terraform apply -auto-approve 2>&1 >/dev/null
    fi
}

destroyTerraform() {
    logInfo "Destroying created instances..."
    cd $TERRAFORM_CONF_DIR
    terraform destroy -auto-approve 2>&1 >/dev/null
}

getIpAddress() {
    cd $TERRAFORM_CONF_DIR
    ip="$(terraform output | grep "elastic_ip" | sed "s/elastic_ip =//g" | sed "s/\"//g")"
    echo $ip
}

runUserScript() {
    script_path=""
    echo ""
    echo "Please enter the path to the file you want to run (e.g. /path/to/script.sh):"
    # Get the path of the script to be run from user
    read script_path
    echo ""

    # Upload script to the created EC2 instance
    instance_ip="$(getIpAddress)"
    logInfo "Uploading user script..."
    scp -o StrictHostKeyChecking=no $script_path $USERNAME@$instance_ip:/home/$USERNAME/user.sh 2> /dev/null
    logInfo "Running user script..."
    OUTPUT="$(ssh -o StrictHostKeyChecking=no $USERNAME@$instance_ip 'sh user.sh')"
}
#########################################


################## MAIN ##################
startMessage
getRepo
checkDependencies
applyTerraform
runUserScript
destroyTerraform
echo ""
echo "OUTPUT OF THE SCRIPT:"
echo $OUTPUT
