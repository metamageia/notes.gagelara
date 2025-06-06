Flakes have multiple functions, but their primary use is to lock individual packages (or your entire system) to an explicitly defined version to maximize the stability and reproducibility of your system. By default NixOS package versions are managed via "Channels", wherein package version information is stored outside of your configuration file(s). Flakes, however, store all version information in a generated `flake.lock` file in your configuration directory, guaranteeing your system will use the same package versions defined by your Flake every time you rebuild your system. 

The generated `flake.lock` can be versioned via a version control solution like Git to effectively create a time machine for your machine. 

---
[[NixOS]]
[[Nix]]