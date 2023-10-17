Here we deploy a simple python application that exposes a REST endpoint that returns the following
 JSON payload with the current timestamp and a static message:
{
  “message”: “Automate all the things!”,
  “timestamp”: 1529729125
}


## Prerequisites
3.  Active AWS account
1.  install Docker cli
2.  Install Terraform
4.  Install AWS Cli


### Install docker
Docker installation steps using default repository from Ubuntu
Update local packages by executing below command:
```sudo apt update```
``` sudo apt install docker.io -y ```

### Add Ubuntu user to Docker group
``` sudo usermod -aG docker $USER ```

### Install AWS CLi
    
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip 
    sudo ./aws/install 
    

### Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
 echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
 sudo apt update && sudo apt install terraform 
 
### Create AWS IAM User Access Key
Iam User > Security Credentials > Create Access Keys
    - Command Line Interface (CLI)

### Configure AWS
``` aws configure ```
    - Insert your Access Key ID
    - Insert Secret
    - Insert region name
    - Output format: json

### Check current AWS User
``` aws sts get-caller-identity```


### Run deployment script
chmod +x deploy.sh
./deploy.sh