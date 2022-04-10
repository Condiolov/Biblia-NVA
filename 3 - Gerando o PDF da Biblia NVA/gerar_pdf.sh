#!/usr/bin/env bash
###################################################################################
# Script : gerar_pdf.sh
# Versão : 1.0 (/home/thiago/Documentos/_imp/ROBONVA/3 - Gerando o PDF da biblia/gerar_pdf.sh)
# Autor  : Thiago Condé
# Data   : 2022-03-19 18:14:20
# Info   : 
###################################################################################
# Margem L R T B
wkhtmltopdf -L 0 -R 0 -T 2 -B 2 --page-size A4 --dpi 600  'localhost/biblianva/'  'bibliaNVA.pdf'
# pdfunite    'capa.pdf' 'bibliaNVA sem capa.pdf' 'bibliaNVA.pdf'

