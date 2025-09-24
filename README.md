# Promptly™ Terminal Banner

**Promptly™** is a lightweight, cross-platform Bash script for creating **dynamic terminal banners**.  
It displays custom ASCII banners, system information, and optional rainbow colors with `lolcat`. Compatible with **Linux** and **macOS**.

---

## Features
- Custom ASCII banner with `figlet`
- Automatic adjustment to terminal width
- Displays:
  - OS & Version
  - Logged-in users
  - Uptime
  - CPU Usage
  - RAM Usage
  - Disk Usage
- Optional rainbow colors with `lolcat`
- Cross-platform (Linux & macOS)

---

## Dependencies
- `figlet` (required)
- `lolcat` (optional, adds rainbow colors)

### Install Dependencies

**Linux (Debian/Ubuntu):**
```bash
sudo apt update
sudo apt install figlet lolcat
macOS (Homebrew):

bash
Copy code
brew install figlet lolcat
Installation
Clone the repository

bash
Copy code
git clone https://github.com/yourusername/Promptly.git
cd Promptly
Make the script executable

bash
Copy code
chmod +x terminal-banner.sh
Test the banner

bash
Copy code
./terminal-banner.sh
Add to .bashrc to display banner on terminal startup

bash
Copy code
echo "~/Promptly/terminal-banner.sh" >> ~/.bashrc
source ~/.bashrc
Customization
Banner text: Edit the BANNER_TEXT variable in terminal-banner.sh.

Figlet font: Change FONT_NAME or font directory FIGLET_DIR.

Max width: Adjust MAX_BANNER_WIDTH for your terminal preference.

Example Output
markdown
Copy code
   ____                      _                       ™
  |  _ \ __ _ _ __ ___   ___| |__  _ __ ___  ___
  | |_) / _` | '_ ` _ \ / _ \ '_ \| '__/ _ \/ __|
  |  __/ (_| | | | | | |  __/ | | | | |  __/\__ \
  |_|   \__,_|_| |_| |_|\___|_| |_|_|  \___||___/
--------------------------------------
Welcome, Sensei! ⚡
Type 'help' for available commands.
--------------------------------------
OS & Version: Linux 6.5.0-arch
Logged In Users: 1 (dean)
Uptime: 2 hours, 15 minutes
CPU Usage: [#####---------------] 25%
RAM Usage: [#########---------] 60%
Disk Usage: [#####---------------] 30%
License
MIT License – free to use, modify, and share.
