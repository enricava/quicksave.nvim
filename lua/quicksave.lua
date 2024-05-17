local M = {}

-- Sessions will be stored here
local saved_sessions_dir = vim.fn.stdpath('data') .. '/quicksave/'

-- Ensure session directory exists
local function ensure_session_dir()
    if vim.fn.isdirectory(saved_sessions_dir) == 0 then
        vim.fn.mkdir(saved_sessions_dir, 'p')
    end
end

-- Create session file name based on current directory
local function make_session_filename()
    local cur_dir = vim.fn.getcwd()
    local sanitized_dir = cur_dir:gsub('/', '-')
    return saved_sessions_dir .. sanitized_dir .. '.session'
end

-- Save the current session
function M.save_session()
    local session_file = make_session_filename()
    local status, err = pcall(function()
        vim.cmd('mksession! ' .. session_file)
    end)
    if not status then
        print('Failed to save session: ' .. err)
    end
end

-- Load the session
function M.load_session()
    local session_file = make_session_filename()
    if vim.fn.filereadable(session_file) == 1 then
        local status, err = pcall(function()
            vim.cmd('source ' .. session_file)
        end)
        if not status then
            print('Failed to load session: ' .. err)
        end
    else
        print('No session found for ' .. session_file)
    end
end

function M.setup()
    ensure_session_dir()
    vim.cmd('command! -nargs=0 SessionSave lua require("quicksave").save_session()')
    vim.cmd('command! -nargs=0 SessionLoad lua require("quicksave").load_session()')
end

return M
