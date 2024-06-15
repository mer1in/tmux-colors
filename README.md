# Tmux Window Colors

This project provides a set of functions to set tmux window colors based on test results, allowing you to see the status of tests without switching to the window.

## Installation

To install the tmux window colors script, run the following command:

```sh
curl -sSL https://raw.githubusercontent.com/mer1in/tmux-colors/master/installer.sh | bash
```

## Usage
The script defines several functions to set tmux window colors for different test statuses:

- **taberr**: Sets the window background to red, foreground to black (indicating an error).
- **tabok**: Sets the window background to green, foreground to black (indicating success).
- **tabrun**: Sets the window background to black, foreground to white (indicating running tests).
- **tabdefault**: Resets the window colors to default.

## Example
In your test script, you can use these functions to update the tmux window colors based on the test results:
```bash
#!/bin/bash

# Run your tests here
if ./run-tests.sh; then
    tabok "Tests Passed"
else
    taberr "Tests Failed"
fi
```

## How It Works
The installer script:

1. Creates a script at **`~/.tmux_window_colors.sh`** containing the functions to set tmux window colors.
1. Adds a line to source this script in your **`~/.bashrc`** file, ensuring it's added only once and updates it if already present.

## Updating
If you need to update the script, simply run the installation command again. The installer will replace the existing script with the new version and ensure the **`~/.bashrc`** is correctly configured.

## Contributing
Feel free to submit issues or pull requests if you have any improvements or bug fixes.

## License
This project is licensed under the MIT License.
