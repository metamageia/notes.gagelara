{
  description = "Quartz static site development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
            pkgs.yarn
          ];
          shellHook = ''
            echo "Welcome to the Quartz development environment!"
            echo "Run 'npm i' to install dependencies."
            echo "Run 'npx quartz create' to init quartz."
            echo "Run 'npx quartz build --serve' to build and test site."
            echo "Run 'npx quartz sync --no-pull' to update GitHub pages."
          '';
        };
      });
}
