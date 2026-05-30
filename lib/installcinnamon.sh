#!/bin/sh
# Not a standalone file, please don't run it on its own.

. ./lib/function.sh

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

makelightcolor()
{
find * -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r file
       do sed_inplace 's/5d656b/d3dae3/g' "${file}"
     done
}

makedarkcolor()
{
find * -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r file
       do sed_inplace 's/d3dae3/5d656b/g' "${file}"
     done
}

_header "Installing the basic icon pack"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-light"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-dark"
_footer

cd "${_basefolder}" || exit 1

_header "Installing the basic folder"
mkdir -p apps devices emblems mimetypes places
cp -a "${_basedir}/wm/cinnamon/actions" .
cp -a "${_basedir}/wm/cinnamon/animations" .
cp -a "${_basedir}/wm/cinnamon/status" .
cp -a "${_basedir}/wm/cinnamon/ui" .
_footer

_header "Copying \"actions\" icons"
    (
     cd actions || exit 1
        ln -s 48 16
        ln -s 16 16@2x
        ln -s 48 22
        ln -s 22 22@2x
        ln -s 48 24
        ln -s 24 24@2x
        ln -s 48 32
        ln -s 32 32@2x
        ln -s 48 48@2x
        ln -s 64 64@2x
        ln -s 64 96
        ln -s 96 96@2x
        ln -s 64 128
        ln -s 128 128@2x
        ln -s 64 256
        ln -s 256 256@2x
        mkdir -p symbolic
        (
          cd symbolic || exit 1
             find "${_basedir}/base/actions/16" -name '*.svg' 2>/dev/null |
             while IFS= read -r file
                do cp -a "${file}" .
              done
             for i in *.svg
              do mv "${i}" "${i%.svg}-symbolic.svg"
            done
            find * -type l  -exec sh -c '
            for i
             do t=$(readlink -- "$i") || continue
                case "$t" in
                  *.svg) ln -sf -- "${t%.svg}-symbolic.svg" "$i"
                esac
           done
           '  sh {} +
        )
    )
_footer

_header "Copying \"apps\" icons"
    (
     cd apps || exit 1
        cp -a "${_basedir}/base/scalable/apps/" 64
        ln -s 64 16
        ln -s 16 16@2x
        ln -s 64 22
        ln -s 22 22@2x
        ln -s 64 24
        ln -s 24 24@2x
        ln -s 64 32
        ln -s 32 32@2x
        ln -s 64 48
        ln -s 48 48@2x
        ln -s 64 64@2x
        ln -s 64 96
        ln -s 96 96@2x
        ln -s 64 128
        ln -s 128 128@2x
        ln -s 64 256
        ln -s 256 256@2x
        mkdir -p symbolic
        (
          cd symbolic || exit 1
             find "${_basedir}/base/apps/16" -name '*.svg' 2>/dev/null |
             while IFS= read -r file
                do cp -a "${file}" .
              done
             for i in *.svg
              do mv "${i}" "${i%.svg}-symbolic.svg"
            done
            find * -type l  -exec sh -c '
            for i
             do t=$(readlink -- "$i") || continue
                case "$t" in
                  *.svg) ln -sf -- "${t%.svg}-symbolic.svg" "$i"
                esac
           done
           '  sh {} +
        )
    )
_footer

ln -s apps categories

_header "Copying \"devices\" icons"
    (
     cd devices || exit 1
        cp -a "${_basedir}/base/scalable/devices/" 64
        ln -s 64 16
        ln -s 16 16@2x
        ln -s 64 22
        ln -s 22 22@2x
        ln -s 64 24
        ln -s 24 24@2x
        ln -s 64 32
        ln -s 32 32@2x
        ln -s 64 48
        ln -s 48 48@2x
        ln -s 64 64@2x
        ln -s 64 96
        ln -s 96 96@2x
        ln -s 64 128
        ln -s 128 128@2x
        ln -s 64 256
        ln -s 256 256@2x
        mkdir -p symbolic
        (
          cd symbolic || exit 1
             find "${_basedir}/base/devices/16" -name '*.svg' 2>/dev/null |
             while IFS= read -r file
                do cp -a "${file}" .
              done
             for i in *.svg
              do mv "${i}" "${i%.svg}-symbolic.svg"
            done
            find * -type l  -exec sh -c '
            for i
             do t=$(readlink -- "$i") || continue
                case "$t" in
                  *.svg) ln -sf -- "${t%.svg}-symbolic.svg" "$i"
                esac
           done
           '  sh {} +
        )
    )
_footer

_header "Copying \"emblems\" icons"
    (
     cd emblems || exit 1
        find "${_basedir}/base/emblems" -type d \
              ! -path "${_basedir}/base/emblems" 2>/dev/null |
             while IFS= read -r dir
                do cp -a "${dir}" .
              done
        ln -s 16 16@2x
        ln -s 22 22@2x
        ln -s 24 24@2x
        ln -s 24 32
        ln -s 32 32@2x
    )
_footer

_header "Copying \"mimetypes\" icons"
    (
     cd mimetypes || exit 1
        cp -a "${_basedir}/base/scalable/mimetypes/" 64
        ln -s 64 16
        ln -s 16 16@2x
        ln -s 64 22
        ln -s 22 22@2x
        ln -s 64 24
        ln -s 24 24@2x
        ln -s 64 32
        ln -s 32 32@2x
        ln -s 64 48
        ln -s 48 48@2x
        ln -s 64 64@2x
        ln -s 64 96
        ln -s 96 96@2x
        ln -s 64 128
        ln -s 128 128@2x
        ln -s 64 256
        ln -s 256 256@2x
        mkdir -p symbolic
        (
          cd symbolic || exit 1
             find "${_basedir}/base/mimetypes/16" -name '*.svg' 2>/dev/null |
             while IFS= read -r file
                do cp -a "${file}" .
              done
             for i in *.svg
              do mv "${i}" "${i%.svg}-symbolic.svg"
            done
            find * -type l  -exec sh -c '
            for i
             do t=$(readlink -- "$i") || continue
                case "$t" in
                  *.svg) ln -sf -- "${t%.svg}-symbolic.svg" "$i"
                esac
           done
           '  sh {} +
        )
    )
_footer

_header "Copying \"places\" icons"
    (
     cd places || exit 1
        cp -a "${_basedir}/base/scalable/places/" 64
        ln -s 64 16
        ln -s 16 16@2x
        ln -s 64 22
        ln -s 22 22@2x
        ln -s 64 24
        ln -s 24 24@2x
        ln -s 64 32
        ln -s 32 32@2x
        ln -s 64 48
        ln -s 48 48@2x
        ln -s 64 64@2x
        ln -s 64 96
        ln -s 96 96@2x
        ln -s 64 128
        ln -s 128 128@2x
        ln -s 64 256
        ln -s 256 256@2x
        mkdir -p symbolic
        (
          cd symbolic || exit 1
             find "${_basedir}/base/places/16" -name '*.svg' 2>/dev/null |
             while IFS= read -r file
                do cp -a "${file}" .
              done
             for i in *.svg
              do mv "${i}" "${i%.svg}-symbolic.svg"
            done
            find * -type l  -exec sh -c '
            for i
             do t=$(readlink -- "$i") || continue
                case "$t" in
                  *.svg) ln -sf -- "${t%.svg}-symbolic.svg" "$i"
                esac
           done
           '  sh {} +
        )
    )
_footer

_header "Copying \"status\" icons"
    (
     cd status || exit 1
        find "${_basedir}/wm/cinnamon/status" -type d \
             ! -path "${_basedir}/wm/cinnamon/status" 2>/dev/null |
             while IFS= read -r dir
                do cp -a "${dir}" .
              done
        ln -s 64 16
        ln -s 16 16@2x
        ln -s 64 22
        ln -s 22 22@2x
        ln -s 64 24
        ln -s 24 24@2x
        ln -s 64 32
        ln -s 32 32@2x
        ln -s 48 48@2x
        ln -s 64 64@2x
        ln -s 64 96
        ln -s 96 96@2x
        ln -s 64 128
        ln -s 128 128@2x
        ln -s 64 256
        ln -s 256 256@2x
        mkdir -p symbolic
        (
          cd symbolic || exit 1
             find "${_basedir}/base/status/16" -name '*.svg' 2>/dev/null |
             while IFS= read -r file
                do cp -a "${file}" .
              done
             for i in *.svg
              do mv "${i}" "${i%.svg}-symbolic.svg"
            done
            find * -type l  -exec sh -c '
            for i
             do t=$(readlink -- "$i") || continue
                case "$t" in
                  *.svg) ln -sf -- "${t%.svg}-symbolic.svg" "$i"
                esac
           done
           '  sh {} +
        )
    )
_footer

_header "Colorize \"status\" files"
  (
     cd status/symbolic || exit 1
     makelightcolor
  )
_footer

_header "Copying \"ui\" icons"
    (
     cd ui || exit 1
        cp -a "${_basedir}/wm/cinnamon/ui/16" .
        ln -s 16 16@2x
        mkdir -p symbolic
        (
          cd symbolic || exit 1
             find ../16 -name '*.svg' 2>/dev/null |
             while IFS= read -r i
                do ln -s "$i" "$(basename "$i" .svg)-symbolic.svg"
              done
        )
     )
_footer

makelightcursor
makedistrofiles

for files in AUTHORS COPYING README.md
    do cp -a "${_basedir}/${files}" .
  done

cp -a "${_basedir}/wm/cinnamon/index.theme" .
sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}/g" index.theme

cd "../Diagonal${__wmtype}${__distro}-dark" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a dark theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"
_footer

_header "Installing the basic folder"
mkdir -p actions apps devices mimetypes places
cp -a "../Diagonal${__wmtype}${__distro}/ui" .
ln -s "../Diagonal${__wmtype}${__distro}/emblems" .
ln -s "../Diagonal${__wmtype}${__distro}/status" .
ln -s apps categories
_footer

_header "Copying \"actions\" icons"
    (
     cd actions || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/actions/48" .
        ln -s "../../Diagonal${__wmtype}${__distro}/actions/64" .
        cp -a "../../Diagonal${__wmtype}${__distro}/actions/symbolic" .
        find  "../../Diagonal${__wmtype}${__distro}/actions/" -type l \
              ! -name '*.svg' -exec cp -a {} . \;
    )
_footer

_header "Colorize \"actions\" files"
  (
     cd actions/symbolic || exit 1
     makelightcolor
  )
_footer

_header "Copying \"animations\" icons"
cp -a "../Diagonal${__wmtype}${__distro}/animations" .
_footer

_header "Colorize \"animations\" files"
  (
     cd animations/22 || exit 1
     makelightcolor
  )
  (
     cd animations/24 || exit 1
     makelightcolor
  )
_footer

_header "Copying \"apps\" icons"
    (
     cd apps || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/apps/64" .
        cp -a "../../Diagonal${__wmtype}${__distro}/apps/symbolic" .
        find  "../../Diagonal${__wmtype}${__distro}/apps/" -type l \
              ! -name '*.svg' -exec cp -a {} . \;
    )
_footer

_header "Colorize \"apps\" files"
  (
     cd apps/symbolic || exit 1
     makelightcolor
  )
_footer

_header "Copying \"devices\" icons"
    (
     cd devices || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/devices/64" .
        cp -a "../../Diagonal${__wmtype}${__distro}/devices/symbolic" .
        find  "../../Diagonal${__wmtype}${__distro}/devices/" -type l \
              ! -name '*.svg' -exec cp -a {} . \;
    )
_footer

_header "Colorize \"devices\" files"
  (
     cd devices/symbolic || exit 1
     makelightcolor
  )
_footer



_header "Copying \"mimetypes\" icons"
    (
     cd mimetypes || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/mimetypes/64" .
        cp -a "../../Diagonal${__wmtype}${__distro}/mimetypes/symbolic" .
        find  "../../Diagonal${__wmtype}${__distro}/mimetypes/" -type l \
              ! -name '*.svg' -exec cp -a {} . \;
    )
_footer

_header "Colorize \"mimetypes\" files"
  (
     cd mimetypes/symbolic || exit 1
     makelightcolor
  )
_footer

_header "Copying \"places\" icons"
    (
     cd places || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/places/64" .
        cp -a "../../Diagonal${__wmtype}${__distro}/places/symbolic" .
        find  "../../Diagonal${__wmtype}${__distro}/places/" -type l \
              ! -name '*.svg' -exec cp -a {} . \;
    )
_footer

_header "Colorize \"places\" files"
  (
     cd places/symbolic || exit 1
     makelightcolor
  )
_footer

_header "Colorize \"ui\" files"
  (
     cd ui/16 || exit 1
     makelightcolor
  )
_footer

makedarkcursor

for files in AUTHORS COPYING README.md
    do cp -a "${_basedir}/${files}" .
  done

cp -a "${_basedir}/wm/cinnamon/index.theme" .
sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}-dark/g" index.theme

cd "../Diagonal${__wmtype}${__distro}-light" || exit 1
printf ";;;\n"
_line
printf ";;; \n"
printf ";;; %bCreating a light theme version... %bdone.%b\n" "${cyan}" "${green}" "${reset}"
printf ";;; \n"

_header "Installing the basic folder"
mkdir -p status
ln -s "../Diagonal${__wmtype}${__distro}/actions" .
ln -s "../Diagonal${__wmtype}${__distro}/animations" .
ln -s "../Diagonal${__wmtype}${__distro}/apps" .
ln -s apps categories
ln -s "../Diagonal${__wmtype}${__distro}/cursors" .
ln -s "../Diagonal${__wmtype}${__distro}/devices" .
ln -s "../Diagonal${__wmtype}${__distro}/emblems" .
ln -s "../Diagonal${__wmtype}${__distro}/mimetypes" .
ln -s "../Diagonal${__wmtype}${__distro}/places" .
ln -s "../Diagonal${__wmtype}${__distro}/ui" .
_footer

_header "Copying \"status\" icons"
    (
     cd status || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/status/48" .
        ln -s "../../Diagonal${__wmtype}${__distro}/status/64" .
        cp -a "../../Diagonal${__wmtype}${__distro}/status/symbolic" .
        find  "../../Diagonal${__wmtype}${__distro}/status/" -type l \
              ! -name '*.svg' -exec cp -a {} . \;
    )
_footer

_header "Colorize \"status\" files"
  (
     cd status/symbolic || exit 1
     makedarkcolor
  )
_footer

for files in AUTHORS COPYING README.md
    do cp -a "${_basedir}/${files}" .
  done

cp -a "${_basedir}/wm/cinnamon/index.theme" .
sed_inplace "s/Diagonal${__wmtype}/Diagonal${__wmtype}${__distro}-light/g" index.theme

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

