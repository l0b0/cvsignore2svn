#!/usr/bin/env bash
#
# NAME
#        cvsignore2svn - Convert .cvsignore files to svn:ignore properties
#
# SYNOPSIS
#        cvsignore2svn [PATH...]
#
# DESCRIPTION
#        Run after importing / converting a CVS repository into a Subversion
#        repository. Recursively converts .cvsignore files in the specified
#        PATHs (default current directory) to svn:ignore properties of the same
#        directories, and removes the .cvsignore files from the repository
#        afterwards.
#
# EXAMPLES
#        cvsignore2svn
#            Converts .cvsignore files in the current directory and all
#            subdirectories.
#
#        cvsignore2svn ~/dev/project*
#            Converts .cvsignore files in all the project directories in ~/dev.
#
# BUGS
#        https://github.com/l0b0/cvsignore2svn/issues
#
# COPYRIGHT AND LICENSE
#        Copyright (C) 2011 Victor Engmark
#
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        (at your option) any later version.
#
#        This program is distributed in the hope that it will be useful,
#        but WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#        GNU General Public License for more details.
#
#        You should have received a copy of the GNU General Public License
#        along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

while IFS= read -r -d '' -u 9
do
    dir_path="$(dirname -- "$REPLY")x"
    dir_path="${dir_path%x}"
    svn propset svn:ignore -F "$REPLY" -- "$dir_path"
    svn remove "$REPLY"
done 9< <( find ${1+"$@"} -name .cvsignore -print0 )
