{ config, pkgs, ... }:

{
  imports = [
    ./home/git.nix
  ];

  home = {
    homeDirectory = "/home/aria";
    username = "aria";
    stateVersion = "26.05";
  };
}
