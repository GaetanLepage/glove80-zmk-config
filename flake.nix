{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    glove80-zmk = {
      url = "github:moergo-sc/zmk";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    glove80-zmk
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages."x86_64-linux".default = let
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

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
