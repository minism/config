#!/usr/bin/env python

"""Assists with installing symlinks for all dotfiles/configs under this dir."""

import os
import sys


FILE_MAP = {
  'bashrc': '~/.bashrc',
  'colordiffrc': '~/.colordiffrc',
  'gitconfig': '~/.gitconfig',
  'pystartup': '~/.pystartup',
  'tmux.conf': '~/.tmux.conf',
  'vimrc': '~/.vimrc',

  # TODO(joshcb): This should be OSX only.
  'slate': '~/.slate',
}

DIR_MAP = {
  'sublime': '~/.config/sublime-text-3/Packages/User'
}


def ensure_installed(src, dst):
  rel = os.path.relpath(dst, os.path.expanduser('~'))
  if os.path.islink(dst):
    print "%s is already a symlink, assuming we've already installed it." % rel
  elif not os.path.exists(dst):
    result = raw_input("%s doesn't exist.  Install symlink? [y/n] " % rel)
    if result.upper() == 'Y':
      os.symlink(src, dst)
      print "Created %s" % rel
  else:
    print "WARNING: %s already exists and is not a symlink, skipping." % rel


def main():
  # TODO(joshcb): Improve multi-platform support.
  if sys.platform == 'darwin':
    del DIR_MAP['sublime']
  config_root = os.path.dirname(__file__)
  full_map = {}
  for src_dir, dst_dir in DIR_MAP.iteritems():
    for file in os.listdir(os.path.join(config_root, src_dir)):
      full_map[os.path.join(config_root, src_dir, file)] = os.path.join(
          dst_dir, file)
  for src_file, dst_file in FILE_MAP.iteritems():
    full_map[os.path.join(config_root, src_file)] = dst_file
  for src in sorted(full_map.keys()):
    ensure_installed(os.path.abspath(src), os.path.expanduser(full_map[src]))



if __name__ == '__main__':
  main()
