;Elias Robles Program
;THis program will play tictactoe
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			.ORIG x3000
			
			JSR CLEARSCREEN			;Clear the screen to black; GOOD1
			
			JSR DRAWH				;Draw the rows for tictactoe; GOOD1
			
			JSR DRAWV				;Draw the columns for tictactoe; GOOD1
			
TICTACTOE	JSR TURN				;Determine the turn, Starts on O; GOOD1

			JSR GETMOV				;Get the next move for tictactoe; GOOD1
			
			JSR GETADDRESS			;GETS THE ADDRESS FOR THE GAME
			
			JSR GAMEMEMORY			;
			
			JSR DRAWB				;
			
			BRnzp TICTACTOE 		;
			;Figure out a way to repeat this move multiple times
			
			
			;Horizontal line
DRAWH		ST R7, SAVER7			;
			LD R0, CURRCOLOR1		;
			LD R1, CORDROW			;
			LD R3, PIXELCOUNT		;
			LD R4, ROW				;
			AND R5, R5, #0			;
			ADD R5, R5, #1			;Counter for two rows
		
LOOP1		STR R0, R1, #0			;write pixel
			ADD R1, R1, #1			;increment to next pixel
			ADD R3, R3, #-1			;decrement counter
			BRp LOOP1				;Repeat until pixel counter is 0
			
			ADD R5, R5, #-1			;Decrement counter newrow
			BRn RETURNROW			;Return the program
			ADD R3, R3, #15			;counter #30
			ADD R3, R3, #15			;
			
NEWROW		ADD R1, R1, R4			;Add #128 to row
			ADD R3, R3, #-1			;decrement counter
			BRp NEWROW				;LOOP
			
			ADD R3, R3, #15			;counter #30
			ADD R3, R3, #15			;
			BRnzp LOOP1				;create new row
RETURNROW	RET						;


			;Vertical line
DRAWV		ST R7, SAVER7			;
			LD R0, CURRCOLOR2		;
			LD R1, CORDCOL			;
			LD R3, PIXELCOUNT		;
			LD R4, ROW				;
			AND R5, R5, #0			;
			ADD R5, R5, #1			;Counter for two rows
			
LOOP2		STR R0, R1, #0			;write pixel
			ADD R1, R1, R4 			;next row
			ADD R3, R3, #-1			;decrement pixel counter
			BRp LOOP2				;

			ADD R5, R5, #-1			;Decrement counter newrow
			BRn RETURNCOL			;Return the program
			ADD R3, R3, #15			;counter #30
			ADD R3, R3, #15			;
			NOT R4, R4				;~R4
			ADD R4, R4, #1			;-R4
			
NEWCOL		ADD R1, R1, R4 			;return to row origin
			ADD R1, R1, #1			;move right
			ADD R3, R3, #-1			;decrement counter
			BRp NEWCOL				;Loop
			
			ADD R3, R3, #15			;counter #30
			ADD R3, R3, #15			;
			LD R4, ROW				;R4=ROW
			BRnzp LOOP2				;
RETURNCOL	RET						;RETURN	

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
			BRnzp TOGGLE			;
			
XTURN		LEA R0, PROMPTX			;Load prompt			
			PUTS					;Display Turn
			
TOGGLE		LD  R6, TURN			;
			ADD R2, R2, #1			;
			AND R2, R2, #1			; toggle 0<->1
			ST  R2, TURN			; <-- state persisted in memory
			LD  R7, SAVER7
			
RETURNT		RET						;RETURN			
			
			;Create an input for the program
			;THIS ONLY GETS THE R0 VALUE FOR THE INPUT
			;THIS MUST BE AFTER JSR TURN
GETMOV		ST R7, SAVER7			;SAVE
			GETC					;Input in R0
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
			BRnzp COMPLETEGM		;RETURN
			
ILLEGAL		AND R0, R0, #0			;mask
			ADD R0, R0, #-1			;Add value into R0
COMPLETEGM	RET						;Return to funtion
			
			
GETADDRESS	ST R7, SAVER7			;SAVE
			LDR R0, R0, #0			;Load R0 for Branch
			BRn	COMPLETEGA			;RETURN if R0=-1
			LD R1, ADDRESSTABLE		;R1=ADDRESSTABLE
			ADD R3, R0, #0			;temp data for correct address
			ADD R4, R1, R3			;Find te correct address in the table
			ST R4, TEMPADDRESS		;Store address for DRAW B
COMPLETEGA	RET	
			


DRAWB		ST R7, SAVERR7			;SAVE
			LD R4, TEMPADDRESS		;LOAD the address saved for tictactoe
			LD R1, TURN				;
			
			BRp XDRAW				;
			BRz ODRAW				;
XDRAW		LD R2, IMAGEX			;
			ST R2, CURRIMAGE		;
			LD R0, IMAGEX			;
			BRnzp DRAWIMAGE			;
ODRAW		LD R2, IMAGEO			;
			ST R2, CURRIMAGE		;
			LD R0, IMAGEO			;
			BRnzp DRAWIMAGE			;
			
DRAWIMAGE	ADD R1, R3, #0			;
			LD R0, CURIMAGE			;
			LD R2, STRIDE			;stride for image rows
			AND R6, R6, #0			;
			ADD R6, R6, #15			;
			ADD R6, R6, #5			;20 rows
DROWS    	AND R5, R5, #0			;
			ADD R5, R5, #15			;
			ADD R5, R5, #5			;20 cols
DCOLS    	LDR R4, R0, #0			;
			STR R4, R1, #0			;
			ADD R0, R0, #1			;
			ADD R1, R1, #1			;
			ADD R5, R5, #-1			;
			BRp DCOLS				;
			ADD R1, R1, R2			;
			ADD R6, R6, #-1			;
			BRp DROWS				;
			LD R7, SAVER7			;
			RET						;
			
			
		
			;Clear Screen
CLEARSCREEN	ST R7, SAVER7			;Store address
			AND R1, R1, #0			;mask R1
			LD R2, VRAMBEGIN		;videoRAM beginning
			LD R3, VRAMEND			;videoRAM ending
			AND R4, R4, #0			;mask
			NOT R4, R3				;NOT R3
			ADD R4, R4, #1			;limit for image
LOOPCLEAR1	STR R1, R2, #0			;clear pixel
			ADD R2, R2, #1			;load next pixel
			ADD R5, R2, R4			;compare to find zero
			BRnz LOOPCLEAR1			;LOOP CLEAR
			RET						;return
			
qSEL		LEA R0, PROMPTQuit		;loads the quit message
			PUTS					;print message "thanks for playing"
			AND R0, R0, #0			;Mask
			ADD R0, R0, #9			;R0=#9
			HALT					;halt program			
			
			;DATA
PROMPTX		.STRINGZ "O move: "		;O move
PROMPTO		.STRINGZ "X move: "		;X move

TURNCOUNT	.FILL #8				;Turn Counter
TURN		.FILL x0000				;Toggle between 0 and 1, X is 0, O is 1

CURRCOLOR1  .FILL x03E0				;
CURRCOLOR2  .FILL x001F				;
CORDROW		.FILL xCF40				;Start location for Rows
CORDCOL		.FILL xC01E				;Start Location for Cols
PIXELCOUNT  .FILL #30				;30 pixels in a row or column
COORD2		.FILL xD030				;

IMAGEX		.FILL xA000				;
IMAGEO		.FILL xA200				;
CURRIMAGE	.FILL xA000				;Stores the current image for drawing

VRAMBEGIN	.FILL xC000				;
VRAMEND		.FILL xFDFF				;

SAVER0		.BLKW 1					;
SAVER7		.BLKW 1					;
NEGq		.FILL xFF8F 			;
ASCII0		.FILL x0030				;
ASCII9		.FILL x0038				;
ROW			.FILL #128				;

ADDRESSTABLE						;This is the address table for the code
	.FILL xC285
	.FILL xC2A3
	.FILL xC2C1
	.FILL xD185
	.FILL xD1A3
	.FILL xD1C1
	.FILL xE085
	.FILL xE0A3
	.FILL xE0C1

CELL0		.FILL x4010				;
CELL1		.FILL x4011				;
CELL2		.FILL x4012				;
CELL3		.FILL x4013				;
CELL4		.FILL x4014				;
CELL5		.FILL x4015				;
CELL6		.FILL x4016				;
CELL7		.FILL x4017				;
CELL8		.FILL x4018				;
			.END