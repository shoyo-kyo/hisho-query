require "sass"
#
# hisho-query support functions v0.1.2
# http://query.hisho.com
# 
# Copyright 2014 shoyo kyo
# Released under the MIT license
# https://github.com/syouyou/hisho-query/blob/master/LICENSE
# 
# Date: 2014-04-30
# 

#
# hq-list functions
# list操作関数を集めたrubyファイル
#
module HishoQueryList
  #
  # hq-list-to-string($map)
  # return string
  #

  #
  # [name] hq-list-toString v1.0.0
  # [desc] listを文字列に変換。debugで等で利用
  # [return] string
  # [exsample] hq-list-toString($map)
  #
  def hq_list_toString(list)
    result = list.to_s
    Sass::Script::String.new(result)
  end
end



#
# hq-map functions
# map操作関数を集めたrubyファイル
#
module HishoQueryMap
  #
  # hq-map-to-string($map)
  # return string
  #

  #
  # [name] hq-map-to-string v1.0.0
  # [desc] mapを文字列に変換。debugで等で利用
  # [return] string
  # [exsample] hq-map-to-string($map)
  #
  def hq_map_to_string(map)
    assert_type map, :Map, :map
    result = to_h(map).to_s
    Sass::Script::String.new(result)
  end
end



#
# hq-str functions
# 文字列操作関数を集めたrubyファイル
#

module HishoQueryStr

  #
  # [name] hq-str-strip v1.0.0
  # [desc] 前後にあるspace除去
  # [return] string
  # [exsample] hq-str-strip("  AbC")
  #
  def hq_str_strip(str)
    assert_type str, :String
    result = str.value.strip
    Sass::Script::String.new(result)
  end

  #
  # [name] hq-str-succ v1.0.0
  # [desc] 次の文字を返す
  # [return] string
  # [exsample] hq-str-succ("a") -> b
  #
  def hq_str_succ(str)
    assert_type str, :String
    result = str.value.succ
    Sass::Script::String.new(result)
  end

  #
  # [name] hq-str-reverse v1.0.0
  # [desc] 文字反転
  # [return] string
  # [exsample] hq-str-reverse("AbC")
  #
  def hq_str_reverse(str)
    assert_type str, :String
    result = str.value.reverse
    Sass::Script::String.new(result)
  end

  #
  # [name] hq-str-capitalize v1.0.0
  # [desc] 先頭大文字化(以外は小文字に)
  # [return] string
  # [exsample] hq-str-capitalize("aBC")
  #
  def hq_str_capitalize(str)
    assert_type str, :String
    result = str.value.capitalize
    Sass::Script::String.new(result)
  end

  #
  # [name] hq-str-first-letter-upper-case v1.0.0
  # [desc] 先頭のみ大文字化
  # [return] string
  # [exsample] hq_str_first_letter_upper_case("aBC")
  #
  def hq_str_first_letter_upper_case(str)
    assert_type str, :String
    result = str.value.gsub(/^\w/){|word| word.upcase}
    Sass::Script::String.new(result)
  end

  #
  # [name] hq-str-first-letter-lower-case v1.0.0
  # [desc]先頭のみ小文字化
  # [return] string
  # [exsample] hq-str-first-letter-lower-case("ABC")
  #
  def hq_str_first_letter_lower_case(str)
    assert_type str, :String
    result = str.value.gsub(/^\w/){|word| word.downcase}
    Sass::Script::String.new(result)
  end

  #
  # [name] hq-str-match v1.0.0
  # [desc] 文字列の検索
  # [return] string
  # [exsample] hq-str-match(abbc,"/a.*c/")
  #
  def hq_str_match(str, find)
    assert_type str, :String
    assert_type find, :String
    if (/\/.+\// =~ find.value) then
      findValue = find.value.gsub(/\//, "")
      isMatch = str.value.match(/#{findValue}/)
    else
      isMatch = str.value.match(find.value)
    end
    result =  if isMatch then true else false end
    Sass::Script::Bool.new(result)
  end

  #
  # [name] hq-str-replace v1.0.0
  # [desc] 文字列の置換
  # [return] string
  # [exsample] hq-str-replace(aabb, "/aa(.*)/", "xx\1")
  #
  def hq_str_replace(str, find, rep)
    assert_type str, :String
    assert_type find, :String
    assert_type rep, :String
    if (/\/.+\// =~ find.value) then
      findValue = find.value.gsub(/\//, "")
      result = str.value.gsub(/#{findValue}/, rep.value)
    else
      result = str.value.sub(find.value, rep.value)
    end
    Sass::Script::String.new(result)
  end

  #
  # [name] hq-str-split v1.0.0
  # [desc] 指定した区切り文字で分割
  # [return] string
  # [exsample] hq-str-split("aa|bb|cc", "|", 2)
  #
  def hq_str_split(*args)
    str = args[0]
    find = args[1]
    index = args[2]

    datas = str.value.split(find.value)
    if index != nil then
       Sass::Script::String.new(datas[index.to_i].strip)
    else
      Sass::Script::List.new(datas.map{|i| Sass::Script::String.new(i)}, :comma)
    end
  end

  #
  # [name] hq-num-toNumber v1.0.0
  # [desc] number型に変換
  # [return] Number
  # [exsample] hq-num-toNumber("120")
  #
  def hq_num_toNumber(str)
    assert_type str, :String
    result = str.to_i
    Sass::Script::Number.new(result)
  end


  #
  # [name] hq-debug v1.0.0
  # [desc] ターミナルに値の結果を表示
  # [return] null
  # [exsample] hq-debug(1 + 2)
  #
  def hq_debug( *args )
    args.each {|v|
      print v.class
       print " : "
      if v.class == Sass::Script::Value::Map then
        print to_h(v)
      else
        print v
      end
       print "\n"
    }
    print "\n"
    Sass::Script::String.new("")
  end

  #
  # [name] hq-puts v1.0.0
  # [desc] ターミナルに文字列を表示する
  # [return] null
  # [exsample] hq-puts(1 + 2)
  #
  def hq_puts(str)
    puts "\n"
    if str.class == Sass::Script::Value::Map then 
      puts to_h(str)
    else
      puts str
    end
    puts "\n"
    Sass::Script::String.new("")
  end

  #
  # [name] hq-print v1.0.0
  # [desc] ターミナルに文字列を表示する（改行無し）
  # [return] null
  # [exsample] hq-puts(1 + 2)
  #
  def hq_print(str)
    if str.class == Sass::Script::Value::Map then 
      print to_h(str)
    else
      print str
    end
    Sass::Script::String.new("")
  end

  #
  # [name] hq-str-toNumber v1.0.0
  # [desc] StringをNumber型に変換
  # [return] null
  # [exsample] hq-str-toNumber("12px")
  #
  def hq_str_toNumber(str)
    assert_type str, :String
    is_int = str.value.match(".")
    unit = str.value.gsub(/^(.*)[0-9](.*?)$/, '\2')
    if is_int == false
      result = str.value.to_i
    else
      result = str.value.to_f
    end
    Sass::Script::Number.new(result,unit)
  end
  


end



#
# hq-num functions
# Number操作関数を集めたrubyファイル
#

module HishoQueryNum

  #
  # [name] hq-num-toString v1.0.0
  # [desc] string型に変換
  # [return] string
  # [exsample] hq-num-toString(120)
  #
  def hq_num_toString(num)
    assert_type num, :Number
    result = num.to_s
    Sass::Script::String.new(result)
  end


  #
  # [name] hq-num-match v1.0.0
  # [desc] 数値の検索
  # [return] string
  # [exsample] hq-num-match(abbc,"/a.*c/")
  #
  def hq_num_match(num, find)
    assert_type num, :Number
    assert_type find, :String
    str = num.to_s
    if (/\/.+\// =~ find.value) then
      findValue = find.value.gsub(/\//, "")
      isMatch = str.match(/#{findValue}/)
    else
      isMatch = str.match(find.value)
    end
    result =  if isMatch then true else false end
    Sass::Script::Bool.new(result)
  end

  #
  # [name] hq-num-replace v1.0.0
  # [desc] 数値の置換
  # [return] string
  # [exsample] hq-num-replace(aabb, "/aa(.*)/", "xx\1")
  #
  def hq_num_replace(num, find, rep)
    assert_type num, :Number
    assert_type find, :String
    assert_type rep, :String
    str = num.to_s
    if (/\/.+\// =~ find.value) then
      findValue = find.value.gsub(/\//, "")
      result = str.gsub(/#{findValue}/, rep.value)
    else
      result = str.sub(find.value, rep.value)
    end
    result = result.to_i
    Sass::Script::Number.new(result)
  end


end


module Sass::Script::Functions
  include HishoQueryStr
  include HishoQueryMap
  include HishoQueryNum
  include HishoQueryList
end