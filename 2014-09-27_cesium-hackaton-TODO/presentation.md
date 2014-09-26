# TODO

A PRESENTATION BY:
Miguel Palhas
@naps62


# TODO

A ruby CLI for managing a TODO list

```html
<doge>wow. much engineering</doge>
```


# What we want

```sh
# show all current TODO items
$ todo
$ todo -l

# add new items to list
$ todo "Research 'yo momma' jokes"
$ todo -a "Learn how to make presentations"

# remove items
$ todo -r <id>

# mark as done
$ todo -d <id>
```


# 1: Ruby 101

```ruby
    #!/usr/bin/env ruby

    def method_missing(*args)
      "world"
    end

    puts "Hello #{cesium}"
```


# 2: Parsing

`optparse` is included in standard ruby

```ruby
    require 'optparse'

    parser = OptionParser.new do |opts|
      # parse arguments here
    end
    parser.parse!
```


# 2: Parsing

```ruby
    OptionParser.new do |opts|
      opts.banner = "Usage: todo [options]"

      opts.on('-a', '--argument', 'A useful description') do
        # do stuff here
      end
    end
```


# 3: Add an option

Counting the amount of current tasks

```ruby
    OptionParser.new do |opts|
      # ...
      opts.on('-c', '--count', 'Counts the number of tasks on the list') do
        puts count
      end
    end

    # ...

    TASKS_FILE = "~/.todo"

    def count
      puts File.read(TASKS_FILE).scan(/\n/).count
    end
```


# 4: Parameters

Adding a new task to the list

```ruby
    OptionParser.new do |opts|
      # ...
      opts.on('-a', '--add TASK', 'Adds TASK to the todo list') do |task|
        add task
      end
    end

    # ...

    def add(task)
      CSV.open(TASKS_FILE, "a+") do |csv|
        csv << [false, task]
      end
    end
```


# 5: Different types

Mark a task as done

```ruby
    OptionParser.new do |opts|
      # ...
      opts.on('-d', '--done ID', Integer, 'Marks task with given ID as done') do |id|
        mark_as_done id
      end
    end

    # ...

    def mark_as_done(id)
      tasks = CSV.read(TASKS_FILE)
      tasks[id-1][0] = true
      CSV.open(TASKS_FILE, 'wb') do |csv|
        tasks.each { |task| csv << task }
      end
    end
```


# 6: List tasks

```ruby
    OptionParser.new do |opts|
      # ...
      opts.on('-l', '--list', 'List all tasks') do
        list
      end
    end

    # ...

    def list
      CSV.read(TASKS_FILE).map do |task|
        task[0] = { "true" => "[X]", "false" => "[ ]" }[task.first]
        task.join(' ')
      end
    end
```


# 7: Delete a task

```ruby
    OptionParser.new do |opts|
      # ...
      opts.on('-r', '--remove ID', Integer, 'List all tasks') do |id|
        remove id
      end
    end

    # ...

    def remove(id)
      tasks = CSV.read(TASKS_FILE)
      tasks.delete_at(id - 1)
      CSV.open(TASKS_FILE, 'wb') do |csv|
        tasks.each { |task| csv << task }
      end
    end
```


# Extra goodness

```ruby
    begin
      parser.parse(ARGV)
    rescue Errno::ENOENT
      FileUtils.touch(TASKS_FILE)
      retry
    end
```
