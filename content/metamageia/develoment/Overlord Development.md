# [Overlord Version 2.0](https://metamageia.github.io/overlord/)

After doing a significant refactor of the project's codebase I'm excited to finally share the first full version update, including some new features.

## New Features
### Added Progressive Web App (PWA) Functionality:
- Overlord can now be installed as its own app through your browser & used offline. 
### Statblock Components 
- Features and Deeds can be saved as a component for later use in other statblocks from the UI Editor in the left sidebar use the "Save Component" button next to the individual block. 
	- Currently three component types: Features, Deeds, and Presets
- Added a Components tab to the right sidebar
	- You can now browse, preview, and apply saved Deeds and Features to the current statblock from a library of "Statblock Components"
	- Multiple Components can be selected, previewed, and applied simultaneously. 
	- Multiple selected Components can be combined & saved into a single "Preset" Component, which allows you to quickly apply both features and deeds to a Statblock.
- Bundle Compatibility. You can also add Statblock Components to a Statblock Bundle for export & import.
### Core Statblock Bundles
- All core Trespasser statblock bundles are now available from the UI. Go to Bundles -> Upload, and select on the the core bundles to add to library. Current options are the Core Rulebook statblocks, The Laughing Hound statblocks, and the core monster Role templates. Once added to the library they can be toggled, merged, or deleted like any other bundle - and will always be available in the Upload tab if you need to re-add them to your library in the future. 
### Descriptions 
- A small but useful feature: Added an optional multi-line "Description" field to the top of statblocks for miscellaneous text - such as flavor text to be read aloud to players, tactics notes for the Judge, statblock author name, or whatever else you'd like to include. 

---
## Tweaks
- Did a significant refactor of the codebase - so if some new bugs may have slipped through the cracks. If you find anything broken *please* let me know.
- UI Editor
	- You can now reorder Deeds & Features, including individual deed lines, in the UI Editor. Also changed the layout of deed lines in the editor to feel a little less cramped. 
- Statblock Render
	- Only shows the "Role" field if a role has been selected, for statblocks where a role isn't needed.
	- The "-" separator in the title bar only displays if there is a Role, Template, or Level in the statblock data.

--

### DOing




---

## Overlord 2.1

### Urgent
- Fix PDF Export to properly show entire statblock
	- Temporarily disabled

### UI Changes
- Dynamically Extend left and right sidebars to the bottom of the viewport at all scroll positions

### Mobile
- Fix TR placement on mobile
- Swipe gesture to move sidebars

### QOL

- Traits
	- Tags in Statblock YAML
- Tags
	- Tags in Library Data

### Features
