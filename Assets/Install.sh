#!/bin/bash
# ======================================================
#  BackServerOS — Installer
# ======================================================

clear
echo "=========================================="
echo "  Menginstal BackServerOS..."
echo "=========================================="
echo ""

# Link file resmi kamu
URL_FILE="https://raw.githubusercontent.com/ftn-cyber/Backserveros/refs/heads/main/Applications/Backserveos.sh"

# Download file
echo "📥 Mengunduh Backserveos.sh..."
wget "$URL_FILE" -O Backserveos.sh

if [ ! -f "Backserveos.sh" ]; then
    echo "❌ Gagal mengunduh file!"
    exit 1
fi

# Beri izin jalankan
chmod +x Backserveos.sh

echo ""
echo "✅ Instalasi selesai!"
echo ""
echo "Cara menjalankan:"
echo "  bash Backserveos.sh"
echo ""
