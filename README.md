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