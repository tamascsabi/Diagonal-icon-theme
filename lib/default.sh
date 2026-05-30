#!/bin/sh
# Not a standalone file, please don't run it on its own.

. ./lib/function.sh

makesymlink()
{
    find * -type d ! -type l \
        ! -name 'emblems' ! -name 'animations' ! -name 'emotes' 2>/dev/null |
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

lightcolor()
{
    find * -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r i
       do sed_inplace 's/5d656b/d3dae3/g' "${i}"
    done
}

darkcolor()
{
    find * -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r i
       do sed_inplace 's/d3dae3/5d656b/g' "${i}"
    done
}

makelightcolor()
{
    find * -type d ! -name 'emblems' ! -name 'emotes' 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            lightcolor
          )
     done
}

makeapplinks()
{
    find ../../scalable/apps -name '*.svg' 2>/dev/null |
    while IFS= read -r file
       do ln -s "${file}" .
     done
}

makedistrofiles()
{
if [ -n "${__distro}" ]
   then _header "Creating distribution-specific \"applications\" files"
        for i in ${_basedir}/distribution/${_dist}/scalable/apps/*.svg
         do cp -a "${i}" scalable/apps
       done
        _footer
fi
}

makedistrostatusfiles()
{
if [ -n "${__distro}" ]
   then _header "Creating distribution-specific \"status\" files"
        for kt in 16 22 24 32
         do cp -a "${_basedir}/distribution/${_dist}/${kt}/status/start-here.svg" \
         "${kt}/status/start-here.svg"
       done
       _footer
fi
}

_header "Installing the basic icon pack"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-light"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-dark"
_footer

cd "${_basefolder}" || exit 1

_header "Installing the basic folder"
mkdir -p 8 12 16 22 24 32 48 64 96 128 256 scalable symbolic
ln -s 16 16@2x
ln -s 22 22@2x
ln -s 24 24@2x
ln -s 32 32@2x
_footer

_header "Copying base icons"
    (
     cd scalable || exit 1
     cp -a "${_basedir}/base/scalable/apps" .
     cp -a "${_basedir}/base/scalable/devices" .
     cp -a "${_basedir}/base/scalable/mimetypes" .
     cp -a "${_basedir}/base/scalable/places" .
     ln -s apps categories
     ln -s apps applets
     ln -s apps preferences
    )
_footer

_header "Copying \"12\" icons"
    (
     cd 12 || exit 1
     cp -a "${_basedir}/base/actions/12" actions
    )
_footer

_header "Copying \"16\" icons"
    (
     cd 16 || exit 1
     cp -a "${_basedir}/base/actions/16" actions
     cp -a "${_basedir}/wm/kde/animations/16" animations
     cp -a "${_basedir}/wm/kde/applets/16" applets
     cp -a "${_basedir}/base/apps/16" apps
     ln -s apps categories
     cp -a "${_basedir}/base/devices/16" devices
     cp -a "${_basedir}/base/emblems/16" emblems
     ln -s ../22/emotes
     cp -a "${_basedir}/base/mimetypes/16" mimetypes
     cp -a "${_basedir}/base/places/16" places
     cp -a "${_basedir}/base/status/16" status
     ln -s status panel
    )
_footer

_header "Copying \"8\" icons"
    (
     cd 8 || exit 1
     ln -s ../16/emblems .
    )
_footer

_header "Copying \"22\" icons"
    (
     cd 22 || exit 1
     cp -a "${_basedir}/base/actions/22" actions
     cp -a "${_basedir}/wm/kde/animations/22" animations
     cp -a "${_basedir}/wm/kde/applets/22" applets
     cp -a "${_basedir}/base/devices/22" devices
     cp -a "${_basedir}/base/emblems/22" emblems
     cp -a "${_basedir}/base/emotes/22" emotes
     cp -a "${_basedir}/base/mimetypes/22" mimetypes
     cp -a "${_basedir}/base/places/22" places
     cp -a "${_basedir}/base/status/22" status
     ln -s status panel
    )
_footer

_header "Copying \"24\" icons"
    (
     cd 24 || exit 1
     cp -a "${_basedir}/base/actions/24" actions
     cp -a "${_basedir}/wm/mate/24x24/animations" animations
     cp -a "${_basedir}/wm/kde/applets/24" applets
     cp -a "${_basedir}/base/devices/24" devices
     cp -a "${_basedir}/base/emblems/24" emblems
     ln -s ../22/emotes .
     cp -a "${_basedir}/base/mimetypes/24" mimetypes
     cp -a "${_basedir}/base/places/24" places
     cp -a "${_basedir}/base/status/24" status
     ln -s status panel
    )
_footer

_header "Copying \"32\" icons"
    (
     cd 32 || exit 1
     cp -a "${_basedir}/base/actions/32" actions
     cp -a "${_basedir}/base/status/32" status
     ln -sf ../scalable/applets .
     ln -sf ../scalable/apps .
     ln -sf ../scalable/categories .
     ln -sf ../scalable/devices .
     ln -s ../22/emblems .
     ln -s ../22/emotes .
     ln -sf ../scalable/mimetypes .
     ln -sf ../scalable/places .
     ln -sf ../scalable/preferences .
    )
_footer

makedistrostatusfiles

_header "Copying \"48\" icons"
    (
     cd 48 || exit 1
     ln -sf ../scalable/apps .
     ln -sf ../scalable/categories .
     ln -sf ../scalable/devices .
     ln -sf ../scalable/mimetypes .
     ln -sf ../scalable/places .
     ln -sf ../scalable/preferences .
     cp -a "${_basedir}/wm/kde/actions/48" actions
     cp -a "${_basedir}/wm/kde/applets/48" applets
    )
_footer

_header "Creating \"applets\" symbolic links"
    (
     cd 48/applets || exit 1
        makeapplinks
    )
_footer

_header "Copying \"64\" icons"
    (
     cd 64 || exit 1
     ln -sf ../scalable/applets .
     ln -sf ../scalable/apps .
     ln -sf ../scalable/categories .
     ln -sf ../scalable/devices .
     ln -sf ../scalable/mimetypes .
     ln -sf ../scalable/places .
     ln -sf ../scalable/preferences .
     cp -a "${_basedir}/wm/kde/actions/64" actions
     cp -a "${_basedir}/base/status/64" status
    )
_footer

_header "Copying \"96\" icons"
    (
     cd 96 || exit 1
     ln -sf ../scalable/applets .
     ln -sf ../scalable/apps .
     ln -sf ../scalable/categories .
     ln -sf ../scalable/devices .
     ln -sf ../scalable/mimetypes .
     ln -sf ../scalable/places .
     ln -sf ../scalable/preferences .
    )
_footer

_header "Copying \"128\" icons"
    (
     cd 128 || exit 1
     ln -sf ../scalable/apps .
     ln -sf ../scalable/categories .
     ln -sf ../scalable/devices .
     ln -sf ../scalable/mimetypes .
     ln -sf ../scalable/places .
     ln -sf ../scalable/preferences .
     cp -a "${_basedir}/wm/kde/applets/128" applets
    )
_footer

_header "Creating \"applets\" symbolic links"
    (
     cd 128/applets || exit 1
        makeapplinks
    )
_footer

_header "Copying \"256\" icons"
    (
     cd 256 || exit 1
     ln -sf ../scalable/applets .
    )
_footer

_header "Copying \"symbolic\" icons"
    (
     cd symbolic || exit 1
     mkdir -p actions apps devices mimetypes places status
     ln -s apps categories
     cp -a "${_basedir}/wm/gnome/scalable/emblems" .
     cp -a "${_basedir}/wm/gnome/scalable/emotes" .
    )
_footer

_header "Colorize \"status\" files"
   (
     cd 16/status || exit 1
     lightcolor
   )
   (
     cd 22/status || exit 1
     lightcolor
   )
   (
     cd 24/status || exit 1
     lightcolor
   )
   (
     cd 32/status || exit 1
     lightcolor
   )
_footer

_header "Creating symbolic links to the \"12\" folders"
  (
     cd 12 || exit 1
     makesymlink
  )
_footer

_header "Creating symbolic links to the \"16\" folders"
  (
     cd 16 || exit 1
     makesymlink
     (
       cd apps || exit 1
          rm -r applications-accessories-symbolic.svg
          rm -r applications-development-symbolic.svg
          rm -r applications-education-symbolic.svg
          rm -r applications-games-symbolic.svg
          rm -r applications-graphics-symbolic.svg
          rm -r applications-internet-symbolic.svg
          rm -r applications-multimedia-symbolic.svg
          rm -r applications-office-symbolic.svg
          rm -r applications-other-symbolic.svg
          rm -r applications-science-symbolic.svg
          rm -r applications-system-symbolic.svg
          rm -r applications-utilities-symbolic.svg
     )
     (
       cd actions || exit 1
          rm -r applications-other-symbolic.svg
     )
  )
_footer

_header "Creating symbolic links to the \"22\" folders"
  (
     cd 22 || exit 1
     makesymlink
  )
_footer

_header "Creating symbolic links to the \"24\" folders"
  (
     cd 24 || exit 1
     makesymlink
  )
_footer

_header "Creating symbolic links to the \"32\" folders"
  (
     cd 32 || exit 1
     makesymlink
  )
_footer

_header "Creating links to the \"symbolic/actions\" folders"
  (
     cd symbolic/actions || exit 1
     for i in ../../16/actions/*-symbolic.svg
      do ln -s "$i" .
    done
  )
_footer

_header "Creating links to the \"symbolic/apps\" folders"
  (
     cd symbolic/apps || exit 1
     for i in ../../16/apps/*-symbolic.svg
      do ln -s "$i" .
    done
  )
_footer

_header "Creating links to the \"symbolic/devices\" folders"
  (
     cd symbolic/devices || exit 1
     for i in ../../16/devices/*-symbolic.svg
      do ln -s "$i" .
    done
  )
_footer

_header "Creating links to the \"symbolic/mimetypes\" folders"
  (
     cd symbolic/mimetypes || exit 1
     for i in ../../16/mimetypes/*-symbolic.svg
      do ln -s "$i" .
    done
  )
_footer

_header "Creating links to the \"symbolic/places\" folders"
  (
     cd symbolic/places || exit 1
     for i in ../../16/places/*-symbolic.svg
      do ln -s "$i" .
    done
  )
_footer

_header "Creating links to the \"symbolic/status\" folders"
  (
     cd symbolic/status || exit 1
     for i in ../../16/status/*-symbolic.svg
      do ln -s "$i" .
    done
  )
_footer

makedistrofiles
makelightcursor

for files in AUTHORS COPYING README.md
    do cp -a "${_basedir}/${files}" .
  done

cp -a "${_basedir}/wm/default/index.theme" .
sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}/g" index.theme

cd "../Diagonal${__wmtype}${__distro}-dark" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a dark theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"

_header "Installing the basic folder"
mkdir -p 12 16 22 24 32 48 128 symbolic
ln -s 16 16@2x
ln -s 22 22@2x
ln -s 24 24@2x
ln -s 32 32@2x
ln -sf "../Diagonal${__wmtype}${__distro}/scalable" .
ln -sf "../Diagonal${__wmtype}${__distro}/8" .
ln -sf "../Diagonal${__wmtype}${__distro}/64" .
ln -sf "../Diagonal${__wmtype}${__distro}/96" .
ln -sf "../Diagonal${__wmtype}${__distro}/256" .
_footer

_header "Copying \"12\" icons"
    (
      cd 12 || exit 1
      cp -a "../../Diagonal${__wmtype}${__distro}/12/actions" .
    )
_footer

_header "Colorize \"12\" icons"
    (
      cd 12 || exit 1
      makelightcolor
    )
_footer

_header "Copying \"16\" icons"
    (
      cd 16 || exit 1
      cp -a "../../Diagonal${__wmtype}${__distro}/16/actions" .
      cp -a "../../Diagonal${__wmtype}${__distro}/16/animations" .
      cp -a "../../Diagonal${__wmtype}${__distro}/16/applets" .
      cp -a "../../Diagonal${__wmtype}${__distro}/16/apps" .
      cp -a "../../Diagonal${__wmtype}${__distro}/16/devices" .
      cp -a "../../Diagonal${__wmtype}${__distro}/16/mimetypes" .
      cp -a "../../Diagonal${__wmtype}${__distro}/16/places" .
      ln -s apps categories
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/emblems" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/emotes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/status" .
      ln -s status panel
    )
_footer

_header "Colorize \"16\" icons"
    (
      cd 16 || exit 1
      makelightcolor
    )
_footer

_header "Copying \"22\" icons"
    (
      cd 22 || exit 1
      cp -a "../../Diagonal${__wmtype}${__distro}/22/actions" .
      cp -a "../../Diagonal${__wmtype}${__distro}/22/animations" .
      cp -a "../../Diagonal${__wmtype}${__distro}/22/applets" .
      cp -a "../../Diagonal${__wmtype}${__distro}/22/devices" .
      cp -a "../../Diagonal${__wmtype}${__distro}/22/mimetypes" .
      cp -a "../../Diagonal${__wmtype}${__distro}/22/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/emblems" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/emotes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/status" .
      ln -s status panel
    )
_footer

_header "Colorize \"22\" icons"
    (
      cd 22 || exit 1
      makelightcolor
    )
_footer

_header "Copying \"24\" icons"
    (
      cd 24 || exit 1
      cp -a "../../Diagonal${__wmtype}${__distro}/24/actions" .
      cp -a "../../Diagonal${__wmtype}${__distro}/24/animations" .
      cp -a "../../Diagonal${__wmtype}${__distro}/24/applets" .
      cp -a "../../Diagonal${__wmtype}${__distro}/24/devices" .
      cp -a "../../Diagonal${__wmtype}${__distro}/24/mimetypes" .
      cp -a "../../Diagonal${__wmtype}${__distro}/24/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/emblems" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/emotes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/status" .
      ln -s status panel
    )
_footer

_header "Colorize \"24\" icons"
    (
      cd 24 || exit 1
      makelightcolor
    )
_footer

_header "Copying \"32\" icons"
    (
      cd 32 || exit 1
      cp -a "../../Diagonal${__wmtype}${__distro}/32/actions" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/applets" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/apps" .
      ln -s apps categories
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/devices" .
      ln -sf "../22/emblems" .
      ln -sf "../22/emotes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/mimetypes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/preferences" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/32/status" .
     )
_footer

_header "Colorize \"32\" icons"
    (
      cd 32 || exit 1
      makelightcolor
    )
_footer

_header "Copying \"48\" icons"
    (
      cd 48 || exit 1
      cp -a "${_basedir}/wm/kde/applets/48" applets
         (
            cd applets || exit 1
               lightcolor
               makeapplinks
         )
      ln -sf "../../Diagonal${__wmtype}${__distro}/48/actions" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/apps" .
      ln -s apps categories
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/devices" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/mimetypes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/preferences" .
     )
_footer

_header "Copying \"128\" icons"
    (
      cd 128 || exit 1
      cp -a "${_basedir}/wm/kde/applets/128" applets
         (
            cd applets || exit 1
               makeapplinks
         )
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/apps" .
      ln -s apps categories
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/devices" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/mimetypes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/scalable/preferences" .
     )
_footer

_header "Copying \"symbolic\" icons"
    (
      cd symbolic || exit 1
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/actions" .
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/apps" .
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/devices" .
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/emblems" .
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/emotes" .
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/mimetypes" .
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/status" .
      ln -s apps categories
    )
_footer

_header "Colorize \"symbolic\" icons"
    (
      cd symbolic || exit 1
      lightcolor
    )
_footer

makedarkcursor

for files in AUTHORS COPYING README.md index.theme
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
mkdir -p 12 16 22 24 32 symbolic
ln -s 16 16@2x
ln -s 22 22@2x
ln -s 24 24@2x
ln -s 32 32@2x
ln -sf "../Diagonal${__wmtype}${__distro}/scalable" .
ln -sf "../Diagonal${__wmtype}${__distro}/8" .
ln -sf "../Diagonal${__wmtype}${__distro}/48" .
ln -sf "../Diagonal${__wmtype}${__distro}/64" .
ln -sf "../Diagonal${__wmtype}${__distro}/96" .
ln -sf "../Diagonal${__wmtype}${__distro}/128" .
ln -sf "../Diagonal${__wmtype}${__distro}/256" .
ln -sf "../Diagonal${__wmtype}${__distro}/cursors" .
_footer

_header "Copying \"12\" icons"
    (
      cd 12 || exit 1
      ln -sf "../../Diagonal${__wmtype}${__distro}/12/actions" .
    )
_footer

_header "Copying \"16\" icons"
    (
      cd 16 || exit 1
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/actions" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/animations" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/applets" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/apps" .
      ln -s apps categories
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/devices" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/mimetypes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/emblems" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/emotes" .
      ln -sf status panel
      cp -a "../../Diagonal${__wmtype}${__distro}/16/status" .
    )
_footer

_header "Colorize \"16\" status icons"
    (
      cd 16/status || exit 1
         darkcolor
    )
_footer

_header "Copying \"22\" icons"
    (
      cd 22 || exit 1
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/actions" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/animations" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/applets" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/devices" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/emotes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/mimetypes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/places" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/22/emblems" .
      cp -a "../../Diagonal${__wmtype}${__distro}/22/status" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/16/emblems" .
      ln -s status panel
    )
_footer

_header "Colorize \"22\" status icons"
    (
      cd 22/status || exit 1
         darkcolor
    )
_footer

_header "Copying \"24\" icons"
    (
      cd 24 || exit 1
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/actions" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/animations" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/applets" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/devices" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/emblems" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/emotes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/mimetypes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/24/places" .
      cp -a "../../Diagonal${__wmtype}${__distro}/24/status" .
      ln -s status panel
    )
_footer

_header "Colorize \"24\" status icons"
    (
      cd 24/status || exit 1
         darkcolor
    )
_footer

_header "Copying \"32\" icons"
    (
      cd 32 || exit 1
      ln -sf "../../Diagonal${__wmtype}${__distro}/32/actions" .
      ln -sf ../scalable/applets .
      ln -sf ../scalable/apps .
      ln -sf ../scalable/categories .
      ln -sf ../scalable/devices .
      ln -s ../22/emblems
      ln -s ../22/emotes
      ln -sf ../scalable/mimetypes .
      ln -sf ../scalable/places .
      ln -sf ../scalable/preferences .
      cp -a "../../Diagonal${__wmtype}${__distro}/32/status" .
    )
_footer

_header "Colorize \"32\" status icons"
    (
      cd 32/status || exit 1
         darkcolor
    )
_footer

_header "Copying \"symbolic\" icons"
    (
      cd symbolic || exit 1
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/actions" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/apps" .
      ln -s apps categories
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/devices" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/emblems" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/emotes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/mimetypes" .
      ln -sf "../../Diagonal${__wmtype}${__distro}/symbolic/places" .
      cp -a "../../Diagonal${__wmtype}${__distro}/symbolic/status" .
    )
_footer

for files in AUTHORS COPYING README.md index.theme
    do cp -a "../Diagonal${__wmtype}${__distro}/${files}" .
  done
  sed_inplace "s/Diagonal${__wmtype}${__distro}/Diagonal${__wmtype}${__distro}-light/g" index.theme

cd "${_basefolder}" || exit 1

if [ -n "${__foldercolor}" ]
   then ( cd scalable/places || exit 1
         makefoldercolor
        )
        (
          cd scalable/apps || exit 1
          cp -a ../places/folder.svg .
          cp -a ../places/folder-new.svg .
          cp -a ../places/folder-system.svg filemanager-actions.svg
        )
   else ( cd scalable/places || exit 1
         makedistrofolder
        )
        (
          cd scalable/apps || exit 1
          cp -a ../places/folder.svg .
          cp -a ../places/folder-new.svg .
          cp -a ../places/folder-system.svg filemanager-actions.svg
        )
fi




















