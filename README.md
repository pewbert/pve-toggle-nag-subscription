# pve-toggle-nag-subscription
Enable or disable the subscription pop-up window in proxmox.
This is written in zsh using sed, grep, and cut.
We find the line to be edited around line 614, this can easily change in updates.
the string is a boolean comparison that determines if the subscription is active or not.
default for no-subscription is not active, !== 'active'
we remove the !bang and replace it with nothing. This makes the subscription always active.
run the same script again to find the same line again. RE-insert the !bang to make the subscription inactive.

This checked_command runs 3 times in proxmox. removing it is not an option.
the checked command is called upon initial login sequence with a popup Javascript5 Window Ext.Msg.Show
changing the Ext.Msg.Show to Ext.Msg.Hide works, but it breaks the following:
the checked_command is called whenever the sources.list repositories need to be used through the web-gui. 
When the Ext.Msg.Hide is called the window is hidden and you cannot continue to add a repository to the list.
A subscription check is also called whenever an update command is issued through the gui's updates.
