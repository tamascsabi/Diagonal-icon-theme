#!/bin/sh

_sys_dir="/usr/share/icons"
_usr_dir="$HOME/.local/share/icons"
_usr_icondir="$HOME/.icons"
_nix_icondir="/var/opt/icons"
_bsd_icondir="/usr/local/share/icons"
_homesnapdir="$HOME/.local/share/applications"
_git_dir="/base/scalable/"
_missing_file="/tmp/missing.txt"
red="\033[1;31m"
reset="\033[0m"
_basedir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
_rootdir=$(CDPATH= cd -- "$_basedir/.." && pwd)

cd "${_rootdir}" 2>/dev/null || {
    printf ";;;\n"
    printf ";;; %bERROR!!! I can't change to the installation directory.%b\n" "${red}" "${reset}"
    printf ";;; %bPlease start the program from the parent directory.%b\n" "${red}" "${reset}"
    printf ";;;\n"
    exit 1
}

. "${_rootdir}/lib/function.sh"

root_usage()
{
clear ;
printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bThe program does not run with root privileges !!!%b\n" "${red}" "${reset}"
printf ";;; %bYou can only use it as a user.%b\n" "${red}" "${reset}"
printf ";;; \n"
_line
printf ";;; \n"
}

usage() {
clear ;
_line
printf ";;; \n"
printf ";;; %bThis program replaces the icons of Snap programs.%b\n" "${blue}" "${reset}"
printf ";;; %bThe program does not override system-wide settings.%b\n" "${blue}" "${reset}"
printf ";;; %bIt only modifies desktop files in your own user account.%b\n" "${blue}" "${reset}"
printf ";;; %bIf you install a Snap package, always run it.%b\n" "${blue}" "${reset}"
printf ";;; %bThis will update the app icons.%b\n" "${blue}" "${reset}"
printf ";;; %bShould I update my Snap icons?%b\n" "${blue}" "${reset}"
printf ";;; %b y (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
printf ";;; \n"
read -r _install_answer
        case $_install_answer in
y | Y | yes | Yes) :
            ;;
                *) exit 0
            ;;
        esac
}

copysnapfile()
{
cd "${_snapdir}" || exit 1
 for i in *.desktop
  do _stripapp=${i##*/}
     if [ ! -f "${_homesnapdir}/${_stripapp}" ]
        then cp -a "${i}" "${_homesnapdir}"
     fi
done
}

editsnapfile()
{
cd "${_homesnapdir}" || exit 1
 for snapdfile in *.desktop
  do if ! grep '^Icon=' "${snapdfile}" >/dev/null
        then break
   elif grep '^Icon=.*symbolic' "${snapdfile}" >/dev/null
        then break
   elif grep '^Icon=.*icon.png$' "${snapdfile}" >/dev/null
        then _appname="$(grep 'X-SnapInstanceName=' "${snapdfile}")"
             _stripappname="${_appname##*=}"
             if [ -f "${_rootdir}${_git_dir}/apps/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/places/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/devices/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
                else printf "%s\n" "${_stripappname}" >> "${_missing_file}"

             fi
   elif grep '^Icon=.*icon.svg$' "${snapdfile}" >/dev/null
        then _appname="$(grep 'X-SnapInstanceName=' "${snapdfile}")"
             _stripappname="${_appname##*=}"
             if [ -f "${_rootdir}${_git_dir}/apps/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/places/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/devices/${_stripappname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${snapdfile}"
                else printf "%s\n" "${_stripappname}" >> "${_missing_file}"
             fi
   elif grep '^Icon=/' "${snapdfile}" >/dev/null
        then _iconlabel="$(grep 'Icon=' "${snapdfile}")"
             _stripiconlabel="${_iconlabel##*/}"
             case "$_stripiconlabel" in
              *.png | *.svg) _iconname="${_stripiconlabel%.*}"
                        ;;
                         * ) _iconname="$_stripiconlabel"
                        ;;
             esac
             if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/places/${_iconname}.svg" ]
                then  sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_iconname}.svg" ]
                then  sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/devices/${_iconname}.svg" ]
                then  sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
                else printf "%s\n" "${_iconname}" >> "${_missing_file}"
             fi
   elif grep '^Icon=[a-zA-Z0-9]' "${snapdfile}" >/dev/null
        then _iconlabel="$(grep 'Icon=' "${snapdfile}")"
             _stripiconlabel="${_iconlabel##*=}"
             case "$_stripiconlabel" in
               *.png | *.svg) _iconname="${_stripiconlabel%.*}"
                         ;;
                           *) _iconname="$_stripiconlabel"
                         ;;
             esac
             if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/places/${_iconname}.svg" ]
                then  sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_iconname}.svg" ]
                then  sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
           elif [ -f "${_rootdir}${_git_dir}/devices/${_iconname}.svg" ]
                then  sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${snapdfile}"
                else printf "%s\n" "${_iconname}" >> "${_missing_file}"
             fi
        else printf "%s\n" "${_iconname}" >> "${_missing_file}"
     fi
done
}

if [ "$(id -u)" -eq "${_root_uid}" ]
   then root_usage
        exit 1
fi

if ! command -v snap >/dev/null 2>&1
   then clear
        printf ";;; \n"
        _line
        printf ";;; \n"
        printf ";;; %bThe system does not use Snap.%b\n" "${red}" "${reset}"
        printf ";;; %bThe program only works when using Snap.%b\n" "${red}" "${reset}"
        printf ";;; \n"
        _line
        printf ";;; \n"
        exit 1
fi

if [ -f "${_missing_file}" ]
   then rm -rf "${_missing_file}"
fi

usage
_snapbase="$(printf '%s\n' "$XDG_DATA_DIRS" | tr ':' '\n' | grep 'snapd' | grep -v '^/home')"
_snapdir="${_snapbase}/applications"
_diagonal_theme=""

for dir in "${_sys_dir}" "${_usr_dir}" "${_usr_icondir}" "${_nix_icondir}" "${_bsd_icondir}"
do if [ -d "$dir" ]
      then _diagonal_theme=$(find "$dir" -type d -name 'Diagonal-*' 2>/dev/null)
           if [ -n "${_diagonal_theme}" ]
              then break
           fi
  fi
done

if [ -z "${_diagonal_theme}" ]
   then clear
        printf ";;; \n"
        _line
        printf ";;; \n"
        printf ";;; %bNo Diagonal icon theme installed.%b\n" "${red}" "${reset}"
        printf ";;; %bInstall a Diagonal theme to use the program.%b\n" "${red}" "${reset}"
        printf ";;; \n"
        _line
        printf ";;; \n"
        exit 1
fi

if [ -f "${_missing_file}" ]
   then rm -rf "${_missing_file}"
fi

if find "${_snapdir}" -type f -name '*.desktop' >/dev/null
   then if [ ! -d "${_homesnapdir}" ]
           then mkdir -p "${_homesnapdir}"
                _header "Find and edit application icons"
                copysnapfile
                editsnapfile
                _footer
           else _header "Find and edit application icons"
                copysnapfile
                editsnapfile
                _footer
        fi
   else _line
        printf ";;; \n"
        printf ";;; %bYou are not yet using any apps installed by Snap.%b\n" "${blue}" "${reset}"
        printf ";;; %bIf you install your Snap app, run the program again.%b\n" "${blue}" "${reset}"
        printf ";;; \n"
        _line
        exit 1
fi

if [ -f "${_missing_file}" ]
   then cat "${_missing_file}" | sort | uniq > "${_missing_file}.sort"
        mv "${_missing_file}.sort" "${_missing_file}"
        _line
        printf ";;; \n"
        printf ";;; %bUpdate complete.%b\n" "${blue}" "${reset}"
        printf ";;; %bI couldn't update some icons because they weren't in the icon set.%b\n" "${blue}" "${reset}"
        printf ";;; %bMissing icons:%b\n" "${blue}" "${reset}"
        printf ";;; \n"
        cat "${_missing_file}" |
        while IFS= read -r i
           do printf ";;; %b - %s%b\n" "${cyan}" "${i}" "${reset}"
         done
        printf ";;; \n"
        _line
        printf "\n"
   else _line
        printf ";;; \n"
        printf ";;; %bUpdate complete.%b\n" "${blue}" "${reset}"
        printf ";;; \n"
        _line
        printf "\n"
fi

exit 0
