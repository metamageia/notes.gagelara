## Introduction
NixOS is A FOSS [[Linux Distribution]] based on the [[Nix Package Manager]]. It's built on the principles of immutability, atomic updates, and strictly declarative system configuration allowing for extremely reliable reproducibility and portability. 

### Useful NixOS Resources
- [Search Nix packages](https://search.nixos.org/packages )
- [Search options for NixOS & Home-manager configs](https://mynixos.com )
- [Interesting QOL tools for NixOS](https://youtu.be/DnA4xNTrrqY?si=ab6XLQEUieB8_zw1)I should consider integrating into my flake.
- Might be worthwhile to look into [Snowflakes](https://snowflakeos.org/), a flavor of NixOS focusing on ease of use. 

---
## Configuration Basics
Starting from initial installation, the entirety of NixOS is managed by two configuration files: `hardware-configuration.nix` for managing drivers and other hardware related tasks, and `configuration.nix` for everything else. Both are generated automatically when NixOS is installed, and for most users only the later needs to be modified. 

Configuration files are created by default in the `/etc/nixos/` directory, and can be copied and moved for the sake of creating multiple configurations or changing its location for backup and version control. 

As of NixOS 19.03 the default configuration file can be edited with the command `sudo nixos-rebuild edit`, and the new changes finalized with `sudo nixos-rebuild switch`.

When using Nix Flakes, a topic that'll be expanded on later, a system rebuild can be initiated by appending the `--flake /path/to/flake.nix` flag to the command.

```ad-example
The command `sudo nixos-rebuild switch --flake .` will build the system based on the file named flake.nix in the current directory.

```
---

### Remote Rebuild:
`nixos-rebuild switch --flake .#auriga --target-host metamageia@auriga --sudo --ask-sudo-password`

`nixos-rebuild switch --flake .#auriga --target-host root@auriga`

`nixos-rebuild switch --flake .#beacon --target-host root@192.168.100.1`


---
## [[Nix Flakes]]
## [[Home-Manager]]

---
[[Free and Open Source Software (FOSS)]]
[[Linux]]
[[Nix]]