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

makedarkcolor()
{
    find * -type f -name '*.svg' 2>/dev/null |
    while IFS= read -r i
       do sed_inplace 's/d3dae3/5d656b/g' "${i}"
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
}

removesystemicon24()
{ for i in \
      system-lock-screen.svg \
      system-log-out.svg \
      system-reboot.svg \
      system-restart-panel.svg \
      system-shutdown-panel-restart.svg \
      system-shutdown-panel.svg \
      system-shutdown.svg \
      system-suspend-hibernate.svg \
      system-suspend-inhibited.svg \
      system-suspend.svg \
      system-suspend-uninhibited.svg \
      system-switch-user.svg
   do rm -r "${i}"
 done
}

removesystemicon22()
{ for i in \
      system-lock-screen.svg \
      system-log-out.svg \
      system-reboot.svg \
      system-shutdown.svg \
      system-suspend-hibernate.svg \
      system-suspend-inhibited.svg \
      system-suspend.svg \
      system-suspend-uninhibited.svg \
      system-switch-user.svg
   do rm -r "${i}"
 done
}

removesystemicon16()
{ for i in \
      system-lock-screen.svg \
      system-log-out.svg \
      system-reboot.svg \
      system-shutdown-panel-restart.svg \
      system-shutdown-panel.svg \
      system-shutdown.svg \
      system-suspend-hibernate.svg \
      system-suspend.svg \
      system-switch-user.svg
   do rm -r "${i}"
 done
}

_header "Installing the basic icon pack"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}"
    mkdir -p "${_workfolder}/Diagonal${__wmtype}${__distro}-light"
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
     (
       cd apps || exit 1
          rm -r system-log-out.svg && \
          ln -s log-out.svg system-log-out.svg
          rm -r system-lock-screen.svg && \
          ln -s preferences-desktop-screensaver.svg system-lock-screen.svg
          rm -r system-shutdown.svg && \
          ln -s shutdown.svg system-shutdown.svg
          rm -r system-reboot.svg && \
          ln -s reload.svg system-reboot.svg
          rm -r system-restart.svg && \
          ln -s reload.svg system-restart.svg
          rm -r system-cancel.svg && \
          ln -s cancel2.svg system-cancel.svg
          rm -r system-suspend.svg && \
          ln -s suspend.svg system-suspend.svg
          rm -r system-save-session.svg && \
          ln -s save.svg system-save-session.svg
          rm -r system-hibernate.svg && \
          ln -s hibernate.svg system-hibernate.svg
          rm -r system-suspend-hibernate.svg && \
          ln -s hibernate.svg system-suspend-hibernate.svg && \
          rm -r help-browser.svg
     )
     cp -a "${_basedir}/base/scalable/devices" .
     cp -a "${_basedir}/base/scalable/mimetypes" .
     cp -a "${_basedir}/base/scalable/places" .
     ln -s apps categories
    )
_footer

_header "Copying \"24x24\" icons"
    (
     cd 24x24 || exit 1
     cp -a "${_basedir}/base/actions/24" actions
     cp -a "${_basedir}/wm/mate/24x24/animations" .
     cp -a "${_basedir}/base/emblems/24" emblems
     cp -a "${_basedir}/base/devices/24" devices
     cp -a "${_basedir}/base/places/24" places
     ln -s ../22x22/emotes .
     cp -a "${_basedir}/base/mimetypes/24" mimetypes
     cp -a "${_basedir}/base/status/24" status
       (
          cd status || exit 1
             removesystemicon24
       )
     ln -s status panel
     ln -s ../64x64/apps .
     ln -s apps categories
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
       (
          cd status || exit 1
             removesystemicon22
       )
     cp -a "${_basedir}/base/devices/22" devices
     cp -a "${_basedir}/base/places/22" places
     ln -s status panel
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s ../24x24/animations .
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
       (
          cd status || exit 1
             removesystemicon16
       )
     cp -a "${_basedir}/wm/mate/16x16/symbolic" .
     ln -s symbolic symbolic-up-to-20
     ln -s ../22x22/emotes .
     ln -s ../64x64/apps .
     ln -s apps categories
     ln -s status panel
      (
        cd symbolic || exit 1
           ln -s ../actions .
           cp -a "${_basedir}/base/apps/16" apps
           ln -s apps categories
           ln -s ../devices .
           ln -s ../places .
           ln -s ../mimetypes
           ln -s ../status .
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
     makesymlink
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

_header "Creating symbolic links to the \"symbolic/apps\" folders"
  (
     cd 16x16/symbolic/apps || exit 1
        find * -name '*.svg' ! -name '*-symbolic.svg' 2>/dev/null |
        while IFS= read -r file
           do mv "${file}" "${file%.svg}"-symbolic.svg
         done

  )
  (
     cd 16x16/symbolic/apps || exit 1
        find . -type l | while IFS= read -r link
        do target=$(readlink -- "$link") || continue
           case "$target" in
         *.svg) newtarget=${target%.svg}-symbolic.svg
                ln -sf -- "$newtarget" "$link"
             ;;
           esac
       done
  )
_footer

_header "Colorize \"16x16/status\" icons"
    (
     cd 16x16/status || exit 1
        makelightcolor
    )
_footer

_header "Colorize \"22x22/status\" icons"
    (
     cd 22x22/status || exit 1
        makelightcolor
    )
_footer

_header "Colorize \"24x24/status\" icons"
    (
     cd 24x24/status || exit 1
        makelightcolor
    )
_footer

makelightcursor

for files in AUTHORS diagonal-release
    do cp -a "${_basedir}/${files}" .
  done

cp -a "${_basedir}/wm/xfce/index.theme" .
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
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/devices" .
     ln -s "../../Diagonal${__wmtype}${__distro}/24x24/emblems" .
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/mimetypes" .
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/places" .
     cp -a "../../Diagonal${__wmtype}${__distro}/24x24/status" .
     ln -s status panel
     ln -s "../64x64/apps" .
     ln -s apps categories
     ln -s "../../Diagonal${__wmtype}${__distro}/24x24/emotes" .
    )
_footer

_header "Copying \"22x22\" icons"
    (
     cd 22x22 || exit 1
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/actions" .
     ln -s ../24x24/animations .
     ln -s "../64x64/apps" .
     ln -s apps categories
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/devices" .
     ln -s "../../Diagonal${__wmtype}${__distro}/22x22/emblems" .
     ln -s "../../Diagonal${__wmtype}${__distro}/22x22/emotes" .
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/mimetypes" .
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/places" .
     cp -a "../../Diagonal${__wmtype}${__distro}/22x22/status" .
     ln -s status panel
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
         ln -s ../actions .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/apps" .
         ln -s apps categories
         ln -s ../devices .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/emblems" .
         cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/emotes" .
         ln -s ../mimetypes .
         ln -s ../places .
         ln -s ../status .
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
        -o -path '*status' -o -path '*devices' -o -path '*places' \) 2>/dev/null |
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
        \( -path '*actions' -o -path '*mimetypes' -o -path '*devices' \
        -o -path '*status' -o -path '*animations' -o -path '*places' \) 2>/dev/null |
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

for files in AUTHORS index.theme diagonal-release
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
mkdir -p 16x16 16x16/symbolic 22x22 24x24
ln -s "../Diagonal${__wmtype}${__distro}/8x8" .
ln -s "../Diagonal${__wmtype}${__distro}/18x18" .
ln -s "../Diagonal${__wmtype}${__distro}/32x32" .
ln -s "../Diagonal${__wmtype}${__distro}/42x42" .
ln -s "../Diagonal${__wmtype}${__distro}/48x48" .
ln -s "../Diagonal${__wmtype}${__distro}/64x64" .
ln -s "../Diagonal${__wmtype}${__distro}/84x84" .
ln -s "../Diagonal${__wmtype}${__distro}/96x96" .
ln -s "../Diagonal${__wmtype}${__distro}/128x128" .
ln -s "../Diagonal${__wmtype}${__distro}/cursors" .
ln -s 16x16 16x16@2x
ln -s 18x18 18x18@2x
ln -s 22x22 22x22@2x
ln -s 24x24 24x24@2x
ln -s 32x32 32x32@2x
ln -s 48x48 48x48@2x
ln -s 64x64 64x64@2x
_footer

_header "Copying \"16x16\" icons"
    (
        cd 16x16 || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/16x16/actions" .
        ln -s "../../Diagonal${__wmtype}${__distro}/16x16/apps" .
        ln -s apps categories
        ln -s "../../Diagonal${__wmtype}${__distro}/16x16/devices" .
        ln -s "../../Diagonal${__wmtype}${__distro}/16x16/emblems" .
        ln -s "../../Diagonal${__wmtype}${__distro}/16x16/emotes" .
        ln -s "../../Diagonal${__wmtype}${__distro}/16x16/mimetypes" .
        ln -s "../../Diagonal${__wmtype}${__distro}/16x16/places" .
        cp -a "../../Diagonal${__wmtype}${__distro}/16x16/status" .
        ln -s symbolic symbolic-up-to-20
        ln -s status panel
        (
          cd symbolic || exit 1
             ln -s ../actions .
             ln -s "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/apps" .
             ln -s apps categories
             ln -s ../devices
             ln -s "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/emblems" .
             ln -s "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/emotes" .
             ln -s ../mimetypes .
             ln -s ../places .
             cp -a "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/status" .
             ln -s "../../../Diagonal${__wmtype}${__distro}/16x16/symbolic/up-to-32" .
        )
    )
_footer

_header "Copying \"24x24\" icons"
    (
        cd 24x24 || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/actions" .
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/animations" .
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/apps" .
        ln -s apps categories
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/devices" .
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/emblems" .
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/emotes" .
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/mimetypes" .
        ln -s "../../Diagonal${__wmtype}${__distro}/24x24/places" .
        cp -a "../../Diagonal${__wmtype}${__distro}/24x24/status" .
        ln -s status panel
    )
_footer

_header "Copying \"22x22\" icons"
    (
        cd 22x22 || exit 1
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/actions" .
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/animations" .
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/apps" .
        ln -s apps categories
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/devices" .
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/emblems" .
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/emotes" .
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/mimetypes" .
        ln -s "../../Diagonal${__wmtype}${__distro}/22x22/places" .
        cp -a "../../Diagonal${__wmtype}${__distro}/22x22/status" .
        ln -s status panel
    )
_footer

_header "Colorize \"16x16/status\" icons"
    (
     cd 16x16/status || exit 1
        makedarkcolor
    )
_footer

_header "Colorize \"22x22/status\" icons"
    (
     cd 22x22/status || exit 1
        makedarkcolor
    )
_footer

_header "Colorize \"24x24/status\" icons"
    (
     cd 24x24/status || exit 1
        makedarkcolor
    )
_footer

for files in AUTHORS index.theme diagonal-release
    do cp -a "../Diagonal${__wmtype}${__distro}/${files}" .
  done
  sed_inplace "s/Diagonal${__wmtype}${__distro}/Diagonal${__wmtype}${__distro}-light/g" index.theme

cd "${_basefolder}" || exit 1

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

