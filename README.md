# lightdm-nodpms

The primary purpose in creating this script was to prevent lightdm from blanking the screen when idle. When running an Ubuntu HTPC, having the screen blank will cause the television to lose signal.

This installs a startup script for lightdm that will request X to disable dpms and not blank the screen.


## Requirements

- ubuntu 12.04 or greater (may work on earlier versions)

## How to Use

1. Install configuration files for lightdm: `sudo setup.py install`

2. Reboot (you can just restart lightdm)


## Contributors

Richard A. Bray

## License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 

