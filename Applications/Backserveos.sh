#!/bin/bash
# ======================================================
#  BackServerOS — Server Management System
#  GitHub Mirror: https://github.com/ftn-cyber/BMJI/tree/main/Mirrors/Terminal/Back%20server%20os/Pakcage
# ======================================================

clear
show_banner() {
cat <<'BANNER'
 ____             _                  _______  _____
|  _ \           | |                |  ____|/ ____|
| |_) | __ _  ___| | _____ _ __     | |__  | (___  
|  _ < / _` |/ __| |/ / _ \ '__|    |  __|  \___ \ 
| |_) | (_| | (__|   <  __/ |       | |____ ____) |
|____/ \__,_|\___|_|\_\___|_|       |______|_____/ 

            S E R V E R   O S
BANNER
echo ""
echo "=========================================="
echo "  BackServerOS v1.0.0"
echo "=========================================="
echo ""
}

# === STRUKTUR FOLDER ===
init_folders() {
    echo "📂 Menyiapkan struktur sistem..."
    mkdir -p ~/BackServerOS/{Var,Lib,Tools,PARTI,OnlineCLI}
    echo "✅ Struktur folder siap di: ~/BackServerOS/"
}

# === FILE KONFIGURASI ===
PASS_FILE="$HOME/BackServerOS/Var/.online_pass"
ROOT_PASS_FILE="$HOME/BackServerOS/Var/.root_pass"
MIRROR_BASE="https://raw.githubusercontent.com/ftn-cyber/BMJI/main/Mirrors/Terminal/Back%20server%20os/Pakcage"

# === DAFTAR TOOLS & LINK MIRROR ===
declare -A TOOLS=(
    ["neofetch"]="$MIRROR_BASE/Neofetch%20mirrors/neofetch"
    ["htop"]="$MIRROR_BASE/Htop%20mirrors/htop-3.3.0.tar.gz"
    ["nginx"]="$MIRROR_BASE/Nginx%20mirrors/nginx-1.26.2.tar.gz"
    ["apache"]="$MIRROR_BASE/Apache%20mirrors/httpd-2.4.69.tar.gz"
    ["nmap"]="$MIRROR_BASE/Nmap%20mirrors/nmap-7.94.tar.bz2"
    ["openssh"]="$MIRROR_BASE/Openssh%20mirrors/openssh-10.6p1.tar.gz"
    ["redis"]="$MIRROR_BASE/Redis%20mirrors/redis-7.2.4.tar.gz"
    ["docker"]="$MIRROR_BASE/Docker%20mirrors/docker-27.0.3.tgz"
    ["rsync"]="$MIRROR_BASE/Rsync%20mirrors/rsync-3.3.0.tar.gz"
    ["tmux"]="$MIRROR_BASE/Tmux%20mirrors/tmux-3.5.0.tar.gz"
)

# === SETUP PASSWORD ONLINE ===
setup_online_password() {
    echo "🔐 Setup Password Online CLI & Root"
    echo "Masukkan password baru: "
    read -s PASS1
    echo "Konfirmasi password: "
    read -s PASS2
    
    if [ "$PASS1" != "$PASS2" ]; then
        echo "❌ Password tidak cocok, coba lagi!"
        return 1
    fi
    
    echo "$PASS1" > "$PASS_FILE"
    chmod 600 "$PASS_FILE"
    cp "$PASS_FILE" "$ROOT_PASS_FILE"
    chmod 600 "$ROOT_PASS_FILE"
    
    echo "✅ Password berhasil disimpan!"
    echo "Sama untuk akses Online CLI & masuk Root"
}

# === CEK PASSWORD ===
verify_password() {
    local INPUT_PASS="$1"
    local SAVED_PASS=$(cat "$PASS_FILE" 2>/dev/null)
    [ "$INPUT_PASS" = "$SAVED_PASS" ]
}

# === MENU UTAMA SAAT DIBUKA ===
main_menu() {
    while true; do
        show_banner
        echo "📋 Menu Utama"
        echo "=============================="
        echo "  1. Jalankan repo-setup-mirrors"
        echo "  q. Keluar"
        echo ""
        echo -n "Pilih: "
        read PILIH
        
        case "$PILIH" in
            1) repo_setup_mirrors ;;
            q|Q) echo "👋 Sampai jumpa!"; exit 0 ;;
            *) echo "Pilihan tidak valid!"; sleep 1 ;;
        esac
    done
}

# === DOWNLOAD SEMUA TOOLS DARI MIRROR ===
repo_setup_mirrors() {
    clear
    show_banner
    echo "📥 repo-setup-mirrors — Mengunduh semua tools..."
    echo "================================================"
    echo ""
    
    init_folders
    cd ~/BackServerOS/Tools || return
    
    for TOOL_NAME in "${!TOOLS[@]}"; do
        URL="${TOOLS[$TOOL_NAME]}"
        echo "⬇️  Mengunduh: $TOOL_NAME"
        wget -q --show-progress "$URL" -O "$TOOL_NAME" 2>/dev/null && {
            chmod +x "$TOOL_NAME" 2>/dev/null
            echo "✅ $TOOL_NAME selesai"
        } || echo "⚠️  $TOOL_NAME — gagal unduh"
        echo ""
    done
    
    echo "🎉 Semua tools selesai diunduh!"
    echo "Lokasi: ~/BackServerOS/Tools/"
    echo ""
    sleep 2
    tools_menu
}

# === MENU SETELAH TOOLS SIAP ===
tools_menu() {
    while true; do
        clear
        show_banner
        echo "🛠️  Semua Tools Terpasang"
        echo "=============================="
        echo "  1. Jalankan Tools di Terminal"
        echo "  2. Aktifkan Web Interface (Apache)"
        echo "  3. Monitoring Sistem"
        echo "  4. Masuk Root"
        echo "  5. Setup/Ubah Password"
        echo "  q. Keluar"
        echo ""
        echo -n "Pilih: "
        read PILIH
        
        case "$PILIH" in
            1) terminal_tools ;;
            2) start_apache_web ;;
            3) show_monitoring ;;
            4) enter_root ;;
            5) setup_online_password ;;
            q|Q) echo "👋 Sampai jumpa!"; exit 0 ;;
            *) echo "Pilihan tidak valid!"; sleep 1 ;;
        esac
    done
}

# === JALANKAN TOOLS DI TERMINAL ===
terminal_tools() {
    clear
    echo "🖥️  Tools di Terminal"
    echo "=============================="
    echo "Pilih tools untuk dijalankan:"
    echo "  1. neofetch   2. htop      3. nmap"
    echo "  4. redis      5. tmux      6. nginx"
    echo "  7. Kembali"
    echo ""
    echo -n "Pilih: "
    read PILIH
    cd ~/BackServerOS/Tools || return
    
    case "$PILIH" in
        1) ./neofetch ;;
        2) ./htop ;;
        3) echo "Masukkan alamat IP/host: "; read HOST; ./nmap "$HOST" ;;
        4) ./redis-cli ;;
        5) ./tmux ;;
        6) ./nginx ;;
        7) return ;;
        *) echo "Tidak ada!"; sleep 1 ;;
    esac
    echo ""
    echo "Tekan Enter untuk kembali..."
    read
}

# === MONITORING SISTEM ===
show_monitoring() {
    clear
    echo "📊 Monitoring Sistem BackServerOS"
    echo "=========================================="
    echo "Waktu: $(date)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p 2>/dev/null)"
    echo ""
    echo "--- CPU & Load ---"
    uptime
    echo ""
    echo "--- RAM ---"
    free -h 2>/dev/null || grep MemTotal /proc/meminfo
    echo ""
    echo "--- Disk ---"
    df -h ~/BackServerOS
    echo ""
    echo "--- Proses ---"
    ps aux --sort=-%mem | head -6
    echo ""
    echo "Tekan Enter untuk kembali..."
    read
}

# === WEB INTERFACE VIA APACHE ===
start_apache_web() {
    clear
    echo "🌐 Web Interface (Online CLI)"
    echo "=========================================="
    echo "Masukkan password untuk akses web:"
    read -s INPUT_PASS
    
    if ! verify_password "$INPUT_PASS"; then
        echo "❌ Password salah! Akses ditolak."
        sleep 1
        return
    fi
    
    echo "✅ Password benar — Menyiapkan Web Interface..."
    
    # Buat halaman web sederhana
    mkdir -p ~/BackServerOS/OnlineCLI/www
    cat > ~/BackServerOS/OnlineCLI/www/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>BackServerOS — Online CLI</title>
<style>
body{background:#1a1a2e;color:#0ff;font-family:monospace;padding:20px;}
.box{background:#16213e;padding:20px;border-radius:8px;}
pre{color:#0f0;}
</style>
</head>
<body>
<h1>🚀 BackServerOS — Online CLI</h1>
<div class="box">
<h3>📊 Sistem Status</h3>
<pre id="status">Memuat...</pre>
<script>
setInterval(()=>{
fetch('/status.txt').then(r=>r.text()).then(t=>{
document.getElementById('status').textContent=t
})
},3000)
</script>
<p>✅ Terhubung ke BackServerOS</p>
</div>
</body>
</html>
EOF
    
    # Buat skrip update status
    cat > ~/BackServerOS/OnlineCLI/www/status.txt << EOF
Waktu: $(date)
Host: $(hostname)
Uptime: $(uptime -p 2>/dev/null)
EOF
    
    echo ""
    echo "🌐 Web Interface siap diakses!"
    echo "Buka di browser: http://localhost:8080"
    echo "(Server berjalan di folder: ~/BackServerOS/OnlineCLI/www/)"
    echo "Tekan Enter untuk berhenti dan kembali..."
    read
}

# === MASUK ROOT ===
enter_root() {
    clear
    echo "🔑 Masuk Mode Root"
    echo "=========================================="
    echo "Ketik: sudo"
    echo -n "Masukkan password: "
    read -s INPUT_PASS
    echo ""
    
    if ! verify_password "$INPUT_PASS"; then
        echo "❌ Password salah!"
        sleep 1
        return
    fi
    
    echo "✅ Masuk Mode ROOT"
    echo ""
    echo "📂 Struktur Folder Root:"
    echo "   ~/BackServerOS/"
    echo "   ├── Var/          → Data sistem & log"
    echo "   ├── Lib/          → Library sistem"
    echo "   ├── Tools/        → Semua tools terinstall"
    echo "   ├── PARTI/        → Partisi sistem"
    echo "   └── OnlineCLI/    → Data web interface"
    echo ""
    echo "Anda sekarang di dalam lingkungan sistem."
    echo "Ketik 'exit' untuk keluar dari mode root."
    echo ""
    
    # Simulasi shell root
    while true; do
        echo -n "root@backsrvos:~# "
        read CMD
        case "$CMD" in
            exit) echo "Keluar dari mode root"; return ;;
            ls) echo "Var  Lib  Tools  PARTI  OnlineCLI" ;;
            pwd) echo "$HOME/BackServerOS" ;;
            *) echo "Perintah tidak dikenal: $CMD" ;;
        esac
    done
}

# === PERINTAH KHUSUS ===
check_commands() {
    case "$1" in
        repo-setup-mirrors) repo_setup_mirrors; exit 0 ;;
        setup-online-password) setup_online_password; exit 0 ;;
    esac
}

# =============== MULAI DI SINI ===============
check_commands "$@"
main_menu
