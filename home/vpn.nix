# home/vpn.nix
{ pkgs, ... }:
let
  gpCallbackScript = pkgs.writeShellScript "gpcallback" ''
    echo -n "$1" | ${pkgs.netcat}/bin/nc -w1 127.0.0.1 "$(cat /tmp/gpcallback.port)"
  '';
in
{
  home.packages = with pkgs; [ gpclient openconnect netcat ];
  xdg.mimeApps.enable = true;
  xdg.desktopEntries.globalprotectcallback = {
    name = "GlobalProtect Callback";
    type = "Application";
    exec = "${gpCallbackScript} %u";
    mimeType = [ "x-scheme-handler/globalprotectcallback" ];
    noDisplay = true;
  };
  xdg.mimeApps.defaultApplications."x-scheme-handler/globalprotectcallback" =
    "globalprotectcallback.desktop";
}