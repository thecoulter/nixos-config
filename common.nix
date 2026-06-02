{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-fortisslvpn
      networkmanager-iodine
      networkmanager-openconnect
      networkmanager-vpnc
    ];
  };

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
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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

  environment.systemPackages = with pkgs; [
    vim
    wget
    brave
    emacs-nox
    gpclient
    openconnect
    git
    remmina
    terminator
    (keepassxc.override { withKeePassX11 = true; })
    wtype
    cifs-utils
    zoom-us
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
