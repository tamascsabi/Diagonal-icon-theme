# snap_import.sh

## Description

`snap_import.sh` imports Snap application desktop entries and replaces their default icons with icons from the **Diagonal icon theme**, when available.

Snap applications normally use their own bundled icons instead of the icons provided by the system icon theme. This script checks the Snap applications installed on the system and looks for a corresponding icon in the Diagonal icon theme.

If a matching Diagonal icon is found, the application's `.desktop` file is copied to the user's local applications directory and modified to use the corresponding Diagonal icon.

If no matching icon is available in the Diagonal icon theme, the script does not create a local desktop entry. The application therefore continues to use its default Snap desktop entry and icon.

## How It Works

The script performs the following steps:

1. Detects the Snap applications installed on the system.
2. Examines the desktop entry associated with each application.
3. Checks whether a corresponding icon is available in the Diagonal icon theme.
4. If a matching icon is found:
   - copies the `.desktop` file to `~/.local/share/applications/`;
   - changes the icon entry to use the Diagonal icon.
5. If no matching icon is found, the application is left unchanged.

## Purpose

The script provides a simple way to integrate Snap applications into the Diagonal icon theme without modifying the original Snap package or its bundled files.

Only applications for which a suitable Diagonal icon exists are imported. This prevents the creation of unnecessary local desktop entries and allows applications without a matching icon to retain their standard Snap configuration.