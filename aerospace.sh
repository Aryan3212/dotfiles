#!/usr/bin/env zsh

# Define app-to-workspace mapping
typeset -A APP_WORKSPACE_MAP
APP_WORKSPACE_MAP=(
    "com.microsoft.VSCode" "code_editor"
    "company.thebrowser.Browser" "Browser:Personal"
    "com.github.wez.wezterm" "Terminal"
    "md.obsidian" "Notes"
    "com.microsoft.teams2" "Messaging"
    "com.microsoft.Outlook" "Email"
    "com.microsoft.edgemac" "Browser:Work"
)

# Function to move an app to its workspace
reset_workspaces() {
    local app_id=$1
    local workspace=$2

    # Find the app's window ID
    local app_window_id=$(aerospace list-windows --all --format "%{window-id} %{app-bundle-id}" | grep "$app_id" | awk '{print $1}')

    # If the app window is found, move it to the workspace
    if [[ -n $app_window_id ]]; then
        aerospace move-node-to-workspace --window-id "$app_window_id" "$workspace" --fail-if-noop
    fi
}

bring_workspace() {
    local workspace=$1
    local current_workspace=$(aerospace list-workspaces --focused)

    # List all windows in the target workspace and move them to the focused workspace
    aerospace list-windows --workspace "$workspace" --format "%{window-id}" | while read -r window_id; do
        aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
    done
}


# Iterate over all apps based on the CLI argument
case $1 in
    "reset-workspaces")
        for app_id workspace in ${(kv)APP_WORKSPACE_MAP}; do
            reset_workspaces "$app_id" "$workspace"
        done
        ;;
    "bring-workspace")
        if [[ -n $2 ]]; then
            bring_workspace "$2"
        fi
        ;;
    *)
        echo "Only reset-workspaces and bring-workspace commands are supported!"
        ;;
esac
