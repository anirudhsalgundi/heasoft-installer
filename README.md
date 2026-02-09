# HEASoft Installation Scripts

This repository contains automated installation scripts for HEASoft on Linux and macOS systems.

**Prerequisites**: You must download and extract the HEASoft archive file before using these scripts. 

**Note**: These scripts run in a screen session to ensure that the installation process continues even if you get logged out. In order to exit the screen session, you can use `Ctrl + A` followed by `D` to detach from the session. You can reattach to the session later using `screen -r heasoft_install`.

Please write to anirudhsalgundi@gmail.com if you have any questions or need help with the installation process. If you wish to make any contributions or improvements to the scripts, feel free to fork the repository and submit a pull request.

## Steps to install HEASoft on Linux




1. Clone this repository inside the HEASoft directory.
```bash
# Use your actual repo link
git clone https://github.com/anirudhsalgundi/heasoft-installer.git
```
or, if you have ssh set up
```bash
# Use your actual repo link
git clone git@github.com:anirudhsalgundi/heasoft-installer.git
```

2. Navigate to the cloned repository folder.
```bash
cd heasoft-installer
```

3. Make the Linux installation script executable.
```bash
chmod +x linux_install.sh
```

4. Run the installation script. This will take a while.
```bash
sh linux_install.sh
```

5. Reload your shell configuration to apply changes.
```bash
source ~/.bashrc
```

## Steps to install HEASoft on macOS

1. Clone this repository inside the HEASoft directory.
```bash
# Use your actual repo link
git clone https://github.com/anirudhsalgundi/heasoft-installer.git
```
or, if you have ssh set up
```bash
# Use your actual repo link
git clone git@github.com:anirudhsalgundi/heasoft-installer.git
```

2. Navigate to the cloned repository folder.
```bash
cd heasoft-installer
```

3. Make the macOS installation script executable.
```bash
chmod +x macOS_install.sh
```

4. Run the installation script.
```bash
sh macOS_install.sh
```

5. Reload your shell configuration to apply changes.
```bash
source ~/.zshrc
```