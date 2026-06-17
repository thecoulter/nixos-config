# hosts/work-desktop/home.nix
{ ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.andrew = import ../../home;
}