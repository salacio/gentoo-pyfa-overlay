# Gentoo Pyfa Overlay

The most recent [pyfa](https://github.com/pyfa-org/Pyfa) versions for Gentoo.

## Add repo with eselect repository (recommended)

Install app-eselect/repository if it is not already installed

    emerge -av --noreplace app-eselect/repository
    eselect repository enable pyfa
    emaint sync -r pyfa

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
