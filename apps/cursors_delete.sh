#!/bin/sh

_icon_base="Diagonal"
_sys_dir="/usr/share/icons"
_usr_dir="$HOME/.local/share/icons"
_usr_icondir="~/.icons"
_nix_icondir="/var/opt/icons"
_bsd_icondir="/usr/local/share/icons"
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

install_usage()
{
clear ;
_line
printf ";;; \n"
printf ";;; %bThis program helps you remove Diagonal cursor themes.%b\n" "${blue}" "${reset}"
printf ";;;\n"
_line
}

install_usage

delete_theme_set()
{   base=$1
    for dir in "${_sys_dir}" "${_usr_dir}" "${_usr_icondir}" "${_nix_icondir}" "${_bsd_icondir}"
     do path="${dir}/${base}"
            if [ -d "${path}" ]
               then if [ "${dir}" = "${_sys_dir}" ] && [ "$(id -u)" -ne 0 ]
                       then if [ -n "${_auto_priv}" ]
                               then printf ";;; \n"
                                    printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                                    printf ";;; \n"
                                    $_auto_priv rm -rf "${path}"
                               else printf ";;; \n"
                                    printf ";;; %bPermission required to delete: %s\n" "${red}" "${path}" "${reset}"
                                    printf ";;; \n"
                            fi
                  elif [ "${dir}" = "${_bsd_icondir}" ] && [ "$(id -u)" -ne 0 ]
                       then if [ -n "${_auto_priv}" ]
                               then printf ";;; \n"
                                    printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                                    printf ";;; \n"
                                    $_auto_priv rm -rf "${path}"
                               else printf ";;; \n"
                                    printf ";;; %bPermission required to delete: %s\n" "${red}" "${path}" "${reset}"
                                    printf ";;; \n"
                            fi
                  elif [ "${dir}" = "${_nix_icondir}" ] && [ "$(id -u)" -ne 0 ]
                       then if [ -n "${_auto_priv}" ]
                               then printf ";;; \n"
                                    printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                                    printf ";;; \n"
                                    $_auto_priv rm -rf "${path}"
                               else printf ";;; \n"
                                    printf ";;; %bPermission required to delete: %s\n" "${red}" "${path}" "${reset}"
                                    printf ";;; \n"
                            fi
                       else printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                            printf ";;; \n"
                            rm -rf "${path}"
                    fi
            fi
     done
}

list_cursor_dirs()
{
    for base in "${_sys_dir}" "${_usr_dir}" "${_usr_icondir}" "${_nix_icondir}" "${_bsd_icondir}"
    do [ -d "$base" ] || continue
        for d in "$base"/*
        do [ -d "$d" ] || continue
            case "${d##*/}" in
                "${_icon_base}"*cursors )
                  printf '%s\n' "$d"
                    ;;
            esac
        done
    done | sort -u
}

dirs_list=$(list_cursor_dirs)

  if command -v doas >/dev/null 2>&1
     then _auto_priv="doas"
elif command -v sudo >/dev/null 2>&1
     then _auto_priv="sudo"
     else _auto_priv=""
  fi

if [ -z "${dirs_list}" ]
   then clear ;
        printf ";;; \n"
        printf ";;;%b No installed Diagonal cursor theme found %s%b\n" "${red}" "(${_icon_base}*)." "${reset}"
        printf ";;; \n"
        printf ";;; \n"
        exit 0
fi

printf ";;; \n"
printf ";;;%b Installed Diagonal cursor themes:%b\n" "${blue}" "${reset}"
printf ";;; \n"
i=1
while IFS= read -r d
   do [ -z "${d}" ] && continue
      base=$(basename "${d}")
      printf ";;; %d) %b%s%b\n" "${i}" "${red}" "${base}" "${reset}"
      eval "opt_${i}=\${base}"
      i=$((i + 1))
done <<EOF
$dirs_list
EOF
total=$((i - 1))


printf ";;; \n"
printf ";;; %bEnter the number of the cursor theme to be deleted:%b \n" "${blue}" "${reset}"
read -r choice </dev/tty
case ${ans} in
y | Y | yes | Yes )
while IFS= read -r d
   do [ -z "${d}" ] && continue
      base=$(basename "${d}")
      delete_theme_set "${base}"
 done <<EOF
"${dirs_list}"
EOF
esac

i=1
while [ "${i}" -le "${total}" ]
      do eval "base=\$opt_${i}"
         if [ "${i}" -eq "${choice}" ] 2>/dev/null
            then printf ";;; \n"
                 _line
                 printf ";;; \n"
                 printf ";;; %bYou will deleted the following cursor themes:%b \n" "${blue}" "${reset}"
                 printf ";;; \n"
                 printf ";;; %b%s%b\n" "${red}" "${base}" "${reset}"
                 printf ";;; \n"
                 printf ";;; %bAre you continuing?%b \n" "${blue}" "${reset}"
                 printf ";;; \n"
                 printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
                 read -r ans </dev/tty
        case ${ans} in
y | Y | yes | Yes ) _line
                    printf ";;; \n"
                    delete_theme_set "${base}"
                    printf ";;; \n"
                 ;;
                * ) _line
                    printf ";;; \n"
                    printf ";;; %bDelete canceled.%b \n" "${blue}" "${reset}"
                    printf ";;; \n"
                    printf ";;; \n"
                ;;
        esac
        exit 0
    fi
    i=$((i + 1))
done

printf ";;; \n"
printf ";;;%b %s%b\n" "${red}" "There is no such cursor theme." "${reset}"
printf ";;; \n"
printf "\n"

exit 1
