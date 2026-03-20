# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
	plymouth = {
		enable = true;
		theme = "rings";
		themePackages = with pkgs; [
			# by default install all themes
			(adi1090x-plymouth-themes.override {
				selected_themes = [ "rings" ];
				}
			)
		];
	};
	# enable silent boot"
	consoleLogLevel = 3;
	initrd.verbose = false;
	kernelParams = [
		"quiet"
		"udev.log_level=3"
		"systemd.show_status=auto"
	];
	# hide generation os choice for bootloader
	# hit any key to open bootloader
	loader.timeout = 0;
  };
	
  # Bootloader.
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-work"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "winkeys";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mrph = {
    isNormalUser = true;
    description = "magnus rotvit perlt hansen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };
	# allow unfree packages
	nixpkgs.config.allowUnfree = true;

  # activate docker
  virtualisation.docker.enable = true;

  # enable programs
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.mango.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    zoxide
    bat
    fzf
    bat
    tmux
    docker
    kubectl
    kubernetes-helm
    kind
    k9s
    gcc 
    cmake
    gnumake
    fnm
    ranger
    wev
    wl-clipboard
    wl-clip-persist
    cliphist
    wlsunset
    brightnessctl
    pamixer
    pipewire
    swayidle
    swayosd
    wlr-randr
    grim
    slurp
    satty
    wlogout
    sox
    wmenu
    swaybg
    waybar
    signal-desktop
    xdg-desktop-portal-wlr

    go
    starship
    alacritty
    vivaldi
    chezmoi
    _1password-gui
    _1password-cli
    tealdeer
    fastfetch
    eza
    btop
    htop
    fd
    ripgrep
    plymouth
    tlp
    nerd-fonts.jetbrains-mono
  ];  

  # register fonts
  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	corefonts
  ];
  # services and settings
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
  };

  # bash
  programs.bash = {
	enable = true;
	completion.enable = true;

	interactiveShellInit ="
	set -o vi
	";
	histSize = 10000;
	histFile = "$HOME/.bash_history"
	setOptions = [
	"HIST_IGNORE_ALL_DUPS"
	];

	shellAliases = {
	
	#eza
	ls = "eza --icons --git --group-directories-first";
	ll = "eza -lah --icons --git --group-directories-first";
	tree = "eza --tree --icons";

	
	# bat
	cat = "bat";

	#grep
	grep = "rg";

	#clipboard
	copy = "wl-copy";
	paste = "wl-paste";
	};
  };
  # tailscale 
#  services.tailscale = {
#	enable = true;
#  };

  # tlp settings
  services.tlp = {
	enable = true;
	settings = {
		CPU_SCALING_GOVERNOR_ON_AC = "performance";
		CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
		# requires supported hardware, e.g Thinkpad
		START_CHARGE_THRESH_BAT0 = 40;
		STOP_CHARGE_THRESH_BAT0 = 80;
	};
  };
  services.power-profiles-daemon.enable = false;	
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
