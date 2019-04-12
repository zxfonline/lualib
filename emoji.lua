 -- RuneLen returns the number of bytes required to encode the rune.
  -- It returns -1 if the rune is not a valid value to encode in UTF-8.
  local surrogateMin = 55296 --0xD800
  local surrogateMax =57343 -- 0xDFFF
  local rune1Max = 127 --1<<7 - 1
  local rune2Max = 2047 -- 1<<11 - 1
  local rune3Max =65535 -- 1<<16 - 1
  local MaxRune  = 1114111-- "\U0010FFFF" -- Maximum valid Unicode code point.
  function RuneLen(r)
      if r < 0 then
          return -1
      elseif r <= rune1Max then
          return 1
      elseif r <= rune2Max then
          return 2
      elseif surrogateMin <= r and r <= surrogateMax then
          return -1
      elseif r <= rune3Max then
          return 3
      elseif r <= MaxRune then
          return 4
      else
          return -1
      end
  end

  local str="a你😊b好3😊c"
  for p, c in utf8.codes(str) do
      print("#############################################")
      print(p .."=".. c .."("..RuneLen(c)..")")
  end
