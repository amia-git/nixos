{
  lib,
  appimageTools,
  fetchurl,
}:

appimageTools.wrapType2 (finalAttrs: {
  pname = "photon-studio";
  version = "0.1.68";

  src = fetchurl {
    url = "https://downloads.tenzen.studio/photon/stable/linux/${finalAttrs.version}/Photon-Studio-${finalAttrs.version}-linux-x64.AppImage";
    hash = "sha256-0v9Pz4NEoWZcdmpPWTjySWVEL+z8LlSWrdfBv+UiC4k=";
  };

  extraPkgs = pkgs: [ pkgs.util-linux ];

  extraInstallCommands = ''
    install -Dm644 ${finalAttrs.contents}/photon-studio.desktop "$out/share/applications/photon-studio.desktop"
    substituteInPlace "$out/share/applications/photon-studio.desktop" \
      --replace-fail "Exec=AppRun" "Exec=$out/bin/photon-studio"
    install -Dm644 ${finalAttrs.contents}/usr/share/icons/hicolor/512x512/apps/photon-studio.png \
      "$out/share/icons/hicolor/512x512/apps/photon-studio.png"
  '';

  meta = {
    description = "Offline photo editor with native PSD support";
    homepage = "https://tenzen.studio/photon/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "photon-studio";
  };
})
