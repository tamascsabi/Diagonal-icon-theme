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

cd "${_basedir}" 2>/dev/null || {
    printf ";;;\n"
    printf ";;; %bERROR!!! I can't change to the installation directory.%b\n" "${red}" "${reset}"
    printf ";;; %bPlease start the program from the parent directory.%b\n" "${red}" "${reset}"
    printf ";;;\n"
    exit 1
}

. ./lib/function.sh

uninstall_usage()
{
clear
_line
printf ";;; \n"
printf ";;; %bThis program removes Diagonal icons installed on the system.%b\n" "${blue}" "${reset}"
printf ";;; %bThe program runs in interactive mode without command line arguments.%b\n" "${blue}" "${reset}"
printf ";;;\n"
_line
}

uninstall_usage

delete_theme_set()
{   base=$1
    for dir in "${_sys_dir}" "${_usr_dir}" "${_usr_icondir}" "${_nix_icondir}" "${_bsd_icondir}"
     do for variant in "" "-dark" "-light"
         do path="${dir}/${base}${variant}"
            if [ -d "${path}" ]
               then if [ "${dir}" = "${_sys_dir}" ] && [ "$(id -u)" -ne 0 ]
                       then if [ -n "${_auto_priv}" ]
                               then printf ";;; \n"
                                    printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                                    $_auto_priv rm -rf "${path}"
                                    $_auto_priv find "${dir}" -type l -name 'Diag-g*' ! -exec test -e {} \; -exec rm {} \;
                               else printf ";;; \n"
                                    printf ";;; %bPermission required to delete: %s\n" "${red}" "${path}" "${reset}"
                            fi
                  elif [ "${dir}" = "${_bsd_icondir}" ] && [ "$(id -u)" -ne 0 ]
                       then if [ -n "${_auto_priv}" ]
                               then printf ";;; \n"
                                    printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                                    $_auto_priv rm -rf "${path}"
                                    $_auto_priv find "${dir}" -type l -name 'Diag-g*' ! -exec test -e {} \; -exec rm {} \;
                               else printf ";;; \n"
                                    printf ";;; %bPermission required to delete: %s\n" "${red}" "${path}" "${reset}"
                            fi
                  elif [ "${dir}" = "${_nix_icondir}" ] && [ "$(id -u)" -ne 0 ]
                       then if [ -n "${_auto_priv}" ]
                               then printf ";;; \n"
                                    printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                                    $_auto_priv rm -rf "${path}"
                                    $_auto_priv find "${dir}" -type l -name 'Diag-g*' ! -exec test -e {} \; -exec rm {} \;
                               else printf ";;; \n"
                                    printf ";;; %bPermission required to delete: %s\n" "${red}" "${path}" "${reset}"
                            fi
                       else printf ";;; %bDelete:%b %b%s%b\n" "${blue}" "${reset}" "${red}" "${path}" "${reset}"
                            rm -rf "${path}"
                            find "${dir}" -type l -name 'Diag-g*' ! -exec test -e {} \; -exec rm {} \;
                    fi
            fi
        done
    done
}

list_icon_dirs()
{
    for base in "${_sys_dir}" "${_usr_dir}" "${_usr_icondir}" "${_nix_icondir}" "${_bsd_icondir}"
    do [ -d "$base" ] || continue
        for d in "$base"/*
        do [ -d "$d" ] || continue
            case "${d##*/}" in
                Diagonal*-cursors)
                    continue
                    ;;
                "${_icon_base}"*)
                    d="${d%-light}"
                    d="${d%-dark}"
                    printf '%s\n' "$d"
                    ;;
            esac
        done
    done | sort -u
}

dirs_list=$(list_icon_dirs)

  if command -v doas >/dev/null 2>&1
     then _auto_priv="doas"
elif command -v sudo >/dev/null 2>&1
     then _auto_priv="sudo"
     else _auto_priv=""
  fi

if [ -z "${dirs_list}" ]
   then printf ";;; \n"
        printf ";;;%b No installed icon theme found %s%b\n" "${red}" "(${_icon_base}*)." "${reset}"
        printf ";;; \n"
        printf ";;; \n"
        exit 0
fi

printf ";;; \n"
printf ";;;%b Installed Diagonal icon themes:%b\n" "${blue}" "${reset}"
printf ";;; \n"
i=1
while IFS= read -r d
   do [ -z "${d}" ] && continue
      base=$(basename "${d}")
      case "${base}" in
     *-dark | *-light ) continue ;;
      esac
      printf ";;; %d) %b%s%b\n" "${i}" "${red}" "${base}" "${reset}"
      eval "opt_${i}=\${base}"
      i=$((i + 1))
done <<EOF
$dirs_list
EOF
total=$((i - 1))
printf ";;; %d) %b%s%b\n" "${i}" "${red}" "Delete all Diagonal icon themes" "${reset}"
printf ";;; \n"
_all_opt=$i

printf ";;; %bEnter the number of the icon pack to be deleted:%b \n" "${blue}" "${reset}"
read -r choice </dev/tty
if [ "${choice}" -eq "${_all_opt}" ] 2>/dev/null
   then printf ";;; %bAll ${_icon_base} icon themes will be deleted.%b \n" "${blue}" "${reset}"
        printf ";;; %bAre you continuing?%b \n" "${blue}" "${reset}"
        printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
        read -r ans </dev/tty
        case ${ans} in
y | Y | yes | Yes )
            while IFS= read -r d
               do [ -z "${d}" ] && continue
                  base=$(basename "${d}")
                  case "${base}" in
       *-dark|*-light ) continue ;;
                  esac
                  delete_theme_set "${base}"
             done <<EOF
             "${dirs_list}"
EOF
                 ;;
                * ) printf ";;; %bDelete canceled.%b \n" "${blue}" "${reset}"
                    printf ";;; \n"
            ;;
       esac
       exit 0
fi

i=1
while [ "${i}" -le "${total}" ]
      do eval "base=\$opt_${i}"
         if [ "${i}" -eq "${choice}" ] 2>/dev/null
            then printf ";;; \n"
                 _line
                 printf ";;; \n"
                 printf ";;; %bYou will delete the following icon themes:%b \n" "${blue}" "${reset}"
                 printf ";;; \n"
                 printf ";;; %b%s%b\n" "${red}" "${base}" "${reset}"
                 printf ";;; \n"
                 printf ";;; %bAre you continuing?%b \n" "${blue}" "${reset}"
                 printf ";;; \n"
                 printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
                 read -r ans </dev/tty
        case ${ans} in
y | Y | yes | Yes ) delete_theme_set "${base}"
                    printf ";;; \n"
                 ;;
                * ) printf ";;; %bDelete canceled.%b \n" "${blue}" "${reset}"
                    printf ";;; \n"
                ;;
        esac
        exit 0
    fi
    i=$((i + 1))
done

printf ";;; \n"
printf ";;;%b %s%b\n" "${red}" "There is no such icon theme." "${reset}"
printf ";;; \n"
printf "\n"

exit 1
