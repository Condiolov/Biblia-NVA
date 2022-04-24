#!/usr/bin/env bash
###################################################################################
# Script : gerar_pdf.sh
# Versão : 1.0 (/home/thiago/Documentos/_imp/ROBONVA/3 - Gerando o PDF da biblia/gerar_pdf.sh)
# Autor  : Thiago Condé
# Data   : 2022-03-19 18:14:20
# Info   : 
###################################################################################
# Margem L R T B
link="localhost/_script/ROBONVA/3 - Gerando o PDF da Biblia NVA/biblianva/index.php"

#fonte grande com indice
 wkhtmltopdf -L 0 -R 0 -T 2 -B 2 --page-size A4 --dpi 600  "$link?teste=0&fonte=18&indices=ok"  'bibliaNVA  GND sem IND.pdf'

#fonte grande com indice
 wkhtmltopdf -L 0 -R 0 -T 2 -B 2 --page-size A4 --dpi 600  "$link?teste=0&fonte=18"  'bibliaNVA GND com IND.pdf'

#fonte pequena sem indice
 wkhtmltopdf -L 0 -R 0 -T 2 -B 2 --page-size A4 --dpi 600  "$link?teste=0&fonte=12"  'bibliaNVA PEQ sem IND.pdf'

#fonte pequena sem indice
 wkhtmltopdf -L 0 -R 0 -T 2 -B 2 --page-size A4 --dpi 600  "$link?teste=0&fonte=12&indices=ok"  'bibliaNVA PEQ com IND.pdf'


