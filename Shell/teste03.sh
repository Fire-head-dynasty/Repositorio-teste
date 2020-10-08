#!/usr/bin/env bash
#
# teste03.sh - Extrai títulos do site lxer.com/
#
# Site:       https://seusite.com.br
# Autor:      Fire-Head.
# Manutenção: Fire-Head.
#
# ------------------------------------------------------------------------ #
#  Este programa irá extrair títulos do blog LXER, colocar em um arquivo de
# Texto e ler mostrando com cores na tela.
#
# Exemplos:
#      $ ./teste03.sh
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
lynx -source http://lxer.com/ | grep blurb | sed 's/<div.*line">//;s/<\/span.*//' > titulos.txt

while read -r titulo_lxer
do
  echo -e "${VERMELHO}Titulo: ${VERDE}$titulo_lxer"
done < "$ARQUIVO_DE_TITULOS"
# ------------------------------------------------------------------------ #
