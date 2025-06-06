When a NixOS system rebuild fails to complete for any reason, such as user interruption, the following error may occur on subsequent rebuilds:
```
Failed to start transient service unit: Unit nixos-rebuild-switch-to-configuration.service was already loaded or has a fragment file.
Could not acquire lock
```
The fix for this issue is to stop the lingering systemd service:
```
sudo systemctl stop nixos-rebuild-switch-to-configuration.service
```
Then rebuild the system as normal:
```
sudo nixos-rebuild switch --flake .
```

---

[[NixOS]]
[[Nix Flakes]]

