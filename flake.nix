{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can change the word unstable to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:4evy/nixcord";
    # PR #84: remove references to the removed scripted initrd options.
    nixos-core.url = "github:manic-systems/nixos-core/13e4d6d811e1e6fa3c9366613931e59ba10b3bd4";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.stuckmoth = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.disko.nixosModules.disko
        inputs.chaotic.nixosModules.default
        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = [
              inputs.nix-cachyos-kernel.overlays.pinned
              inputs.millennium.overlays.default
            ];
          }
        )
        inputs.nixos-core.nixosModules.default
        { system.nixos-core.enable = true; }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            backupFileExtension = "bak";
            extraSpecialArgs = { inherit inputs; };
            users.aria = import ./features/home.nix;
          };
        }
        ./configuration.nix
        ./disko.nix
      ];
    };
  };
}

