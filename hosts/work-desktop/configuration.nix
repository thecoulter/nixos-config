{ config, pkgs, ... }:

{
  networking.hostName = "andrewc-desktop";

  fileSystems."/mnt/itshare" = {
    device = "//its-share-01.sgc.local/ITData/";
    fsType = "cifs";
    options = [
      "credentials=/home/andrew/.ssh/.testout"
      "iocharset=utf8"
      "uid=1000"
      "gid=1000"
      "nofail"
      "x-systemd.automount"
      "x-systemd.requires=network-online.target"
    ];
  };

  system.stateVersion = "25.11";
}
