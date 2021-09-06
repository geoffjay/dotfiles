def rekey(obj):
  . as $in
  | reduce (obj|keys_unsorted)[] as $k ({};
      if $in|has($k) then . + {($k): $in[$k]} else . end)
  | . + $in ;
