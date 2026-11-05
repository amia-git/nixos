{ config, pkgs, ... }:

{
  imports = [
    ./home/git.nix
    ./home/discord.nix
    ./home/spotify.nix
  ];

  home = {
    homeDirectory = "/home/aria";
    username = "aria";
    stateVersion = "26.05";
    packages = with pkgs; [
      fastfetch
      btop
    ];
  };
}
