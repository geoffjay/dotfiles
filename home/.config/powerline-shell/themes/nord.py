from powerline_shell.themes.default import DefaultColor

"""
absolute colors based on
https://github.com/arcticicestudio/nord-vim
"""

dark0 = 235
dark1 = 237
dark2 = 239
dark3 = 241
dark4 = 243
light0 = 229
light1 = 223
light2 = 250
light3 = 248
light4 = 246
dark_gray  = 0
light_gray = 8
light_white = 7
dark_white = 15
neutral_red    = 1
neutral_green  = 2
neutral_yellow = 3
neutral_blue   = 4
neutral_purple = 5
neutral_aqua   = 14
bright_red    = 1
bright_green  = 2
bright_yellow = 3
bright_blue   = 4
bright_purple = 5
bright_aqua   = 6

class Color(DefaultColor):
    USERNAME_ROOT_BG = neutral_red
    USERNAME_BG = light_gray
    USERNAME_FG = neutral_blue
    HOSTNAME_BG = dark_gray
    HOSTNAME_FG = bright_aqua
    HOME_SPECIAL_DISPLAY = True
    HOME_BG = neutral_blue
    HOME_FG = light2
    PATH_BG = dark3
    PATH_FG = light_gray
    CWD_FG = dark_white
    SEPARATOR_FG = dark_gray
    READONLY_BG = bright_red
    READONLY_FG = light0
    SSH_BG = neutral_purple
    SSH_FG = light0
    REPO_CLEAN_BG = neutral_aqua
    REPO_CLEAN_FG = dark1
    REPO_DIRTY_BG = neutral_purple
    REPO_DIRTY_FG = light0
    JOBS_FG = neutral_aqua
    JOBS_BG = dark1
    CMD_PASSED_FG = light4
    CMD_PASSED_BG = dark1
    CMD_FAILED_FG = light0
    CMD_FAILED_BG = neutral_red
    SVN_CHANGES_FG = REPO_DIRTY_FG
    SVN_CHANGES_BG = REPO_DIRTY_BG
    GIT_AHEAD_BG = dark2
    GIT_AHEAD_FG = light3
    GIT_BEHIND_BG = dark2
    GIT_BEHIND_FG = light3
    GIT_STAGED_BG = neutral_green
    GIT_STAGED_FG = light0
    GIT_NOTSTAGED_BG = neutral_blue
    GIT_NOTSTAGED_FG = light0
    GIT_UNTRACKED_BG = neutral_red
    GIT_UNTRACKED_FG = light0
    GIT_CONFLICTED_BG = neutral_red
    GIT_CONFLICTED_FG = light0
    GIT_STASH_BG = neutral_yellow
    GIT_STASH_FG = dark0
    VIRTUAL_ENV_BG = dark_gray
    VIRTUAL_ENV_FG = bright_aqua
    BATTERY_NORMAL_BG = neutral_green
    BATTERY_NORMAL_FG = dark2
    BATTERY_LOW_BG = neutral_red
    BATTERY_LOW_FG = light1
    AWS_PROFILE_FG = neutral_aqua
    AWS_PROFILE_BG = dark1
    TIME_FG = light2
    TIME_BG = dark4
