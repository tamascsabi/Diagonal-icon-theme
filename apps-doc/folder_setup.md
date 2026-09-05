# folder_setup.sh

## Description

`folder_setup.sh` allows users to change the color scheme of the folder icons after installing the Diagonal icon theme.

If a user decides to change the folder color after installation, there is no need to run the main installer again. This script can be used to apply a different folder color directly.

## Available Color Schemes

The script supports the standard folder color schemes available during the Diagonal icon theme installation, as well as additional distribution-specific color schemes.

For example, users who prefer the openSUSE color scheme can select it to give the folder icons the colors used by the default openSUSE desktop environment.

The available color schemes may include:

- Standard Diagonal folder colors
- Distribution-specific color schemes
- Other color variants provided by the theme

## How It Works

The script recolors the folder icons and their contents according to the selected color scheme.

The selected colors are applied to the existing Diagonal folder icons, allowing users to change the appearance of their installed icon theme without reinstalling or running the main installation script again.

## Usage

Run the script and select the desired folder color scheme.

The selected color scheme is then applied to the Diagonal folder icons.

## Purpose

`folder_setup.sh` provides a convenient way to customize the appearance of folder icons independently from the main Diagonal icon theme installation.

This makes it easy to experiment with different color schemes or switch to a distribution-specific appearance at any time.

## How It Works

The script always starts from the original folder icons stored in the default `places` directory.

When a color scheme is selected, all folder icons are copied from the default `places` directory and then recolored according to the selected scheme.

This means that every color change starts from the original icons rather than from a previously recolored version. The user can therefore switch between color schemes as often as desired without gradually accumulating or mixing colors from previous selections.

For example, a user can switch from red to green and later to an openSUSE-inspired color scheme. Each time, the icons are recreated from the original source files, ensuring a clean and consistent result.
