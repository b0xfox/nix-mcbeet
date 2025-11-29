{
  description = "The Minecraft pack development kit.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          beet = pkgs.callPackage ./beet {
            pythonPackages = pkgs.python312Packages;
          };

          bolt = pkgs.callPackage ./bolt {
            beet = self.packages.${system}.beet;
            mecha = self.packages.${system}.mecha;
            pythonPackages = pkgs.python312Packages;
          };

          mecha = pkgs.callPackage ./mecha {
            beet = self.packages.${system}.beet;
            tokenstream = self.packages.${system}.tokenstream;
            pythonPackages = pkgs.python312Packages;
          };

          lectern = pkgs.callPackage ./lectern {
            beet = self.packages.${system}.beet;
            pythonPackages = pkgs.python312Packages;
          };

          tokenstream = pkgs.callPackage ./tokenstream {
            pythonPackages = pkgs.python312Packages;
          };
        }
      );

      overlays.default = final: prev: {
        beet = self.packages.beet;
        mecha = self.packages.beet;
        bolt = self.packages.beet;
        lectern = self.packages.beet;
        tokenstream = self.packages.tokenstream;
      };
    };
}
