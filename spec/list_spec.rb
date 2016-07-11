require('rspec')
require('pg')
require('list')
require('spec_helper')


describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      list1 = List.new({:name => "Epicodus stuff", :id => nil})
      list2 = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list1).to(eq(list2))
    end
  end

  describe('.sort') do
    it('starts off with no tasks') do
      list1 = List.new({:name => "household chores", :id => nil})
      list1.save()
      expect(list1.sort()).to(eq([]))
    end

    it('returns tasks in the order of their due date') do
      list1 = List.new({:name => "household chores", :id => nil})
      list1.save()
      task1 = Task.new({:description => "wash the dishes", :list_id => list1.id(), :due_date => '2016-07-20 00:00:00'})
      task1.save()
      task2 = Task.new({:description => "sweep the floor", :list_id => list1.id(), :due_date => '2016-07-19 00:00:00'})
      task2.save
      sorted_list1 = list1.sort()
      expect(sorted_list1).to(eq([task2, task1]))
    end
  end

  describe(".find") do
    it("returns a list by its ID") do
      test_list = List.new({:name => "Epicodus stuff", :id => nil})
      test_list.save()
      test_list2 = List.new({:name => "Home stuff", :id => nil})
      test_list2.save()
      expect(List.find(test_list2.id())).to(eq(test_list2))
    end
  end

  describe("#tasks") do
    it("returns an array of tasks for that list") do
      test_list = List.new({:name => "Epicodus stuff", :id => nil})
      test_list.save()
      test_task = Task.new({:description => "learn SQL", :list_id => test_list.id(), :due_date => "2016-07-21 00:00:00"})
      test_task.save()
      test_task2 = Task.new({:description => "Review Ruby", :list_id => test_list.id(), :due_date => "2016-07-15 00:00:00"})
      test_task2.save()
      expect(test_list.tasks()).to(eq([test_task, test_task2]))
    end
  end
end
