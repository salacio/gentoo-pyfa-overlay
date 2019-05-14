# Gentoo Pyfa Overlay

Do to missing dependencies in the main Gentoo repository the Pyfa versions it provides are very old
and stuck on the 1.x versions. This overlay attempts to provide the most recent version of Pyfa and
all missing dependencies that are not upstream yet.

To use this overlay add the following config to /etc/portage/repos.conf/pyfa.conf

    [pyfa]
    priority = 50
    location = /usr/local/portage/pyfa-overlay
    sync-type = git
    sync-uri = git://github.com/ZeroPointEnergy/gentoo-pyfa-overlay.git
    auto-sync = Yes
