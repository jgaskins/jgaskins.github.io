require 'benchmark'
require 'json'

def create_hash(n = 50)
  return {} if n <= 0

  n.times.with_object({}) do |i, hash|
    hash[i] = {
      depth: n,
      value: rand,
      next: create_hash(n - 1)
    }
  end
end

json = create_hash(9).to_json
File.write 'js.js', <<-JS
  window.zomg = #{json};
  document.getElementById('result').innerText = performance.now() - started_at;
JS
File.write 'json.js', <<-JS
  window.zomg = JSON.parse(#{json.inspect});
  document.getElementById('result').innerText = performance.now() - started_at;
JS
# 10.times do |i|
#   pp Benchmark.realtime {
#     pp(create_hash(i).to_json.size)
#   }
# end
