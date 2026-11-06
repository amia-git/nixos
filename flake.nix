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
    llm-agents.url = "github:numtide/llm-agents.nix";
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waydroid-a17-nvidia-nix.url = "github:amia-git/waydroid-a17-nvidia-nix";
    lichii-nix.url = "github:amia-git/lichii-nix/v0.1.0";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    packages.x86_64-linux.frame =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.callPackage ./pkgs/frame.nix { };

    packages.x86_64-linux.photon-studio =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          # allow the unfree package for exposed flake package
          config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "photon-studio";
        };
      in
      pkgs.callPackage ./pkgs/photon-studio.nix { };

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
        inputs.waydroid-a17-nvidia-nix.nixosModules.default
        {
          virtualisation.waydroid-a17-nvidia-nix.enable = true;
        }
        ./configuration.nix
        ./disko.nix
      ];
    };
  };
}

