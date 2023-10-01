#!/usr/bin/python3
import os
from os.path import join
import sys

VERSION = '0.9'
HOME = os.getenv('HOME')
DUNST_CONFIG_FOLDER_PATH = join(HOME, '.config/dunst/')
DUNST_CONFIG_PATH = join(DUNST_CONFIG_FOLDER_PATH, 'dunstrc')
DUNST_TEMPLATE_PATH = join(DUNST_CONFIG_FOLDER_PATH, 'dunstrc.template')
WAL_CACHE_PATH = join(HOME, '.cache/wal/colors')


def wal_cache_file_to_dict():  # Creating a list where each element is a color from the wal cache
    with open(WAL_CACHE_PATH, 'r') as file:
        colors = []
        for index, line in enumerate(file.readlines()):
            colors.append(('${{wal.color{}}}'.format(index), line[:-1]))
    return colors


def modify_dunst_config_file(colors):  #
    with open(DUNST_TEMPLATE_PATH, 'r') as template_file:
        with open(DUNST_CONFIG_PATH, 'w') as config_file:
            for line in template_file.readlines():
                for i, x in colors:
                    if i in line:
                        line = line.replace(i, x)
                config_file.write(line)


def main():
    global DUNST_TEMPLATE_PATH, WAL_CACHE_PATH, VERSION
    if len(sys.argv) == 2:
        if sys.argv[1] == '-v':
            print('wal-dunst ' + VERSION)
            sys.exit()
        if sys.argv[1] == '-h' or sys.argv[1] == '--help':
            print("usage: wal-dunst [-h] [-v version] [-t 'path/to/template']\n")
            print('optional arguments:')
            print('\t-h, --help            show this help message and exit')
            print('\t-v                    displays the version of wal-dunst')
            print('\t-t                    runs the script with a custom template path')
            sys.exit()
        else:
            print('Syntax error!')
            sys.exit()
    if len(sys.argv) >= 3:
        if sys.argv.index('-t') != -1:
            DUNST_TEMPLATE_PATH = sys.argv[sys.argv.index('-t') + 1]
            try:
                open(DUNST_TEMPLATE_PATH, 'r')
            except IOError:
                print('The provided template file does not exist')
                sys.exit()
    print('Loading wal cache...')
    try:
        colors = wal_cache_file_to_dict()
    except IOError:
        print('Could not read ' + WAL_CACHE_PATH)
        sys.exit()
    print('Wal cache successfully loaded!')
    print('Loading the template and generating the new config...')
    try:
        modify_dunst_config_file(colors)
    except IOError:
        print('Could not read ' + WAL_CACHE_PATH)
        sys.exit()
    print('Template file successfully loaded and new config file generated!')


if __name__ == '__main__':
    main()
