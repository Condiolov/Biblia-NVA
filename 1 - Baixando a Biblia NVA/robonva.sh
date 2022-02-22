#!/usr/bin/env bash
###################################################################################
# Script : robonva2.sh
# Versão : 1.0 (/home/thiago/Documentos/_imp/ROBONVA/robonva2.sh)
# Autor  : Thiago Condé
# Data   : date=2022-02-21 17:18:30
# Info   : Baixa livros completo da biblia NVA com revisões atualizadas
#
###################################################################################


IFS=$'\n' # split only on newlines ->  dividir apenas em novas linhas
set -f    # disable globbing -->  desativar globbing


pasta_livros="./biblia_NVA" # nome da pasta onde vai ficar os livros

listaDeURLs="./lista"   # lista dos links

mkdir -p $pasta_livros #criar directorio  (-p -> se nao existe)

contador=1

while IFS= read -r link; do

    # joga a url e pega a url redirecionada ja perara ela pra baixar os livros
    url_padrao=$(curl -Ls -o /dev/null -w %{url_effective} "$link" | sed 's/https:\/\/door43.org\/u\/alexandre_brazil\///' )

   # echo $url_padrao >> links_master.txt
    link_baixar=$(echo https://cdn.door43.org/u/alexandre_brazil/$url_padrao"print_all.html")


    # Salvo a pagina com o nome com o contador
    curl "$link_baixar" -o "$pasta_livros/$contador.html" #pega

    #pego o nome do livro entre o h1
    nome=$(tr '\n' ' ' < "$pasta_livros/$contador.html" | grep -oP '<h1>\K.*?(?=</h1>)' | tail -1)

    #echo $contador-$nome #>> nomes_errados.txt

    #Renomeio com o novo nome
    mv $pasta_livros/$contador.html $pasta_livros/$contador-$nome.html

    #contador acrescento um a cada rodada
    contador=`expr $contador + 1`

    done < $listaDeURLs

