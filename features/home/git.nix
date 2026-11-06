{ config, pkgs, ... }:

{
  programs.gh.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.name = "Amia";
      user.email = "149911531+amia-git@users.noreply.github.com";
      gpg.format = "ssh";
    };
    signing = {
      key = "~/.ssh/id_ed25519";
      signByDefault = true;
      allowedSigners = ''
        149911531+amia-git@users.noreply.github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjS4S+P1vPnCHmiR0qiPxafNyJa/8dX710CbEOiW25/
      '';
    };
  };
}
