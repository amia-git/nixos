# NixOS flake

## Packages

### Frame

[Frame](https://framegui.app/) is available for `x86_64-linux` as `packages.x86_64-linux.frame`.

Run it directly:

```sh
nix run github:amia-git/nixos#frame
```

Install it in your profile:

```sh
nix profile install github:amia-git/nixos#frame
```

To use it from another NixOS flake, add this flake as an input:

```nix
inputs.amia-nixos.url = "github:amia-git/nixos";
```

Then include the package in your configuration:

```nix
environment.systemPackages = [
  inputs.amia-nixos.packages.${pkgs.stdenv.hostPlatform.system}.frame
];
```

### Photon Studio

[Photon Studio](https://tenzen.studio/photon/) is available for `x86_64-linux` as `packages.x86_64-linux.photon-studio`.

Run it directly:

```sh
nix run github:amia-git/nixos#photon-studio
```

Install it in your profile:

```sh
nix profile install github:amia-git/nixos#photon-studio
```

To use it from another NixOS flake, add this flake as an input:

```nix
inputs.amia-nixos.url = "github:amia-git/nixos";
```

Then include the package in your configuration:

```nix
environment.systemPackages = [
  inputs.amia-nixos.packages.${pkgs.stdenv.hostPlatform.system}.photon-studio
];
```
