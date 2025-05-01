#!/bin/bash

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

# ASCII ART - Mr. Robot
ascii_art='
        _____   .__ .__     __________     ___.   .__                  
       /  _  \  |__||  |__  \______   \__ _\_ |__ |  |__   ____ ___.__.
      /  /_\  \ |  ||  |  \  |     ___/\__  \| __ \|  |  \ /  _ <   |  |
     /    |    \|  ||   Y  \ |    |     / __ \ \_\ \   Y  (  <_> )___  |
     \____|__  /|__||___|  / |____|    (____  /___  /___|  /\____// ____|
             \/          \/                 \/    \/     \/       \/     

            Elliot Alderson | Mr. Robot Terminal Watch
'

# Cabeçalho visual
print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║     🧠  LINUX SERVICES & RAM MONITOR - by @miuidroidzz     ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
}

# RAM
show_ram_usage() {
    echo -e "${YELLOW}${BOLD}📊 MEMÓRIA RAM:${RESET}"
    echo -e "${MAGENTA}──────────────────────────────────────────────────────────────${RESET}"
    free -h | awk '/Mem:/ {printf "  Total: %s | Usada: %s | Livre: %s\n", $2, $3, $4}'
    echo -e "${MAGENTA}──────────────────────────────────────────────────────────────${RESET}\n"
}

# Serviços
show_active_services() {
    echo -e "${GREEN}${BOLD}⚙️  SERVIÇOS ATIVOS:${RESET}"
    echo -e "${MAGENTA}──────────────────────────────────────────────────────────────${RESET}"
    systemctl list-units --type=service --state=running | awk 'NR>1 {print "  •", $1}' | head -n 15
    echo -e "${MAGENTA}──────────────────────────────────────────────────────────────${RESET}"
    echo -e "${CYAN}(Mostrando os 15 primeiros serviços em execução)${RESET}\n"
}

# Otimização de RAM
optimize_ram() {
    echo -e "${RED}${BOLD}🧹 Otimizando memória RAM (limpando cache de páginas)...${RESET}"
    sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    echo -e "${GREEN}✅ Otimização concluída.${RESET}\n"
    sleep 2
}

# Loop principal
while true; do
    clear
    print_header
    echo -e "${MAGENTA}${ascii_art}${RESET}"
    show_ram_usage
    show_active_services

    echo -e "${YELLOW}${BOLD}💡 Opções:${RESET}"
    echo -e "  1. Atualizar status"
    echo -e "  2. Otimizar RAM"
    echo -e "  3. Sair"
    echo
    read -p "Escolha uma opção [1-3]: " choice
    case $choice in
        1) continue ;;
        2) optimize_ram ;;
        3) echo -e "${RED}Saindo...${RESET}"; exit 0 ;;
        *) echo -e "${RED}Opção inválida.${RESET}"; sleep 1 ;;
    esac
done
