# This flake was initially generated by fh, the CLI for FlakeHub (version 0.1.9)
{
  description = "Project Template";

  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*.tar.gz";
    utility-flake.url = "https://flakehub.com/f/atomic-studio-org/Utility-Flake-Library/*.tar.gz";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
  };

  outputs = { self, flake-schemas, nixpkgs, utility-flake }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      schemas = flake-schemas.schemas;

      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixpkgs-fmt);

      checks = forEachSupportedSystem ({ pkgs }: {
        inherit (utility-flake.checks.${pkgs.system}) pre-commit-check;
      });

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = utility-flake.lib.${pkgs.system}.devShellPackages ++ (with pkgs; [ go-task melange apko ]);
        };
      });
    };
}
