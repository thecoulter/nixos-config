# home/vpn.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [ gpclient openconnect netcat ];

  xdg.mimeApps.enable = true;
  xdg.desktopEntries.globalprotectcallback = {
    name = "GlobalProtect Callback";
    type = "Application";
    exec = "bash -c 'echo -n \"%u\" | nc -w1 127.0.0.1 $(cat /tmp/gpcallback.port)'";
    mimeType = [ "x-scheme-handler/globalprotectcallback" ];
    noDisplay = true;
  };
  xdg.mimeApps.defaultApplications."x-scheme-handler/globalprotectcallback" =
    "globalprotectcallback.desktop";
}