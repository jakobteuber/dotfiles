# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs


# Added by Toolbox App
export PATH="$PATH:/home/jakobteuber/.local/share/JetBrains/Toolbox/scripts"

# Rust setup
. "$HOME/.cargo/env"

# opam configuration
test -r /home/jakobteuber/.opam/opam-init/init.sh && . /home/jakobteuber/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
