{ config, pkgs, ... }:

{
  imports = [
    ./home/git.nix
    ./home/discord.nix
    ./home/spotify.nix
  ];

  programs.nushell = {
    enable = true;
    # Bash already loads and exports the Home Manager session variables.
    loadSessionVariables = false;
  };
  programs.bash = {
    enable = true;
    initExtra = ''
      # Start Nu only for terminal sessions, preserving Bash for scripts and
      # explicit commands. The marker lets `bash` inside Nu stay in Bash.
      if [[ $- == *i* && -t 0 && -t 1 \
          && -z "''${BASH_EXECUTION_STRING:-}" \
          && -z "''${NUSHELL_STARTED_FROM_BASH:-}" ]]; then
        export NUSHELL_STARTED_FROM_BASH=1
        exec ${config.programs.nushell.package}/bin/nu
      fi
    '';
  };

  home = {
    homeDirectory = "/home/aria";
    username = "aria";
    stateVersion = "26.05";
    packages = with pkgs; [
      fastfetch
      btop
      eza
      dust
    ];
  };
}
