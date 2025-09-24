#!/bin/bash
# QuantumTerminator™ Terminal Banner (Cross-Platform)
# ====================================================
# Prints a dynamic ASCII banner followed by system info:
#   - OS & Version
#   - Logged-in Users
#   - Uptime
#   - CPU Usage
#   - RAM Usage
#   - Disk Usage
# Supports Bash on Linux and macOS.
# Optional rainbow colors if 'lolcat' is installed.
#
# Usage:
#   1. Make executable: chmod +x terminal-banner.sh
#   2. Test: ./terminal-banner.sh
#   3. Add to ~/.bashrc to display banner on terminal startup:
#        ~/path/to/terminal-banner.sh
# ====================================================

# ------------------- Configuration -------------------
MAX_BANNER_WIDTH=200               # Maximum width of banner
BANNER_TEXT="Dean's Machines"      # Text to display
FIGLET_DIR="/usr/share/figlet/fonts"  # Default Linux figlet font directory
FONT_NAME="slant.flf"             # Figlet font

# ------------------- Terminal Setup -------------------
clear
TERM_WIDTH=$(tput cols)
BANNER_WIDTH=$(( TERM_WIDTH < MAX_BANNER_WIDTH ? TERM_WIDTH : MAX_BANNER_WIDTH ))

# ------------------- Banner Generation ----------------
if ! command -v figlet &> /dev/null; then
    echo "$BANNER_TEXT"   # Fallback if figlet not installed
else
    # Determine correct font directory for Linux/macOS
    if [[ "$(uname)" == "Darwin" ]]; then
        FIGLET_DIR="/usr/local/Cellar/figlet/2.2.5/share/figlet/fonts"
    fi

    # Generate ASCII banner
    banner=$(figlet -d "$FIGLET_DIR" -f "$FONT_NAME" -w $BANNER_WIDTH "$BANNER_TEXT")

    # Print banner with ™ symbol
    {
        first_line=true
        while IFS= read -r line; do
            if $first_line; then
                line_length=$(echo -n "$line" | wc -c)
                padding=$((BANNER_WIDTH - line_length - 1))
                [ "$padding" -lt 0 ] && padding=1
                printf "%s%*s\033[90m™\033[0m\n" "$line" "$padding" ""
                first_line=false
            else
                echo "$line"
            fi
        done <<< "$banner"

        # ------------------- Welcome Section ----------------
        echo -e "\033[36m--------------------------------------\033[0m"
        echo -e "Welcome, Sensei! ⚡"
        echo -e "\033[32mType 'help' for available commands.\033[0m"
        echo -e "\033[36m--------------------------------------\033[0m"

        # ------------------- Progress Bar Function ----------------
        print_bar() {
            local percent=$1
            local width=30
            local filled=$(( percent * width / 100 ))
            local empty=$(( width - filled ))
            printf "["
            printf "%0.s#" $(seq 1 $filled)
            printf "%0.s-" $(seq 1 $empty)
            printf "] %3d%%\n" "$percent"
        }

        # ------------------- Dynamic System Info ----------------
        # OS & Version
        echo -e "\033[33mOS & Version:\033[0m $(uname -srv)"

        # Logged-in users
        users_list=$(who | awk '{print $1}' | uniq | tr '\n' ' ')
        users_count=$(echo "$users_list" | wc -w)
        echo -e "\033[33mLogged In Users:\033[0m $users_count ($users_list)"

        # Uptime
        echo -e "\033[33mUptime:\033[0m $(uptime -p 2>/dev/null || uptime | awk -F'(up |,)' '{print $2}')"

        # CPU & RAM Usage
        if [[ "$(uname)" == "Darwin" ]]; then
            # macOS
            cpu_idle=$(top -l 1 | grep "CPU usage" | awk '{print $7}' | tr -d '%')
            cpu_used=$(printf "%.0f" $(echo "100 - $cpu_idle" | bc))
            echo -ne "\033[33mCPU Usage:   \033[0m"
            print_bar $cpu_used

            ram_used=$(top -l 1 | grep PhysMem | awk '{gsub("M","",$2); print $2}')
            ram_free=$(top -l 1 | grep PhysMem | awk '{gsub("M","",$6); print $6}')
            ram_total=$((ram_used + ram_free))
            ram_percent=$(( ram_used * 100 / ram_total ))
            echo -ne "\033[33mRAM Usage:   \033[0m"
            print_bar $ram_percent
        else
            # Linux
            cpu_used=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | awk '{printf "%.0f\n",$1}')
            echo -ne "\033[33mCPU Usage:   \033[0m"
            print_bar $cpu_used

            ram_used=$(free -m | awk '/^Mem:/ {print $3}')
            ram_total=$(free -m | awk '/^Mem:/ {print $2}')
            ram_percent=$(( ram_used * 100 / ram_total ))
            echo -ne "\033[33mRAM Usage:   \033[0m"
            print_bar $ram_percent
        fi

        # Disk Usage (root partition)
        disk_used=$(df -h / | tail -1 | awk '{gsub("%","",$5); print $5}')
        echo -ne "\033[33mDisk Usage:  \033[0m"
        print_bar $disk_used

    } | if command -v lolcat &> /dev/null; then lolcat; else cat; fi
fi

# ====================================================
# End of QuantumTerminator™ Terminal Banner
# ====================================================

