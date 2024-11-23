# My Unix Configs

Inspired a lot by: @josean-dev

Goals? 1. Increase the time under flow state or in the focus zone, configuring and learning these tools take up a lot of time. The return on the time saved is not a lot I believe but the return on the focus gained is a lot. 1 minute of focused time is worth its weight in gold.

Terminal: Wezterm - According to my research pretty good. The dev is also a nice guy. Still need to set up a proper workflow here.

Workspace Manager: Aerospace - Most bang for the buck in terms of workflow improvement in my opinion. Helps you quickly switch between screens and windows. For example, going from the code editor to the browser to your notepad, really fast. Linux equivalent would be i3.

Editor: Transitioning from VSCode to NeoVim. I plan on using big name IDEs, steal their ideas and integrate them into NeoVim. Why? NeoVim is at most times faster and more reliable because every thing is configured by you, the user.

Keyboard Layout: Colemak DH ANSI. After some research I decided Colemak DH was the best keyboard layout for comfort. However, more than that I believe it allowed me to properly learn touch typing. Before, when using QWERTY I always fell back to looking at the keyboard no matter how much I tried to learn how to touch type. The painful 1 month of typing in COLEMAK meant that I never needed to look at the keyboard again because it wouldn't help anyways. Previously, I configured using MacOS Input Settings but I ran into a few issues with this approach therefore I now use a Karabiner setting to write in COLEMAK.

Keyboard/Mouse Input Modifier: Karabiner Elements. Explained above. I also changed Caps Lock to Bckspc inspired by a dev I look up to. This position is easier for me. Point is, modify the unused keys on your keyboard to useful keys that can be within your reach.

Quality of Life Settings Changes for MacOS:

1. Reduce Animations

Add docs:

1. Tools to install and use as dependencies.
2. zsh-nvim, bat, eza, fd, fzf, ripgrep, tldr, pure etc. etc. etc.
3. DevTools configuration to make things easier- Preserve Log, Network Tab settings.

To setup Aerospace with my custom script:

1. Take the .aerospace.toml file and put in your desired config folder. Default folder they look at is home or ~. Look at the config file to get an idea and configure it.

2. Take the aerospace.sh file and put it inside the ~ or home folder. Configure this script. You can see the apps and their workspaces listed in the beginning.

3. Make you sure you setup proper permissions for running the scripts. I had a hard time with the permissions.

4. Unique operations from my config:
   1. Opening new windows distributes them to their unique workspace.
   2. You can bring windows from other workspace to your current workspace.
   3. Even if you change workspace you can reset everything using alt-r.
