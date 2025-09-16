; Installs a driver for the Tachyon System Update Mode
;

; Use modern interface
  !include MUI2.nsh
  !define MUI_FINISHPAGE_NOAUTOCLOSE

; General
  Name                  "Tachyon Driver Installation"
  OutFile               "tachyon-driver-setup.exe"
  ShowInstDetails       show
  RequestExecutionLevel admin

; Pages
  !insertmacro MUI_PAGE_INSTFILES

;Languages
  !insertmacro MUI_LANGUAGE "English"

; Install driver
; wdi-simple usage
;
; -n, --name <name>          set the device name
; -f, --inf <name>           set the inf name
; -m, --manufacturer <name>  set the manufacturer name
; -v, --vid <id>             set the vendor ID (VID)
; -p, --pid <id>             set the product ID (PID)
; -i, --iid <id>             set the interface ID (MI)
; -t, --type <driver_type>   set the driver to install
;                            (0=WinUSB, 1=libusb0, 2=libusbK, 3=usbser, 4=custom)
; -d, --dest <dir>           set the extraction directory
; -x, --extract              extract files only (don't install)
; -c, --cert <certname>      install certificate <certname> from the
;                            embedded user files as a trusted publisher
;     --stealth-cert         installs certificate above without prompting
; -s, --silent               silent mode
; -b, --progressbar=[HWND]   display a progress bar during install
;                            an optional HWND can be specified
; -o, --timeout              set timeout (in ms) to wait for any 
;                            pending installations
; -l, --log                  set log level (0=debug, 4=none)
; -h, --help                 display usage
Section "tachyon-driver" SecDriver
  SetOutPath $TEMP
  File "libwdi\Win32\Release\examples\wdi-simple.exe"

  DetailPrint "Installing driver"
  nsExec::ExecToLog '"$TEMP\wdi-simple.exe" --name "Particle Tachyon (System Update)" --vid 0x05c6 --pid 0x9008 --progressbar=$HWNDPARENT --timeout 120000'

  Delete "$TEMP\wdi-simple.exe"
SectionEnd
