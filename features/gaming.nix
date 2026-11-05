{ config, pkgs, ... }:

{
  programs.gamemode.enable = true;
  services.power-profiles-daemon.enable = true;

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "nvidia-performance";
      runtimeInputs = [
        config.programs.gamemode.package
        pkgs.power-profiles-daemon
        pkgs.systemd
        pkgs.gnugrep
      ];
      text = ''
        # Adapted from CachyOS-Settings/usr/bin/game-performance.
        if (( $# == 0 )); then
          echo "Usage: nvidia-performance COMMAND [ARG...]" >&2
          exit 2
        fi

        export NVPRESENT_ENABLE_SMOOTH_MOTION=1
        set -- gamemoderun "$@"

        # Still enable GameMode and Smooth Motion without a performance profile.
        if ! powerprofilesctl list | grep 'performance:' >/dev/null; then
          exec "$@"
        fi

        # Preserve CachyOS's opt-out for idle/sleep inhibition.
        if [[ -n "''${GAME_PERFORMANCE_SCREENSAVER_ON:-}" ]]; then
          exec powerprofilesctl launch -p performance \
            -r "Launched with nvidia-performance" -- "$@"
        else
          exec systemd-inhibit --why "nvidia-performance is running" \
            powerprofilesctl launch -p performance \
            -r "Launched with nvidia-performance" -- "$@"
        fi
      '';
    })
  ];

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
