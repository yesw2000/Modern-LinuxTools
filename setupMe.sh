#!/bin/bash
#
# This script helps set up the virtual env of Linux tools
#
# May, 2025
# Author: Shuwei Ye <yesw@bnl.gov>
#---------------------------------

setup_me() {
    local myName="${BASH_SOURCE:-${funcsourcetrace[1]%:*}}"
    myName=$(readlink -f -- $myName)
    local myDir=$(dirname $myName)

    local arch_ld=$(ls $myDir/lib*/ld-linux-*.so* 2>/dev/null | head -n1 | sed -E 's|.*/ld-linux-([^.]+)\.so.*|\1|; s/-/_/g')
    local arch_uname=$(uname -m)

    if [[ "$arch_ld" != "$arch_uname" ]]; then
        echo "Warning: Architecture from the container ($arch_ld) does not match the machine ($arch_uname)"
        return -1
    fi

    \env which --skip-functions micromamba >/dev/null 2>&1
    if [ $? -ne 0 ]; then
       export MAMBA_EXE=$myDir/bin/micromamba
    else
       export MAMBA_EXE=$(\env which --skip-functions micromamba)
    fi

    local shellName=$(readlink /proc/$$/exe | awk -F "[/-]" '{print $NF}')
    typeset -f micromamba >/dev/null || eval "$($MAMBA_EXE shell hook --shell=$shellName)"

    # package cache dir
    export CONDA_PKGS_DIRS=/tmp/$USER/pkgs

    # alias
    # alias mamba=micromamba

    # add the default "conda-forge" channel
    micromamba config get channel 2>/dev/null | grep conda-forge >/dev/null || micromamba config prepend channels conda-forge
    micromamba config get channel 2>/dev/null | grep defaults >/dev/null || micromamba config prepend channels defaults

    # set up the virtual env
    export CONDA_PREFIX=$myDir/opt/conda
    export MAMBA_ROOT_PREFIX=$CONDA_PREFIX
    micromamba activate

    # define a shell function git_delta
    # Check if both 'git' and 'delta' commands are available
    if command -v git &> /dev/null && command -v delta &> /dev/null; then
        # If both commands are found, define the function
        git_delta() {
          # Check for help argument first
          if [[ "$1" == "-h" || "$1" == "--help" ]]; then
            echo "Wrapper for 'git diff ARGV | delta'. See 'git diff --help' and 'delta --help' for options."
            return 0
          fi

          # Check if current directory is a Git repository
          if ! git rev-parse --is-inside-work-tree &> /dev/null; then
             echo "Current directory or the parent directory is NOT a Git repository."
             return 1
          fi

          # If all checks pass, execute the command
          git diff "$@" | delta
        }
    fi 

    # cache directory for tealdeer (tldr)
    # export TEALDEER_CACHE_DIR=$myDir/root/.cache/tealdeer
    export TEALDEER_CACHE_DIR=$CONDA_PREFIX/.cache/tealdeer

    local redCol="\e[1;31;40m"
    echo -e "🚀 Modern Linux tools (${redCol}micromamba\e[0m, ${redCol}tldr\e[0m, ${redCol}rg\e[0m, and more) are now available!

- Run '${redCol}list_tools\e[0m' to view the complete list of new tools.
- For command usage, run '${redCol}<command> --help\e[0m' (e.g., '${redCol}rg --help\e[0m').
- For quick examples (except for gemini, copilot-api, and goose),
      use '${redCol}tldr <command>\e[0m' (e.g., '${redCol}tldr rg\e[0m')."
   type -t git_delta &> /dev/null && echo -e "A wrapper function ${redCol}git_delta\e[0m is defined. Run 'git_delta -h' for help"
}

mamba_new() {
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
        echo "Usage: mamba_new [-h|--help] <env_name>"
        echo "Create a new conda environment with the given name."
        echo "If <env_name> contains '/', it will be used as the path to the environment."
        return
    fi

    env_name="$1"
    if [[ "$env_name" == */* ]]; then
        env_path="$env_name"
    else
        env_path="./$env_name"
    fi

   if [[ -e "$env_name" ]]; then
       echo "!!Warning!! The directory $env_name exists already. Remove it first"
       return 1
   fi

    micromamba create -y -p "$env_path" "${@:2}"
    micromamba activate "$env_path"
    echo -e "\nTo deactivate the env, simply run\n\t micromamba deactivate $env_path"
}

# Call the setup_mamba function
setup_me

list_tools() {
   if command -v glow &> /dev/null && [ -f "$CONDA_PREFIX/../../list-of-tools.md" ]; then
      glow "$CONDA_PREFIX/../../list-of-tools.md"
   fi
}

