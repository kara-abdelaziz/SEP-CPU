# SEP-CPU
SEP (for Simple Enough Processor) is a simplistic academic processor to construct step-by-step by the student, it is an 8-bits CPU using an academic logic simulator called Logisim, supporting major real-world CPUs capabilities, like multiple programmable registers, multiple addressing modes, shift instruction, comparison and logic instructions, multiple branch and jump instructions the stack and subroutine mechanisms, flags indicators, input/output mechanism, a proper assembler... etc. The processor would comprise 21 instructions and 4 addressing modes, with the capability using the flexible control unit sequencer, to easily add more customizable instructions architectures.

![SEP image](https://github.com/kara-abdelaziz/SEP-CPU/blob/main/SEP-CPU.png)

## How to run/execute a program
To run a program on SEP you have to follow these steps :

*STEP 1 : Download Logisim to your local machine, a jar version will work for any operating system.

*STEP 2 : Download this repository, and locate the programs with the extension .RAM, they are found in the directory programs.

*STEP 3 : Open with Logisim the circuit 'SEP architecture.circ' in the root directory.

*STEP 4 : Under Logisim, right-click upon the RAM circuit and click load image menu. Choose one program (.RAM files not .ASM) to load for the architecture.

*STEP 5 : Finally, you have to launch under Logisim the simulation. Some programs require an input from the user, which could be done using the SEP keyboard (it is a binary 8-bits keyboard).

*STEP 6 : Simulation could be done step-by-step or continuously, the result will be displayed on the seven segment display.

## How to assemble a program
To assemble your own assembly program, you have to write the program with SEP assembly language, you can get some inspiration from programs with the extension .ASM within 'programs' directory. Then you have to compile them online using CustomAsm at the address : https://hlorenzi.github.io/customasm/web/. The output format should be 'Logisim 8-bits'. And you have to add the header SEP CPU definition before the compilation, you can copy-paste it from other programs .ASM. The output is usually saved under .RAM file extension.
