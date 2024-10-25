# dots ⚙️

**D**otfiles **O**rganize, **T**ransfer & **S**ync

## Setup 🏗️ 

Recommended to use with [GNU stow](https://www.gnu.org/software/stow/).

1. Clone the repository:
   ```bash
   git clone https://github.com/8hantanu/dots.git
   ```

2. Install GNU Stow (if not already installed):
   ```bash
   # Using apt (on Debian/Ubuntu)
   sudo apt install stow
   ```
   ```zsh
   # Using brew (on macOS)
   brew install stow
   ```

3. Change to the dots directory:
   ```bash
   cd dots
   ```

4. Use GNU Stow to symlink the config files to home directory:
   ```bash
   stow .
   ```

## Includes 📦

The repo has following configs:
- `.vimrc` - vim config
- `.tmux.conf` - tmux configuration file.

## Feedback 📝

Any ideas, suggestions, or feedback regarding dots, please feel free to open an issue on the repository.

Also share any config tips/tricks.

## License 📃

Open-source licensed under the MIT license.
