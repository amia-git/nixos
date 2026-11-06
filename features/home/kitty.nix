{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings.confirm_os_window_close = 0;
    font = {
      name = "FiraCode Nerd Font Mono";
      package = pkgs.nerd-fonts.fira-code;
    };
  };
}
