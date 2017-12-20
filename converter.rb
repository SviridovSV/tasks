# Replace ranges in the given string with the shortened form.
# `'abcdab987612' => 'a-dab9-612`
class Converter
  def convert_string(str)
    str.scan(/.{6}/).each { |elem| elem[1..2] = '-' }.join('')
  end
end
