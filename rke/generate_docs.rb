class GenerateDocs

  @@types = {}
  @@yaml = {}

  @@title = ''

  def initialize(title)
    @@title = title
  end

  def dynamic(readFile, writeFile)
    require 'yaml'

    docline = false
    comment = Array.new
    current_type = String.new

    open(readFile).each { |l|
      if docline then
        type = l.match(/^\s+\w+ (\[\])?([A-Z]\w+)/)
        yaml = l.match(/yaml:"(\w+)"/)

        unless yaml.nil? then
          @@types[current_type][yaml[1]] = {
            'yaml' => yaml[1],
            'comment' => comment[1]
          }

          unless type.nil? then
            @@types[current_type][yaml[1]]['type'] = type[2]
          else
            var_type = l.match(/^\s+\w+ (\[\])?(\w+)/)

            unless var_type.nil? then
              unless var_type[1].nil? then
                # it is an array (slice)
                vt = 'array'
              else
                vt = var_type[2]
              end

              @@types[current_type][yaml[1]]['vartype'] = vt
            end
          end
        end
        docline = false
        next
      end

      comment = l.match(/\/\/.(.+)/)
      unless comment.nil? then
        # comment: #{comment[1]}
        docline = true
        next
      end

      type = l.match(/type.(\w+).struct/)
      unless type.nil? then
        @@types[type[1]] = Hash.new
        current_type = type[1]
        next
      end
    }

    old_stdout = $stdout.dup
    stdout = File.open(writeFile, 'w')
    $stdout.reopen(stdout)
    puts @@title
    puts '=' * @@title.length

    @@types.first.each do |target|
      unless target.instance_of?(String) then
        self.loop(target, '', 1)
      end
    end

    yaml_title = "Full cluster.yml:"

    puts <<FULL

-----

## #{yaml_title}

```yaml
#{@@yaml.to_yaml}
```
FULL

    $stdout = old_stdout
  end

  def loop(target, parent, count)
    dash = "  " * (count - 1)
    unless parent.empty? then
      @@yaml[parent] = {}
    end

    target.each do |key, value|
      if count == 1 then
        puts
        puts "#{value['yaml'].gsub(/_/, '\_')}"
        puts "-" * value['yaml'].length
      else
        case value['vartype']
        when 'map'
          vartype = { "option1" => "value", "option2" => "value" }
        when 'array'
          vartype = [ 'string1...', 'string2...', 'string3...' ]
        when 'string'
          vartype = "string..."
        when 'int'
          vartype = 1234
        when 'bool'
          vartype = true
        else
          vartype = value['vartype']
        end

        @@yaml[parent][key] = vartype
      end

      puts "#{dash} * #{key.gsub(/_/, '\_')} - #{value['comment'].gsub(/_/, '\_')}"
      unless value['type'].nil? then
        self.loop(@@types[value['type']], key, count+1)
      end
    end
  end
end
