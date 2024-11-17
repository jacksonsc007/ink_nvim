local M = {}

-- Utility function to check if the cursor is inside a LaTeX-style math environment
M.in_math_env = function ()
  -- Get the current line and position of the cursor
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- print("perform in math env function")
  -- Check for math environments like $...$, $$...$$, or \[...\]
  local before = line:sub(1, col)
  local after = line:sub(col + 1, -1)

  -- Look for opening and closing $ or \[...\] patterns
  local math_env_before = before:match("(%$%$?)") or before:match("\\[")
  local math_env_after = after:match("(%$%$?)") or after:match("\\]")

  if math_env_before and math_env_after then
    return true
  end
  -- deal with multi-line condition for $$...$$
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, _ = cursor[1] - 1, cursor[2]  -- row is 0-indexed
  local lines = vim.api.nvim_buf_get_lines(0, 0, row+10, false)
  -- print(vim.inspect(lines))
  -- print("no math inline. Perform multi-line search")
  -- Search upwards for an opening delimiter ($$, \[)
  local math_open = false
  for i = row, 0, -1 do
    if lines[i] then
      if lines[i]:match("%$%$") then
        math_open = true
        break
      end
    end
  end

  -- If no opening delimiter found, we're not in a math zone
  if not math_open then
    -- print("not found in previous lines")
    return false
  end
  -- print("found in previous lines, looking for pairs")
  -- Search downwards for a closing delimiter ($$, \])
  for i = row, row+10 do
    -- print("current line:", i)
    if lines[i]:match("%$%$") then
      return true
    end
  end

  -- If no closing delimiter is found below, we're still in a math zone
  return false
end



return M
