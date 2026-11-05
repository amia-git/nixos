{
  lib,
  appimageTools,
  fetchurl,
}:

appimageTools.wrapType2 (finalAttrs: {
  pname = "frame";
  version = "0.33.1";

  src = fetchurl {
    url = "https://github.com/66HEX/frame/releases/download/${finalAttrs.version}/Frame-x86_64.AppImage";
    hash = "sha256-9pubdZIM/nk4pundBwaCtnilZLS8dZXSq+kE2JL63kM=";
  };

  extraPkgs = pkgs: [
    pkgs.libxkbcommon
    pkgs.wayland
    pkgs.vulkan-loader
  ];

  extraInstallCommands = ''
    install -Dm644 ${finalAttrs.contents}/Frame.desktop "$out/share/applications/Frame.desktop"
    substituteInPlace "$out/share/applications/Frame.desktop" \
      --replace-fail "TryExec=AppRun" "TryExec=$out/bin/frame" \
      --replace-fail "Exec=AppRun" "Exec=$out/bin/frame"
    mkdir -p "$out/share/icons"
    cp -r ${finalAttrs.contents}/usr/share/icons/hicolor "$out/share/icons/"
  '';

  meta = {
    description = "Native FFmpeg media converter";
    homepage = "https://www.framegui.app/";
    changelog = "https://github.com/66HEX/frame/releases/tag/${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "frame";
  };
})
