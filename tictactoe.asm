;Elias Robles Program
;THis program will play tictactoe
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			.ORIG x3000
			JSR CLEARSCREEN			;Clear the screen to black; GOOD1
			JSR DRAWH				;Draw the rows for tictactoe; GOOD1
			JSR DRAWV				;Draw the columns for tictactoe; GOOD1
TICTACTOE	JSR TURN				;Determine the turn, Starts on O; GOOD1
			LD R0, TURNCOUNT		;Branch if turncount is negative
			BRn GAMEOVER			;
RETRY		JSR GETMOV				;Get the next move for tictactoe; GOOD1
			LD R0, SAVER0			;Loops if R0 is negative
			BRn RETRY				;			
			JSR GETADDRESS			;GETS THE ADDRESS FOR THE GAME			
			JSR GAMEMEMORY			;
			JSR DRAWB				;
			BRnzp TICTACTOE 		;Repeat for next turn	
GAMEOVER	HALT					;End Program			
DRAWH		ST R7, SAVER7			;R7 store address
			LD R0, CURRCOLORW		;R0 white color
			LD R1, CORDROW			;R1 is current cord
			LD R3, PIXELCOUNT		;90 pixel count
			LD R4, STRIDE			;128 stride
			AND R5, R5, #0			;
			ADD R5, R5, #1			;Counter for two rows
LOOP1		STR R0, R1, #0			;write pixel
			ADD R1, R1, #1			;increment to next pixel
			ADD R3, R3, #-1			;decrement counter
			BRp LOOP1				;Repeat until pixel counter is 0
			ADD R5, R5, #-1			;Decrement counter newrow
			BRn RETURNROW			;Return the program
			LD R3, PIXELCOUNT		;90 pixel count
			ADD R5, R5, #15			;R5 counter #30
			ADD R5, R5, #15			;
NEWROW		ADD R1, R1, R4			;Add #128 to row
			ADD R5, R5, #-1			;decrement counter
			BRp NEWROW				;LOOP
			LD R3, PIXELCOUNT		;Load pixel counter
			NOT R3, R3				;~R3
			ADD R3, R3, #1			;-R3
			ADD R1, R1, R3			;Set pixel counter back 90 pixels
			BRnzp LOOP1				;create new row
RETURNROW	LD R7, SAVER7			;
			RET						;
DRAWV		ST R7, SAVER7			;
			LD R0, CURRCOLORW		;
			LD R1, CORDCOL			;
			LD R3, PIXELCOUNT		;
			LD R4, STRIDE			;
			AND R5, R5, #0			;
			ADD R5, R5, #1			;Counter for two rows
LOOP2		STR R0, R1, #0			;write pixel
			ADD R1, R1, R4 			;next row
			ADD R3, R3, #-1			;decrement pixel counter
			BRp LOOP2				;
			ADD R5, R5, #-1			;Decrement counter newrow
			BRn RETURNCOL			;Return the program
			LD R3, PIXELCOUNT		;Load 90 pixels
			NOT R4, R4				;~R4
			ADD R4, R4, #1			;-R4
NEWCOL		ADD R1, R1, R4 			;return to row origin
			ADD R3, R3, #-1			;decrement counter
			BRp NEWCOL				;Loop
			ADD R1, R1, #15			;counter #30
			ADD R1, R1, #15			;
			LD R3, PIXELCOUNT		;load 90 pixels
			LD R4, STRIDE			;R4=ROW
			BRnzp LOOP2				;
RETURNCOL	LD R7, SAVER7			;
			RET						;RETURN	
TURN		ST R7, SAVER7			;SAVE
			LD R6, TURNCOUNT		;Load amount of turns
			ADD R6, R6, #-1			;decrement counter
			ST R6, TURNCOUNT		;Save turns
			BRn RETURNT				;No more turns after neg
			AND R5, R5, #0			;Mask
			ADD R5, R5, R6			;Temp Data
			AND R5, R5, #1			;If even 0, If odd 1
			BRz XTURN				;Proceed to X turn
			LEA R0, PROMPTO			;Load prompt
			PUTS					;Display
			BRnzp TOGGLE			;toggle
XTURN		LEA R0, PROMPTX			;Load prompt			
			PUTS					;Display Turn
TOGGLE		LD  R2, TURNBOOL		;Load the bool
			ADD R2, R2, #1			;0 if even=2, 0 if odd=1
			AND R2, R2, #1			;toggle
			ST  R2, TURNBOOL		;store the bool
RETURNT		LD  R7, SAVER7			;
			RET						;RETURN			
GETMOV		ST R7, SAVER7			;SAVE
			GETC					;Input in R0
			OUT						;ECHO
			;If q is chosen, branch to qSEL	
			LD R1, NEGq				;load negative q
			ADD R2, R0, R1			;Compare
			BRz qSEL				;end the program branch
			;test for numbers
			LD R1, ASCII8			;Loads x38
			NOT R1, R1				;~R1
			ADD R1, R1, #1			;-R1
			ADD R2, R0, R1			;Compare
			BRp ILLEGAL				;Return if more than 8
			LD R1, ASCII0			;Loads x30
			NOT R1, R1				;~R1
			ADD R1, R1, #1			;-R1
			ADD R2, R0, R1			;Compare
			BRn ILLEGAL 			;Return if less than 0
			AND R0, R0, #0			;mask
			ADD R0, R0, R2			;Add value into R0
			ST R0, SAVER0			;Store R0
			BRnzp COMPLETEGM		;RETURN
ILLEGAL		AND R0, R0, #0			;mask
			ADD R0, R0, #-1			;Add value into R0
			ST R0, SAVER0			;Store R0
COMPLETEGM	LD R7, SAVER7			;
			RET						;Return to funtion	
GETADDRESS	ST R7, SAVER7			;SAVE
			LD R0, SAVER0			;Load R0
			BRn	COMPLETEGA			;RETURN if R0=-1
			LEA R1, ADDRESSTABLE	;Load base of the address table
			ADD R4, R1, #0			;Point to the address 
			LDR R4, R4, #0			;Find the correct address in the table
			ST R4, TEMPADDRESS		;Store address for DRAW B
COMPLETEGA	LD R7, SAVER7			;Restore
			RET						;Return
GAMEMEMORY	ST R7, SAVER7			;SAVE
			LD R0, SAVER0			;Load Cell
			LEA R1, CELLTABLE		;Load the cell table
			ADD R3, R1, R0			;
			LDR R3, R3, #0			;Store a 1 inside of the register
			LD R4, TURNBOOL			;LOAD X or O player
			ADD R4, R4, #1			;Store 1 for O, 2 for X
			STR R4, R3, #0			;Writes the player into game memory
			LD R7, SAVER7			;Load R7
			RET						;
DRAWB		ST R7, SAVER7			;SAVE
			LD R1, TURNBOOL			;Turn bool
			BRz XDRAW				;BOOL
			BRp ODRAW				;BOOL
XDRAW		LD R2, IMAGEX			;LOAD imageX
			ST R2, CURRIMAGE		;Store image into temp data
			BRnzp DRAWIMAGE			;
ODRAW		LD R2, IMAGEO			;Load imageO
			ST R2, CURRIMAGE		;Store image into temp data			
DRAWIMAGE	LD R1, TEMPADDRESS		;Load beginning of program
			LD R2, CURRIMAGE		;The current image
			LD R3, BOXCOUNTER		;20 pixels
			LD R4, STRIDE			;128 stride
			LD R5, BOXCOUNTER		;20 pixels
DROWS    	ADD R6, R3, #0			;This is the col counter
DCOLS    	LDR R0, R2, #0			;
			STR R0, R1, #0			;
			ADD R1, R1, #1			;
			ADD R2, R2, #1			;
			ADD R6, R6, #-1			;
			BRp DCOLS				;
			ADD R1, R1, R4			;Add Stride
			ADD R5, R5, #-1			;decrement counter
			BRp DROWS				;
			LD R7, SAVER7			;
			RET						;
CLEARSCREEN	ST R7, SAVER7			;Store address
			AND R1, R1, #0			;mask R1
			LD R2, VRAMBEGIN		;videoRAM beginning
			LD R3, VRAMEND			;videoRAM ending
			NOT R4, R3				;NOT R3
			ADD R4, R4, #1			;limit for image
LOOPCLEAR1	STR R1, R2, #0			;clear pixel
			ADD R2, R2, #1			;load next pixel
			ADD R5, R2, R4			;compare to find zero
			BRnz LOOPCLEAR1			;LOOP CLEAR
			LD R7, SAVER7			;
			RET						;return
qSEL		LEA R0, PROMPTQUIT		;loads the quit message
			PUTS					;print message "thanks for playing"
			AND R0, R0, #0			;Mask
			ADD R0, R0, #9			;R0=#9
			HALT					;halt program			
			;DATA
CURRCOLORW	.FILL x7FFF				;White pixel
CORDROW		.FILL xCF40				;Start location for Rows
CORDCOL		.FILL xC01E				;Start Location for Cols
PIXELCOUNT  .FILL x005A				;90 pixels in a row or column
TURNCOUNT	.FILL #9				;Turn Counter
TURNBOOL	.FILL x0000				;Toggle between 0 and 1, X is 0, O is 1
PROMPTX		.STRINGZ "\nO move: "		;O move
PROMPTO		.STRINGZ "\nX move: "		;X move
PROMPTQUIT	.STRINGZ "\nQUIT"			;Quit
IMAGEX		.FILL xA000				;Address of X image
IMAGEO		.FILL xA200				;Address of O image
CURRIMAGE	.FILL xA000				;Tempdata of image
VRAMBEGIN	.FILL xC000				;Start address of image
VRAMEND		.FILL xFDFF				;End address of image
SAVER0		.BLKW 1					;Save R0 data after GETMOV
SAVER7		.BLKW 1					;SAVE R7 address
NEGq		.FILL xFF8F 			;negative q
ASCII0		.FILL x0030				;ASCII 0
ASCII8		.FILL x0038				;ASCII 9
STRIDE		.FILL #128			   ;Convert to HEX later
ROWOFFSET	.FILL #108				;Row offset for the boxes
BOXCOUNTER	.FILL #20				;Counter for drawing the box
ADDRESSTABLE						;This is the address table for the code
	.FILL xC285						;Top Left
	.FILL xC2A3						;Top Center
	.FILL xC2C1						;Top Right
	.FILL xD185						;Center Left
	.FILL xD1A3						;Center
	.FILL xD1C1						;Center Right
	.FILL xE085						;Bottom Left
	.FILL xE0A3						;Bottom Center
	.FILL xE0C1						;Bottom Right
TEMPADDRESS	.FILL x0000				;Temp data for address
CELLTABLE							;This is the address table for the cells, Use LDI and STI
	.FILL x4010						;
	.FILL x4011						;
	.FILL x4012						;
	.FILL x4013						;
	.FILL x4014						;
	.FILL x4015						;
	.FILL x4016						;
	.FILL x4017						;
	.FILL x4018						;
			.END					;End Program