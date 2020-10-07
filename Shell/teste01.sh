#!/usr/bin/env bash
#
# listaUsuarios.sh - Extrai usuários do /etc/passwd
#
# Site:       https://seusite.com.br
# Autor:      Fire-Head.
# Manutenção: Fire-Head.
#
# ------------------------------------------------------------------------ #
#  Irá extrair usuários do /etc/passwd, havendo a possibilidade de colocar
# em maiúsculo e em ordem alfabética.
#
# Exemplos:
#       $ ./listaUsuarios.sh -s -m
#       Neste exemplo ficará em ordem alfabética e em maiúsculo.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 07/10/2020, Fire-Head:
#     - Adiconei os parametros: -s, -h & -v.
#   v1.1 07/10/2020, Fire-Head:
#     - Troquei o IF pelo CASE.
#     - Adicionei o basename.
#   v1.2 07/10/2020, Fire-Head:
#     - Adicionei -m.
#     - Adicionei 2 flags.
#   v1.3 07/10/2020, Fire-Head:
#     - Adicionei while com shift e teste de variável.
#     - Adicionado 2 flags.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.18(1).
# ------------------------------------------------------------------------ #
# ------------------------------- VARIÁVEIS ------------------------------ #
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
  $(basename $0) - [OPÇÕES]

    -h - Menu de ajuda
    -v - Versão
    -s - Ordenar a saída
    -m - Coloca em maiúsculo
  "

VERSAO="v1.3"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0
# ------------------------------------------------------------------------ #
# ------------------------------- EXECUÇÃO ------------------------------- #
while test -n "$1"
do
  case "$1" in
    -h) echo "$MENSAGEM_USO"              && exit 0 ;;
    -v) echo "$VERSAO"                    && exit 0 ;;
    -s) CHAVE_ORDENA=1                              ;;
    -m) CHAVE_MAIUSCULO=1                           ;;
     *) echo "Opção inválida, veja o -h." && exit 1 ;;
  esac
  shift
done

[ $CHAVE_ORDENA -eq 1 ]    && USUARIOS=$(echo "$USUARIOS" | sort)
[ $CHAVE_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
# ------------------------------------------------------------------------ #
