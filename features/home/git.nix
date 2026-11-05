{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Aria";
      user.email = "149911531+ariaofdelusion@users.noreply.github.com";
      gpg.format = "ssh";
    };
    signing = {
      key = "~/.ssh/id_ed25519";
      signByDefault = true;
      allowedSigners = ''
        149911531+ariaofdelusion@users.noreply.github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjS4S+P1vPnCHmiR0qiPxafNyJa/8dX710CbEOiW25/
      '';
    };
  };
}
