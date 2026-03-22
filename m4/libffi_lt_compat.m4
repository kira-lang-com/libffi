dnl Compatibility glue for newer libtool releases that no longer provide
dnl LT_SYS_SYMBOL_USCORE. libffi still uses the macro to decide whether
dnl Darwin-family targets need SYMBOL_UNDERSCORE defined.

m4_ifndef([LT_SYS_SYMBOL_USCORE], [
AC_DEFUN([LT_SYS_SYMBOL_USCORE], [
  AC_CACHE_CHECK([for _ prefix in compiled symbols], [lt_cv_sys_symbol_underscore], [
    case $host_os in
      darwin* | ios* | iossimulator* | tvos* | watchos* | xros* )
        lt_cv_sys_symbol_underscore=yes
        ;;
      * )
        lt_cv_sys_symbol_underscore=no
        ;;
    esac
  ])
  sys_symbol_underscore=$lt_cv_sys_symbol_underscore
])
])
