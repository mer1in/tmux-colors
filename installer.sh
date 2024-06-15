#!/bin/bash

# Installer script to set up tmux window color functions

# Define the destination for the script
DEST="$HOME/.tmux_window_colors.sh"
BASHRC="$HOME/.bashrc"
MARKER="# tmux window colors script"

# Create the script content
cat << 'EOF' > $DEST
# This script sets tmux window colors to visually indicate the status of tests 
# without switching to the window. It defines functions to set different color 
# schemes and rename windows based on test results.

tabstyle(){
    # Check if the TMUX_PANE variable is set; if not, return immediately
    [ -z $TMUX_PANE ] && return
    
    # Extract the pane ID from the TMUX_PANE variable
    local pane_id=`echo "$TMUX_PANE" | sed 's/%//'`
    
    # Determine the window index for the current pane
    local window_index=`tmux list-panes -a -F '#{pane_id} #{window_id}' | grep "^%$pane_id" | sed 's/.* //'`
    
    # If the window index is not determined, print an error message
    [ -z $window_index ] && echo "Window index not determined"
    
    # Set the window status style based on the provided argument
    tmux set-window-option -t $window_index window-status-style $1
    
    # Rename the window if a second argument is provided
    [ -z $2 ] || tmux rename-window -t $window_index $2
}

# Define functions for different test result statuses
taberr(){ tabstyle bg=red,fg=black $1; }       # Error: red background, black foreground
tabok(){ tabstyle bg=green,fg=black $1; }      # OK: green background, black foreground
tabrun(){ tabstyle bg=black,fg=white $1; }     # Running: black background, white foreground
tabdefault(){ tabstyle bg=default,fg=default $1; }  # Default: reset to default colors

# Export all functions to make them available in the shell environment
for f in taberr tabok tabrun tabdefault tabstyle; do export -f $f; done
EOF

# Add the script to the user's shell profile if not already present
if grep -q "$MARKER" "$BASHRC"; then
    echo "Updating existing tmux window colors script reference in $BASHRC."
else
    echo "Adding tmux window colors script reference to $BASHRC."
    echo "$MARKER" >> "$BASHRC"
    echo "source $DEST" >> "$BASHRC"
fi

echo "Installation complete. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."

