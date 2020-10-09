#!/usr/bin/env bash
#
# rm_titulo.sh - Extrai títulos de blogs.
#
# Site:       https://seusite.com.br
# Autor:      Fire-Head.
# Manutenção: Fire-Head.
#
# ------------------------------------------------------------------------ #
#  Este programa irá extrair títulos de blogs, colocar em um arquivo de
# texto e ler mostrando com cores na tela.
#
# Exemplos:
#      $ ./rm_titulo.sh
#      Neste exemplo o programa vai extrair os títulos e mostrar na tela.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 08/10/2020, Fire-Head:
#       - Montei a expressão regular com fator em comum.
#   v1.1 08/10/2020, Fire-Head:
#       - Criei o primeiro código em cores.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.18(1).
# ------------------------------------------------------------------------ #
# ------------------------------- VARIÁVEIS ------------------------------ #
ARQUIVO_DE_TITULOS="titulos.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
# ------------------------------------------------------------------------ #
# ------------------------------- TESTES --------------------------------- #
[ ! -x "$(which lynx)" ] && sudo pacman -S lynx #lynx instalado?
# ------------------------------------------------------------------------ #
# ------------------------------- EXECUÇÃO ------------------------------- #
lynx -source https://www.bakadesuyo.com/ | grep h1.*a | sed 's/<h1.*\/">//;s/<\/a.*//' > titulos.txt

while read -r titulo_site
do
  echo -e "${VERMELHO}Titulo: ${VERDE}$titulo_site"
done < "$ARQUIVO_DE_TITULOS"
# ------------------------------------------------------------------------ #
