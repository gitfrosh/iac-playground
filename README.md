az login
az account show

- terraform fmt (formatieren)

- terraform init (Backend initialisieren)

- terraform validate (Validation of syntax etc.)

- terraform plan -out main.tfplan

- terraform plan (Prüfen, was bereit gestellt werden würde)

- mit terraform apply werden all Dateien (z. B. main.tf usw.) in dem Ordner berücksichtigt
- terraform apply (enthält auch das plan) bzw.
- terraform apply -auto-approve
- terraform apply main.tfplan