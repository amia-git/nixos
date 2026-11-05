{ pkgs, ... }:

{
  chaotic.mesa-git.enable = true;
  services.scx = {
    enable = true;
    scheduler = "scx_cake";
  };
}