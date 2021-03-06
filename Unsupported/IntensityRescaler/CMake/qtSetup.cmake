# Locate Qt include paths and libraries

# This module defines
# QT_INCLUDE_DIR, where to find qt.h, etc.
# QT_LIBRARIES, the libraries to link against to use Qt.
# QT_DEFINITIONS, definitions to use when compiling code that uses Qt.
# QT_WRAP_CPP, If false, don't use QT_WRAP_CPP command.
# QT_WRAP_UI, If false, don't use QT_WRAP_UI command.
# QT_FOUND, If false, don't try to use Qt.

# also defined, but not for general use are
# QT_MOC_EXECUTABLE, where to find the moc tool.
# QT_UIC_EXECUTABLE, where to find the uic tool.
# QT_QT_LIBRARY, where to find the Qt library.
# QT_QTMAIN_LIBRARY, where to find the qtmain library. This is only required by Qt3 on Windows.


FIND_PATH(QT_INCLUDE_DIR qt.h
  $ENV{QTDIR}/include
  /usr/local/qt/include
  /usr/local/include
  /usr/include/qt3
  /usr/include/qt
  /usr/include 
  C:/Progra~1/qt/include
  )

FIND_LIBRARY(QT_QT_LIBRARY 
  NAMES qt qt-mt qt-mt230nc
  PATHS
  $ENV{QTDIR}/lib
  /usr/local/qt/lib
  /usr/local/lib
  /usr/lib
  /usr/share/qt3/lib
  C:/Progra~1/qt/lib
  )

FIND_PROGRAM(QT_MOC_EXECUTABLE moc
  $ENV{QTDIR}/bin C:/Progra~1/qt/bin
  )

FIND_PROGRAM(QT_UIC_EXECUTABLE uic
  $ENV{QTDIR}/bin C:/Progra~1/qt/bin
  )


IF (WIN32)
  FIND_LIBRARY(QT_QTMAIN_LIBRARY qtmain
    $ENV{QTDIR}/lib C:/Progra~1/qt/lib
    DOC "This Library is only needed by and included with Qt3 on MSWindows. It should be NOTFOUND, undefined or IGNORE otherwise."
    )
ENDIF (WIN32)


IF (QT_MOC_EXECUTABLE)
  SET ( QT_WRAP_CPP "YES")
ENDIF (QT_MOC_EXECUTABLE)

IF (QT_UIC_EXECUTABLE)
  SET ( QT_WRAP_UI "YES")
ENDIF (QT_UIC_EXECUTABLE)


IF(QT_INCLUDE_DIR)
  IF(QT_QT_LIBRARY)
    SET( QT_LIBRARIES ${QT_LIBRARIES} ${QT_QT_LIBRARY} )
    SET( QT_FOUND "YES" )
    SET( QT_DEFINITIONS "")

    IF (WIN32)
      IF (QT_QTMAIN_LIBRARY)
        # for version 3
        SET (QT_DEFINITIONS -DQT_DLL)
        SET (QT_DEFINITIONS "-DQT_DLL -DQT_THREAD_SUPPORT -DNO_DEBUG")
        SET (QT_LIBRARIES imm32.lib  ${QT_QT_LIBRARY} ${QT_QTMAIN_LIBRARY} )
        SET (QT_LIBRARIES ${QT_LIBRARIES} winmm wsock32)
      ELSE (QT_QTMAIN_LIBRARY)
        # for version 2
        SET (QT_LIBRARIES imm32.lib ws2_32.lib  ${QT_QT_LIBRARY} )
      ENDIF (QT_QTMAIN_LIBRARY)
    ELSE (WIN32)
      SET (QT_LIBRARIES ${QT_QT_LIBRARY} )
    ENDIF (WIN32)

    # Backwards compatibility for CMake1.4 and 1.2
    SET (QT_MOC_EXE ${QT_MOC_EXECUTABLE} )
    SET (QT_UIC_EXE ${QT_UIC_EXECUTABLE} )

    IF(UNIX)
      INCLUDE( ${CMAKE_ROOT}/Modules/FindX11.cmake )
      IF (X11_FOUND)
        SET (QT_LIBRARIES ${QT_LIBRARIES} ${X11_LIBRARIES})
      ENDIF (X11_FOUND)
      IF (CMAKE_DL_LIBS)
        SET (QT_LIBRARIES ${QT_LIBRARIES} ${CMAKE_DL_LIBS})
      ENDIF (CMAKE_DL_LIBS)
    ENDIF(UNIX)
    IF(QT_QT_LIBRARY MATCHES "qt-mt")
      INCLUDE( ${CMAKE_ROOT}/Modules/FindThreads.cmake )
      SET(QT_LIBRARIES ${QT_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
    ENDIF(QT_QT_LIBRARY MATCHES "qt-mt")

  ENDIF(QT_QT_LIBRARY)
ELSE(QT_INCLUDE_DIR)
   MESSAGE(FATAL_ERROR "QT library not found!\n" "Please go to http://www.ia.unc.edu/dev/tutorials/InstallLib")
ENDIF(QT_INCLUDE_DIR)


MARK_AS_ADVANCED(
  QT_INCLUDE_DIR
  QT_QT_LIBRARY
  QT_QTMAIN_LIBRARY
  QT_UIC_EXECUTABLE
  QT_MOC_EXECUTABLE
  QT_WRAP_CPP
  QT_WRAP_UI
  )

