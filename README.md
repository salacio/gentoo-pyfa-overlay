# Gentoo Pyfa Overlay

The most recent [pyfa](https://github.com/pyfa-org/Pyfa) versions for Gentoo.

## Add repo with layman

To add the pyfa overlay you can simply use layman:

    layman -a pyfa

## Add repo manually

To configure the repo manually add the following config to `/etc/portage/repos.conf/pyfa.conf`:

    [pyfa]
    priority = 50
    location = /usr/local/portage/pyfa
    sync-type = git
    sync-uri = git://github.com/ZeroPointEnergy/gentoo-pyfa-overlay.git
    auto-sync = Yes
