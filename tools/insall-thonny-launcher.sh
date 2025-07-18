# Create desktop file for launcher
cat > ~/.local/share/applications/thonny.desktop << EOF
[Desktop Entry]
Name=Thonny
Comment=Python IDE for beginners
Exec=thonny %F
Icon=thonny
Terminal=false
Type=Application
Categories=Development;IDE;
MimeType=text/x-python;
EOF

# Make executable
chmod +x ~/.local/share/applications/thonny.desktop