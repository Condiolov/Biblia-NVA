#  Bíblia NVA
Usando script Shell conseguimos baixar a bíblia NVA completa, que esta sob a licença CC BY-SA 4.0 .A ideia desse vídeo é baixar e disponibilizar a bíblia em um site que iremos fazer juntos, e aprender mais sobre programação e um pouco de bíblia. É isso ai valeu!! Estes scripts tem a finalidade de baixar a bíblia NVA no [repositório](https://door43.org/)  em forma de html, depois converter HTML para SQL poderemos então gerar um site ou ate mesmo um PDF da bíblia NVA!! No canal diversalizando no youtube detalho todo os scripts;
Resumo dos processos:
```mermaid
graph LR
A((door43.org)) -- .sh --> B(TODOS LIVROS<br/>BIBLIA NVA em HTML<br/>)
B -- .sh --> D[SQL]
D-->E(SITE)
D-->F(PDF)
D-->H(etc ...)
```

# 1 - Baixando a Biblia NVA
Primeiro procedimento desse script é acessar o repositório da bíblia achar o livro desejado e imprimir, salvar o HTML. Simples assim!!

video 1: https://youtu.be/Tcn5QlcZraE


# 2 - Criando SQL da Biblia NVA
Com o HTML baixado numa pasta e podemos trabalhar ele como quisermos, então lemos livro por livro, e quebramos os versos usando uma regex, montamos as querys SQL e ja guardamos o arquivo SQL que esta nessa pasta!! Detalho todo esse script no video a baixo:

video 2: https://youtu.be/v4v1_vevRZQ

# 2 - Criando SQL da Biblia NVA
com o SQL no banco de dados converteremos para PDF, com pequenas edições de CSS ja temos uma Biblia NVA em PDF pronta para Download!! Conseguimos baixar a bíblia NVA completa!! Detalho todo esse script no video a baixo:

video 3: https://youtu.be/OFqlrfqCwRo

## Em breve

 - [x] 1 - Baixando a Biblia NVA
 - [x] 2 - Criando SQL da Biblia NVA
 - [x] 3 - PDF da Biblia NVA
 - [ ]  (Site, pdf, outros)


> **Note:** Inscreve no canal no youtube deixe seu like tem muita coisa legal por la!!

stackedit.io/app
