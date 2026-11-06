# NixOS flake

## Packages

### Frame

[Frame](https://framegui.app/) is available for `x86_64-linux` as `packages.x86_64-linux.frame`.

Run it directly:

```sh
nix run github:ariaofdelusion/nixos#frame
```

Install it in your profile:

```sh
nix profile install github:ariaofdelusion/nixos#frame
```

To use it from another NixOS flake, add this flake as an input:

```nix
inputs.aria-nixos.url = "github:ariaofdelusion/nixos";
```

Then include the package in your configuration:

```nix
environment.systemPackages = [
  inputs.aria-nixos.packages.${pkgs.stdenv.hostPlatform.system}.frame
];
```

### Photon Studio

[Photon Studio](https://tenzen.studio/photon/) is available for `x86_64-linux` as `packages.x86_64-linux.photon-studio`.

Run it directly:

```sh
nix run github:ariaofdelusion/nixos#photon-studio
```

Install it in your profile:

```sh
nix profile install github:ariaofdelusion/nixos#photon-studio
```

To use it from another NixOS flake, add this flake as an input:

```nix
inputs.aria-nixos.url = "github:ariaofdelusion/nixos";
```

Then include the package in your configuration:

```nix
environment.systemPackages = [
  inputs.aria-nixos.packages.${pkgs.stdenv.hostPlatform.system}.photon-studio
];
```

The flake output already allows Photon Studio's unfree license, so these examples do not need an additional unfree setting.
