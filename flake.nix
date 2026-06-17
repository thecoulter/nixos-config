{
  description = "Andrew's NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";   # your existing line, untouched
    home-manager = {
      url = "github:nix-community/home-manager";           # defaults to master = tracks unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {

      andrewc-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/work-desktop/configuration.nix
          ./hosts/work-desktop/hardware-configuration.nix
          ./hosts/work-desktop/hardware.nix
          ./hardware-common.nix
          ./common.nix
          ./modules/openssh.nix	  	  	  
        ];
      };

      andrewc-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/work-laptop/configuration.nix
          ./hosts/work-laptop/hardware-configuration.nix
          ./hardware-common.nix
          ./common.nix
        ];
      };

    };
  };
}
