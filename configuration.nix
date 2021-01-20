{ config, pkgs, ... }:

{
        imports =
        [ # Include the results of the hardware scan.
                ./hardware-configuration.nix
        ];


        # Use the systemd-boot EFI boot loader.
        boot = {
                loader = {
                        systemd-boot.enable = true;
                        efi.canTouchEfiVariables = true;
                        grub.useOSProber = true;
                };

                supportedFilesystems = [ "ntfs" ];

                plymouth.enable = true;

        };


        networking = {
                hostName = "Nix"; # Define your hostname.
                networkmanager.enable = true; # Enables wireless
         
                # replicates the default behaviour.
                useDHCP = false;
                interfaces = {
                        enp3s0.useDHCP = true;
                        wlp4s0.useDHCP = true;
                };

        };


        # Set your time zone.
        time.timeZone = "Asia/Kathmandu";
  
  
        # Select internationalisation properties.
        i18n.defaultLocale = "en_US.UTF-8";
        console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
        };
  
  
        # Define a user account.
        users.users.sloth = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
        };
  
  
        # Enable sound.
        sound.enable = true;
        hardware = {
                pulseaudio = {
                        enable = true;
                        # package = pkgs.pulseaudioFull;
                };
        };
  
  
        # List services that you want to enable:
        services = {
                # Enable Xserver.
                xserver = {
                        enable = true;
                        displayManager.sddm.enable = true;
                        desktopManager.plasma5.enable = true;

                        # Configure keymap in X11
                        layout = "us";
                        # xkbOptions = "eurosign:e";
  
                        # Enable touchpad support (enabled default in most desktopManager).
                        libinput.enable = true;
                };

                # Enable CUPS to print documents.
                # printing.enable = true;
 
                # Enable the OpenSSH daemon.
                openssh.enable = true;
        };


        # Fonts
        fonts.fonts = with pkgs; [
        dejavu_fonts
        inconsolata
        font-awesome
        ];
  
  
        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
        vim
        wget curl git tmux lynx file tree unzip

        gcc gdb valgrind
    
        brightnessctl
        cmus cava
        neofetch

        firefox
        vlc
        transmission-gtk
        libreoffice
        gimp
        # flameshot
        openshot-qt
        obs-studio

        whois nmap wireshark
        python38Packages.binwalk steghide
        ];
  
  
        system.stateVersion = "20.09";
}
