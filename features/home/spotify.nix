{ inputs, pkgs, ... }:

{
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.bloom;
      colorScheme = "dark";
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        beautifulLyrics
      ];
    };
}
