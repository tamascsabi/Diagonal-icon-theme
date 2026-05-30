#!/bin/sh
# Not a standalone file, please don't run it on its own.

. ./lib/function.sh

cd "${_workfolder}" || exit 1

makecache
makeiconpack

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
     y | Y | yes | Yes) if [ ! -d "${_install_dir}/Diagonal${__wmtype}${__distro}" ]
                           then copyiconpack
                                mv "Diagonal${__wmtype}${__distro}-${_version}.${_archiveext}" "$HOME"
                                printf ";;; \n"
                                _line
                                printf ";;; \n"
                                printf ";;; %bYou can find the compressed package in your %b%s%b %bdirectory%b\n" "${blue}" "${red}" "${HOME}" "${reset}" "${blue}" "${reset}"
                                printf ";;; \n"
                           else mv "Diagonal${__wmtype}${__distro}-${_version}.${_archiveext}" "$HOME"
                                printf ";;; \n"
                                _line
                                printf ";;; \n"
                                printf ";;; %bThe %b%s%b icon theme already exists in the system.%b\n" "${red}" "${reset}" "Diagonal${__wmtype}${__distro}" "${red}" "${reset}"
                                printf ";;; %bI will not overwrite it.%b\n" "${red}" "${reset}"
                                printf ";;; %bYou can find the compressed package in your %b%s%b %bdirectory%b\n" "${blue}" "${red}" "${HOME}" "${reset}" "${blue}" "${reset}"
                                printf ";;; %bYou can install it at any time.%b\n" "${blue}" "${reset}"
                        fi
                     ;;
                     *) mv "Diagonal${__wmtype}${__distro}-${_version}.${_archiveext}" "$HOME"
                        printf ";;; \n"
                        _line
                        printf ";;; \n"
                        printf ";;; %bYou can find the compressed package in your  %b%s%b %bdirectory%b\n" "${blue}" "${red}" "${HOME}" "${reset}" "${blue}" "${reset}"
                        printf ";;; %bYou can install it at any time.%b\n" "${blue}" "${reset}"
                        printf ";;; \n"
                     ;;
    esac
