{ config, pkgs, ... }:

{

  # Openssh
  services.openssh = {
    enable = false;
    settings = {
      PermitRootLogin = "no";          # or "prohibit-password"
      PasswordAuthentication = false;  # key-only auth
      KbdInteractiveAuthentication = false;
    };
    ports = [ 22 ];
  };

}