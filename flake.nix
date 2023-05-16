{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages."x86_64-linux".default = let
      firmwareSource = pkgs.fetchFromGitHub {
        owner = "moergo-sc";
        repo = "zmk";
        rev = "2a7f8d22273cc057b97a8a04b5ec0e5dc2a89aba";
        hash = "sha256-dqDjXkG8PuLz9w6VG/uelujsdSmGsenqfmH2DGFlZlo=";
      };

      firmware = import firmwareSource {inherit pkgs;};

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
