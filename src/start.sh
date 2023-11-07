#!/bin/bash

############### CONSTANTS ###############
TERRAFORM_CONF_DIR="$(pwd)/terraform"
USERNAME="admin"
OUTPUT=""

############ EXTRA FUNCTIONS ############
logInfo () {
    echo "[INFO] $1"
}

logWarn () {
    echo "[WARNING] $1"
}

checkTerraform() {
    logInfo "Checking if 'terraform' is installed..."
    which terraform > /dev/null
    if [ $? != 0 ]; then
        logWarn "Terraform is not installed!"
        logInfo "Installing Terraform..."
        sudo apt install terraform -y > /dev/null
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
checkTerraform
applyTerraform
runUserScript
destroyTerraform
echo ""
echo "OUTPUT OF THE SCRIPT:"
echo $OUTPUT
echo "Test"