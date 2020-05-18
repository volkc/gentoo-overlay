## Installation

```zsh
# install layman (make sure the "git" useflag is set)
emerge -av layman

# configure layman to fetch this overlay
layman -o https://git.io/JfEzE -f -a volkc-gentoo-overlay

# sync
layman -s volkc-gentoo-overlay
```
