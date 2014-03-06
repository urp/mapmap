TEMPLATE = app
TARGET = mapmap
QT += gui opengl xml
CONFIG += qt debug
DEFINES += UNICODE QT_THREAD_SUPPORT QT_CORE_LIB QT_GUI_LIB

HEADERS  = \
    DestinationGLCanvas.h \
#    Facade.h \
    MainApplication.h \
    MainWindow.h \
    Mapper.h \
    MapperGLCanvas.h \
    Mapping.h \
    MappingManager.h \
    Math.h \
#    NameAllocator.h \
    Paint.h \
    ProjectReader.h \
    ProjectWriter.h \
    Shape.h \
    SourceGLCanvas.h \
    UidAllocator.h \
    Util.h \
    unused.h

SOURCES  = \
#    Controller.cpp \
    DestinationGLCanvas.cpp \
#    Facade.cpp \
    MainWindow.cpp \
    MainApplication.cpp \
    Mapper.cpp \
    MapperGLCanvas.cpp \
    Mapping.cpp \
    MappingManager.cpp \
#    NameAllocator.cpp \
    Paint.cpp \
    ProjectReader.cpp \
    ProjectWriter.cpp \
    Shape.cpp \
    SourceGLCanvas.cpp \
    UidAllocator.cpp \
    Util.cpp \
    main.cpp

RESOURCES = mapmap.qrc
TRANSLATIONS = mapmap_fr.ts
include(contrib/qtpropertybrowser/src/qtpropertybrowser.pri)
docs.depends = $(HEADERS) $(SOURCES)
docs.commands = (cat Doxyfile; echo "INPUT = $?") | doxygen -
QMAKE_EXTRA_TARGETS += docs

# Linux-specific:
unix:!mac {
  DEFINES += UNIX
  # stricter build flags:
  QMAKE_CXXFLAGS += -Wno-unused-result -Wfatal-errors
  INCLUDEPATH += /usr/include/gstreamer-0.10 \
    /usr/local/include/gstreamer-0.10 \
    /usr/include/glib-2.0 \
    /usr/lib/x86_64-linux-gnu/glib-2.0/include \
    /usr/include/libxml2
  LIBS += -lgstreamer-0.10 \
    -lgstinterfaces-0.10 \
    -lglib-2.0 \
    -lglut \
    -lgmodule-2.0 \
    -lgobject-2.0 \
    -lgthread-2.0 \
    -lGLU \
    -lGL \
    -lX11 \
    -lGLEW
}

# Mac OS X-specific:
mac {
  DEFINES += MACOSX
  INCLUDEPATH += /opt/local/include/ \
    /opt/local/include/gstreamer-0.10/ \
    /opt/local/include/glib-2.0/ \
    /opt/local/lib/glib-2.0/include \
    /opt/local/include/libxml2
  LIBS += -L/opt/local/lib \
    -lGLEW \
    -lgstreamer-0.10 \
    -lgstapp-0.10 \
    -lgstvideo-0.10 \
    -lglib-2.0 \
    -lgobject-2.0
  OBJECTIVE_SOURCES += cocoa_utils.mm
  LIBS += -framework OpenGL -framework GLUT
  QMAKE_CXXFLAGS += -D__MACOSX_CORE__
}

# Windows-specific:
win32 {
  DEFINES += WIN32
  INCLUDEPATH += \
    C:/gstreamer/include \
    C:/gstreamer/include/libxml2 \
    C:/gstreamer/include/glib-2.0 \
    C:/gstreamer/lib/glib-2.0/include \
    C:/gstreamer/include/gstreamer-0.10
  LIBS += -L"C:/gstreamer/lib" \
    -L"C:/gstreamer/bin" \
    -lgstreamer-0.10 \
    -lglib-2.0 \
    -lgmodule-2.0 \
    -lgobject-2.0 \
    -lgthread-2.0 \
    -lgstinterfaces-0.10 \
    -lopengl32 \
    -lglu32 \
    -lglew32
  # Add console to the CONFIG to see debug messages printed in 
  # the console on Windows
  CONFIG += console
}

