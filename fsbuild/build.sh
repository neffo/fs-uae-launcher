. ./PACKAGE.FS
. fsbuild/system.sh

make

BUILDDIR=fsbuild/_build

# Remove files from PyQt5 that we don't want to bundle (before pyinstaller
# pulls in their dependencies).

# disabled for amigalive build
# python3 fsbuild/fix-pyqt5.py

rm -Rf $BUILDDIR/pyinstaller
if [ "$SYSTEM_OS" = "Windows" ]; then
	pyinstaller \
		--specpath pyinstaller \
		--distpath $BUILDDIR/pyinstaller \
		--log-level DEBUG \
		--windowed \
		$PACKAGE_NAME
	BINDIR=fsbuild/_build/pyinstaller/$PACKAGE_NAME
elif [ "$SYSTEM_OS" = "macOS" ]; then
	pyinstaller \
		--specpath pyinstaller \
		--distpath $BUILDDIR/pyinstaller \
		--log-level DEBUG \
		--windowed \
		--osx-bundle-identifier no.fengestad.fs-uae-launcher \
		$PACKAGE_NAME
	BINDIR=fsbuild/_build/pyinstaller/$PACKAGE_NAME.app/Contents/MacOS
else
	pyinstaller \
		--specpath pyinstaller \
		--distpath $BUILDDIR/pyinstaller \
		--log-level DEBUG \
		$PACKAGE_NAME
	BINDIR=fsbuild/_build/pyinstaller/$PACKAGE_NAME
	# Fontconfig in particular can crash the application because it conflicts
	# with system font cache or config files. For now, assume these library are
	# always present and use the system ones.
	if [ -f $BINDIR/libfreetype.so.6 ]; then
		echo "rm $BINDIR/libfreetype.so.6"
		rm $BINDIR/libfreetype.so.6
	fi
	if [ -f $BINDIR/libfontconfig.so.1 ]; then
		echo "rm $BINDIR/libfontconfig.so.1"
		rm $BINDIR/libfontconfig.so.1
	fi
fi

# These do not work with macOS notarization, but might as well remove for all
# platforms.
if [ -f $BINDIR/PyQt5/Qt/translations ]; then
	rm -Rf $BINDIR/PyQt5/Qt/translations
fi
if [ -f $BINDIR/PyQt5/Qt/qml ]; then
	rm -Rf $BINDIR/PyQt5/Qt/qml
fi

# In case the Qt dir is Qt5...
if [ -f $BINDIR/PyQt5/Qt5/translations ]; then
	rm -Rf $BINDIR/PyQt5/Qt5/translations
fi
if [ -f $BINDIR/PyQt5/Qt5/qml ]; then
	rm -Rf $BINDIR/PyQt5/Qt5/qml
fi
