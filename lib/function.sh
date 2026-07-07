#!/bin/sh
# Not a standalone file, please don't run it on its own.

_root_uid="0"
_tmpinstall="/tmp"
_workfolder="${_tmpinstall}/Diagonal"
_basefolder="${_workfolder}/Diagonal${__wmtype}${__distro}"
_version="$(cat diagonal-release)"
_dist="${__distro#-}"
_sed_inplace_style=""
bow="\033[30;47m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
magenta="\033[1;35m"
cyan="\033[1;36m"
wob="\033[37;40m"
reset="\033[0m"
_colorfg="7dbaff"
_colorbg="3e8ae6"
_colorline="00c110"

_line() {
printf ";;; **********************************************************************|\n"
}

distrocheck() {
_distro=""
if [ -f /etc/os-release ]
   then _did=$(
                (
                  . /etc/os-release
                  printf '%s\n' "$ID"
                )
              )
    case "$_did" in
           arch ) _distro="Arch"      ;;
        cachyos ) _distro="Cachyos"   ;;
         debian ) _distro="Debian"    ;;
        fedora* ) _distro="Fedora"    ;;
         gentoo ) _distro="Gentoo"    ;;
        kubuntu ) _distro="Kubuntu"   ;;
        manjaro ) _distro="Manjaro"   ;;
      linuxmint ) _distro="Mint"      ;;
      opensuse* ) _distro="OpenSuse"  ;;
      slackware ) _distro="Slackware" ;;
         ubuntu ) _distro="Ubuntu"    ;;
        freebsd ) _distro="FreeBSD"   ;;
              * ) _distro=""          ;;
    esac
  else
    case "$(uname -s)" in
      FreeBSD ) _distro="FreeBSD" ;;
      OpenBSD ) _distro="OpenBSD" ;;
             * ) _distro=""       ;;
    esac
  fi
}

idcheck() {
  if [ "$(id -u)" -eq "${_root_uid}" ]
     then case "${_distro}" in
OpenBSD | openbsd ) if [ ! -d "/usr/local/share/icons" ]
                       then mkdir -p /usr/local/share/icons
                            _install_dir="/usr/local/share/icons"
                       else _install_dir="/usr/local/share/icons"
                    fi
                 ;;
                * ) _install_dir="/usr/share/icons"
                 ;;
          esac
elif [ ! -d "$HOME/.local/share/icons" ]
     then mkdir -p "$HOME/.local/share/icons"
          _install_dir="$HOME/.local/share/icons"
          if [ ! -e "$HOME/.icons" ]
             then ln -s "${_install_dir}" "$HOME/.icons"
          fi
elif [ ! -e "$HOME/.icons" ]
     then _install_dir="$HOME/.local/share/icons"
          ln -s "${_install_dir}" "$HOME/.icons"
     else
    _install_dir="$HOME/.local/share/icons"
  fi
}

wmcheck() {
  case $(printf '%s' "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]') in
       ( *kde* ) _wmtype="kde"      ;;
     ( *gnome* ) _wmtype="gnome"    ;;
  ( *cinnamon* ) _wmtype="cinnamon" ;;
      ( *mate* ) _wmtype="mate"     ;;
      ( *xfce* ) _wmtype="xfce"     ;;
    ( *budgie* ) _wmtype="budgie"   ;;
           ( * ) _wmtype=""         ;;
  esac
}

detect_sed_inplace() {
    [ -n "${_sed_inplace_style}" ] && return 0
    tmpfile="$(mktemp /tmp/sedtest.XXXXXX 2>/dev/null || echo "/tmp/sedtest.$$")"
    printf "test\n" > "${tmpfile}"
    if sed -i "" "s/test/ok/" "${tmpfile}" 2>/dev/null
       then _sed_inplace_style="bsd"
  elif sed -i "s/test/ok/" "${tmpfile}" 2>/dev/null
       then _sed_inplace_style="gnu"
    fi
    rm -f "${tmpfile}"
}

sed_inplace() {
    [ "$#" -ge 2 ]
    detect_sed_inplace
    script=$1
    shift
    case "${_sed_inplace_style}" in
        gnu)
            sed -i "${script}" "$@" ;;
        bsd)
            sed -i "" "${script}" "$@" ;;
    esac
}

show_progress() {
    message="${1:-Processing}"
    printf ";;; %b%s%b" "${blue}" "${message}" "${reset}"
    i=0
    while :; do
        i=$(( (i + 1) % 4 ))
        case "${i}" in
            0) dots="   " ;;
            1) dots="."   ;;
            2) dots=".."  ;;
            3) dots="..." ;;
        esac
        printf "\r;;; %b%s%s%b" "${blue}" "${message}" "${dots}" "${reset}"
        sleep 0.5
    done
}

_header() {
    message="${1:-Processing}"
    show_progress "${message}" &
    pid=$!
    trap 'kill "${pid}" 2>/dev/null; wait "${pid}" 2>/dev/null;
          printf "\n;;; %bTerminated by user%b\n" "${red}" "${reset}";
          exit 1' INT TERM
}

_footer() {
    kill "${pid}" 2>/dev/null
    wait "${pid}" 2>/dev/null
    trap - INT TERM
    printf "\r;;; %b%s... %bdone.%b\n" "${blue}" "${message}" "${green}" "${reset}"
}

rmworkfolder() {
if [ -d "${_workfolder}" ]
   then _header "Delete old temporary files"
        rm -rf "${_workfolder}"
        _footer
        mkdir -p "${_workfolder}"
   else mkdir -p "${_workfolder}"
fi
}

makelightcursor() {
    _header "Creating cursor themes for the light theme"
    case "${__distro}" in
                     -ubuntu ) cp -a "${_basedir}/cursors/light/orange/cursors" . ;;
-opensuse | -manjaro | -mint | -cachyos ) cp -a "${_basedir}/cursors/light/green/cursors" .  ;;
                           * ) cp -a "${_basedir}/cursors/light/base/cursors" .   ;;
    esac
    _footer
}

makedarkcursor() {
    _header "Creating cursor themes for the dark theme"
    case "${__distro}" in
                      -ubuntu ) cp -a "${_basedir}/cursors/dark/orange/cursors" .   ;;
-opensuse | -manjaro | -mint | -cachyos ) cp -a "${_basedir}/cursors/dark/green/cursors" .    ;;
                            * ) cp -a "${_basedir}/cursors/dark/base/cursors" .     ;;
    esac
    _footer
}

makecache() {
     _header "Diagonal${__wmtype}${__distro} icon pack compilation"
     if command -v gtk-update-icon-cache >/dev/null 2>&1
        then for pack in "Diagonal${__wmtype}${__distro}" \
                         "Diagonal${__wmtype}${__distro}-dark" \
                         "Diagonal${__wmtype}${__distro}-light"
              do if [ -d "${pack}" ]
                    then gtk-update-icon-cache -f "${pack}" 1>/dev/null 2>&1
                 fi
            done
    fi
_footer
}

makeiconpack() {
_header "Compressing icon pack"
     cd "${_workfolder}" || exit 1
     case "${_distro}" in
OpenBSD | openbsd )
            _compresscmd="tar -cjf"
            _archiveext="tar.bz2"
               ;;
                * )
            _compresscmd="tar -cJf"
            _archiveext="tar.xz"
               ;;
     esac
     ${_compresscmd} "Diagonal${__wmtype}${__distro}-${_version}.${_archiveext}" *
 _footer
}

copyiconpack()
{
    _header "Installing icon pack"
    for pack in "Diagonal${__wmtype}${__distro}" \
                "Diagonal${__wmtype}${__distro}-dark" \
                "Diagonal${__wmtype}${__distro}-light"
             do if [ -d "${pack}" ]
                   then cp -a "${pack}" "${_install_dir}"
                fi
           done
     case "${__wmtype}" in
          -gnome ) (
                     cd "${_install_dir}" || exit 1
                        ln -s "Diagonal${__wmtype}${__distro}" "Diag-g${__distro}"
                        ln -s "Diagonal${__wmtype}${__distro}-dark" "Diag-g${__distro}-dark"
                        ln -s "Diagonal${__wmtype}${__distro}-light" "Diag-g${__distro}-light"
                   )
          ;;
     esac
    _footer
}

makefoldercolor() {
    _header "Installing selected folder colors"
    for file in $(find * -type f -name '*.svg')
     do case "${__foldercolor}" in
            Blue ) sed_inplace -e "s/${_colorfg}/0f72e5/g" -e "s/${_colorbg}/053b7b/g" "${file}" ;;
             Red ) sed_inplace -e "s/${_colorfg}/e01b24/g" -e "s/${_colorbg}/a51d2d/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           Green ) sed_inplace -e "s/${_colorfg}/29b668/g" -e "s/${_colorbg}/165e3c/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           Black ) sed_inplace -e "s/${_colorfg}/3b3b3b/g" -e "s/${_colorbg}/040404/g" "${file}" ;;
          Yellow ) sed_inplace -e "s/${_colorfg}/ffcb3a/g" -e "s/${_colorbg}/ffad0b/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
            Cyan ) sed_inplace -e "s/${_colorfg}/00ac9e/g" -e "s/${_colorbg}/0b5765/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         Magenta ) sed_inplace -e "s/${_colorfg}/fa0394/g" -e "s/${_colorbg}/c01a7b/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          Violet ) sed_inplace -e "s/${_colorfg}/a27bec/g" -e "s/${_colorbg}/6220dc/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
            Grey ) sed_inplace -e "s/${_colorfg}/697489/g" -e "s/${_colorbg}/454e5b/g" "${file}" ;;
          Orange ) sed_inplace -e "s/${_colorfg}/f7711e/g" -e "s/${_colorbg}/cb4e00/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          Ubuntu ) sed_inplace -e "s/${_colorfg}/666666/g" -e "s/${_colorbg}/e65524/g" -e "s/${_colorline}/752a71/g" "${file}" ;;
        esac
    done
    _footer
}

makedistrofolder() {
    _header "Creating distribution-specific directory folder"
    for file in $(find * -type f -name '*.svg')
     do case "${_dist}" in
           arch ) sed_inplace -e "s/${_colorfg}/55a8d1/g" -e "s/${_colorbg}/168bc4/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
        cachyos ) sed_inplace -e "s/${_colorfg}/33c175/g" -e "s/${_colorbg}/00adf9/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         debian ) sed_inplace -e "s/${_colorfg}/f8125e/g" -e "s/${_colorbg}/283e48/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         fedora ) sed_inplace -e "s/${_colorfg}/4d7ed7/g" -e "s/${_colorbg}/214b97/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
        freebsd ) sed_inplace -e "s/${_colorfg}/dd003b/g" -e "s/${_colorbg}/66000b/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         gentoo ) sed_inplace -e "s/${_colorfg}/a27bec/g" -e "s/${_colorbg}/6220dc/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
        kubuntu ) sed_inplace -e "s/${_colorfg}/1370ff/g" -e "s/${_colorbg}/004cc0/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
        manjaro ) sed_inplace -e "s/${_colorfg}/00ac9e/g" -e "s/${_colorbg}/0b5765/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           mint ) sed_inplace -e "s/${_colorfg}/28bd37/g" -e "s/${_colorbg}/20a12d/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
        openbsd ) sed_inplace -e "s/${_colorfg}/eaa100/g" -e "s/${_colorbg}/a06e00/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
       opensuse ) sed_inplace -e "s/${_colorfg}/4ba520/g" -e "s/${_colorbg}/025575/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
      slackware ) sed_inplace -e "s/${_colorfg}/8faaee/g" -e "s/${_colorbg}/4861a0/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         ubuntu ) sed_inplace -e "s/${_colorfg}/666666/g" -e "s/${_colorbg}/e95420/g" -e "s/${_colorline}/752a71/g" "${file}" ;;
       esac
   done
   _footer
}
