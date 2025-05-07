#!/bin/bash

# Warna teks
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
WHITE='\e[37m'

# Style
BOLD='\e[1m'
UNDERLINE='\e[4m'
RESET='\e[0m'  # Mengembalikan ke normal

while true; do
    echo -e "${MAGENTA}=================================="
    echo -e "${BOLD}${CYAN}  Aplikasi Managemen Hutang Toko ${RESET} "
    echo -e "${MAGENTA}==================================${CYAN}"
    echo " 1. Daftar Pelanggan"
    echo " 2. Tambah Hutang"
    echo " 3. Bayar Hutang"
    echo -e " 4. Keluar${WHITE}"
    read -p "Pilih opsi [1-4]: " choice

    case $choice in
        1) display_consumer ;;
        2) add_debt ;;
        3) pay_debt ;;
        4)
            echo -e "${GREEN}Berhasil keluar dari aplikasi!"
            exit 0
            ;;
        *) echo -e "${RED}Opsi ${choice} tidak tersedia, silahkan pilih lagi." ;;
    esac
done
