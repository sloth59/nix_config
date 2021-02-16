{ config, pkgs, ... }:

{
	imports =
	[ 	# Include the results of the hardware scan.
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


	# Networking settings
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
	users.users.washbin = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "vboxusers" "adbusers" ];
	};


	# Enable sound.
	sound.enable = true;
	hardware = {
		pulseaudio = {
			enable = true;
			# package = pkgs.pulseaudioFull;
		};
	};


	# Nixpkgs options
	nixpkgs = {
		config = {
			# Enable non-free softwre
			# allowUnfree = true;
		};
	};


	# List services that you want to enable:
	services = {
		# Enable Xserver.
		xserver = {
			enable = true;
			displayManager = {
				lightdm.enable = true;
			};
			desktopManager = {
				pantheon.enable = true;
			};

			# Configure keymap in X11
			layout = "us";
			# xkbOptions = "eurosign:e";

			# Enable touchpad support
			libinput.enable = true;	
		};

		# Enable CUPS to print documents.
		# printing.enable = true;

		# Enable the OpenSSH daemon.
		openssh.enable = true;
	};


	# Enabling Virtualization
	virtualisation = {
		virtualbox = {
			host.enable = true;
			guest = {
				enable = true;
				x11 = true;
			};
		};
		
		# anbox.enable = true;
	};


	# Additional Programs
	programs = {
		tmux.enable = true;
		vim.defaultEditor = true;
		adb.enable = true;
	};


	# Fonts
	fonts.fonts = with pkgs; [
		hack-font
		dejavu_fonts
		inconsolata
		fira-code
		font-awesome
	];


	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment = {
		systemPackages = with pkgs; [
			wget curl lynx git
			file unzip tree
			brightnessctl
			cmus cava
			neofetch
			gcc gdb valgrind
			vscodium emacs
			mono6 python3
			firefox chromium
			vlc
			audacity
			transmission-gtk
			libreoffice
			gimp
			flameshot
			openshot-qt
			obs-studio
			remmina
			screenkey
			gparted
			whois nmap wireshark
			python38Packages.binwalk steghide
		];

		pantheon.excludePackages = with pkgs;[
			epiphany
			gnome3.geary
		];
	};


	system.stateVersion = "20.09";
}
