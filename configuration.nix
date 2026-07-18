# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, config, inputs, ... }:

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
 
  # --- nix system settings --- 
  nix.settings = {
    # enable flakes
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # --- Updates & maintenance ---
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "./nixos#nixos-work";
    dates = "daily";
  };
   
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = ["monthly"];
  };

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
  virtualisation.cri-o.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    curl
    nmap
    net-tools
    # config management
    chezmoi
    # container stuff
    distrobox
    docker
    kubectl
    kubernetes
    kubernetes-helm
    istioctl
    cri-tools
    kind
    minikube
    k9s
    # development stuff
    gcc 
    cmake
    gnumake
    fnm
    go
    # wayland desktop stuff
    swayidle
    swayosd
    swaybg
    swaylock
    wlr-randr
    grim
    slurp
    satty
    wlogout
    sox
    wmenu
    waybar
    xdg-desktop-portal-wlr
    wev
    wl-clipboard
    wl-clip-persist
    cliphist
    wlsunset
    # sound and display controls
    brightnessctl
    pamixer
    pipewire
    pavucontrol
    # communication
    signal-desktop
    # terminal fluff and stuff
    zsh
    fzf
    highlight
    bat
    tmux    
    vifm
    vimv
    alacritty
    tealdeer
    fastfetch
    eza
    btop
    htop
    fd
    ripgrep
    starship
    nerd-fonts.jetbrains-mono
    # browsers
    vivaldi
    librewolf
    chromium
    # security
    dislocker
    # system utils
    ntfs3g
    plymouth
    tlp
    # work related-apps 
#    citrix_workspace
    libreoffice
    pdftk
    plantuml
    drawio
    texliveFull
  ];  
  # enable programs as modules
  #  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.mango.enable = true;
  programs._1password-gui.enable = true;
  programs._1password.enable = true;
  programs.sway = {
    enable = true;
  };
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

#    colorschemes.desert.enable = true;
    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";
    opts = {

      # general settings
      timeoutlen = 500;
      termguicolors = true;
      completeopt = "menu,menuone,noselect";
      updatetime = 100;
      clipboard = "unnamedplus";      
      mouse = "a";
      splitbelow = true;
      splitright = true;

      # line numbers and cursor settings
      number = true;
      relativenumber = true;
      cursorline = true;
      colorcolumn = "80";
      scrolloff = 8;
      sidescrolloff = 5;

      # tab settings
      autoindent = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      shiftround = true;
      signcolumn = "yes";
      smartindent = true;

      #search
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = false;
      wildmode = "longest:full,full";

      # save settings
      autowrite = true;
      confirm = true;

      swapfile = false;
      backup = false;
      writebackup = false;
      undofile = true;
      undolevels = 10000;

      spell = false;
      spelllang = "en_us";

      list = true;
      listchars = {
        tab = "-->";
        trail = "*";
        extends = ">";
        precedes = "<";
      };

      # folding 
      foldmethod = "indent";
      foldlevel = 99;
      foldenable = false;
      };

    keymaps = [
      # telescope
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options.silent = true;
      }
    ];
    #plugins
    plugins = {

      lualine = {
        enable = true;
      };

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
      };

      lsp =  {
        enable = true;
        servers = {
          vue_ls.enable   = true;
          ts_ls.enable    = true;
          cssls.enable    = true;
          jsonls.enable   = true;
          lua_ls.enable   = true;
          nixd.enable     = true;
        };
      };
      dashboard = {
        enable = true;
        settings = {
          theme = "doom";
          config = {
            header = [
            "TIME TO VIM, NIXJEX"
            ];
            center = [
            ];
            footer = [
            ];
          };
        };
      };
      webdev-icons.enable = true;
      colorscheme.tokyonight = {
        enable = true;
        settings.style = "day"; # options: "moon", "storm", "night", "day"
      };
      telescope = {
        enable = true;
        extentions."fzf-native" = {
          enable = true; 
          settings = {
            fuzzy = true;
            override_file_sorter = true;
            override_generic_sorter = true;
            case_mode = "smart_case";
          };
        };
        settings = {
          defaults= {
            layout_config = { prompt_position = "top"; };
            sorting_strategy = "ascending";
            };
            pickers.find_files.hidden = true;
          };
      };
    };
  };
  # .............................................................................................................................................................................................
  # git
  programs.git = {
      enable = true;
      config = {
	init = {
	  defaultBranch = "main";
	};
	  user.name = "Magnus Rotvit Perlt Hansen";
	  user.email = "magnuha@gmail.com";
	  url = {
	      "https://github.com/" = {
		insteadOf = [
	    "gh:"
	    "github:"
		];
	      };
	    };
      };
  };


  # bash
  programs.bash = {
    enable = true;
    completion.enable = true;

    interactiveShellInit ="
    set -o vi
    ";
    # following only for home manager
    #historyFileSize = 10000;
    #historySize = 1000;
    #historyFile = "$HOME/.bash_history";

    #shellOptions = [
    #"histappend"
    #];

    shellAliases = {
	
      #eza
      ls = "eza --icons --git --group-directories-first";
      ll = "eza -lah --icons --git --group-directories-first";
      tree = "eza --tree --icons";

      #clipboard
      copy = "wl-copy";
      paste = "wl-paste";
      };
    }; 
 
  # Set environment variables

  environment.variables = {
    PATH = [
      "$HOME/scripts"
    ];
  };
 # prereqs for citrix_workspace

#  nixpkgs.config.permittedInsecurePackages = [
#    "libsoup-2.74.3" 
#    "libxml2-2.13.8"
#   ];
#
#   let  
#	citrix-src = builtins.fetchTarball {  
#	url = Fileurl-to-the-package;  
#	sha256 = "sha256:thesha256";  
#	};  
#      citrix-work = pkgs.citrix-workspace.overrideAttrs (oldAttrs: { src = citrix-src; });   
#    in  
#      environment.packages = [ citrix-work ];

  # register fonts
  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	corefonts
  ];
  # services 
  services.fwupd.enable = true;
  services.fstrim.enable = true;
  # enable swaylock to use the pam services
  security.pam.services.swaylock = {};

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
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
