local M = {}

local tmux_map = { h="L", j = "D", k = "U", l = "R" }

function M.move_left()
  move("h")
end

function M.move_down()
  move("j")
end

function M.move_right()
  move("l")
end

function M.move_up()
  move("k")
end

function move(direction)
  local win_num_before = vim.fn.winnr()
  vim.cmd([[execute "wincmd ]] .. direction .. [["]])
  if vim.fn.winnr() == win_num_before then
    tmux_move(direction)
  end
end

function tmux_move(direction)
  local tmux_direction = tmux_map[direction]
  vim.cmd([[silent exec "!tmux selectp -]] .. tmux_direction .. [["]])
end
 
return M
