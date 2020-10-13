#!/usr/bin/env bash
#
# sistema_de_usuarios.sh - Sistema para gerenciamento de usuários.
#
# Site:       https://seusite.com.br
# Autor:      FIre-Head.
# Manutenção: Fire-Head.
#
# ------------------------------------------------------------------------ #
#  Este programa faz todas as funções de gerenciamento de usuários, como:
# inserir, deletar e alterar.
#
# Exemplos:
#      $ source sistema_de_usuarios.sh
#      $ ListaUsuarios
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 13/10/2020, FIre-Head:
#       - Tratamento de erros com alteração ao arquivo do banco de dados.
#       - Lista usuários.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.18(1).
# ------------------------------------------------------------------------ #
# ------------------------------- VARIÁVEIS ------------------------------ #
ARQUIVO_BANCO_DE_DADOS="banco_de_dados.txt"
SEP=:
TEMP=temp.$$
VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
# ------------------------------------------------------------------------ #
# ------------------------------- TESTES --------------------------------- #
[ ! -e "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo não existe." && exit 1
[ ! -r "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo não tem permissão de leitura." && exit 1
[ ! -w "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo não tem permissão de escrita." && exit 1
# ------------------------------------------------------------------------ #
# ------------------------------- FUNÇÕES -------------------------------- #
MostraUsuarioNaTela () {
  local id="$(echo $1 | cut -d $SEP -f 1)"
  local nome="$(echo $1 | cut -d $SEP -f 2)"
  local email="$(echo $1 | cut -d $SEP -f 3)"

  echo -e "${VERDE}ID: ${VERMELHO}$id"
  echo -e "${VERDE}Nome: ${VERMELHO}$nome"
  echo -e "${VERDE}E-mail: ${VERMELHO}$email"
}

ListaUsuarios () {
  while read -r linha
  do
    [ "$(echo $linha | cut -c1)" = "#" ] && continue
    [ ! "$linha" ] && continue

    MostraUsuarioNaTela "$linha"
  done < "$ARQUIVO_BANCO_DE_DADOS"
}

ValidaExistenciaUsuario () {
  grep -i -q "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS"
}

InsereUsuario () {
  local nome="$(echo $1 | cut -d $SEP -f 2)"

  if ValidaExistenciaUsuario "$nome"
  then
    echo "ERRO. Usuário já exite!"
  else
    echo "$*" >> "$ARQUIVO_BANCO_DE_DADOS"
    echo "Usuário cadastrado com sucesso!"
  fi
  OrdenaLista
}

ApagaUsuario () {
  ValidaExistenciaUsuario "$1" || return

  grep -i -v "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

  echo "Usuário removido com sucesso!"
  OrdenaLista
}

OrdenaLista () {
  sort "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"
}

# ------------------------------------------------------------------------ #
# ------------------------------- EXECUÇÃO ------------------------------- #

# ------------------------------------------------------------------------ #
