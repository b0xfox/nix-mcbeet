# nix-mcbeet

A Nix flake for packaging the [mcbeet](https://github.com/mcbeet) package set.

This includes:
 - [Beet](https://github.com/mcbeet/beet)
 - [Bolt](https://github.com/mcbeet/bolt)
 - [Mecha](https://github.com/mcbeet/mecha)
 - [Lectern](https://github.com/mcbeet/lectern)

## Flake Usage Example
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
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
    };
}


This is not an official mcbeet resource.
