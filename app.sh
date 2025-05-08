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

# menggunakan asosiative array
declare -A costumers_data

# Fungsi menampilkan pelanggan
display_costumers(){
    # Cek apakah ada pelanggan
    if [ ${#costumers_data[@]} -gt 0 ]; then
        counter=1
        echo -e "${BOLD}${YELLOW}=== Daftar Hutang ===${RESET} "
        for name in "${!costumers_data[@]}"; do
            echo "${counter}. $name: Rp ${costumers_data[$name]}"
            (( counter++ ))
        done
        echo ""
    # Jika belum ada pelanggan
    else
        echo -e "${RED}Belum ada pelanggan yang ditambahkan."
    fi
}

# Fungsi menambahkan pelanggan
add_costumers(){
    read -p "Nama pelanggan: " name
    read -p "Hutang: " debt
    maksDebt=1000000

    # Cek jumlah input hutang maksimal 1 juta
    if [[ $debt -le $maksDebt ]]; then
        # Cek apakah nama pelanggan sudah ada
        if [[ -v costumers_data["$name"] ]]; then
            # Cek apakah hutang sudah mencapai maksimal
            if [[ $((${costumers_data["$name"]} + debt)) -le $maksDebt ]]; then
                costumers_data["$name"]=$((costumers_data["$name"] + debt))
                echo -e "${GREEN}Hutang $name ditambahkan sebesar Rp.$debt, total: Rp.${costumers_data[$name]}${RESET}"
            else
                echo -e "${RED}Hutang ${name} sudah di batas maksimum${RESET}"
            fi
        else
            # Jika belum ada, tambahkan pelanggan baru dan jumlah hutangnya
            costumers_data["$name"]="$debt"
            echo -e "${GREEN}Hutang $name ditambahkan sebesar Rp.$debt"
        fi
    else
        echo -e "${RED}Maksimal hutang adalah Rp.1000000(1 Juta rupiah)"
    fi
}

# Fungsi pembayaran hutang
pay_debt(){
    read -p "Masukkan nama pelanggan: " name

    # Cek apakah nama pelanggan ada di daftar
    if [[ -v costumers_data["$name"] ]]; then
        echo -e "=>Total hutang ${name} sebesar ${YELLOW}Rp.${costumers_data[$name]}${WHITE}"
        read -p "Masukkan nominal yang ingin dibayar: " payDebt
        echo -e "${YELLOW}Pastikan uang yang di terima sudah sesuai yang diinput, tekan ENTER jika sudah yakin!" 
        read

        # Cek apakah nominal yang akan di bayar >= Rp.1000
        if [[ $payDebt -gt 999 ]]; then
            # Jumlah hutang yang tersimpan di kurangi jumlah yang dibayar
            costumers_data["$name"]=$((costumers_data["$name"] - payDebt))

            echo -e "${GREEN}Hutang ${name} berhasil dibayar sebesar Rp.${payDebt}, sisa Rp.${costumers_data[$name]}${WHITE}"
        else
            echo -e "${RED}Pembayaran terlalu sedikit, minimal Rp.1000"
        fi
    else
        echo "${name} belum punya hutang"
    fi
}

# Program utama
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
