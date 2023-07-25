# One-key Linux Setup

## Overview

This project aims to conveniently setup and deploy a Linux environment which is easy to use and help install many useful packages. It mainly have the ability to deploy zsh with a set of handy plugins, and a spacevim, which is my favorite vim distro. You will not encounter messy installation problems and the script is tested on ubuntu and WSL ubuntu. 

Currently, it only support Ubuntu system, but the support of centos is also on the way, maybe also the MacOS version.

It is highly customizable and elegantly wrote, you can folk and customize your own version based on it!

## Usage

### Method  1

1. Make sure you already have curl installed by "sudo apt-get install curl".

2. Use command `curl -fsSL https://raw.githubusercontent.com/miracleyoo/one-key-linux-setup/master/one-key-linux-setup.sh -o one-key-linux-setup.sh && one-key-linux-setup.sh`
   1. For docker/k8s Linux system setup (Assuming your base image is `pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel`):
      `curl -fsSL https://raw.githubusercontent.com/miracleyoo/one-key-linux-setup/master/one-key-setup-for-pytorch-docker.sh -o one-key-setup-for-pytorch-docker.sh && bash one-key-setup-for-pytorch-docker.sh && rm one-key-setup-for-pytorch-docker.sh`
   2. For a brand-new Linux machine: `curl -fsSL https://raw.githubusercontent.com/miracleyoo/one-key-linux-setup/master/oks-full.sh -o oks-full.sh && sudo bash oks-full.sh && rm oks-full.sh`
   3. legacy: `curl -fsSL https://raw.githubusercontent.com/miracleyoo/one-key-linux-setup/master/one-key-linux-setup.sh -o one-key-linux-setup.sh && sudo bash one-key-linux-setup.sh`

4. You are all set! Here is an awesome new linux!


### Method 2

1. Make sure you already have curl installed by "sudo apt-get install git".
2. Clone this repo using `git clone https://github.com/miracleyoo/one-key-linux-setup`
3. Switch into this folder and run `./one-key-linux-setup.sh`
4. You are all set! 

## Content

1. `apt-get install packags` like git, curl, tmux, vim, and python supports.
2. A `zsh` which has plenty of handy plugins like `oh-my-zsh`, `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-completions` , `extract`, `z`, `cp`. They are managed with `antigen`, which made it easy and decent to mange your zsh plugins. You can get even more plugins [here](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview).
3. A `.zshrc` file which contains some basic but useful functions. You can change it to your own favorite commands and alias.
4. A [spacevim](https://github.com/SpaceVim/SpaceVim), which is a quite good version of vim. It initially installed several famous plugins, with a nice interface. You will find it a really vim distro as you use it. Certainly, you can change to your own version, while I've tested several distro and they all have some kinds of inconvenience, like the line number, extra space, wrong background color and so on.
5.   More on the way!

