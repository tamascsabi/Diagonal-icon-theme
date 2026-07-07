#!/bin/sh
# Not a standalone file, please don't run it on its own.

. ./lib/function.sh

makedistrofiles()
{
if [ -n "${__distro}" ]
   then _header "Creating distribution-specific files"
        cp -a "${_basedir}/distribution/${_dist}/scalable/apps" 48x48
        _footer
fi
}

makedistrostatusfiles()
{
if [ -n "${__distro}" ]
   then _header "Creating distribution-specific status files"
        for kt in 16x16 22x22 24x24
         do cp -a "${_basedir}/distribution/${_dist}/${kt}" .
       done
       _footer
fi
}

makestatusmenulightcolor()
{
if [ -n "${__distro}" ]
   then _header "Colorize status files for a light theme"
        find * -type d \( -path '16x16/status' -o -path '22x22/status'\
                       -o -path '24x24/status' \) 2>/dev/null |
        while IFS= read -r dir
           do
         (
           cd "${dir}" || exit 1
           find * -type f -name 'start-here.svg' 2>/dev/null |
           while IFS= read -r i
              do sed_inplace 's/5d656b/d3dae3/g' "${i}"
            done
         )
         done
        _footer
fi
}

makestatuslightcolor() {
    _header "Colorize status files for a light theme"
    find * -type d \( -path '16x16/status' -o -path '22x22/status'\
                       -o -path '24x24/status' \) 2>/dev/null |
    while IFS= read -r dir
       do
         (
           cd "${dir}" || exit 1
           find * -type f -name '*.svg' 2>/dev/null |
           while IFS= read -r i
              do sed_inplace 's/5d656b/d3dae3/g' "${i}"
            done
         )
     done
     _footer
}

_header "Installing the basic icon pack"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-light"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-dark"
_footer

cd "${_basefolder}" || exit 1

_header "Installing the basic folder"
mkdir -p 16x16 22x22 24x24 32x32 48x48 256x256 scalable scalable-max-32
ln -s 16x16 16x16@2x
ln -s 22x22 22x22@2x
ln -s 24x24 24x24@2x
ln -s 32x32 32x32@2x
ln -s 48x48 48x48@2x
ln -s 256x256 256x256@2x
_footer

_header "Copying base icons"
    (
     cd 48x48 || exit 1
     cp -a "${_basedir}/base/scalable/apps" .
     cp -a "${_basedir}/base/scalable/devices" .
     cp -a "${_basedir}/base/scalable/mimetypes" .
     cp -a "${_basedir}/base/scalable/places" .
     ln -s apps categories
    )
_footer

_header "Copying \"16x16\" icons"
    (
     cd 16x16 || exit 1
     cp -a "${_basedir}/base/actions/16" actions
     cp -a "${_basedir}/base/apps/16/" apps
     cp -a "${_basedir}/base/devices/16" devices
     cp -a "${_basedir}/base/emblems/16" emblems
     cp -a "${_basedir}/base/mimetypes/16" mimetypes
     cp -a "${_basedir}/base/places/16" places
     cp -a "${_basedir}/wm/gnome/16x16/status" .
     ln -s status panel
     ln -s apps categories
    )
_footer

_header "Copying \"22x22\" icons"
    (
     cd 22x22 || exit 1
     cp -a "${_basedir}/base/actions/22" actions
     cp -a "${_basedir}/base/devices/22" devices
     cp -a "${_basedir}/base/emblems/22" emblems
     cp -a "${_basedir}/base/mimetypes/22" mimetypes
     cp -a "${_basedir}/base/places/22" places
     cp -a "${_basedir}/wm/gnome/22x22/status" .
     ln -s status panel
     ln -s ../16x16/apps apps
     ln -s ../16x16/categories categories
    )
_footer

_header "Copying \"24x24\" icons"
    (
     cd 24x24 || exit 1
     cp -a "${_basedir}/base/actions/24" actions
     cp -a "${_basedir}/base/devices/24" devices
     cp -a "${_basedir}/base/emblems/24" emblems
     cp -a "${_basedir}/base/mimetypes/24" mimetypes
     cp -a "${_basedir}/base/places/24" places
     cp -a "${_basedir}/wm/gnome/24x24/status" .
     cp -a "${_basedir}/wm/gnome/24x24/animations" .
     ln -s status panel
     ln -s ../16x16/apps apps
     ln -s ../16x16/categories categories
    )
_footer

_header "Copying \"32x32\" icons"
    (
     cd 32x32 || exit 1
     cp -a "${_basedir}/base/actions/32" actions
     cp -a "${_basedir}/wm/gnome/32x32/status" .
     ln -s ../48x48/apps apps
     ln -s ../48x48/devices devices
     ln -s ../48x48/mimetypes mimetypes
     ln -s ../48x48/places places
     ln -s ../48x48/categories categories
     ln -s ../24x24/emblems emblems
    )
_footer

_header "Copying \"256x256\" icons"
    (
     cd 256x256 || exit 1
     ln -s ../48x48/apps apps
     ln -s ../48x48/devices devices
     ln -s ../48x48/mimetypes mimetypes
     ln -s ../48x48/places places
     ln -s ../48x48/categories categories
    )
_footer

_header "Copying \"scalable\" icons"
    (
     cd scalable || exit 1
     for i in $(find "${_basedir}/wm/gnome/scalable/" -mindepth 1 -type d)
      do cp -a "${i}" .
    done
     mkdir -p actions devices places status mimetypes
     ln -s apps categories
    )
_footer

_header "Copying \"scalable-32\" icons"
     cp -ar "${_basedir}/wm/gnome/scalable-max-32/" .
_footer

makestatuslightcolor

_header "Creating symbolic icons"
    (
     cd scalable/actions || exit 1
     for i in ../../16x16/actions/*.svg
      do ln -s "$i" "$(basename "$i" .svg)-symbolic.svg"
    done
    )
    (
     cd scalable/devices || exit 1
     for i in ../../16x16/devices/*.svg
      do ln -s "$i" "$(basename "$i" .svg)-symbolic.svg"
    done
    )
    (
     cd scalable/mimetypes || exit 1
     for i in ../../16x16/mimetypes/*.svg
      do ln -s "$i" "$(basename "$i" .svg)-symbolic.svg"
    done
    )
    (
     cd scalable/places || exit 1
     for i in ../../16x16/places/*.svg
      do ln -s "$i" "$(basename "$i" .svg)-symbolic.svg"
    done
    )
    (
     cd scalable/status || exit 1
     for i in ../../16x16/status/*.svg
      do ln -s "$i" "$(basename "$i" .svg)-symbolic.svg"
    done
    )
_footer

for files in AUTHORS COPYING README.md diagonal-release
    do cp -a "${_basedir}/${files}" .
  done
cp -a "${_basedir}/wm/gnome/index.theme" .
sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}/g" index.theme

makelightcursor
makedistrofiles
makedistrostatusfiles
makestatusmenulightcolor

cd "../Diagonal${__wmtype}${__distro}-dark" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a dark theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"

_header "Installing the basic folder"
mkdir -p 16x16 22x22 24x24 32x32 48x48 256x256 scalable scalable-max-32
ln -s 16x16 16x16@2x
ln -s 22x22 22x22@2x
ln -s 24x24 24x24@2x
ln -s 32x32 32x32@2x
ln -s 48x48 48x48@2x
ln -s 256x256 256x256@2x
_footer

_header "Copying the basic \"16x16\" folders"
   (
     cd 16x16 || exit 1
     for dir in actions apps devices mimetypes places
       do cp -a "../../Diagonal${__wmtype}${__distro}/16x16/${dir}" .
     done
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/status" status
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/emblems" emblems
     ln -sf status panel
     ln -sf apps categories
    )
_footer

_header "Colorize \"16x16\" files"
   (
     cd 16x16 || exit 1
     find * -type d ! -type l 2>/dev/null |
     while IFS= read -r dir
        do (
             cd "${dir}" || exit 1
             find * -type f -name '*.svg' 2>/dev/null |
             while IFS= read -r i
                do sed_inplace 's/5d656b/d3dae3/g' "${i}"
              done
           )
      done
    )
_footer

_header "Copying the basic \"22x22\" folders"
   (
     cd 22x22 || exit 1
     for dir in actions devices mimetypes places
       do cp -a "../../Diagonal${__wmtype}${__distro}/22x22/${dir}" .
     done
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/apps" apps
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/status" status
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/emblems" emblems
     ln -sf status panel
     ln -sf apps categories
    )
_footer

_header "Colorize \"22x22\" files"
   (
     cd 22x22 || exit 1
     find * -type d ! -type l 2>/dev/null |
     while IFS= read -r dir
        do (
             cd "${dir}" || exit 1
             find * -type f -name '*.svg' 2>/dev/null |
             while IFS= read -r i
                do sed_inplace 's/5d656b/d3dae3/g' "${i}"
              done
           )
      done
    )
_footer

_header "Copying the basic \"24x24\" folders"
   (
     cd 24x24 || exit 1
     for dir in actions animations devices mimetypes places
       do cp -a "../../Diagonal${__wmtype}${__distro}/24x24/${dir}" .
     done
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/apps" apps
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/status" status
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/emblems" emblems
     ln -sf status panel
     ln -sf apps categories
    )
_footer

_header "Colorize \"24x24\" files"
   (
     cd 24x24 || exit 1
     find * -type d ! -type l 2>/dev/null |
     while IFS= read -r dir
        do (
             cd "${dir}" || exit 1
             find * -type f -name '*.svg' 2>/dev/null |
             while IFS= read -r i
                do sed_inplace 's/5d656b/d3dae3/g' "${i}"
              done
            )
      done
    )
_footer

_header "Copying the basic \"48x48\" folders"
    (
      cd 48x48 || exit 1
      ln -sf "../../Diagonal${__wmtype}${__distro}/48x48/apps" apps
      ln -sf "../../Diagonal${__wmtype}${__distro}/48x48/devices" devices
      ln -sf "../../Diagonal${__wmtype}${__distro}/48x48/mimetypes" mimetypes
      ln -sf "../../Diagonal${__wmtype}${__distro}/48x48/places" places
      ln -sf apps categories
    )
_footer

_header "Copying the basic \"32x32\" folders"
   (
     cd 32x32 || exit 1
     cp -a "../../Diagonal${__wmtype}${__distro}/32x32/actions" actions
     ln -sf ../48x48/apps apps
     ln -sf ../48x48/devices devices
     ln -sf ../48x48/mimetypes mimetypes
     ln -sf ../48x48/places places
     ln -sf "../../Diagonal${__wmtype}${__distro}/32x32/emblems" emblems
     ln -sf "../../Diagonal${__wmtype}${__distro}/32x32/status" status
     ln -sf apps categories
   )
_footer

_header "Copying the basic \"256x256\" folders"
    (
      cd 256x256 || exit 1
      ln -sf ../48x48/apps apps
      ln -sf ../48x48/devices devices
      ln -sf ../48x48/mimetypes mimetypes
      ln -sf ../48x48/places places
      ln -sf apps categories
    )
_footer

_header "Copying the basic \"scalable\" folders"
    (
      cd scalable || exit 1
      for i in $(find "../../Diagonal${__wmtype}${__distro}/scalable/" -mindepth 1 -type d)
      do cp -a "${i}" .
     done
     ln -sf apps categories
    )
_footer

_header "Colorize \"scalable\" files"
    (
      cd scalable || exit 1
      find * -type d ! -name 'actions' ! -name 'apps' ! -name 'devices' \
                     ! -name 'mimetypes' ! -name 'places' ! -name 'status' 2>/dev/null |
      while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            find * -type f -name '*.svg' 2>/dev/null |
            while IFS= read -r i
               do sed_inplace 's/5d656b/d3dae3/g' "${i}"
             done
          )
     done
     )
_footer

_header "Copying the basic \"scalable-max-32\" folders"
    (
      cd scalable-max-32 || exit 1
      cp -a "../../Diagonal${__wmtype}${__distro}/scalable-max-32/status" status
      cd status || exit 1
      sed_inplace 's/5d656b/d3dae3/g' *.svg
    )
_footer

makedarkcursor

for files in AUTHORS COPYING README.md index.theme diagonal-release
    do cp -a "../Diagonal${__wmtype}${__distro}/${files}" .
  done
  sed_inplace "s/Diagonal${__wmtype}${__distro}/Diagonal${__wmtype}${__distro}-dark/g" index.theme

cd "../Diagonal${__wmtype}${__distro}-light" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a light theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"

_header "Installing the basic folder"
mkdir -p 16x16 22x22 24x24 scalable
ln -s 16x16 16x16@2x
ln -s 22x22 22x22@2x
ln -s 24x24 24x24@2x
_footer

_header "Copying the basic \"16x16\" folders"
   (
     cd 16x16 || exit 1
     cp -a "${_basedir}/wm/gnome/16x16/status" .
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/actions" actions
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/apps" apps
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/devices" devices
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/emblems" emblems
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/mimetypes" mimetypes
     ln -sf "../../Diagonal${__wmtype}${__distro}/16x16/places" places
     ln -sf status panel
     ln -sf apps categories
    )
_footer

_header "Copying the basic \"22x22\" folders"
   (
     cd 22x22 || exit 1
     cp -a "${_basedir}/wm/gnome/22x22/status" .
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/actions" actions
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/apps" apps
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/devices" devices
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/emblems" emblems
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/mimetypes" mimetypes
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/places" places
     ln -sf status panel
     ln -sf apps categories
    )
_footer

_header "Copying the basic \"24x24\" folders"
   (
     cd 24x24 || exit 1
     cp -a "${_basedir}/wm/gnome/24x24/status" .
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/actions" actions
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/animations" animations
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/apps" apps
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/devices" devices
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/emblems" emblems
     ln -sf "../../Diagonal${__wmtype}${__distro}/24x24/mimetypes" mimetypes
     ln -sf "../../Diagonal${__wmtype}${__distro}/22x22/places" places
     ln -sf status panel
     ln -sf apps categories
    )
_footer

ln -s "../Diagonal${__wmtype}${__distro}/48x48" 48x48
ln -s 48x48 48x48@2x

ln -s "../Diagonal${__wmtype}${__distro}/32x32" 32x32
ln -s 32x32 32x32@2x

ln -s "../Diagonal${__wmtype}${__distro}/256x256" 256x256
ln -s 256x256 256x256@2x

_header "Copying the basic \"scalable\" folders"
    (
      cd scalable || exit 1
      for i in $(find "../../Diagonal${__wmtype}${__distro}/scalable/" -mindepth 1 -type d ! -name 'status')
       do ln -s "${i}" "$(basename "$i")"
     done
     cp -a "../../Diagonal${__wmtype}${__distro}/scalable/status" status
     ln -s apps categories

    )
_footer

_header "Colorize \"scalable\" files"
   (
     cd scalable || exit 1
     find * -type d -name 'status' l 2>/dev/null |
     while IFS= read -r dir
        do (
             cd "${dir}" || exit 1
             find * -type f -name '*.svg' 2>/dev/null |
             while IFS= read -r i
                do sed_inplace 's/d3dae3/5d656b/g' "${i}"
              done
            )
      done
    )
_footer

ln -s "../Diagonal${__wmtype}${__distro}/scalable-max-32" scalable-max-32

for files in AUTHORS COPYING README.md index.theme diagonal-release
    do cp -a "../Diagonal${__wmtype}${__distro}/${files}" .
  done
  sed_inplace "s/Diagonal${__wmtype}${__distro}/Diagonal${__wmtype}${__distro}-light/g" index.theme

ln -sf "../Diagonal${__wmtype}${__distro}/cursors" cursors

makedistrostatusfiles

cd "${_basefolder}" || exit 1

if [ -n "${__foldercolor}" ]
   then ( cd 48x48/places || exit 1
         makefoldercolor
        )
        (
          cd 48x48/apps || exit 1
          cp -a ../places/folder.svg .
          cp -a ../places/folder-new.svg .
          cp -a ../places/folder-system.svg filemanager-actions.svg
        )
   else ( cd 48x48/places || exit 1
         makedistrofolder
        )
        (
          cd 48x48/apps || exit 1
          cp -a ../places/folder.svg .
          cp -a ../places/folder-new.svg .
          cp -a ../places/folder-system.svg filemanager-actions.svg
        )
fi



