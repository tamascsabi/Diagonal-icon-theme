#!/bin/sh

_sys_dir="/usr/share/icons"
_usr_dir="$HOME/.local/share/icons"
_usr_icondir="$HOME/.icons"
_nix_icondir="/var/opt/icons"
_bsd_icondir="/usr/local/share/icons"
_git_dir="/base/scalable/"
_tempdir="/tmp/diagonal"
_missing_file="/tmp/missing"
_appdir="/usr/share/applications"
_homeappdir="$HOME/.local/share/applications"
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
printf ";;; %bThis program replaces the icons of other programs.%b\n" "${blue}" "${reset}"
printf ";;; %bThe program does not override system-wide settings.%b\n" "${blue}" "${reset}"
printf ";;; %bIt only modifies desktop files in your own user account.%b\n" "${blue}" "${reset}"
printf ";;; %bThis will update the app icons.%b\n" "${blue}" "${reset}"
printf ";;; %bShould I update icons?%b\n" "${blue}" "${reset}"
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

copyappfile()
{
cd "${_appdir}" || exit 1
 for i in *.desktop
  do _stripapp=${i##*/}
     if [ ! -f "${_homeappdir}/${_stripapp}" ]
        then cp -a "${i}" "${_tempdir}"
     fi
done
}

editappfile()
{
cd "${_tempdir}" || exit 1
 for appfile in *.desktop
  do if ! grep '^Icon=' "${appfile}" >/dev/null
        then rm -rf "${appfile}"
   elif grep '^Icon=.*symbolic' "${appfile}" >/dev/null
        then rm -rf "${appfile}"
   elif grep '^Icon=.*icon.png$' "${appfile}" >/dev/null
        then _iconlabel="$(grep '^Icon=/' "${appfile}")"
             _stripiconlabel="${_iconlabel##*/}"
             case "$_stripiconlabel" in
              icon.png) _appname="$(grep -m 1 '^Name=' "${appfile}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"
                        _stripappname="${_appname##*=}"
                        if [ -f "${_rootdir}${_git_dir}/apps/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/places/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/devices/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                           else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                                rm -rf "${appfile}"
                        fi
                        ;;
                    * ) _iconname="${_stripiconlabel%.png}"
                        if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/places/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/devices/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                           else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                                rm -rf "${appfile}"
                        fi
                        ;;
             esac
   elif grep '^Icon=.*icon.svg$' "${appfile}" >/dev/null
        then _iconlabel="$(grep '^Icon=/' "${appfile}")"
             _stripiconlabel="${_iconlabel##*/}"
             case "$_stripiconlabel" in
              icon.svg) _appname="$(grep -m 1 '^Name=' "${appfile}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"
                        _stripappname="${_appname##*=}"
                        if [ -f "${_rootdir}${_git_dir}/apps/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/places/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/devices/${_stripappname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                           else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                                rm -rf "${appfile}"
                        fi
                        ;;
                    * ) _iconname="${_stripiconlabel%.svg}"
                        if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/places/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                      elif [ -f "${_rootdir}${_git_dir}/devices/${_iconname}.svg" ]
                           then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                           else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                                rm -rf "${appfile}"
                        fi
                        ;;
             esac
   elif grep '^Icon=/' "${appfile}" >/dev/null
        then _iconlabel="$(grep '^Icon=/' "${appfile}")"
             _stripiconlabel="${_iconlabel##*/}"
             case "$_stripiconlabel" in
              *.png | *.svg) _iconname="${_stripiconlabel%.*}"
                        ;;
                         * ) _iconname="$_stripiconlabel"
                        ;;
             esac
             if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
           elif [ -f "${_rootdir}${_git_dir}/places/${_iconname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
           elif [ -f "${_rootdir}${_git_dir}/mimetypes/${_iconname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
           elif [ -f "${_rootdir}${_git_dir}/devices/${_iconname}.svg" ]
                then sed_inplace "s|^Icon=.*$|Icon=${_iconname}|" "${appfile}"
                else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                     rm -rf "${appfile}"
             fi
   elif grep '^Icon=[a-zA-Z0-9]' "${appfile}" >/dev/null
        then _iconlabel="$(grep '^Icon=' "${appfile}")"
             _stripiconlabel="${_iconlabel##*=}"
             case "$_stripiconlabel" in
               *.svg) _iconname="${_stripiconlabel%.svg}"
                      if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                         then rm -rf "${appfile}"
                         else _appname="$(grep -m 1 '^Name=' "${appfile}" \
                              | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"
                              _stripappname="${_appname##*=}"
                              if [ -f "${_rootdir}${_git_dir}/apps/${_stripappname}.svg" ]
                                 then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                                 else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                                      rm -rf "${appfile}"
                              fi
                      fi
                   ;;
               *.png) _iconlabel="$(grep '^Icon=' "${appfile}")"
                      _stripiconlabel="${_iconlabel##*=}"
                      _iconname="${_stripiconlabel%.png}"
                      if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                         then rm -rf "${appfile}"
                         else _appname="$(grep -m 1 '^Name=' "${appfile}" \
                              | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"
                              _stripappname="${_appname##*=}"
                              if [ -f "${_rootdir}${_git_dir}/apps/${_stripappname}.svg" ]
                                 then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                                 else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                                      rm -rf "${appfile}"
                              fi
                      fi
                   ;;
                   *) _iconname="$_stripiconlabel"
                      if [ -f "${_rootdir}${_git_dir}/apps/${_iconname}.svg" ]
                         then rm -rf "${appfile}"
                         else _appname="$(grep -m 1 '^Name=' "${appfile}" \
                              | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"
                              _stripappname="${_appname##*=}"
                              if [ -f "${_rootdir}${_git_dir}/apps/${_stripappname}.svg" ]
                                 then sed_inplace "s|^Icon=.*$|Icon=${_stripappname}|" "${appfile}"
                                 else printf "%s\n" "${appfile%.desktop}" >> "${_missing_file}"
                                      rm -rf "${appfile}"
                              fi
                      fi
                   ;;
             esac
        rm -rf "${appfile}"
     fi
done
}


if [ "$(id -u)" -eq "${_root_uid}" ]
   then root_usage
        exit 1
fi

usage
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
   then printf ";;; \n"
        _line
        printf ";;; \n"
        printf ";;; %bNo Diagonal icon theme installed.%b\n" "${red}" "${reset}"
        printf ";;; %bInstall a Diagonal theme to use the program.%b\n" "${red}" "${reset}"
        printf ";;; \n"
        _line
        printf ";;; \n"
        exit 1
fi

if [ -d "${_tempdir}" ]
   then rm -rf "${_tempdir}" && mkdir -p "${_tempdir}"
   else mkdir -p "${_tempdir}"
fi

if [ -f "${_missing_file}" ]
   then rm -rf "${_missing_file}"
fi

if find "${_appdir}" -type f -name '*.desktop' >/dev/null
   then if [ ! -d "${_homeappdir}" ]
           then mkdir -p "${_homeappdir}"
                _header "Find and edit application icons"
                copyappfile
                editappfile
                (
                cd "${_tempdir}" || exit 1
                for i in $(find . -type f -name '*.desktop')
                 do if [ ! -f "${_homeappdir}/$i" ]
                       then cp -a "${_tempdir}/$i" "${_homeappdir}"
                    fi
               done
                )
                _footer
           else _header "Find and edit application icons"
                copyappfile
                editappfile
                (
                cd "${_tempdir}" || exit 1
                for i in $(find . -type f -name '*.desktop')
                 do if [ ! -f "${_homeappdir}/$i" ]
                       then cp -a "${_tempdir}/$i" "${_homeappdir}"
                    fi
               done
                )
                _footer
        fi
   else _line
        printf ";;; \n"
        printf ";;; %bNo applications are installed yet.%b\n" "${blue}" "${reset}"
        printf ";;; \n"
        _line
        exit 1
fi

if [ -f "${_missing_file}" ]
   then cat "${_missing_file}" | sort | uniq > "${_missing_file}.sort"
        mv "${_missing_file}.sort" "${_missing_file}"
        printf ";;; \n"
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
   else
        _line
        printf ";;; \n"
        printf ";;; %bUpdate complete.%b\n" "${blue}" "${reset}"
        printf ";;; \n"
        _line
        printf "\n"
fi

exit 0
