#!/bin/bash
cat > /etc/sudoers.d/xorg << EOF
Defaults env_keep += XORG_PREFIX
Defaults env_keep += XORG_CONFIG
EOF

sudo bash -c cat > /etc/profile.d/xorg.sh << EOF
# Menambahkan direktori ke PATH
export PATH=$XORG_PREFIX/bin:$PATH

# Menambahkan direktori ke PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$XORG_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$XORG_PREFIX/share/pkgconfig:$PKG_CONFIG_PATH

# Menambahkan direktori ke LIBRARY_PATH
export LIBRARY_PATH=$XORG_PREFIX/lib:$LIBRARY_PATH

# Menambahkan direktori ke C_INCLUDE_PATH
export C_INCLUDE_PATH=$XORG_PREFIX/include:$C_INCLUDE_PATH

# Menambahkan direktori ke CPLUS_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$XORG_PREFIX/include:$CPLUS_INCLUDE_PATH

# Set ACLOCAL untuk autoconf
export ACLOCAL="aclocal -I $XORG_PREFIX/share/aclocal"

# Menyimpan variabel untuk shell
export PATH PKG_CONFIG_PATH ACLOCAL LIBRARY_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH
EOF


source /etc/profile.d/xorg.sh
echo "$XORG_PREFIX/lib" >> /etc/ld.so.conf
sed -e "s@X11R6/man@X11R6/share/man@g" \
    -e "s@/usr/X11R6@$XORG_PREFIX@g"   \
    -i /etc/man_db.conf

ln -svf $XORG_PREFIX/share/X11 /usr/share/X11
ln -svf $XORG_PREFIX /usr/X11R6

echo "Seleseai"
