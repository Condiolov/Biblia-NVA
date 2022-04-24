#!/usr/bin/env bash
###################################################################################
# Script : criando_sql_bibliaNVA.sh
# Versão : 1.0 (/home/thiago/Documentos/_imp/ROBONVA/2 - copilando a Biblia/criando_sql_bibliaNVA.sh)
# Autor  : Thiago Condé
# Data   : date=2022-02-23 17:29:11
# Info   : 22:44
# modificação: Acrescentei a geração de json e csv
###################################################################################

shopt -s extglob            # parametro que ajuda a remover espaços vazios nas frases
inicio=$(date +%s)          # para registrar quanto tempo gastei na execução do script
set -f                      # disable glob (wildcard) expansion ->  desabilitar a expansão glob (curinga)
IFS=$'\n'                   # let's make sure we split on newlinha chars ->  vamos ter certeza de dividir em caracteres de nova linha
pasta_livros="../1 - Baixando a Biblia NVA/biblia_NVA" # nome da pasta onde vai ficar os livros .html
usuario=usuario
senha=senha
banco_de_dados=meuBD
lista_livros=$(ls -tr $pasta_livros) #ls pra listar t-> lista por data de modificação r-> ordenar

#maior_verso=0 #registro q quantidade de caracteres do maior versiculo

[[ -f "bibliaNVA.sql" ]] && rm bibliaNVA.sql   # apago caso ja tenha a bibliaNVA em sql
[[ -f "bibliaNVA.json" ]] && rm bibliaNVA.json # apago caso ja tenha a bibliaNVA em sql
[[ -f "bibliaNVA.csv" ]] && rm bibliaNVA.csv # apago caso ja tenha a bibliaNVA em sql

echo "--> Criando o SQL e o JSON da Biblia!!"
echo "[" >>bibliaNVA.json #apenas para iniciar o json

for livro in $lista_livros; do

	verso_bruto=$(tr -d "\n" <"$pasta_livros/$livro" | grep -oP 'span class="v-num" id="([0-9]+)-ch-([0-9]+)-v-([0-9]+)">(.+?)</span>(.+?)<')
	#echo $verso_bruto > quebra
	#exit;
	for linha in $verso_bruto; do
		regex='span class="v-num" id="([0-9]+)-ch-([0-9]+)-v-([0-9]+)">(.+?)</span>(.+?)<'

		[[ $linha =~ $regex ]] # $pat must be unquoted

		n_livro="${BASH_REMATCH[1]##+(0)}"     # Removo os zeros a esquerda  ##+(0)
		n_capitulo="${BASH_REMATCH[2]##+(0)}"  # Removo os zeros a esquerda  ##+(0)
		n_versiculo="${BASH_REMATCH[3]##+(0)}" # Removo os zeros a esquerda  ##+(0)
		versiculo=${BASH_REMATCH[5]##+( )}     #Remove longest matching series of spaces from the front ->  Remova a série de espaços correspondentes mais longa da frente
		versiculo=${versiculo%%+( )}           #Remove longest matching series of spaces from the back

		echo "$n_livro|$n_capitulo|$n_versiculo|$versiculo" >>bibliaNVA.csv

		versiculo="${versiculo//\"/\\\"}"      # escapo as aspas duplas
		echo '{"l":'$n_livro',"c":'$n_capitulo',"n":'$n_versiculo',"v":'\"$versiculo\"'},' >>bibliaNVA.json

		versiculo="${versiculo//\'/\\\'}" # escapo as aspas simples
		#cria a query e insere se ja existe.
		echo 'INSERT INTO `bibliaNVA` (`id`, `n_livro`, `n_capitulo`, `n_versiculo`, `versiculo`) VALUES (NULL, '$n_livro', '$n_capitulo', '$n_versiculo', '\'$versiculo\'') ON DUPLICATE KEY UPDATE versiculo='\'$versiculo\'';' >>bibliaNVA.sql



		: 'FORMA DE COMENTAR NO SCRIPT SHELL (dois pontos, espaço, aspas simples)
          –eq (==), -ne (!=), -gt (>), -lt (<), -ge (>=), -le (<=)
		  '

		#Maneira de medir o tamanho do versiculo
		#[[ $maior_verso -lt ${#BASH_REMATCH[5]} ]] && a=${#BASH_REMATCH[5]} && versoo=${BASH_REMATCH[5]}
		#a=$(( "${#BASH_REMATCH[5]}" > $maior_verso ? ${#BASH_REMATCH[5]} : $maior_verso  ))

		#exit; # apenas um versiculo
	done
	#  exit; #apenas um livro
done
echo '{"geração":"CondTEC"}]' >>bibliaNVA.json #apenas para finalizar o json

tempogasto=$(($(date +%s) - $inicio))
final=$(echo "scale=2; $tempogasto / 60" | bc -l)
echo "--> Tempo gasto: $final min"

echo "--> Criando tabela" # mesmo que ela ja exista evita erro de ja existe "IF NOT EXISTS"
mysql -u $usuario -p$senha -D $banco_de_dados -e '
CREATE TABLE IF NOT EXISTS `bibliaNVA` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`n_livro` int(11) NOT NULL,
	`n_capitulo` int(11) NOT NULL,
	`n_versiculo` int(11) NOT NULL,
	`versiculo` varchar(1000) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `n_livro` (`n_livro`,`n_capitulo`,`n_versiculo`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	'

echo "--> Inserindo dados"
mysql -u $usuario -p$senha -D $banco_de_dados <bibliaNVA.sql

tempogasto=$(($(date +%s) - $inicio))
final=$(echo "scale=2; $tempogasto / 60" | bc -l)
echo "--> Tempo total: $final min"
