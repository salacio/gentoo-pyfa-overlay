# Gentoo Pyfa Overlay

This is a Gentoo overlay for the newest versions of Pyfa and dependencies that are not upstream yet.

To use this overlay add the following config to /etc/portage/repos.conf/pyfa.conf

    [pyfa]
    priority = 50
    location = /usr/local/portage/pyfa-overlay
    sync-type = git
    sync-uri = git://github.com/ZeroPointEnergy/gentoo-pyfa-overlay.git
    auto-sync = Yes
