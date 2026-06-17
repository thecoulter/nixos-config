# home/emacs/default.nix
{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;   # pin e.g. pkgs.emacs30 if you want
    extraPackages = epkgs: with epkgs; [ magit use-package ];
  };

  # symlink the committed init.el into place
  xdg.configFile."emacs/init.el".source = ./init.el;
}
