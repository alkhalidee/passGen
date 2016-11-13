#Encoding: UTF-8
#simple passwords generator
#by Eyeslov (alkhalidee)

require 'Qt'

class PassGen < Qt::Widget
	slots 'gen()',
			'aboutDef()',
			'save()'

	def initialize()
        super()

        resize 450,600

        self.windowTitle = tr("PassGen")

        passTypeLabel = Qt::Label.new("PASS TYPE : ")
        @typeLetter = Qt::CheckBox.new(tr("LETTERS"))
        @typeLetter.checked = true
        @typeNumbers = Qt::CheckBox.new(tr("NUBERS"))
        @typeCletter = Qt::CheckBox.new(tr("C LETTERS"))
        @typeSymbols = Qt::CheckBox.new(tr("SYMBOLS"))
        passLengthLabel = Qt::Label.new("PASS LENGTH : ")
        @passLength = Qt::LineEdit.new("6")
        passNumberLabel = Qt::Label.new("NUBERS : ")
        @passNumber = Qt::LineEdit.new(tr("1"))
        @passGenButton = Qt::PushButton.new(tr("GEN PASSWORDS"))
        @newPasswords = Qt::TextEdit.new
        @saveFile = Qt::PushButton.new(tr("SAVE AS TEXT FILE"))
        about = Qt::PushButton.new(tr("ABOUT"))
        @l = ["a","b","c","d","e","f","g","h","i","j","k","l",
        	 "m","n","o","p","q","r","s","t","u","v","w","x","y","z"] 
        @n = ["1","2","3","4","5","6","7","8","9","0"]
        @bl = ["A","B","C","D","E","F","G","H","I","J","K","L",
        	 "M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        @s = ["$","&","+","-","_"]

        self.layout = Qt::GridLayout.new do |m|
            m.addWidget(passTypeLabel)
            m.addWidget(@typeLetter)
            m.addWidget(@typeCletter)
            m.addWidget(@typeNumbers)
            m.addWidget(@typeSymbols)
            m.addWidget(passLengthLabel)
            m.addWidget(@passLength)
            m.addWidget(passNumberLabel)
            m.addWidget(@passNumber)
            m.addWidget(@passGenButton)
            m.addWidget(@newPasswords)
            m.addWidget(@saveFile)
            m.addWidget(about)
        end

        connect(@passGenButton, SIGNAL('clicked()'),
                self, SLOT('gen()'))
        connect(about, SIGNAL('clicked()'),
                self, SLOT('aboutDef()'))
        connect(@saveFile, SIGNAL('clicked()'),
                self, SLOT('save()'))

        def gen
        	@foo = []
        	if @typeLetter.checked == true
        		@foo = @foo + @l
        	end

        	if @typeNumbers.checked == true
        		@foo = @foo + @n
        	end

        	if @typeCletter.checked == true
        		@foo = @foo + @bl
        	end

        	if @typeSymbols.checked == true
        		@foo = @foo + @s
        	end

        	bm = ""
        	for x in 0...@passNumber.text.to_i
	        	e = ""
	        	for r in 0...@passLength.text.to_i
	        		e << @foo.sample
	        	end
	        	bm << "#{e}\n"
	        	@newPasswords.text = bm
	        end
        end

        def aboutDef
        	Qt::MessageBox::information(self, tr("About"), "PassGen made by Zain Alkhalidee
GitHub | @alkhalidee
Telegram | @Eyeslov
Telegram Channel | @Squlabs")
        end

        def save
		    fileName = Qt::FileDialog.getSaveFileName(self,
		                                tr("Qt::FileDialog.getSaveFileName()"),
		                                @saveFileNameLabel,
		                                tr("All Files (*);;Text Files (*.txt)"))
		    if !fileName.nil?
		        @saveFileNameLabel = fileName
		        savedFile = File.open(fileName+".txt","w")
		        savedFile.write(@newPasswords.toPlainText)
		    end
        end
    end
end

app = Qt::Application.new(ARGV)
window = PassGen.new
window.show
app.exec