#!/bin/sh
# Not a standalone file, please don't run it on its own.

. ./lib/function.sh

case "$1" in
  --mc ) _monochrome="1"
    ;;
esac

makesymlink()
{
    find * -type d ! -type l \
        ! \( -name '*48' -o -name '*64' -o -name '*96' \
         -o -name '*128' -o -name '*256' \) 2>/dev/null |
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

makedir()
{
pwdkt="${PWD##*/}"
find "${_basedir}/base/${pwdkt}" -type d \
     ! -path "${_basedir}/base/${pwdkt}" 2>/dev/null |
        while IFS= read -r dir
           do cp -a "${dir}" .
         done
}

makedistrodir()
{
pwdkt="${PWD##*/}"
find "${_basedir}/wm/kde/${pwdkt}" -type d \
     ! -path "${_basedir}/wm/kde/${pwdkt}" 2>/dev/null |
        while IFS= read -r dir
           do cp -a "${dir}" .
         done
}

makedarkthemedir()
{
pwdkt="${PWD##*/}"
find "../../Diagonal${__wmtype}${__distro}/${pwdkt}" -type d \
     ! -path "../../Diagonal${__wmtype}${__distro}/${pwdkt}" \
     ! -name '48' ! -name '64' ! -name '96' ! -name '128' \
     ! -name '256' 2>/dev/null |
        while IFS= read -r dir
           do cp -a "${dir}" .
         done
}

makedistrofiles()
{
if [ -n "${__distro}" ]
   then _header "Creating distribution-specific \"applications\" files"
        for i in ${_basedir}/distribution/${_dist}/scalable/apps/*.svg
         do cp -a "${i}" apps/64
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
         "status/${kt}/start-here.svg"
       done
       _footer
fi
}

makeapplinks()
{
    find ../../apps/64 -name '*.svg' 2>/dev/null |
    while IFS= read -r file
       do ln -s "${file}" .
     done
}

makedeviceslinks()
{
    find ../../devices/64 -name '*.svg' 2>/dev/null |
    while IFS= read -r file
       do ln -s "${file}" .
     done
}

makestatuslightcolor()
{
find 16 22 24 32 -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r i
       do sed_inplace 's/5d656b/d3dae3/g' "${i}"
    done
}

lightcolor()
{
    find * -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r i
       do sed_inplace 's/5d656b/d3dae3/g' "${i}"
    done
}

makelightcolor()
{
find * -type d 2>/dev/null |
    while IFS= read -r dir
       do (
            cd "${dir}" || exit 1
            lightcolor
          )
     done
}

_header "Installing the basic icon pack"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-light"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-dark"
_footer

cd "${_basefolder}" || exit 1

_header "Installing the basic folder"
mkdir -p actions animations applets apps categories devices \
         emblems emotes mimetypes places preferences status
_footer

_header "Copying \"actions\" icons"
    (
     cd actions || exit 1
        makedir
        makedistrodir
        cp -a "${_basedir}/wm/kde/actions/32" .
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s 32 32@2x
        ln -s 32 32@3x
    )
_footer

_header "Copying \"apps\" icons"
    (
     cd apps || exit 1
        makedir
        cp -a "${_basedir}/base/scalable/apps" 64
        cp -a "${_basedir}/wm/kde/apps/64" .
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 64 32
        ln -s 64 48
     )
_footer

_header "Copying \"animations\" icons"
    (
     cd animations || exit 1
        makedistrodir
        ln -s 16 16@2x
        ln -s 16 16@3x
    )
_footer

_header "Copying \"applets\" icons"
    (
     cd applets || exit 1
        makedistrodir
        ln -s ../apps/32 .
        ln -s ../apps/64 .
        ln -s ../apps/64 256
        ln -s 24 24@2x
        ln -s 24 24@3x
    )
_footer

_header "Copying \"categories\" icons"
    (
     cd categories || exit 1
        if [ -n "${_monochrome}" ]
           then cp -a "${_basedir}/wm/kde/categories/22" .
                ln -s 22 24
        fi
        ln -s ../apps/32 .
    )
_footer

_header "Copying \"devices\" icons"
    (
     cd devices || exit 1
        makedir
        cp -a "${_basedir}/base/scalable/devices" 64
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
     )
_footer

_header "Copying \"emblems\" icons"
    (
     cd emblems || exit 1
        makedir
        ln -s 16 8
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
    )
_footer

_header "Copying \"emotes\" icons"
    (
     cd emotes || exit 1
        makedir
        ln -s 22 22@2x
        ln -s 22 22@3x
    )
_footer

_header "Copying \"mimetypes\" icons"
    (
     cd mimetypes || exit 1
        makedir
        cp -a "${_basedir}/base/scalable/mimetypes" 64
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s 64 32
    )
_footer

_header "Copying \"places\" icons"
    (
     cd places || exit 1
        makedir
        cp -a "${_basedir}/base/scalable/places" 64
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s 64 32
        ln -s 64 48
        ln -s 64 96
    )
_footer

_header "Copying \"preferences\" icons"
    (
     cd preferences || exit 1
        ln -s ../apps/64 32
    )
_footer

_header "Copying \"status\" icons"
    (
     cd status || exit 1
        makedir
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
     )
_footer

makedistrofiles
makedistrostatusfiles
makelightcursor

_header "Creating symbolic links to the \"actions\" folders"
  (
     cd actions || exit 1
     makesymlink
     (
       cd 16 || exit 1
       rm -r applications-other-symbolic.svg
     )
  )
_footer

_header "Creating symbolic links to the \"applets\" folders"
  (
     cd applets || exit 1
     makesymlink
      (
        cd 48 || exit 1
           makeapplinks
      )
      (
        cd 128 || exit 1
           makeapplinks
      )
  )
_footer

_header "Creating symbolic links to the \"apps\" folders"
  (
     cd apps || exit 1
     makesymlink
     (
       cd 16 || exit 1
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
          rm -r preferences-desktop-accessibility-symbolic.svg
     )
  )
_footer

_header "Creating symbolic links to the \"devices\" folders"
  (
     cd devices || exit 1
     makesymlink
     (
       cd 32 || exit 1
       makedeviceslinks
     )
  )
_footer

_header "Creating symbolic links to the \"mimetypes\" folders"
  (
     cd mimetypes || exit 1
     makesymlink
  )
_footer

_header "Creating symbolic links to the \"places\" folders"
  (
     cd places || exit 1
     makesymlink
  )
_footer

_header "Creating symbolic links to the \"status\" folders"
  (
     cd status || exit 1
     makesymlink
  )
_footer

_header "Colorize \"status\" files"
  (
     cd status || exit 1
     makestatuslightcolor
  )
_footer

for files in AUTHORS diagonal-release
    do cp -a "${_basedir}/${files}" .
  done

if [ -n "${_monochrome}" ]
   then cp -a "${_basedir}/wm/kde/index-mc.theme" .
        mv index-mc.theme index.theme
   else cp -a "${_basedir}/wm/kde/index.theme" .
fi

sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}/g" index.theme

cd "../Diagonal${__wmtype}${__distro}-dark" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a dark theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"
_footer

_header "Installing the basic folder"
mkdir -p actions animations applets apps categories devices \
         mimetypes places
ln -s "../Diagonal${__wmtype}${__distro}/emblems" .
ln -s "../Diagonal${__wmtype}${__distro}/emotes" .
ln -s "../Diagonal${__wmtype}${__distro}/preferences" .
ln -s "../Diagonal${__wmtype}${__distro}/status" .
_footer

_header "Copying \"actions\" icons"
    (
     cd actions || exit 1
        makedarkthemedir
        ln -s "../../Diagonal${__wmtype}${__distro}/actions/48" .
        ln -s "../../Diagonal${__wmtype}${__distro}/actions/64" .
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s 32 32@2x
        ln -s 32 32@3x
    )
_footer

_header "Colorize \"actions\" icons"
    (
      cd actions || exit 1
      makelightcolor
    )
_footer

_header "Copying \"animations\" icons"
    (
     cd animations || exit 1
        makedarkthemedir
        ln -s 16 16@2x
        ln -s 16 16@3x
    )
_footer

_header "Colorize \"animations\" icons"
    (
      cd animations || exit 1
      makelightcolor
    )
_footer

_header "Copying \"applets\" icons"
    (
     cd applets || exit 1
        makedarkthemedir
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s "../../Diagonal${__wmtype}${__distro}/applets/64" .
        ln -s "../../Diagonal${__wmtype}${__distro}/applets/256" .
        ln -s "../../Diagonal${__wmtype}${__distro}/applets/128" .
        cp -a "../../Diagonal${__wmtype}${__distro}/applets/48" .
    )
_footer

_header "Colorize \"applets\" icons"
    (
      cd applets || exit 1
      makelightcolor
    )
_footer

_header "Copying \"apps\" icons"
    (
     cd apps || exit 1
        makedarkthemedir
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s "../../Diagonal${__wmtype}${__distro}/apps/32" .
        ln -s "../../Diagonal${__wmtype}${__distro}/apps/48" .
        ln -s "../../Diagonal${__wmtype}${__distro}/apps/64" .
    )
_footer

_header "Colorize \"apps\" icons"
    (
      cd apps || exit 1
      makelightcolor
    )
_footer

_header "Copying \"categories\" icons"
    if [ -z "${_monochrome}" ]
       then rm -r categories
            ln -s "../Diagonal${__wmtype}${__distro}/categories" .
       else
        (
           cd categories || exit 1
           cp -a "../../Diagonal${__wmtype}${__distro}/categories/22" .
           ln -s 22 24
           ln -s ../apps/32 .
        )
    fi
_footer

_header "Colorize \"categories\" icons"
    if [ -n "${_monochrome}" ]
    then (
           cd categories/22 || exit 1
              lightcolor
         )
    fi
_footer

_header "Copying \"devices\" icons"
    (
     cd devices || exit 1
        makedarkthemedir
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        cp -a "../../Diagonal${__wmtype}${__distro}/devices/32" .
        ln -s "../../Diagonal${__wmtype}${__distro}/devices/64" .
        makedeviceslinks
    )
_footer

_header "Colorize \"devices\" icons"
    (
      cd devices || exit 1
      makelightcolor
    )
_footer

_header "Copying \"mimetypes\" icons"
    (
     cd mimetypes || exit 1
        makedarkthemedir
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s "../../Diagonal${__wmtype}${__distro}/mimetypes/32" .
        ln -s "../../Diagonal${__wmtype}${__distro}/mimetypes/64" .
     )
_footer

_header "Colorize \"mimetypes\" icons"
    (
      cd mimetypes || exit 1
      makelightcolor
    )
_footer

_header "Copying \"places\" icons"
    (
     cd places || exit 1
        makedarkthemedir
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s "../../Diagonal${__wmtype}${__distro}/places/32" .
        ln -s "../../Diagonal${__wmtype}${__distro}/places/48" .
        ln -s "../../Diagonal${__wmtype}${__distro}/places/64" .
        ln -s "../../Diagonal${__wmtype}${__distro}/places/96" .
    )
_footer

_header "Colorize \"places\" icons"
    (
      cd places || exit 1
      makelightcolor
    )
_footer

makedarkcursor

for files in AUTHORS diagonal-release
    do cp -a "${_basedir}/${files}" .
  done

if [ -n "${_monochrome}" ]
   then cp -a "${_basedir}/wm/kde/index-mc.theme" .
        mv index-mc.theme index.theme
   else cp -a "${_basedir}/wm/kde/index.theme" .
fi

sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}-dark/g" index.theme

cd "../Diagonal${__wmtype}${__distro}-light" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a light theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"

_header "Installing the basic folder"
mkdir -p status
ln -sf "../Diagonal${__wmtype}${__distro}/actions" .
ln -sf "../Diagonal${__wmtype}${__distro}/animations" .
ln -sf "../Diagonal${__wmtype}${__distro}/applets" .
ln -sf "../Diagonal${__wmtype}${__distro}/apps" .
ln -sf "../Diagonal${__wmtype}${__distro}/categories" .
ln -sf "../Diagonal${__wmtype}${__distro}/devices" .
ln -sf "../Diagonal${__wmtype}${__distro}/emblems" .
ln -sf "../Diagonal${__wmtype}${__distro}/emotes" .
ln -sf "../Diagonal${__wmtype}${__distro}/mimetypes" .
ln -sf "../Diagonal${__wmtype}${__distro}/places" .
ln -sf "../Diagonal${__wmtype}${__distro}/preferences" .
ln -sf "../Diagonal${__wmtype}${__distro}/cursors" .
_footer

_header "Copying \"status\" icons"
    (
     cd status || exit 1
        makedarkthemedir
        ln -s 16 16@2x
        ln -s 16 16@3x
        ln -s 22 22@2x
        ln -s 22 22@3x
        ln -s 24 24@2x
        ln -s 24 24@3x
        ln -s "../../Diagonal${__wmtype}${__distro}/status/64" .
    )
_footer

_header "Colorize \"status\" icons"
    (
      cd status || exit 1
         find * -type d 2>/dev/null |
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

for files in AUTHORS diagonal-release
    do cp -a "${_basedir}/${files}" .
  done

if [ -n "${_monochrome}" ]
   then cp -a "${_basedir}/wm/kde/index-mc.theme" .
        mv index-mc.theme index.theme
   else cp -a "${_basedir}/wm/kde/index.theme" .
fi

sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}-light/g" index.theme


printf ";;; \n"
_line
printf ";;; \n"

cd "${_basefolder}" || exit 1

if [ -n "${__foldercolor}" ]
   then ( cd places/64 || exit 1
         makefoldercolor
        )
        (
          cd apps/64 || exit 1
          cp -a ../../places/64/folder.svg .
          cp -a ../../places/64/folder-new.svg .
          cp -a ../../places/64/folder-system.svg filemanager-actions.svg
        )
   else ( cd places/64 || exit 1
         makedistrofolder
        )
        (
          cd apps/64 || exit 1
          cp -a ../../places/64/folder.svg .
          cp -a ../../places/64/folder-new.svg .
          cp -a ../../places/64/folder-system.svg filemanager-actions.svg
        )
fi

