#!/usr/bin/env bash
###################################################################################
# Script : gerar_pdf.sh
# Versão : 1.0 (/home/thiago/Documentos/_imp/ROBONVA/3 - Gerando o PDF da biblia/gerar_pdf.sh)
# Autor  : Thiago Condé
# Data   : 2022-03-19 18:14:20
# Info   : 
###################################################################################

wkhtmltopdf 'localhost/biblianva/'  'bibliaNVA sem capa.pdf'
pdfunite    'capa.pdf' 'bibliaNVA sem capa.pdf' 'bibliaNVA.pdf'
