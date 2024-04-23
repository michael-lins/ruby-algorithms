require 'rspec'
require 'benchmark'
 
def bubble_sort(array)
  n = array.size
  loop do
    swapped = false
    (n - 1).times do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        swapped = true
      end
    end
    break unless swapped
  end
  array
end

def quick_sort(array)
  return array if array.length <= 1

  pivot = array.last
  left, right = array[0...-1].partition { |i| i < pivot }

  return quick_sort(left) + [pivot] + quick_sort(right)
end

sample = Array.new(1000) { rand(1..100) }
Benchmark.bm do |bm|
  bm.report("bubble_sort") { bubble_sort sample.dup }
  bm.report("quick_sort") { quick_sort sample.dup }
end

context 'Sorting algorithms' do
  let(:array) { Array.new(10) { rand(1..100) } }

  describe 'bubble_sort' do
    subject { bubble_sort array }
    it { is_expected.to eq array.sort }
  end

  describe 'quick_sort' do
    subject { quick_sort array }
    it { is_expected.to eq array.sort }
  end
end
