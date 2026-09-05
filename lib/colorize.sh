#!/bin/sh
# Not a standalone file, please don't run it on its own.

. "${_rootdir}/lib/function.sh"

makefcolor() {
 for file in $(find * -type f -name '*.svg')
  do case "${_fcolor}" in
            Blue ) sed_inplace -e "s/${_colorfg}/0f72e5/g" -e "s/${_colorbg}/053b7b/g" "${file}" ;;
             Red ) sed_inplace -e "s/${_colorfg}/e01b24/g" -e "s/${_colorbg}/a51d2d/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           Green ) sed_inplace -e "s/${_colorfg}/29b668/g" -e "s/${_colorbg}/165e3c/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           Black ) sed_inplace -e "s/${_colorfg}/3b3b3b/g" -e "s/${_colorbg}/040404/g" "${file}" ;;
          Yellow ) sed_inplace -e "s/${_colorfg}/ffcb3a/g" -e "s/${_colorbg}/ffad0b/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           White ) sed_inplace -e "s/${_colorfg}/ffffff/g" -e "s/${_colorbg}/f0f0f0/g" -e "s/fff8ff/4d4d4d/g" "${file}" ;;
            Cyan ) sed_inplace -e "s/${_colorfg}/00ac9e/g" -e "s/${_colorbg}/0b5765/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         Magenta ) sed_inplace -e "s/${_colorfg}/fa0394/g" -e "s/${_colorbg}/c01a7b/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          Violet ) sed_inplace -e "s/${_colorfg}/a27bec/g" -e "s/${_colorbg}/6220dc/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
            Grey ) sed_inplace -e "s/${_colorfg}/697489/g" -e "s/${_colorbg}/454e5b/g" "${file}" ;;
          Orange ) sed_inplace -e "s/${_colorfg}/f7711e/g" -e "s/${_colorbg}/cb4e00/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
            arch ) sed_inplace -e "s/${_colorfg}/55a8d1/g" -e "s/${_colorbg}/168bc4/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         cachyos ) sed_inplace -e "s/${_colorfg}/33c175/g" -e "s/${_colorbg}/00adf9/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          debian ) sed_inplace -e "s/${_colorfg}/f8125e/g" -e "s/${_colorbg}/283e48/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          devuan ) sed_inplace -e "s/${_colorfg}/3398ff/g" -e "s/${_colorbg}/004489/g" "${file}" ;;
     endeavouros ) sed_inplace -e "s/${_colorfg}/7e41be/g" -e "s/${_colorbg}/ff6464/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          fedora ) sed_inplace -e "s/${_colorfg}/4d7ed7/g" -e "s/${_colorbg}/214b97/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         freebsd ) sed_inplace -e "s/${_colorfg}/dd003b/g" -e "s/${_colorbg}/66000b/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          garuda ) sed_inplace -e "s/${_colorfg}/c600d5/g" -e "s/${_colorbg}/fd7602/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          gentoo ) sed_inplace -e "s/${_colorfg}/a27bec/g" -e "s/${_colorbg}/6220dc/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
            kali ) sed_inplace -e "s/${_colorfg}/1e7eed/g" -e "s/${_colorbg}/053a95/g" "${file}" ;;
         kdeneon ) sed_inplace -e "s/${_colorfg}/10aca5/g" -e "s/${_colorbg}/2189a1/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         kubuntu ) sed_inplace -e "s/${_colorfg}/1370ff/g" -e "s/${_colorbg}/004cc0/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
          mageia ) sed_inplace -e "s/${_colorfg}/338ccd/g" -e "s/${_colorbg}/254a65/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         manjaro ) sed_inplace -e "s/${_colorfg}/00ac9e/g" -e "s/${_colorbg}/0b5765/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
            mint ) sed_inplace -e "s/${_colorfg}/28bd37/g" -e "s/${_colorbg}/20a12d/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           nixos ) sed_inplace -e "s/${_colorfg}/a4d4f8/g" -e "s/${_colorbg}/4f73bc/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
         openbsd ) sed_inplace -e "s/${_colorfg}/eaa100/g" -e "s/${_colorbg}/a06e00/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
        opensuse ) sed_inplace -e "s/${_colorfg}/4ba520/g" -e "s/${_colorbg}/025575/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
    openmandriva ) sed_inplace -e "s/${_colorfg}/60b1e4/g" -e "s/${_colorbg}/2080bb/g" "${file}" ;;
          parrot ) sed_inplace -e "s/${_colorfg}/06d7d4/g" -e "s/${_colorbg}/236563/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
       pclinuxos ) sed_inplace -e "s/${_colorfg}/6d7dcb/g" -e "s/${_colorbg}/2b397a/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           popos ) sed_inplace -e "s/${_colorfg}/49b8c6/g" -e "s/${_colorbg}/21616a/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
       slackware ) sed_inplace -e "s/${_colorfg}/8faaee/g" -e "s/${_colorbg}/4861a0/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
           solus ) sed_inplace -e "s/${_colorfg}/7a95d0/g" -e "s/${_colorbg}/52647a/g" "${file}" ;;
          ubuntu ) sed_inplace -e "s/${_colorfg}/666666/g" -e "s/${_colorbg}/e95420/g" -e "s/${_colorline}/752a71/g" "${file}" ;;
         zorinos ) sed_inplace -e "s/${_colorfg}/4dbbf0/g" -e "s/${_colorbg}/0972b6/g" -e "s/${_colorline}/283e48/g" "${file}" ;;
     esac
done
}


_line
printf ";;; \n"
printf ";;; %bBasic colors and folder colors for distributions are available.e%b\n" "${blue}" "${reset}"
printf ";;; %bPlease choose by numbers%b\n" "${blue}" "${reset}"
printf ";;;\n"
_line
printf ";;;\n"
printf ";;;  1 %bBlue%b          2 %bRed%b           3 %bGreen%b        4 %bBlack%b\n" "${blue}" "${reset}" "${red}" "${reset}" "${green}" "${reset}" "${bow}" "${reset}"
printf ";;;  5 %bYellow%b        6 %bCyan%b          7 %bMagenta%b      8 %bWhite%b\n"  "${yellow}" "${reset}" "${cyan}" "${reset}" "${magenta}" "${reset}" "${wob}" "${reset}"
printf ";;;  9 %bViolet%b       10 %bGrey%b         11 %bOrange%b\n" "${magenta}" "${reset}" "${bow}" "${reset}" "${yellow}" "${reset}"
printf ";;;\n"
_line
printf ";;;\n"
printf ";;; 12 %bArch%b         13 %bCachyOS%b      14 %bDebian%b      15 %bDevuan%b\n" "${blue}" "${reset}" "${green}" "${reset}" "${red}" "${reset}" "${blue}" "${reset}"
printf ";;; 16 %bEndeavourOS%b  17 %bFedora%b       18 %bFreeBSD%b     19 %bGaruda%b\n" "${magenta}" "${reset}" "${blue}" "${reset}" "${red}" "${reset}" "${magenta}" "${reset}"
printf ";;; 20 %bGentoo%b       21 %bKali%b         22 %bKdeneon%b     23 %bKubuntu%b\n" "${magenta}" "${reset}" "${blue}" "${reset}" "${cyan}" "${reset}" "${blue}" "${reset}"
printf ";;; 24 %bMageia%b       25 %bManjaro%b      26 %bMint%b        27 %bNixos%b\n" "${blue}" "${reset}" "${cyan}" "${reset}" "${green}" "${reset}" "${blue}" "${reset}"
printf ";;; 28 %bOpenBSD%b      29 %bOpenMandriva%b 30 %bOpenSUSE%b    31 %bParrot%b\n" "${yellow}" "${reset}" "${blue}" "${reset}" "${green}" "${reset}" "${cyan}" "${reset}"
printf ";;; 32 %bPcLinuxOS%b    33 %bPop!_OS%b      34 %bSlackware%b   35 %bSolus%b\n" "${blue}" "${reset}" "${cyan}" "${reset}" "${blue}" "${reset}" "${blue}" "${reset}"
printf ";;; 36 %bUbuntu%b       37 %bZorin OS%b\n"  "${yellow}" "${reset}" "${blue}" "${reset}"
printf ";;;\n"
_line

read -r _fcolor
    case $_fcolor in
         1) _fcolor="Blue"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${blue}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         2) _fcolor="Red"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         3) _fcolor="Green"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${green}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         4) _fcolor="Black"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${bow}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         5) _fcolor="Yellow"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${yellow}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         6) _fcolor="Cyan"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${cyan}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         7) _fcolor="Magenta"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${magenta}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         8) _fcolor="White"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${wob}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         9) _fcolor="Violet"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${magenta}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        10) _fcolor="Grey"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${bow}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        11) _fcolor="Orange"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${yellow}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        12) _fcolor="arch"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        13) _fcolor="cachyos"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        14) _fcolor="debian"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        15) _fcolor="devuan"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        16) _fcolor="endeavouros"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        17) _fcolor="fedora"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        18) _fcolor="freebsd"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        19) _fcolor="garuda"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        20) _fcolor="gentoo"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        21) _fcolor="kali"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        22) _fcolor="kdeneon"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        23) _fcolor="kubuntu"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        24) _fcolor="mageia"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        25) _fcolor="manjaro"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        26) _fcolor="mint"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        27) _fcolor="nixos"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        28) _fcolor="openbsd"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        29) _fcolor="openmandriva"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        30) _fcolor="opensuse"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        31) _fcolor="parrot"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        32) _fcolor="pclinuxos"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        33) _fcolor="popos"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        34) _fcolor="slackware"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        35) _distro="solus"
          printf ";;; %bI am installing the %b%s%b%b version.%b\n" "${blue}" "${red}" "${_distro}" "${reset}" "${blue}" "${reset}"
         ;;
        36) _fcolor="ubuntu"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
        37) _fcolor="zorinos"
            printf ";;; %bI am installing the %b%s%b%b folder color.%b\n" "${blue}" "${red}" "${_fcolor}" "${reset}" "${blue}" "${reset}"
         ;;
         *) _fcolor=""
            printf ";;; %bThere is no such option.%b\n" "${blue}" "${reset}"
            printf ";;; %bFolder colors have not changed.%b\n" "${blue}" "${reset}"
         ;;
esac

cd "${_basekt}" || exit 1

  if [ -d places/64 ]
     then ( cd places/64 || exit 1
            for i in ${_rootdir}/base/scalable/places/*.svg
             do cp -a "${i}" .
           done
           _header "Installing selected folder colors"
            makefcolor
           _footer
          )
elif [ -d 64x64/places ]
     then ( cd 64x64/places || exit 1
            for i in ${_rootdir}/base/scalable/places/*.svg
             do cp -a "${i}" .
           done
            _header "Installing selected folder colors"
            makefcolor
           _footer
          )
elif [ -d 48x48/places ]
     then ( cd 48x48/places || exit 1
            for i in ${_rootdir}/base/scalable/places/*.svg
             do cp -a "${i}" .
           done
            _header "Installing selected folder colors"
            makefcolor
           _footer
          )
elif [ -d scalable/places ]
     then ( cd scalable/places || exit 1
            for i in ${_rootdir}/base/scalable/places/*.svg
             do cp -a "${i}" .
           done
            _header "Installing selected folder colors"
            makefcolor
           _footer
          )
  fi

printf ";;; \n"
_line
printf ";;; \n"
printf ";;; %bThe colorize is complete.%b\n" "${blue}" "${reset}"
printf ";;; \n"
