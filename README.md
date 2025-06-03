# HEASoft Installation Scripts

This repository contains automated installation scripts for HEASoft on Linux and macOS systems.

**Prerequisites**: You must download and extract the HEASoft archive file before using these scripts.

## Steps to install HEASoft on Linux

1. Download HEASoft from the official NASA HEASARC website and extract it.
```bash
# You should have a folder named something like heasoft-6.xx
# Navigate to that folder
cd heasoft-6.xx
```

2. Clone this repository inside the HEASoft directory.
```bash
# Use your actual repo link
git clone https://github.com/anirudhsalgundi/heasoft-installer.git
```
or, if you have ssh set up
```bash
# Use your actual repo link
git clone git@github.com:anirudhsalgundi/heasoft-installer.git
```

3. Navigate to the cloned repository folder.
```bash
cd heasoft-installer
```

4. Make the Linux installation script executable.
```bash
chmod +x linux_install.sh
```

5. Run the installation script. This will take a while.
```bash
sh linux_install.sh
```

6. Reload your shell configuration to apply changes.
```bash
source ~/.bashrc
```

## Steps to install HEASoft on macOS

1. Download HEASoft from the official NASA HEASARC website and extract it.
```bash
# You should have a folder named something like heasoft-6.xx
# Navigate to that folder
cd heasoft-6.xx
```
2. Clone this repository inside the HEASoft directory.
```bash
# Use your actual repo link
git clone https://github.com/anirudhsalgundi/heasoft-installer.git
```
or, if you have ssh set up
```bash
# Use your actual repo link
git clone git@github.com:anirudhsalgundi/heasoft-installer.git
```

3. Navigate to the cloned repository folder.
```bash
cd heasoft-installer
```

4. Make the macOS installation script executable.
```bash
chmod +x macOS_install.sh
```

5. Run the installation script.
```bash
sh macOS_install.sh
```

6. Reload your shell configuration to apply changes.
```bash
source ~/.zshrc
```

## Directory Structure
After following the instructions, your setup should look like this:
```
heasoft-6.xx/
├── (HEASoft files and folders)
└── your-repo-name/
    ├── linux_install.sh
    ├── macOS_install.sh
    └── README.md
```
