#!/bin/sh

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
usage() {
clear ;
_line
printf ";;; \n"
printf ";;; %bThe installer is interactive, it has no command line options.%b\n" "${blue}" "${reset}"
printf ";;; %bYou can change the following settings:%b\n" "${blue}" "${reset}"
printf ";;; \n"
printf ";;;     * Distribution - %bArch, Freebsd, OpenSUSE, etc.%b\n" "${green}" "${reset}"
printf ";;;     * Window Manager - %bKDE, Gnome, Mate, Cinnamon, etc.%b\n" "${green}" "${reset}"
printf ";;;     * Folder Color - %bBlue, Green, Yellow, etc.%b\n" "${green}" "${reset}"
printf ";;; \n"
printf ";;; %bIf you don't change the options, %b\n" "${blue}" "${reset}"
printf ";;; %bthe icon theme will install with the default settings.%b\n" "${blue}" "${reset}"
printf ";;; \n"
_line
printf ";;; \n"
}

distroanswer() {
printf ";;; %bAnswer from the distributions with the numbers:%b\n" "${blue}" "${reset}"
printf ";;; \n"
printf ";;;  1 %bArch%b         2 %bCachyos%b\n" "${blue}" "${reset}" "${green}" "${reset}"
printf ";;;  3 %bDebian%b       4 %bFedora%b\n" "${red}" "${reset}" "${blue}" "${reset}"
printf ";;;  5 %bFreeBSD%b      6 %bGentoo%b\n" "${red}" "${reset}" "${magenta}" "${reset}"
printf ";;;  7 %bKubuntu%b      8 %bManjaro%b\n" "${blue}" "${reset}" "${cyan}" "${reset}"
printf ";;;  9 %bMint%b        10 %bOpenBSD%b\n" "${green}" "${reset}" "${yellow}" "${reset}"
printf ";;; 11 %bOpenSUSE%b    12 %bSlackware%b\n" "${green}" "${reset}" "${blue}" "${reset}"
printf ";;; 13 %bUbuntu%b\n" "${yellow}" "${reset}"
printf ";;; 14 %bDistribution free (I do not choose)%b\n" "${red}" "${reset}"

read -r __distribution
     case $__distribution in
       1) _distro="arch"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       2) _distro="cachyos"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${green}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       3) _distro="debian"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       4) _distro="fedora"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       5) _distro="freebsd"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       6) _distro="gentoo"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       7) _distro="kubuntu"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       8) _distro="manjaro"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       9) _distro="mint"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       10) _distro="openbsd"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       11) _distro="opensuse"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       12) _distro="slackware"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       13) _distro="ubuntu"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
       ;;
       *) _distro=""
          printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
       ;;
    esac
}

detect_sed_inplace
distrocheck
idcheck
wmcheck
usage

if [ -n "${_distro}" ]
   then printf ";;; %bThe system you are using is %b%s%b%b.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
        printf ";;; %bWould you like to install this version of %b%s%b%b?%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
        printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
        read -r _distribution
        case $_distribution in
y | Y | yes | Yes) printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
            ;;
  n | N | no | No) distroanswer
            ;;
                *) printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
                   printf ";;; \n"
                   _distro=""
            ;;
        esac
   else printf ";;; %bThe installer did not recognize the running distribution.%b\n" "${blue}" "${reset}"
        printf ";;; %bYou can choose from the icon packs available for installation.%b\n" "${blue}" "${reset}"
        printf ";;; %bAvailable themes:%b\n" "${blue}" "${reset}"
        printf ";;; \n"
        printf ";;;  1 %bArch%b         2 %bCachyos%b\n" "${blue}" "${reset}" "${green}" "${reset}"
        printf ";;;  3 %bDebian%b       4 %bFedora%b\n" "${red}" "${reset}" "${blue}" "${reset}"
        printf ";;;  5 %bFreeBSD%b      6 %bGentoo%b\n" "${red}" "${reset}" "${magenta}" "${reset}"
        printf ";;;  7 %bKubuntu%b      8 %bManjaro%b\n" "${blue}" "${reset}" "${cyan}" "${reset}"
        printf ";;;  9 %bMint%b        10 %bOpenBSD%b\n" "${green}" "${reset}" "${yellow}" "${reset}"
        printf ";;; 11 %bOpenSUSE%b    12 %bSlackware%b\n" "${green}" "${reset}" "${blue}" "${reset}"
        printf ";;; 13 %bUbuntu%b\n" "${yellow}" "${reset}"
        printf ";;; 14 %bDistribution free (I do not choose)%b\n" "${red}" "${reset}"
        printf ";;; \n"
        printf ";;; %bPlease choose from the distribution packages.%b\n" "${blue}" "${reset}"
        read -r __distribution
        case $__distribution in
           1) _distro="arch"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           2) _distro="cachyos"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${green}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           3) _distro="debian"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           4) _distro="fedora"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           5) _distro="freebsd"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           6) _distro="gentoo"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           7) _distro="kubuntu"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           8) _distro="manjaro"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           9) _distro="mint"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           10) _distro="openbsd"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           11) _distro="opensuse"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           12) _distro="slackware"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           13) _distro="ubuntu"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
           ;;
           *) _distro=""
              printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
           ;;
    esac
fi


if [ -n "${_distro}" ]
   then __distro="$(echo -"${_distro}" | tr '[:upper:]' '[:lower:]')"
fi

if [ -n "${_wmtype}" ]
   then printf ";;; \n"
        _line
        printf ";;; \n"
        printf ";;; %bThe system you are using is %b%s%b%b.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
        printf ";;; %bWould you like to install this version of %b%s%b%b?%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
        printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
        read -r _deverison
        case $_deverison in
y | Y | yes | Yes) printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
                   case $_wmtype in
                        kde ) printf ";;; \n"
                                     _line
                              printf ";;; \n"
                              printf ";;; %bWould you like to use monochrome icons in the KDE menu?%b\n" "${blue}" "${reset}"
                              printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
                              read -r _menuanswer
                              case $_menuanswer in
                        y | Y | yes | Yes) _monochrome="1"
                                ;;
                                       * ) _monochrome=""
                                ;;
                              esac
                        ;;
                   esac
                ;;
  n | N | no | No) printf ";;; %bWhich window manager should I create the icon theme for?%b\n" "${blue}" "${reset}"
                   printf ";;; %bChoose from the numbers.%b\n" "${blue}" "${reset}"
                   printf ";;; \n"
                   printf ";;; 1 %bKDE%b\n" "${green}" "${reset}"
                   printf ";;; 2 %bGNOME%b\n" "${green}" "${reset}"
                   printf ";;; 3 %bXfce%b\n" "${green}" "${reset}"
                   printf ";;; 4 %bCinnamon%b\n" "${green}" "${reset}"
                   printf ";;; 5 %bMate%b\n" "${green}" "${reset}"
                   printf ";;; 6 %bBudgie%b\n" "${green}" "${reset}"
                   printf ";;; 7 %bWindow manager free (I do not choose)%b\n" "${red}" "${reset}"
                   printf ";;; \n"
                   read -r __deverison
                   case $__deverison in
                      1) _wmtype="kde"
                          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
                          printf ";;; \n"
                          _line
                          printf ";;; \n"
                          printf ";;; %bWould you like to use monochrome icons in the KDE menu?%b\n" "${blue}" "${reset}"
                          printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
                          read -r _menuanswer
                          case $_menuanswer in
                        y | Y | yes | Yes) _monochrome="1"
                                ;;
                                       * ) _monochrome=""
                                ;;
                          esac
                      ;;
                      2) _wmtype="gnome"
                          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
                      ;;
                      3) _wmtype="xfce"
                          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
                      ;;
                      4) _wmtype="cinnamon"
                          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
                      ;;
                      5) _wmtype="mate"
                          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
                      ;;
                      6) _wmtype="budgie"
                          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
                      ;;
                      *) _wmtype=""
                          printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
                      ;;
                   esac
                ;;
                *) printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
                   printf ";;; \n"
                   _wmtype=""
                ;;
        esac
   else printf ";;; \n"
        _line
        printf ";;; \n"
        printf ";;; %bWhich theme would you like to install?%b\n" "${blue}" "${reset}"
        printf ";;; %bChoose from the numbers.%b\n" "${blue}" "${reset}"
        printf ";;; \n"
        printf ";;; \n"
        printf ";;; 1 %bKDE%b\n" "${green}" "${reset}"
        printf ";;; 2 %bGNOME%b\n" "${green}" "${reset}"
        printf ";;; 3 %bXfce%b\n" "${green}" "${reset}"
        printf ";;; 4 %bCinnamon%b\n" "${green}" "${reset}"
        printf ";;; 5 %bMate%b\n" "${green}" "${reset}"
        printf ";;; 6 %bBudgie%b\n" "${green}" "${reset}"
        printf ";;; 7 %bWindow manager free (I do not choose)%b\n" "${red}" "${reset}"
        printf ";;; \n"
        read -r _deverison
        case $_deverison in
           1) _wmtype="kde"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
              printf ";;; \n"
              _line
              printf ";;; \n"
              printf ";;; %bWould you like to use monochrome icons in the KDE menu?%b\n" "${blue}" "${reset}"
              printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
              read -r _menuanswer
              case $_menuanswer in
                 y | Y | yes | Yes) _monochrome="1"
                            ;;
                                * ) _monochrome=""
                            ;;
              esac
           ;;
           2) _wmtype="gnome"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
           ;;
           3) _wmtype="xfce"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
           ;;
           4) _wmtype="cinnamon"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
           ;;
           5) _wmtype="mate"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
           ;;
           6) _wmtype="budgie"
              printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_wmtype}" "${reset}" "${blue}" "${reset}"
           ;;
           *) _wmtype=""
              printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
           ;;
        esac
fi

if [ -n "${_wmtype}" ]
   then __wmtype="-$_wmtype"
fi

printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bWould you like to change the default folder colors?%b\n" "${blue}" "${reset}"
printf ";;; %by (yes)%b   %bn (no)%b\n" "${red}" "${reset}" "${red}" "${reset}"
read -r _foldercolor
case $_foldercolor in
y | Y | yes | Yes) printf ";;; %bAnswer from the folder colors with numbers:%b\n" "${blue}" "${reset}"
                   printf ";;; \n"
                   printf ";;;  1 %bBlue%b\n" "${blue}" "${reset}"
                   printf ";;;  2 %bRed%b\n"  "${red}" "${reset}"
                   printf ";;;  3 %bGreen%b\n" "${green}" "${reset}"
                   printf ";;;  4 %bBlack%b\n" "${bow}" "${reset}"
                   printf ";;;  5 %bYellow%b\n" "${yellow}" "${reset}"
                   printf ";;;  6 %bCyan%b\n" "${cyan}" "${reset}"
                   printf ";;;  7 %bMagenta%b\n" "${magenta}" "${reset}"
                   printf ";;;  8 %bWhite%b\n" "${wob}" "${reset}"
                   printf ";;;  9 %bViolet%b\n" "${magenta}" "${reset}"
                   printf ";;; 10 %bGrey%b\n" "${bow}" "${reset}"
                   printf ";;; 11 %bOrange%b\n" "${yellow}" "${reset}"
                   printf ";;; 12 %bUbuntu%b\n" "${yellow}" "${reset}"
                   printf ";;; \n"
                   read -r __foldercolor
                   case $__foldercolor in
                       1) __foldercolor="Blue"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${blue}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       2) __foldercolor="Red"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       3) __foldercolor="Green"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${green}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       4) __foldercolor="Black"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${bow}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       5) __foldercolor="Yellow"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${yellow}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       6) __foldercolor="Cyan"
                          printf ";;; %bI am installing the %s folder color.%b\n" "${blue}" "${cyan}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       7) __foldercolor="Magenta"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${magenta}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       8) __foldercolor="White"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${wob}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       9) __foldercolor="Violet"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${magenta}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       10) __foldercolor="Grey"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${bow}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       11) __foldercolor="Orange"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${yellow}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                       12) __foldercolor="Ubuntu"
                          printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${yellow}" "${__foldercolor}" "${reset}" "${blue}" "${reset}"
                       ;;
                        *) __foldercolor=""
                          printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
                       ;;
                   esac
               ;;
               *) __foldercolor=""
                 printf ";;; %bI am installing the default version.%b\n" "${blue}" "${reset}"
               ;;
esac

printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bIcon pack compilation has started.%b\n" "${blue}" "${reset}"
printf ";;; %bPlease wait patiently...%b\n" "${blue}" "${reset}"
printf ";;; \n"

rmworkfolder

cd "${_basedir}" || exit 1

case "${__wmtype}" in
   -gnome ) . ./lib/installgnome.sh
        ;;
    -xfce ) . ./lib/installxfce.sh
        ;;
-cinnamon ) . ./lib/installcinnamon.sh
        ;;
    -mate ) . ./lib/installmate.sh
        ;;
  -budgie ) . ./lib/installbudgie.sh
        ;;
     -kde ) if [ -n "${_monochrome}" ]
               then . ./lib/installkde.sh --mc
               else . ./lib/installkde.sh
            fi
        ;;
        * ) . ./lib/default.sh
        ;;
esac

cd "${_basedir}" || exit 1

. ./lib/installpack.sh

rm -rf "${_workfolder}"

printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bThe installation is complete.%b\n" "${blue}" "${reset}"
printf ";;; \n"
printf ";;; \n"

exit 0
