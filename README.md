# cloud2
In diesem Projekt wird die Ausarbeitung der Aufgabe für "Cloud Computing II" festgehalten.  
Die Aufgabe bezieht sich auf die automatische Bereitstellung einer Infrastruktur auf AWS.

## Was wird verwendet?
- Hoster: Amazon AWS
- IaC-Tool: HasiCorp's Terraform

# HashiCorp's Terraform
## Infrastructure as Code (mit Terraform)
- Management von Infrastruktur mit Konfigurationsdateien statt GUI
- Erstellen, Ändern und Vewralten der Infrastruktur auf sichere, konsistente und wiederholbare Art und Weise
- Definittion von Ressourcen-Konfigurationen, die versioniert, wiederbenutzt und geteilt werden können
- Terraform
    - deklarative, human-readable Konfigurationsdateien
    - Verwaltung des Lifecycle der Infrastruktur
    - Vorteile:
        - Unterstützung mehrere Cloud Plattformen
        - schnelles Schreiben von Infrastructure-Code dank der Konfigurationssprache
        - Nachvollziehbarkeit von Änderungen der Ressourcen (durch Verwendung einer State-File)
        - Kollaboration durch die Zunahme einer Versionierungssoftware

# Terraform & Amazon AWS
## Prerequisites
- Terraform CLI
- AWS CLI

### Festlegen der IAM credentials
1. Öffnen der Datei `~/.aws/credentials`
2. Einfügen der Informationen aus dem [Academy Learner Lab](https://awsacademy.instructure.com/courses/62501/modules/items/5523579)
    - unter `AWS Details` --> `AWS CLI`

## wichtige Befehle
Initialisierung des Arbeitsverzeichnis:
```bash
terraform init
```
Erstellen / Ändern der Infrastruktur:
```bash
terraform apply
```  
> Terraform kann Änderungen *on the fly* übernehmen, indem man zuerst die Konfigurationsdatei entsprechend anpasst und dann `terraform apply` ein weiteres Mal ausführt.

Löschen einer Infrastruktur:
```bash
terraform destroy
```

Formatierung der *.tf-Dateien anpassen:
```bash
terraform fmt
```
semantische Validierung der Dateien:
```bash
terraform validate
```
Aktuellen Status abfragen:
```bash
terraform state
```

## Variablen in Terraform
```terraform
variable "<VARIABLE_NAME>" {
  description = "<DESCRIPTION>"
  type        = <TYPE>
  default     = "<DEFAULT_VALUE>"
}
```
Variablen können mit dem `-var`-Flag flexibel gesetzt werden:
```bash
terraform apply -var "<VAR_NAME>=<VALUE>"
```

## Output in Terraform
```terraform
output "<OUTPUT_NAME>" {
  description = "<DESCRIPTION>"
  value       = <OUTPUT_VALUE>
}
```
Outputs können mit dem `output`-Befehl abgefragt werden:
```bash
# Alle Outputs
terraform output
# Einen speziellen Output
terraform output <OUTPUT_NAME>
```

# Anwendung `./start.sh`
## bekannte Probleme
- Skript ist nur auf Ubuntu-Systeme zugeschnitten
- Skript lädt jedes mal aufs neue das GitHub-Repo runter
- Die Konfiguration der AWS-CLI funktioniert nur bedingt im Skript
  - Ich vermute das liegt an den Eigenarten des AWS Lab-Credentials
- Beim Abbruch des Skripts werden die Instanzen nicht zurückgesetzt und laufen weiter

# Output - erster Start
```text
[WARNING] ############################## WARNING #####################################
[WARNING] Please make sure that your aws_credentials are set correctly in /home/fabian/.aws/credentials!
[WARNING] Please make sure the file '/home/fabian/.ssh/id_rsa.pub' exists.
[WARNING] If not create it using the command 'ssh-keygen' 
[WARNING] ############################################################################
[INFO] Press ENTER to continue or CTRL+C to exit

[INFO] Remove old repository (to update the scripts)...
[sudo] password for fabian: 
rm: cannot remove 'cloud2': No such file or directory
[INFO] Get scripts to setup infrastructure from GitHub...
Cloning into 'cloud2'...
remote: Enumerating objects: 124, done.
remote: Counting objects: 100% (124/124), done.
remote: Compressing objects: 100% (91/91), done.
remote: Total 124 (delta 47), reused 77 (delta 20), pack-reused 0
Receiving objects: 100% (124/124), 19.70 KiB | 1.31 MiB/s, done.
Resolving deltas: 100% (47/47), done.
[INFO] Moving into the source folder of the repo...
[INFO] Checking if 'terraform' is installed...
[WARNING] Terraform is not installed!
[INFO] Installing Terraform...
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Get:2 http://packages.microsoft.com/repos/code stable InRelease [3.569 B]   
Hit:3 http://de.archive.ubuntu.com/ubuntu jammy InRelease                   
Get:4 http://de.archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]  
Get:5 http://de.archive.ubuntu.com/ubuntu jammy-backports InRelease [109 kB]
Get:6 http://packages.microsoft.com/repos/code stable/main armhf Packages [20,8 kB]
Get:7 http://packages.microsoft.com/repos/code stable/main amd64 Packages [20,5 kB]
Get:8 http://packages.microsoft.com/repos/code stable/main arm64 Packages [20,7 kB]
Get:9 http://security.ubuntu.com/ubuntu jammy-security/main amd64 DEP-11 Metadata [42,9 kB]
Get:10 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 DEP-11 Metadata [55,0 kB]
Get:11 http://de.archive.ubuntu.com/ubuntu jammy-updates/main i386 Packages [524 kB]
Get:12 http://de.archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [1.155 kB]
Get:13 http://de.archive.ubuntu.com/ubuntu jammy-updates/main Translation-en [246 kB]
Get:14 http://de.archive.ubuntu.com/ubuntu jammy-updates/main amd64 DEP-11 Metadata [101 kB]
Get:15 http://de.archive.ubuntu.com/ubuntu jammy-updates/universe i386 Packages [661 kB]
Get:16 http://de.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [995 kB]
Get:17 http://de.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 DEP-11 Metadata [304 kB]
Get:18 http://de.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 DEP-11 Metadata [940 B]
Get:19 http://de.archive.ubuntu.com/ubuntu jammy-backports/main amd64 DEP-11 Metadata [4.916 B]
Get:20 http://de.archive.ubuntu.com/ubuntu jammy-backports/universe amd64 DEP-11 Metadata [19,0 kB]
Fetched 4.513 kB in 3s (1.757 kB/s)                             
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
gnupg is already the newest version (2.2.27-3ubuntu2.1).
gnupg set to manually installed.
software-properties-common is already the newest version (0.99.22.7).
software-properties-common set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 2 not upgraded.
--2023-11-09 16:56:10--  https://apt.releases.hashicorp.com/gpg
Resolving apt.releases.hashicorp.com (apt.releases.hashicorp.com)... 18.64.79.111, 18.64.79.85, 18.64.79.48, ...
Connecting to apt.releases.hashicorp.com (apt.releases.hashicorp.com)|18.64.79.111|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3980 (3,9K) [binary/octet-stream]
Saving to: ‘STDOUT’

-                   100%[================>]   3,89K  --.-KB/s    in 0s      

2023-11-09 16:56:10 (53,7 MB/s) - written to stdout [3980/3980]

# Here is normally weird stuff, that I removed

gpg: directory '/home/fabian/.gnupg' created
gpg: /home/fabian/.gnupg/trustdb.gpg: trustdb created
/usr/share/keyrings/hashicorp-archive-keyring.gpg
-------------------------------------------------
pub   rsa4096 2023-01-10 [SC] [expires: 2028-01-09]
      798A EC65 4E5C 1542 8C8E  42EE AA16 FCBC A621 E701
uid           [ unknown] HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>
sub   rsa4096 2023-01-10 [S] [expires: 2028-01-09]

deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com jammy main

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  terraform
0 upgraded, 1 newly installed, 0 to remove and 2 not upgraded.
Need to get 25,6 MB of archives.
After this operation, 80,7 MB of additional disk space will be used.
Get:1 https://apt.releases.hashicorp.com jammy/main amd64 terraform amd64 1.6.3-1 [25,6 MB]
Fetched 25,6 MB in 2s (11,7 MB/s)     
Selecting previously unselected package terraform.
(Reading database ... 296176 files and directories currently installed.)
Preparing to unpack .../terraform_1.6.3-1_amd64.deb ...
Unpacking terraform (1.6.3-1) ...
Setting up terraform (1.6.3-1) ...
[INFO] Checking if 'aws' is installed...
[WARNING] AWS-CLI is not installed!
[INFO] Installing AWS-CLI...
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  docutils-common groff psutils python3-botocore python3-certifi
  python3-dateutil python3-docutils python3-idna python3-jmespath
  python3-pyasn1 python3-pygments python3-requests python3-roman
  python3-rsa python3-s3transfer python3-urllib3 sgml-base xml-core
Suggested packages:
  docutils-doc fonts-linuxlibertine | ttf-linux-libertine
  texlive-lang-french texlive-latex-base texlive-latex-recommended
  python-pygments-doc ttf-bitstream-vera python3-openssl python3-socks
  python-requests-doc sgml-base-doc debhelper
The following NEW packages will be installed:
  awscli docutils-common groff psutils python3-botocore python3-certifi
  python3-dateutil python3-docutils python3-idna python3-jmespath
  python3-pyasn1 python3-pygments python3-requests python3-roman
  python3-rsa python3-s3transfer python3-urllib3 sgml-base xml-core
0 upgraded, 19 newly installed, 0 to remove and 2 not upgraded.
Need to get 11,7 MB of archives.
After this operation, 95,9 MB of additional disk space will be used.
Get:1 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 sgml-base all 1.30 [12,5 kB]
Get:2 http://de.archive.ubuntu.com/ubuntu jammy/universe amd64 groff amd64 1.22.4-8build1 [4.104 kB]
Get:3 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-dateutil all 2.8.1-6 [78,4 kB]
Get:4 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-jmespath all 0.10.0-1 [21,7 kB]
Get:5 http://de.archive.ubuntu.com/ubuntu jammy-updates/main amd64 python3-urllib3 all 1.26.5-1~exp1ubuntu0.1 [98,2 kB]
Get:6 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-certifi all 2020.6.20-1 [150 kB]
Get:7 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-idna all 3.3-1 [49,3 kB]
Get:8 http://de.archive.ubuntu.com/ubuntu jammy-updates/main amd64 python3-requests all 2.25.1+dfsg-2ubuntu0.1 [48,8 kB]
Get:9 http://de.archive.ubuntu.com/ubuntu jammy/universe amd64 python3-botocore all 1.23.34+repack-1 [4.508 kB]
Get:10 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-pyasn1 all 0.4.8-1 [50,9 kB]
Get:11 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 xml-core all 0.18+nmu1 [21,6 kB]
Get:12 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 docutils-common all 0.17.1+dfsg-2 [117 kB]
Get:13 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-roman all 3.3-1 [10,6 kB]
Get:14 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-docutils all 0.17.1+dfsg-2 [387 kB]
Get:15 http://de.archive.ubuntu.com/ubuntu jammy/universe amd64 python3-rsa all 4.8-1 [28,4 kB]
Get:16 http://de.archive.ubuntu.com/ubuntu jammy/universe amd64 python3-s3transfer all 0.5.0-1 [51,5 kB]
Get:17 http://de.archive.ubuntu.com/ubuntu jammy/universe amd64 awscli all 1.22.34-1 [1.172 kB]
Get:18 http://de.archive.ubuntu.com/ubuntu jammy/universe amd64 psutils amd64 1.17.dfsg-4 [56,2 kB]
Get:19 http://de.archive.ubuntu.com/ubuntu jammy/main amd64 python3-pygments all 2.11.2+dfsg-2 [750 kB]
Fetched 11,7 MB in 1s (8.674 kB/s)         
Selecting previously unselected package sgml-base.
(Reading database ... 296177 files and directories currently installed.)
Preparing to unpack .../00-sgml-base_1.30_all.deb ...
Unpacking sgml-base (1.30) ...
Selecting previously unselected package groff.
Preparing to unpack .../01-groff_1.22.4-8build1_amd64.deb ...
Unpacking groff (1.22.4-8build1) ...
Selecting previously unselected package python3-dateutil.
Preparing to unpack .../02-python3-dateutil_2.8.1-6_all.deb ...
Unpacking python3-dateutil (2.8.1-6) ...
Selecting previously unselected package python3-jmespath.
Preparing to unpack .../03-python3-jmespath_0.10.0-1_all.deb ...
Unpacking python3-jmespath (0.10.0-1) ...
Selecting previously unselected package python3-urllib3.
Preparing to unpack .../04-python3-urllib3_1.26.5-1~exp1ubuntu0.1_all.deb ...
Unpacking python3-urllib3 (1.26.5-1~exp1ubuntu0.1) ...
Selecting previously unselected package python3-certifi.
Preparing to unpack .../05-python3-certifi_2020.6.20-1_all.deb ...
Unpacking python3-certifi (2020.6.20-1) ...
Selecting previously unselected package python3-idna.
Preparing to unpack .../06-python3-idna_3.3-1_all.deb ...
Unpacking python3-idna (3.3-1) ...
Selecting previously unselected package python3-requests.
Preparing to unpack .../07-python3-requests_2.25.1+dfsg-2ubuntu0.1_all.deb ...
Unpacking python3-requests (2.25.1+dfsg-2ubuntu0.1) ...
Selecting previously unselected package python3-botocore.
Preparing to unpack .../08-python3-botocore_1.23.34+repack-1_all.deb ...
Unpacking python3-botocore (1.23.34+repack-1) ...
Selecting previously unselected package python3-pyasn1.
Preparing to unpack .../09-python3-pyasn1_0.4.8-1_all.deb ...
Unpacking python3-pyasn1 (0.4.8-1) ...
Selecting previously unselected package xml-core.
Preparing to unpack .../10-xml-core_0.18+nmu1_all.deb ...
Unpacking xml-core (0.18+nmu1) ...
Selecting previously unselected package docutils-common.
Preparing to unpack .../11-docutils-common_0.17.1+dfsg-2_all.deb ...
Unpacking docutils-common (0.17.1+dfsg-2) ...
Selecting previously unselected package python3-roman.
Preparing to unpack .../12-python3-roman_3.3-1_all.deb ...
Unpacking python3-roman (3.3-1) ...
Selecting previously unselected package python3-docutils.
Preparing to unpack .../13-python3-docutils_0.17.1+dfsg-2_all.deb ...
Unpacking python3-docutils (0.17.1+dfsg-2) ...
Selecting previously unselected package python3-rsa.
Preparing to unpack .../14-python3-rsa_4.8-1_all.deb ...
Unpacking python3-rsa (4.8-1) ...
Selecting previously unselected package python3-s3transfer.
Preparing to unpack .../15-python3-s3transfer_0.5.0-1_all.deb ...
Unpacking python3-s3transfer (0.5.0-1) ...
Selecting previously unselected package awscli.
Preparing to unpack .../16-awscli_1.22.34-1_all.deb ...
Unpacking awscli (1.22.34-1) ...
Selecting previously unselected package psutils.
Preparing to unpack .../17-psutils_1.17.dfsg-4_amd64.deb ...
Unpacking psutils (1.17.dfsg-4) ...
Selecting previously unselected package python3-pygments.
Preparing to unpack .../18-python3-pygments_2.11.2+dfsg-2_all.deb ...
Unpacking python3-pygments (2.11.2+dfsg-2) ...
Setting up groff (1.22.4-8build1) ...
Setting up python3-roman (3.3-1) ...
Setting up python3-pygments (2.11.2+dfsg-2) ...
Setting up python3-certifi (2020.6.20-1) ...
Setting up python3-jmespath (0.10.0-1) ...
Setting up python3-idna (3.3-1) ...
Setting up python3-urllib3 (1.26.5-1~exp1ubuntu0.1) ...
Setting up python3-pyasn1 (0.4.8-1) ...
Setting up python3-dateutil (2.8.1-6) ...
Setting up sgml-base (1.30) ...
Setting up psutils (1.17.dfsg-4) ...
Setting up python3-requests (2.25.1+dfsg-2ubuntu0.1) ...
Setting up xml-core (0.18+nmu1) ...
Setting up python3-rsa (4.8-1) ...
Setting up python3-botocore (1.23.34+repack-1) ...
Setting up python3-s3transfer (0.5.0-1) ...
Processing triggers for install-info (6.8-4build1) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for shared-mime-info (2.1-2) ...
Processing triggers for sgml-base (1.30) ...
Setting up docutils-common (0.17.1+dfsg-2) ...
Processing triggers for sgml-base (1.30) ...
Setting up python3-docutils (0.17.1+dfsg-2) ...
Setting up awscli (1.22.34-1) ...
[INFO] Running initial configuration for AWS-CLI...
AWS Access Key ID [****************4W7A]: 
AWS Secret Access Key [****************F0tY]: 
Default region name [None]: 
Default output format [None]: 
[INFO] Applying terraform config...
[WARNING] This leads to an error, you don't have to worry about it!
╷
│ Error: Inconsistent dependency lock file
│ 
│ The following dependency selections recorded in the lock file are
│ inconsistent with the current configuration:
│   - provider registry.terraform.io/hashicorp/aws: required by this configuration but no version is selected
│ 
│ To make the initial dependency selections that will initialize the
│ dependency lock file, run:
│   terraform init
╵
[WARNING] Terraform not initialized!
[INFO] Initializing Terraform...
[INFO] Retrying to apply terraform config...

Please enter the path to the file you want to run (e.g. /path/to/script.sh):                                                                                                                 
/home/fabian/Downloads/test.sh                                                                                                                                                               
                                                                                                                                                                                             
[INFO] Uploading user script...                                                                                                                                                              
test.sh                                                                                                                                                    100%   75     0.6KB/s   00:00     
[INFO] Running user script...                                                                                                                                                                
[INFO] Destroying created instances...                                                                                                                                                       
                                                                                                                                                                                             
OUTPUT OF THE SCRIPT:                                                                                                                                                                        
I will now calculate 2+2! The result is 4 
```
# Output - nach dem ersten Starten
```text
[WARNING] ############################## WARNING #####################################
[WARNING] Please make sure that your aws_credentials are set correctly in /home/fabian/.aws/credentials!
[WARNING] Please make sure the file '/home/fabian/.ssh/id_rsa.pub' exists.
[WARNING] If not create it using the command 'ssh-keygen' 
[WARNING] ############################################################################
[INFO] Press ENTER to continue or CTRL+C to exit

[INFO] Remove old repository (to update the scripts)...
[INFO] Get scripts to setup infrastructure from GitHub...
Cloning into 'cloud2'...
remote: Enumerating objects: 117, done.
remote: Counting objects: 100% (117/117), done.
remote: Compressing objects: 100% (84/84), done.
remote: Total 117 (delta 43), reused 78 (delta 20), pack-reused 0
Receiving objects: 100% (117/117), 17.37 KiB | 8.68 MiB/s, done.
Resolving deltas: 100% (43/43), done.
[INFO] Moving into the source folder of the repo...
[INFO] Checking if 'terraform' is installed...
[INFO] Checking if 'aws' is installed...
[INFO] Applying terraform config...
[WARNING] This leads to an error, you don't have to worry about it!
╷
│ Error: Inconsistent dependency lock file
│ 
│ The following dependency selections recorded in the lock file are inconsistent with the current configuration:
│   - provider registry.terraform.io/hashicorp/aws: required by this configuration but no version is selected
│ 
│ To make the initial dependency selections that will initialize the dependency lock file, run:
│   terraform init
╵
[WARNING] Terraform not initialized!
[INFO] Initializing Terraform...
[INFO] Retrying to apply terraform config...

Please enter the path to the file you want to run (e.g. /path/to/script.sh):
/home/fabian/test.sh                                        

[INFO] Uploading user script...
test.sh                                                                                                                                                    100%   63     0.5KB/s   00:00    
[INFO] Running user script...
[INFO] Destroying created instances...

OUTPUT OF THE SCRIPT:
Das Ergebnis der Berechnug 2+2 = 4
```
