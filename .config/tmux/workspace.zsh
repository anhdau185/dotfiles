session="workspace"

# Check if session already exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)
tmux has-session -t $session 2>/dev/null

if [ $? != 0 ]; then
    # Create a new session
    tmux new-session -d -s $session
fi

# Attach to existing or created session
tmux attach -t $session
