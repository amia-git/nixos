{ pkgs, ... }:

{
  # chaotic.mesa-git.enable = true;
  services.scx = {
    enable = true;
    scheduler = "scx_cake";
  };
  services.bpftune.enable = true;
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      gamemode
      mangohud_git
      gamescope_git
      kdePackages.breeze
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      dwproton-bin
    ];
  };
}
