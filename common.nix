{ config, pkgs, ... }:

{

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-fortisslvpn
      networkmanager-iodine
      networkmanager-l2tp
      networkmanager-openconnect
      networkmanager-openvpn
      networkmanager-vpnc
      networkmanager-sstp
    ];
  };

  # Clean up old versions
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # and keep the boot menu from bloating (systemd-boot)
  boot.loader.systemd-boot.configurationLimit = 20;


  # Time and locale
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  # Plasma 6 / Wayland
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };
  # services.desktopManager.plasma6.enable = true;
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # Plasma 6 / X11
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    settings = {
      General.DefaultSession = "plasmax11.desktop";
      Wayland.SessionDir = "";
    };
  };
  services.displayManager.defaultSession = "plasmax11";
  services.desktopManager.plasma6.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # User
  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew Coulter";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kamoso
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "andrew" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Packages
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  services.emacs.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wireshark
    flameshot
    copyq
    wget
    brave
    gpclient
    openconnect
    git
    remmina
    terminator
    (keepassxc.override { withKeePassX11 = true; })
    wtype
    cifs-utils
    zoom-us
    openssl
    tmux
    dig
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "andrew";
    dataDir = "/home/andrew";
    configDir = "/home/andrew/.config/syncthing";
    settings.folders = {
      "mybash" = {
        path = "/home/andrew/mybash";
        devices = [];
      };
      "Documents" = {
        path = "/home/andrew/Documents";
        devices = [];
      };
      "Downloads" = {
        path = "/home/andrew/Downloads";
        devices = [];
      };
    };
  };
}
