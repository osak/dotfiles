("a".."z").each do |f|
  ("a".."z").each do |s|
    puts "Mod4 Shift #{f.upcase} Mod4 Shift #{s.upcase} :MacroCmd {NextWindow (Title=.*[#{f.upcase}#{f}][#{s.upcase}#{s}].*)} {Delay {ExecCommand ~/script/warpcenter} 100000}"
  end
end
