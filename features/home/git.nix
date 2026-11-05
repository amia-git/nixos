{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Aria";
      user.email = "aria@delusion.gay";
      gpg.format = "ssh";
    };
    signing = {
      key = "~/.ssh/id_ed25519";
      signByDefault = true;
      allowedSigners = ''
        aria@delusion.gay ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjS4S+P1vPnCHmiR0qiPxafNyJa/8dX710CbEOiW25/
      '';
    };
  };
}
