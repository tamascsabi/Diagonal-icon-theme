# cursors_delete.sh

## Description

`cursors_delete.sh` allows users to remove cursor themes that are no longer needed.

Cursor themes are installed separately from the main icon theme and are not necessarily removed when an icon theme is uninstalled. This is intentional, as a user may want to keep and use a cursor theme independently of the corresponding icon theme.

Over time, this can leave unused cursor theme directories on the system.

## How It Works

The script lists the cursor themes currently installed on the system and allows the user to select the themes they want to remove.

The selected cursor theme directories are then deleted from the system.

Only the cursor themes selected by the user are removed. Other installed cursor themes remain unchanged.

## Purpose

`cursors_delete.sh` provides a simple way to clean up unused cursor themes without manually locating and deleting their directories.

It is particularly useful after removing icon themes that included cursor themes, as the cursor files may remain installed even after the associated icon theme has been removed.

The script also allows users to keep any cursor theme they still want to use independently of their installed icon themes.