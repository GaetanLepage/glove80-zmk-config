# My glove80 configuration

## Usage

### Update inputs (zmk firmware, `nixpkgs`)
```sh
nix flake update
```

### Build the firmware
```sh
nix build
```
Resulting firmware is located in `./result/glove80.uf2`.

### Flash the firmware

1. Run `udiskie`
1. Plug the right half in bootloader mode
1. Run command `flash`
1. Unplug right half
1. Plug the left half in bootloader mode
1. Run command `flash`

Done !


## Resources

- [French (Standard, AZERTY) Layout](https://kbdlayout.info/kbdfrna?arrangement=ISO105)
- [HID Usages and Descriptions](https://usb.org/sites/default/files/hut1_2.pdf#page=83)
- [ZMK: keyboard keypad](https://zmk.dev/docs/codes/keyboard-keypad)
- [ZMK cheat sheet](https://peccu.github.io/zmk-cheat-sheet/)
