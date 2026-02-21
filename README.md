# terraform

GOAL:
To create a resource group "rg-demo-dev" with "South India" as the region through CI/CD & Terraform.

PROCESS:
1. Create a remote backend with rg 'rg-tf-backend' and concerned Blob container "sttfbackend1" within which the .tfstate file will be stored as "dev.terraform.tfstate".
2. Define a resource group "rg-demo-dev" as per the spec in the question.
3. Store the .tf config files inside a Repo by the name "Terraform".
4. Create a Service-principal "sp-azuredevops-terraform" using the below command:
az ad sp --create-for-rbac "sp-azuredevops-terraform" \
  --role Contributor \
  --scopes /subscriptions/0fd2670f-7eb9-4541-a1cc-b663a0b3eeb2

5. Save the output of this command which has tenant ID, password etc.
6. Next configure a "Service Connection" and populate the sections with the passwords & IDs saved from the previous step's output.
7. Save the pipeline YAML file into the same repo as .tf files.
8. If you have a hosted agent(VM on which pipeline jobs run), then go to 'Pipeline' section --> select the repo --> select .yaml file 
    ---> run pipeline.
9. This triggers the jobs and tasks/jobs mentioned in the pipeline yaml file start running.

10. In case of any issues during pipeline running, it might be possibly due to incorrect RBAC permissions of the SP towards the Blob storage account, or the 'Public access might be disabled' for the Blob storage account.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Creating a SP in azure:

Run 'az ad sp --create-for-rbac "sp-azuredevops-terraform"   --role Contributor   --scopes /subscriptions/0fd2670f-7eb9-4541-a1cc-b663a0b3eeb2'
