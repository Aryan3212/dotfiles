
# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"
# For loading docker in your PATH
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
