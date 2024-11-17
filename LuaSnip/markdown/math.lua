local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local md = require('util.markdown_ink')

return {
  s({ trig = "ii", snippetType = "autosnippet" }, fmta("$<>$", i(1))),
  s({ trig = "dd", snippetType = "autosnippet" }, fmta("$$\n<>\n$$", i(1))),
  s({ trig = "bf", snippetType = "snippet", }, fmta("\\mathbf{<>}", i(1))),
  s({ trig = "\\=", snippetType = "autosnippet" }, fmta("&=&<>", i(1))),
  s({ trig = "sin", snippetType = "autosnippet" }, {
    t("\\sin"),
  }, {condition = md.in_math_env}),
}
