{ inputs, pkgs, ... }:

{
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.comfy // {
        additionalCss = ''
          :root {
            --font-family: "Noto Sans", "Noto Sans CJK JP", "Noto Color Emoji", sans-serif;
            --encore-body-font-stack: "Noto Sans", "Noto Sans CJK JP", "Noto Color Emoji", sans-serif;
            --encore-title-font-stack: "Noto Sans", "Noto Sans CJK JP", "Noto Color Emoji", sans-serif;
          }
        '';
      };
      colorScheme = "Comfy";
      enabledCustomApps = [ spicePkgs.apps.marketplace ];
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        spicyLyrics
      ];
    };
}
