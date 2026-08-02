#!/bin/sh
# Not a standalone file, please don't run it on its own.

. ./lib/function.sh

cd "${_workfolder}" || exit 1

_install()
{
copyiconpack
mv "Diagonal${__wmtype}${__distro}-${_version}.${_archiveext}" "$HOME"
printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bYou can find the compressed package in your %b%s%b %bdirectory%b\n" "${blue}" "${red}" "${HOME}" "${reset}" "${blue}" "${reset}"
printf ";;; \n"
if [ -n "${_distro}" ]
   then printf ";;; %bThe %bDiagonal-%s-cursor-theme%b %bhas been installed.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
        printf ";;; %bYou can enable it in your desktop environment's cursor settings.%b\n" "${blue}" "${reset}"
   else printf ";;; %bThe %bDiagonal-cursor-theme%b %bhas been installed.%b\n" "${blue}" "${red}" "${reset}" "${blue}" "${reset}"
        printf ";;; %bYou can enable it in your desktop environment's cursor settings.%b\n" "${blue}" "${reset}"
fi
}

_no_install()
{
mv "Diagonal${__wmtype}${__distro}-${_version}.${_archiveext}" "$HOME"
printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bThe icon theme has not been installed.%b\n" "${blue}" "${reset}"
printf ";;; %bYou can find the compressed package in your %b%s%b %bdirectory%b\n" "${blue}" "${red}" "${HOME}" "${reset}" "${blue}" "${reset}"
printf ";;; %bYou can install it at any time.%b\n" "${blue}" "${reset}"
}

_found_releasepack()
{
_line
printf ";;; \n"
printf ";;; %bExisting %b%s%b installation found.%b\n" "${red}" "${reset}" "${_theme}" "${red}" "${reset}"
printf ";;; \n"
printf ";;; %bLocation         : %s%b\n" "${blue}" "$_location" "${reset}"
printf ";;; %bInstalled version: %s%b\n" "${blue}" "$_release" "${reset}"
printf ";;; %bPackage version  : %s%b\n" "${blue}" "$_version" "${reset}"
printf ";;; \n"
printf ";;; %bDo you want to replace the existing icon theme??%b\n" "${red}" "${reset}"
printf ";;; \n"
}

_found_pack()
{
_line
printf ";;; \n"
printf ";;; %bExisting %s installation found.%b\n" "${red}" "${_theme}" "${reset}"
printf ";;; %bDo you want to replace the existing icon theme?%b\n" "${red}" "${reset}"
printf ";;; \n"
}

_user_notice()
{
_line
printf ";;; \n"
printf ";;; %bNotice: %b\n" "${cyan}" "${reset}"
printf ";;; \n"
printf ";;; %bA system-wide installation of this icon theme already exists.%b\n" "${cyan}" "${reset}"
printf ";;; \n"
printf ";;; %bYour personal installation will take precedence for this user.%b\n" "${cyan}" "${reset}"
printf ";;; %bThe system-wide installation will not be modified.%b\n" "${cyan}" "${reset}"
}

_root_notice()
{
_line
printf ";;; \n"
printf ";;; %bNotice: %b\n" "${cyan}" "${reset}"
printf ";;; \n"
printf ";;; %bOne or more user-specific installations of this icon theme may exist.%b\n" "${cyan}" "${reset}"
printf ";;; \n"
printf ";;; %bThe installer will update only the system-wide installation.%b\n" "${cyan}" "${reset}"
printf ";;; %bUser installations will not be modified.%b\n" "${cyan}" "${reset}"
}

makecache
makeiconpack

_theme="Diagonal${__wmtype}${__distro}"

printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bThe %b%s%b %bicon pack is ready.%b\n" "${blue}" "${red}" "Diagonal${__wmtype}${__distro}" "${reset}" "${blue}" "${reset}"
printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bAre you installing the icon theme?%b\n" "${blue}" "${reset}"
printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
read -r _installpack
case ${_installpack} in
   y | Y | yes | Yes) if [ "$(id -u)" -eq 0 ]
                        then if [ -d /usr/share/icons/"${_theme}" ]
                                then _location="/usr/share/icons/${_theme}"
                                     if [ -f /usr/share/icons/"${_theme}"/diagonal-release ]
                                        then _release="$(cat /usr/share/icons/"${_theme}"/diagonal-release)"
                                             _found_releasepack
                                        else _found_pack
                                     fi
                                     read answer
                                          case "$answer" in
                                     y | Y | yes | YES ) rm -rf "/usr/share/icons/${_theme}" 1>/dev/null 2>&1
                                                         rm -rf "/usr/share/icons/${_theme}"-light 1>/dev/null 2>&1
                                                         rm -rf "/usr/share/icons/${_theme}"-dark 1>/dev/null 2>&1
                                                         _install
                                                         _root_notice
                                                 ;;
                                                      *) _no_install
                                                 ;;
                                          esac
                           elif [ -d /usr/local/share/icons/"${_theme}" ]
                                then _location="/usr/local/share/icons/${_theme}"
                                     if [ -f /usr/local/share/icons/"${_theme}"/diagonal-release ]
                                        then _release="$(cat /usr/local/share/icons/"${_theme}"/diagonal-release)"
                                             _found_releasepack
                                        else _found_pack
                                     fi
                                     read answer
                                          case "$answer" in
                                     y | Y | yes | YES ) rm -rf "/usr/local/share/icons/${_theme}" 1>/dev/null 2>&1
                                                         rm -rf "/usr/local/share/icons/${_theme}"-light 1>/dev/null 2>&1
                                                         rm -rf "/usr/local/share/icons/${_theme}"-dark 1>/dev/null 2>&1
                                                         _install
                                                         _root_notice
                                                 ;;
                                                      *) _no_install
                                                 ;;
                                          esac
                                else _install
                              fi
                        else if [ -d "${HOME}/.local/share/icons/${_theme}" ]
                                then _location="${HOME}/.local/share/icons/${_theme}"
                                     if [ -f "${HOME}/.local/share/icons/${_theme}"/diagonal-release ]
                                        then _release="$(cat "${HOME}/.local/share/icons/${_theme}"/diagonal-release)"
                                             _found_releasepack
                                        else _found_pack
                                     fi
                                     read answer
                                          case "$answer" in
                                     y | Y | yes | YES ) rm -rf "${HOME}/.local/share/icons/${_theme}" 1>/dev/null 2>&1
                                                         rm -rf "${HOME}/.local/share/icons/${_theme}"-light 1>/dev/null 2>&1
                                                         rm -rf "${HOME}/.local/share/icons/${_theme}"-dark 1>/dev/null 2>&1
                                                         _install
                                                         _user_notice
                                                 ;;
                                                      *) _no_install
                                                 ;;
                                          esac
                           elif [ -d "${HOME}/.icons/${_theme}" ]
                                then _location="${HOME}/.icons/${_theme}"
                                     if [ -f "${HOME}/.icons/${_theme}"/diagonal-release ]
                                        then _release="$(cat "${HOME}/.icons/${_theme}"/diagonal-release)"
                                             _found_releasepack
                                        else _found_pack
                                     fi
                                     read answer
                                          case "$answer" in
                                     y | Y | yes | YES ) rm -rf "${HOME}/.icons/${_theme}" 1>/dev/null 2>&1
                                                         rm -rf "${HOME}/.icons/${_theme}"-light 1>/dev/null 2>&1
                                                         rm -rf "${HOME}/.icons/${_theme}"-dark 1>/dev/null 2>&1
                                                         _install
                                                         _user_notice
                                                 ;;
                                                      *) _no_install
                                                 ;;
                                          esac
                                else _install
                             fi
                     fi
                  ;;
                  *) _no_install
                  ;;
esac
