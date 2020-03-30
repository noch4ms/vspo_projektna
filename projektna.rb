#checks if any of these txt files exist, deletes if true for appending reasons
["a.txt", "b.txt", "c.txt", "d.txt", "e.txt", "f.txt", "g.txt", "h.txt"].each { |file_name| if File.exist?(file_name) then File.delete(file_name)  end }

`lshw > log.txt` #uporabi lshw enako kot echo `lshw`

$intel = 0

#polnjenje a.txt, b.txt, c.txt
file = open("log.txt")
file.each do |line|
	File.write("b.txt", "#{line.split(' ')[1]}\t\t#{line.split(' ')[0]}\n", mode:"a")
	if !line["usb"] then
		File.write("c.txt", line, mode:"a")
	end
	if line["vendor"] then
		File.write("a.txt", line, mode:"a")
		if line["Intel"] then 
			$intel += 1
		end 
	elsif line["Intel"] then
		$intel += 1
	end
end	
file.close()

#polnjenje d.txt, e.txt
file = open("a.txt")
file.each do |line|
	File.write("d.txt", line.sub("vendor", ""), mode:"a")
	File.write("e.txt", line.sub("vendor", "Firma"), mode:"a")
end
file.close()

#prebere st. vrstic v a.txt ter shrani v ven_no
ven_no = `cat a.txt | wc -l`
puts "log.txt vsebuje #{ven_no.chomp} vrstic z vendor." #chomp odstrani \n
puts "Beseda Intel je #{$intel} krat v log.txt"

#polnjenje f.txt, g.txt, h.txt
file = open("/etc/group")
line_c = 0
file.each do |line|
	words_arr = line.split(":")
	if line_c < 20 then 
		File.write("h.txt", "##{words_arr[2]}##{words_arr[0]}##{words_arr[1]}#\n", mode:"a")
	end
	File.write("f.txt", words_arr[2] + "\n", mode:"a")
	if words_arr[2][0] == "2" then
		File.write("g.txt", words_arr[2] + "\n", mode:"a")
	end
	line_c += 1
end
file.close()


