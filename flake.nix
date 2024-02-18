{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    glove80-zmk = {
      url = "github:moergo-sc/zmk";
      flake = false;
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    glove80-zmk,
    flake-parts,
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        packages.default = let
          firmware = import glove80-zmk {inherit pkgs;};

          keymap = ./glove80.keymap;

          glove80_left = firmware.zmk.override {
            board = "glove80_lh";
            inherit keymap;
          };

          glove80_right = firmware.zmk.override {
            board = "glove80_rh";
            inherit keymap;
          };
        in
          firmware.combine_uf2 glove80_left glove80_right;

        formatter = pkgs.alejandra;
      };
    };
}
