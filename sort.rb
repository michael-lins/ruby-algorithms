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

  quick_sort(left) + [pivot] + quick_sort(right)
end

def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort(array.slice(0, mid))
  right = merge_sort(array.slice(mid, array.length))

  merge(left, right)
end

def merge(left, right)
  sorted = []
  sorted.append(left.first <= right.first ? left.shift : right.shift) while left.any? && right.any?
  sorted + left + right
end

sample = Array.new(1000) { rand(1..100) }
Benchmark.bm(10) do |bm|
  bm.report('bubble_sort') { bubble_sort sample.dup }
  bm.report('quick_sort') { quick_sort sample.dup }
  bm.report('merge_sort') { merge_sort sample.dup }
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

  describe 'merge_sort' do
    subject { merge_sort array }
    it { is_expected.to eq array.sort }
  end
end
