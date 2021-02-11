{ config, pkgs, ... }:

{
	imports =
    	[       # Include the results of the hardware scan.
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
		plymouth.enable = false; # Enable boot splash screen
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
    		extraGroups = [ "wheel" "networkmanager" ];
  	};
  	
  	
  	# Enable sound.
  	sound.enable = true;
  	hardware = {
  		pulseaudio = {
  			enable = true;
  			# package = pkgs.pulseaudioFull;
  		};
  	};
  	

	# Enable non-free softwre
	# nixpkgs.config.allowUnfree = true;


  	# List services that you want to enable:
  	services = {
  	  	# Enable Xserver.
		xserver = {
			enable = true;
			displayManager = {
				lightdm = {
					enable = true;
				};
			};
			desktopManager = {
				mate.enable = true;
			};	
	
  			# Configure keymap in X11
  			layout = "us";
			# xkbOptions = "eurosign:e";
  		
			# Enable touchpad support
  			libinput.enable = true;	
		};

		# Enable picom for graphical effects in windowManagers
		picom = {
			enable = false;
			fade = true;
			inactiveOpacity = 0.9;
			shadow = true;
			fadeDelta = 4;
		};
		
  		# Enable CUPS to print documents.
  		# printing.enable = true;
 	
  		# Enable the OpenSSH daemon.
  		openssh.enable = true;
	};
	
	
	# Additional Programs
	programs = {
		qt5ct.enable = true;
	};
	
	
  	# Fonts
  	fonts.fonts = with pkgs; [
		hack-font
		fira-code
    	        dejavu_fonts
    	        inconsolata
    	        font-awesome
  	];
  	
  	
  	# List packages installed in system profile. To search, run:
  	# $ nix search wget
  	environment.systemPackages = with pkgs; [
    	        tmux vim
    	        wget curl lynx git
	        file unzip tree
	    	
    	        brightnessctl
    	        cmus cava
    	        neofetch

    	        gcc gdb valgrind
	        emacs vscodium
	
    	        firefox chromium
    	        transmission-gtk
    	        libreoffice
		vlc
		audacity
    	        gimp
    	        flameshot
    	        openshot-qt
    	        obs-studio
	
	        gparted

    	        whois nmap wireshark
    	        python38Packages.binwalk steghide
  	];
  	
  	
  	system.stateVersion = "20.09";
}
