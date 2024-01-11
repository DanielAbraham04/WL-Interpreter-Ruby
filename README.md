# Language Interpreter in Ruby

This is a Language System (LS) for the Weird Language (WL). The LS will first a read a WL program from a file called “input.wl”. The file should contain 1 WL instruction in each line. Next, the LS will process each instruction sequentially, starting from the first line of text in the file.

WL programs use two kinds of data structures, namely numbers and singly-linked lists. List elements can be integers or nested lists. Objects of these types are bound to variables, which don’t need to be declared. (WL uses dynamic typing.)

The LS will keep two storage areas, a program memory that stores a WL program loaded from the input file, and a data memory holding identifiers declared in the program and the values bound to each identifier. In addition, the WL maintains a program counter (PC) storing the line number of the instruction being currently executed. Executing a WL program consists of the following two steps:
1. Read a WL program from the input file. The program is stored in the memory starting at address (i.e., line) 0, the first line of code read from the input file.
2. Execute a command loop consisting of three commands:
  o – Execute a single line of code, starting from line 0. The PC and the data memory are updated according to the instruction. The resulting values of the data memory and the PC are   
      printed on the console.
  a – Executes all the instructions until a halt instruction is encountered or there are no more instructions to be executed. The values of the PC and the data memory are printed.
  q– Quits the command loop.
