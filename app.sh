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

# menggunakan asosiative array saran dari gpt
declare -A costumers_data

# Fungsi menampilkan pelanggan
display_costumers(){
  if [ ${#costumers_data[@]} -gt 0 ]; then
        counter=1
        echo ""
        echo -e "${BOLD}${YELLOW}=== Daftar Hutang ===${RESET} "
        for name in "${!costumers_data[@]}"; do
            echo "${counter}. $name: Rp ${costumers_data[$name]}"
            (( counter++ ))
        done
        echo " "
        read -p "Tekan ENTER untuk kembali ke menu..."
    else
        echo -e "${RED}Belum ada pelanggan yang ditambahkan."
        echo " "
    fi
}

add_costumers(){
  read -p "Nama pelanggan: " name
  read -p "Hutang: " debt

  if [[ -v costumers_data["$name"] ]]; then
        # Update nilai hutang (penjumlahan dengan yang sudah ada)
        costumers_data["$name"]=$((costumers_data["$name"] + debt))
        echo -e "${GREEN}Hutang $name ditambahkan sebesar Rp.$debt, total: Rp.${costumers_data[$name]}"
        echo " "
  else
        # Jika belum ada, tambahkan pelanggan baru
        costumers_data["$name"]="$debt"
        echo -e "${GREEN}Hutang $name ditambahkan sebesar Rp.$debt"
        echo ""
  fi
  
}

#pay_debt(){}

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
        1) display_costumers ;;
        2) add_costumers ;;
        3) pay_debt ;;
        4)
            echo -e "${GREEN}Berhasil keluar dari aplikasi!"
            exit 0
            ;;
        *) echo -e "${RED}Opsi ${choice} tidak tersedia, silahkan pilih lagi." ;;
    esac
done
