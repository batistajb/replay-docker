## Configuração do AWS IAM e S3 Bucket

Este projeto inclui configurações do Terraform para configurar um bucket S3 da AWS e um usuário IAM com as permissões necessárias para acessar o bucket.  

### Configuração do Terraform
1. Configuração do Provedor:  
2. Especifica a região da AWS.

### Bucket S3:  
- Cria um bucket S3 chamado replay-bucket-production com tags para nome e ambiente. 

### Usuário IAM:
- Cria um usuário IAM chamado s3-user.

### Política IAM:  
- Define uma política chamada s3-user-policy que concede ao s3-user permissões para listar, obter e colocar objetos no bucket S3.

### Anexo de Política:
- Anexa a s3-user-policy ao s3-user. 

### Chave de Acesso:
- Cria uma chave de acesso para o s3-user.

### Saídas:  
Exibe o ID da chave de acesso e a chave de acesso secreta (marcada como sensível).

Para visualizar o valor sensível s3_user_secret_access_key, use os seguintes passos:  
- Execute o comando para exibir os valores em formato JSON:
    ```bash
    terraform output -json > output.json
    ```
  
