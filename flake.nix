{
  description = "Flake for adding the mcbeet package set";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forEachSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      beetPackages =
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          pythonPkgs = pkgs.python312Packages;

          tokenstream = pkgs.callPackage ./tokenstream {
            inherit pythonPkgs;
          };

          beet = pkgs.callPackage ./beet {
            inherit pythonPkgs;
          };

          mecha = pkgs.callPackage ./mecha {
            inherit
              beet
              pythonPkgs
              tokenstream
              ;
          };

          bolt = pkgs.callPackage ./bolt {
            inherit
              beet
              mecha
              pythonPkgs
              ;
          };

          lectern = pkgs.callPackage ./lectern {
            inherit
              beet
              pythonPkgs
              ;
          };

          addedPackages = {
            inherit
              beet
              bolt
              mecha
              lectern
              ;
          };
        in
        addedPackages;
    in
    {
      packages = forEachSystem beetPackages;

      overlays.default = final: prev: {
        inherit (self.packages.${prev.stdenv.hostPlatform.system})
          beet
          bolt
          mecha
          lectern
          ;
      };
    };
}
