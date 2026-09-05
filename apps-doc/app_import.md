# app_import.sh

## Description

`app_import.sh` creates local desktop entries for applications that use their own bundled icons instead of the system icon theme.

Some applications do not use the icon provided by the current system icon theme. Instead, their `.desktop` file references an application-specific icon, such as `hplip.png`.

The script detects these applications and creates or modifies a corresponding `.desktop` file in the user's local applications directory, allowing the application to use a matching icon from the Diagonal icon theme.

## How It Works

The script examines the desktop entries of installed applications and identifies applications that use their own icon files rather than an icon provided by the system icon theme.

When a matching icon is available in the Diagonal icon theme, the script creates a local copy of the application's `.desktop` file in:

`~/.local/share/applications/`

The local desktop entry is then modified to use the corresponding Diagonal icon.

Applications for which no matching Diagonal icon is available are left unchanged and continue to use their original desktop entries and icons.

## Purpose

`app_import.sh` provides a convenient way to integrate applications with their own bundled icons into the Diagonal icon theme.

It does not modify the original application files or installation. Instead, it uses the user's local desktop entries to override the icon used by the application.

This allows applications such as HPLIP, which normally use their own `hplip.png` icon, to use a corresponding icon from the Diagonal icon theme when one is available.