# nix-mcbeet

A Nix flake for packaging the [mcbeet](https://github.com/mcbeet) package set.

This includes:
 - [Beet](https://github.com/mcbeet/beet)
 - [Bolt](https://github.com/mcbeet/bolt)
 - [Mecha](https://github.com/mcbeet/mecha)
 - [Lectern](https://github.com/mcbeet/lectern)

## Flake Usage Example
```nix
{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mcbeet.url = "github:b0xfox/nix-mcbeet";
  };

  outputs =
    { self, nixpkgs, mcbeet, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ mcbeet.overlays.default ];
      };
    in
    {
      nixosConfigurations = {
        <your hostname> = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          inherit inputs;
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
    };
}

```

The overlay will allow you to add a mcbeet package (beet, bolt, mecha or lectern) to either your enviroment.systemPackages or home.packages just like any other packages
```nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    beet
    bolt
    mecha
    lectern
  ];
}
```

Alternatively, you can also add the exposed packages directly
```nix
{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.mcbeet.packages.${system}.beet
    inputs.mcbeet.packages.${system}.bolt
    inputs.mcbeet.packages.${system}.mecha
    inputs.mcbeet.packages.${system}.lectern
  ];
}
```


This is not an official mcbeet resource.
