#!/bin/sh
# Not a standalone file, please don't run it on its own.

. ./lib/function.sh

makelightcolor()
{
    find * -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r i
       do sed_inplace 's/5d656b/d3dae3/g' "${i}"
    done
}

makedistrofiles()
{
if [ -n "${__distro}" ]
   then _header "Creating distribution-specific \"applications\" files"
        for i in ${_basedir}/distribution/${_dist}/scalable/apps/*.svg
         do cp -a "${i}" 64x64/apps
       done
        _footer
fi
}

makedistrostatusfiles()
{
if [ -n "${__distro}" ]
   then _header "Creating distribution-specific \"status\" files"
        for kt in 16x16 22x22 24x24
         do cp -a "${_basedir}/distribution/${_dist}/${kt}/status/start-here.svg" \
         "${kt}/status/start-here.svg"
       done
       _footer
fi
}

makesymlink()
{
    find * -type d \
        \( -path '*actions' -o -path '*mimetypes' -o -path '*status' \) 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            find * -name '*.svg' ! -name '*-symbolic.svg' 2>/dev/null |
            while IFS= read -r i
               do ln -sf "${i}" "${i%.svg}-symbolic.svg"
            done
          )
     done
 }

_header "Installing the basic icon pack"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-dark"
_footer

cd "${_basefolder}" || exit 1

_header "Installing the basic folder"
mkdir -p 8x8 16x16 18x18 22x22 24x24 32x32 42x42 48x48 64x64 \
         84x84 96x96 128x128
ln -s 16x16 16x16@2x
ln -s 18x18 18x18@2x
ln -s 22x22 22x22@2x
ln -s 24x24 24x24@2x
ln -s 32x32 32x32@2x
ln -s 48x48 48x48@2x
ln -s 64x64 64x64@2x
_footer

_header "Copying base icons"
    (
     cd 64x64 || exit 1
     cp -a "${_basedir}/base/scalable/apps" .
     cp -a "${_basedir}/base/scalable/devices" .
     cp -a "${_basedir}/base/scalable/mimetypes" .
     cp -a "${_basedir}/base/scalable/places" .
     ln -s apps categories
     (
       cd apps || exit 1
          rm -r document-properties.svg
          rm -r edit-paste.svg
     )
    )
_footer

_header "Copying \"24x24\" icons"
    (
     cd 24x24 || exit 1
     cp -a "${_basedir}/base/actions/24" actions
     cp -a "${_basedir}/wm/mate/24x24/animations" .
     cp -a "${_basedir}/base/emblems/24" emblems
     ln -s ../22x22/emotes .
     cp -a "${_basedir}/base/mimetypes/24" mimetypes
     cp -a "${_basedir}/base/status/24" status
     ln -s status panel
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s ../64x64/devices .
     ln -s ../64x64/places .
     (
       cd status || exit 1
          rm -r blueman.svg
     )
    )
_footer

_header "Copying \"22x22\" icons"
    (
     cd 22x22 || exit 1
     cp -a "${_basedir}/base/actions/22" actions
     cp -a "${_basedir}/base/emblems/22" emblems
     cp -a "${_basedir}/base/emotes/22" emotes
     cp -a "${_basedir}/base/mimetypes/22" mimetypes
     cp -a "${_basedir}/base/status/22" status
     ln -s status panel
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s ../64x64/devices .
     ln -s ../64x64/places .
     ln -s ../24x24/animations .
     (
       cd status || exit 1
          rm -r blueman.svg
     )
    )
_footer

_header "Copying \"16x16\" icons"
    (
     cd 16x16 || exit 1
     cp -a "${_basedir}/base/actions/16" actions
     cp -a "${_basedir}/base/devices/16" devices
     cp -a "${_basedir}/base/emblems/16" emblems
     cp -a "${_basedir}/base/mimetypes/16" mimetypes
     cp -a "${_basedir}/base/places/16" places
     cp -a "${_basedir}/base/status/16" status
     cp -a "${_basedir}/wm/mate/16x16/symbolic" .
     ln -s symbolic symbolic-up-to-20
     ln -s ../22x22/emotes .
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s status panel
     (
       cd status || exit 1
          rm -r blueman.svg
     )
     (
      cd symbolic || exit 1
         mkdir -p actions
         cp -a "${_basedir}/base/apps/16" apps
         ln -s apps categories
         mkdir -p devices
         mkdir -p mimetypes
         mkdir -p places
         mkdir -p status
     )
    )
_footer

_header "Copying \"8x8\" icons"
    (
     cd 8x8 || exit 1
     ln -s ../16x16/emblems .
    )
_footer

_header "Copying \"18x18\" icons"
    (
     cd 18x18 || exit 1
     ln -s ../16x16/actions .
    )
_footer

_header "Copying \"32x32\" icons"
    (
     cd 32x32 || exit 1
     cp -a "${_basedir}/base/actions/32" actions
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s ../64x64/devices .
     ln -s ../24x24/emblems .
     ln -s ../22x22/emotes .
     ln -s ../64x64/mimetypes .
     ln -s ../64x64/places .
    )
_footer

_header "Copying \"42x42\" icons"
    (
     cd 42x42 || exit 1
     ln -s ../64x64/apps .
    )
_footer

_header "Copying \"48x48\" icons"
    (
     cd 48x48 || exit 1
     cp -a "${_basedir}/wm/mate/48x48/actions" .
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s ../64x64/devices .
     ln -s ../24x24/emblems .
     ln -s ../22x22/emotes .
     ln -s ../64x64/mimetypes .
     ln -s ../64x64/places .
    )
_footer

_header "Copying \"84x84\" icons"
    (
     cd 84x84 || exit 1
     ln -s ../64x64/apps .
    )
_footer

_header "Copying \"96x96\" icons"
    (
     cd 96x96 || exit 1
     ln -s ../64x64/apps .
     ln -s ../64x64/devices .
     ln -s ../64x64/mimetypes .
     ln -s ../64x64/places .
    )
_footer

_header "Copying \"128x128\" icons"
    (
     cd 128x128 || exit 1
     ln -s ../64x64/apps .
     ln -s ../64x64/devices .
     ln -s ../64x64/mimetypes .
     ln -s ../64x64/places .
    )
_footer

makedistrofiles
makedistrostatusfiles

_header "Creating symbolic links to the \"16x16\" folders"
  (
     cd 16x16 || exit 1
         find * -type d \
        \( -path '*actions' -o -path '*devices' -o -path '*mimetypes' \
        -o -path '*places' -o -path '*status' \) ! -path '*symbolic/*' 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            find * -name '*.svg' ! -name '*-symbolic.svg' 2>/dev/null |
            while IFS= read -r i
               do ln -sf "${i}" "${i%.svg}-symbolic.svg"
            done
          )
     done
  )
_footer

_header "Creating symbolic links to the \"22x22\" folders"
  (
     cd 22x22 || exit 1
     makesymlink
  )
_footer

_header "Creating symbolic links to the \"24x24\" folders"
  (
     cd 24x24 || exit 1
     makesymlink
  )
_footer

_header "Creating symbolic links to the \"32x32\" folders"
  (
     cd 32x32/actions || exit 1
        find * -name '*.svg' ! -name '*-symbolic.svg' 2>/dev/null |
            while IFS= read -r i
               do ln -sf "${i}" "${i%.svg}-symbolic.svg"
            done
  )
_footer

_header "Creating symbolic links to the \"symbolic/actions\" folders"
  (
     cd 16x16/symbolic/actions || exit 1
        find ../../actions -name '*-symbolic.svg' 2>/dev/null |
        while IFS= read -r file
           do ln -s "${file}" .
         done
  )
_footer

_header "Creating symbolic links to the \"symbolic/apps\" folders"
  (
     cd 16x16/symbolic/apps || exit 1
        find * -name '*.svg' ! -name '*-symbolic.svg' 2>/dev/null |
        while IFS= read -r file
           do ln -s "${file}" ${file%.svg}-symbolic.svg
         done
  )
_footer

_header "Creating symbolic links to the \"symbolic/devices\" folders"
  (
     cd 16x16/symbolic/devices || exit 1
        find ../../devices -name '*-symbolic.svg' 2>/dev/null |
        while IFS= read -r file
           do ln -s "${file}" .
         done
  )
_footer

_header "Creating symbolic links to the \"symbolic/mimetypes\" folders"
  (
     cd 16x16/symbolic/mimetypes || exit 1
        find ../../mimetypes -name '*-symbolic.svg' 2>/dev/null |
        while IFS= read -r file
           do ln -s "${file}" .
         done
  )
_footer

_header "Creating symbolic links to the \"symbolic/places\" folders"
  (
     cd 16x16/symbolic/places || exit 1
        find ../../places -name '*-symbolic.svg' 2>/dev/null |
        while IFS= read -r file
           do ln -s "${file}" .
         done
  )
_footer

_header "Creating symbolic links to the \"symbolic/status\" folders"
  (
     cd 16x16/symbolic/status || exit 1
        find ../../status -name '*-symbolic.svg' 2>/dev/null |
        while IFS= read -r file
           do ln -s "${file}" .
         done
  )
_footer

makelightcursor

for files in AUTHORS COPYING README.md diagonal-release
    do cp -a "${_basedir}/${files}" .
  done

cp -a "${_basedir}/wm/mate/index.theme" .
sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}/g" index.theme

cd "../Diagonal${__wmtype}${__distro}-dark" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a dark theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"

_header "Installing the basic folder"
mkdir -p 16x16 16x16/symbolic 18x18 22x22 24x24 32x32
ln -s "../Diagonal${__wmtype}${__distro}/8x8" .
ln -s "../Diagonal${__wmtype}${__distro}/42x42" .
ln -s "../Diagonal${__wmtype}${__distro}/48x48" .
ln -s "../Diagonal${__wmtype}${__distro}/64x64" .
ln -s "../Diagonal${__wmtype}${__distro}/84x84" .
ln -s "../Diagonal${__wmtype}${__distro}/96x96" .
ln -s "../Diagonal${__wmtype}${__distro}/128x128" .
ln -s 16x16 16x16@2x
ln -s 18x18 18x18@2x
ln -s 22x22 22x22@2x
ln -s 24x24 24x24@2x
ln -s 32x32 32x32@2x
ln -s 48x48 48x48@2x
ln -s 64x64 64x64@2x
_footer


_header "Copying \"24x24\" icons"
    (
     cd 24x24 || exit 1
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/actions" .
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/animations" .
     ln -s "../../Diagonal${__wmtype}${__distro}/24x24/emblems" .
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/mimetypes" .
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/status" .
     ln -s status panel
     ln -s "../64x64/apps" .
     ln -s apps categories
     ln -s ../64x64/devices .
     ln -s "../../Diagonal${__wmtype}${__distro}/24x24/emotes" .
     ln -s ../64x64/places .
    )
_footer

_header "Copying \"22x22\" icons"
    (
     cd 22x22 || exit 1
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/actions" .
     ln -s ../24x24/animations .
     ln -s "../64x64/apps" .
     ln -s apps categories
     ln -s ../64x64/devices .
     ln -s "../../Diagonal${__wmtype}${__distro}/22x22/emblems" .
     ln -s "../../Diagonal${__wmtype}${__distro}/22x22/emotes" .
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/mimetypes" .
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/status" .
     ln -s status panel
     ln -s ../64x64/places .
    )
_footer

_header "Copying \"16x16\" icons"
    (
     cd 16x16 || exit 1
     cp -a "../../Diagonal${__wmtype}${__distro}/16x16/actions" .
     ln -s "../64x64/apps" .
     ln -s apps categories
     cp -a "../../Diagonal${__wmtype}${__distro}/16x16/devices" .
     ln -s "../../Diagonal${__wmtype}${__distro}/16x16/emblems" .
     ln -s ../22x22/emotes .
     cp -a "../../Diagonal${__wmtype}${__distro}/16x16/mimetypes" .
     cp -a "../../Diagonal${__wmtype}${__distro}/16x16/places" .
     cp -a "../../Diagonal${__wmtype}${__distro}/16x16/status" .
     ln -s status panel
     ln -s symbolic symbolic-up-to-20
    (
      cd symbolic || exit 1
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/actions" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/apps" .
         ln -s apps categories
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/devices" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/emblems" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/emotes" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/mimetypes" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/places" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/status" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/up-to-32" .
     )
    )
_footer

_header "Copying \"18x18\" icons"
    (
     cd 18x18 || exit 1
        ln -s ../16x16/actions .
    )
_footer

_header "Copying \"32x32\" icons"
    (
     cd 32x32 || exit 1
     cp -a "../../Diagonal${__wmtype}${__distro}/32x32/actions" .
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s ../64x64/devices .
     ln -s ../24x24/emblems .
     ln -s ../22x22/emotes .
     ln -s ../64x64/mimetypes .
     ln -s ../64x64/places .
    )
_footer

_header "Colorize \"16x16\" icons"
    (
      cd 16x16 || exit 1
      find * -type d \
        \( -path '*actions' -o -path '*mimetypes' \
        -o -path '*devices' -o -path '*status' -o -path '*places' \) 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            makelightcolor
          )
     done

    )
_footer

_header "Colorize \"22x22\" icons"
    (
      cd 22x22 || exit 1
      find * -type d \
        \( -path '*actions' -o -path '*mimetypes' \
        -o -path '*status' \) 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            makelightcolor
          )
     done

    )
_footer

_header "Colorize \"24x24\" icons"
    (
      cd 24x24 || exit 1
      find * -type d \
        \( -path '*actions' -o -path '*mimetypes' \
        -o -path '*status' -o -path '*animations' \) 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            makelightcolor
          )
     done

    )
_footer

_header "Colorize \"32x32\" icons"
    (
      cd 32x32 || exit 1
      find * -type d -path '*actions' 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            makelightcolor
          )
     done

    )
_footer

_header "Colorize \"symbolic/apps\" icons"
    (
      cd 16x16/symbolic/apps || exit 1
          makelightcolor
    )
_footer

_header "Colorize \"symbolic/emblems\" icons"
    (
      cd 16x16/symbolic/emblems || exit 1
          makelightcolor
    )
_footer

_header "Colorize \"symbolic/emotes\" icons"
    (
      cd 16x16/symbolic/emotes || exit 1
          makelightcolor
    )
_footer

_header "Colorize \"symbolic/up-to-32\" icons"
    (
      cd 16x16/symbolic/up-to-32 || exit 1
          makelightcolor
    )
_footer

makedarkcursor

for files in AUTHORS COPYING README.md index.theme diagonal-release
    do cp -a "../Diagonal${__wmtype}${__distro}/${files}" .
  done
  sed_inplace "s/Diagonal${__wmtype}${__distro}/Diagonal${__wmtype}${__distro}-dark/g" index.theme

printf ";;; \n"
_line
printf ";;; \n"

cd "${_basefolder}" || exit 1

if [ -n "${__foldercolor}" ]
   then ( cd 64x64/places || exit 1
         makefoldercolor
        )
        (
          cd 64x64/apps || exit 1
          cp -a ../places/folder.svg .
          cp -a ../places/folder-new.svg .
          cp -a ../places/folder-system.svg filemanager-actions.svg
        )
   else ( cd 64x64/places || exit 1
         makedistrofolder
        )
        (
          cd 64x64/apps || exit 1
          cp -a ../places/folder.svg .
          cp -a ../places/folder-new.svg .
          cp -a ../places/folder-system.svg filemanager-actions.svg
        )
fi

