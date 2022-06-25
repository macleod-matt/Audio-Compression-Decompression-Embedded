## 1.0 Introduction

North American telecommunications commonly use 𝜇 Law quantization for voice traffic audio compression and decompression [1].  By compressing the voice traffic, communication network devices can support greater volumes of traffic over a communication network.  𝜇 Law utilizes a logarithmic function to compress data.  𝜇 Law compression works by sacrificing the dynamic range of an input signal to allow the signal to be compressed.  The compression is performed on a logarithmic curve leading to greater distortion to larger signals or louder sounds than smaller signals or quieter sounds.  This method is effective because the human auditory system has a logarithmic transfer function and cannot distinguish distortions to louder noises as well as it can distinguish distortions to quiet noises.  𝜇 Law audio compression is designed to compress an input value of 14 bits to a compressed codeword of 8 bits.  The compression factor of 𝜇 Law is 1.75 [2]. 

This project displays the software and hardware optimized implementation of 𝜇 Law audio compression and decompression for embedded systems.  Optimizations have been specifically made for the S3C2440A 32-Bit CMOS Microcontroller [3].  The project features 4 software solutions and one hardware solution for 𝜇 Law compression. 


### 2.0 Theoretical background

The audio compression is implemented using a logarithmic curve while the decompression is implemented using an exponential curve.  The logarithmic and exponential curves are shown in Figure 1 and Figure 2 respectively.  Figure 3 shows the input value compared to the decompressed output.  The figures are derived from the Optimized 𝜇 Law with If Statements Reverse Software Solution. 

![image](https://user-images.githubusercontent.com/61804317/175790823-09008187-c2de-4c1c-bc99-a9ab2f53873d.png)


![image](https://user-images.githubusercontent.com/61804317/175790841-24c437b4-521f-4267-a08d-e39704ee51b5.png)

![image](https://user-images.githubusercontent.com/61804317/175790842-e7f4cf6c-5a46-456a-88b2-3ab270561903.png)


From Figure 3, one may see the error between the input value and the decompressed value, noted by the squiggly line segments in the input range of 4000 to 8000 and 12000 and 16000.  It is because the ranges correspond to the larger amplitude input signals.  During 𝜇 Law compression, only the most significant five bits are preserved, and the remaining 9 least significant bits are discarded allowing for the input signal to be compressed.  The discarding of bits leads to a loss of information and an error between the input and decompressed signal ultimately distorting the audio.  

The reason the error segments are in the range of 4000 to 8000 and 12000 and 16000 is because these are the extremes of the input signals.  The 14th bit is the input’s sign, and the remaining 13 bits are the signal’s magnitude.  From the provided documentation a 0 in the 14th bit position indicates a positive and a 1 indicates a negative.  Using this convention, the greatest positive value is 8190 in decimal or 01 1111 1111 1111 in binary.  The largest negative value is -8191 in decimal or 11 1111 1111 1111 in binary.  

To implement 𝜇 Law, the team has chosen to utilize a Logarithmic Pulse Code Modulation (PCM).  A logarithmic PCM was chosen over a uniform PCM because it is preferable to have a larger error for a signal with a large amplitude than a signal with a small amplitude.  It is preferable to have this error because the human auditory system has a logarithmic transfer function.  As a result of this function, the system will not detect distortions to audio sounds with a large amplitude as well as it will detect distortions to signals with a small amplitude.  By sacrificing information in the form of discarding the bits following the most significant 5 bits, the algorithm may achieve compression.  As a result of using a logarithmic PCM, the quantization step will be greater for large signals than smaller signals.  The large quantization step will lead to greater distortions to large signals.  Additionally, the large quantization step will allow for a compression factor of 1.75. 

To implement 𝜇 Law, the team has used Equation 1 to perform PCM to 𝜇 Law.

![image](https://user-images.githubusercontent.com/61804317/175790884-ba608e4a-f31a-4e6f-a5e2-f03a92f2c1b0.png)


The argument x is bound to 0 ≤ |x| ≤ 1 and the parameter μ is bound to 0 ≤ μ ≤ 255.  When μ = 0 there is no compression and when μ = 255 maximum compression is performed.  Today it is standard to use maximum compression (μ = 255) [1]. 

To implement 𝜇 Law with maximum compression, one may approximate the logarithmic curve of 𝜇 Law with 8 straight-line segments.  Below shows the approximated curve. These line segments are chords.  


![image](https://user-images.githubusercontent.com/61804317/175790893-a773c2bb-83f4-4157-a788-df94daf62b1d.png)

The slope of each chord is half the previous chord.  The table for the Chord slope and range of inputs may be seen in Table 2.

![image](https://user-images.githubusercontent.com/61804317/175790902-ca883fc6-65b1-4aa7-93a7-a41b18f667d1.png)

𝜇 Law compression works by receiving a 14-bit input.  The input’s sign and magnitude are then determined.  The sign is kept as the most significant bit of the compressed codework and the most significant bit of the decompressed word.  If the input is positive the sign is 0 if the input is negative the sign is 1.   From the input’s magnitude the signal’s Step and Chord is determined.  The Step is the four bits following the first one in the input’s 13-bit magnitude.  The Chord is determined by how large the input value is.  The larger the value the smaller the Chord value.  See Table 3 for a 𝜇 Law binary encoding table.  See Table 4 for a 𝜇 Law binary decoding table.  

![image](https://user-images.githubusercontent.com/61804317/175790929-5c438bbd-312a-45c4-93c2-3a65d86ef3e4.png)


![image](https://user-images.githubusercontent.com/61804317/175790933-65d8d17e-c53c-49bd-839c-0154cdf6957d.png)

## 3.0 Design Process

### 3.1 Software Solution

### 3.1.1 Software Architecture

![image](https://user-images.githubusercontent.com/61804317/175790946-74aec1d0-1e43-43f9-bb6b-eb7b17d906f1.png)


The above figure shows a high-level description of the architecture used to process a .WAV file and then perform the compression and then decompression to reduce the size and then recover the sound of the file. As shown in Appendix A below, incorporating the source code. This solution was modeled in a functional programming implementation that was designed to simplify the API responsible for processing of the WAV file as much as possible such that fully optimized compression and decompression algorithms could be achieved, while minimizing the time and complexity required to develop a reduced wave file processing structure. 

Another potential software architecture that was investigated was a finite state machine FSM. This solution would switch between the following states: (Process Sate, Compress State, Write State, Decompress State). This architecture, although would have been feasible, was ultimately considered to be unnecessarily complicated for this project due to the memory management complexity associated with formatting the wave file data as structs/nodes for a linked list so that the data position in the WAV file and formatting parameters could be handled as they are encoded for compression/decompression and then written into the new file during the state transitions. 

## 3.1.2 WAV file processing

![image](https://user-images.githubusercontent.com/61804317/175790968-9da4ab4a-ddc1-4712-8a4c-bf6f1317fb73.png)

As shown in the code snippet below from the API read_wav.h, the data type “wave_header_t” was created to save the data as it was read from each call to fread() so that it could be partition into the different sections as required to create a readable WAV file. 


![image](https://user-images.githubusercontent.com/61804317/175791339-d86c1b81-6142-4122-8b4f-93c795784ce5.png)

As mentioned above, another solution to accomplish this would have been to incorporate an FSM to subjugate the transitioning between the processing of the input file, the encryption and then the writing of the compressed/decompressed data to another WAV file. However, the approach taken in the proposed solution was far more simplistic, being deliberate in writing each byte of data as it is written and then formatting the output file right away made the processing of the WAV data formatting much (shown in the Figure below):

![image](https://user-images.githubusercontent.com/61804317/175791349-c93fb9be-490a-4d9b-95cd-bffa78036507.png)

According to the WAVE PCM sound file format standard documentation [5] the first 36 bytes that are read are associated with the file formatting. Notable parameters such as audio format, number of channels were deliberately hard coded as each WAV file that is processed using this algorithm will be consistent with one another. 

The remaining bytes to be processed are the data (as shown in Figure 6 above). The overall size of the file is read once the file is first opened and then saved as a counter variable. As the algorithm processes the descriptor and then “sub chunk 1”, the counter variable is decremented by the number of bits that are processed. Once the algorithm reaches “sub chunk 2” (the data to be encoded), the counter variable is used as the bound of the for loop shown in the code snippet below depending on the type of encoding (compressed/decompressed): 

![image](https://user-images.githubusercontent.com/61804317/175791359-c6c5aba6-f132-4e75-9893-e413bd542bf8.png)


Finally, the encoded data is written to the output file and the files are closed. 

### 3.1.3 𝜇 Law Audio Compression Algorithm

The 𝜇 Law Compression Algorithm works by taking an input signal of 13 bits with the first bit being a sign bit.  The input is entered into a series of if statements used to identify the chord of the audio input.  These if statements are shown as diamonds in Figure 10.  Figure 10 shows the Original (unoptimized) code for implementing 𝜇 Law.   If the input matches a chord, the four most significant bits will be kept as the step.  The remaining bits will be truncated and lost allowing for data compression.  The output of the algorithm will be a 7-bit value with the most significant bit being the sign, the following three bits will be the chord and the last least significant bits will be the step.  

![image](https://user-images.githubusercontent.com/61804317/175791372-b5a27819-d401-4bea-945d-98908abdc204.png)

### 3.1.3 𝜇 Law Audio Decompression Algorithm

![image](https://user-images.githubusercontent.com/61804317/175791383-41006d8b-325f-4273-afe0-d51e8624ca8d.png)


### 3.2 Hardware Solution

The hardware solution involves programming and FPGA in VHDL code and simulating the code.  The hardware solution logic is similar to that of the software solution.  To compress an audio signal multiple statements are used to determine how many leading zeros the signal has.  Once the if statement is entered, the signal is broken up into the step, chord, and sign.  These parts are then put together to form the compressed output signal.  

Signal decompression works by shifting the step by the magnitude of the chord.  The sign is then added, and the decompressed signal is produced.  The VHDL code is shown in Appendix D.  

Figure 15 shows the simulated performance of the Hardware Solution.  One may see that the FPGA is able to perform the operation almost instantaneously.  This is possible because the digital components used to implement the design do not consist of items that require latching signals.  On the right side of the figure, one may see that the input signal is 0173 in hex and that the output is the chord, which is 5 and the step is 4.  Both these values are used in the audio compression. 

![image](https://user-images.githubusercontent.com/61804317/175791413-947c7669-c656-446e-9629-4aeacfa51b0c.png)

Figure 16 shows the synthesized designed schematic that uses flip flops to act like if statements allowing the FPGA to perform 𝜇 Law Audio compression.


![image](https://user-images.githubusercontent.com/61804317/175791430-e018accf-e2bd-4d3e-9597-d06ad41da9ec.png)


Figure 17 and Figure 18 show the place and routing used to route the logic through the FPGA and implement the solution.  Figure 17 shows the entire FPGA.  Figure 18 shows a single logic block within the FPGA.

![image](https://user-images.githubusercontent.com/61804317/175791438-1a5e25e4-95bd-46fb-acdb-59082229148e.png)

![image](https://user-images.githubusercontent.com/61804317/175791446-a3e9ae15-a631-4298-ba95-d612c79d6b80.png)



Figure 19 shows the digital logic used in the FPGA to implement the design.  The design appears as a line because the design is using flip-flops in parallel to determine the cord of the input signal.  Once the chord is determined bits are shifted to determine the step and the outcome is produced.  Because there are very few dependencies the hardware, the FPGA can perform the computation very quickly.  Theoretically it can perform it in a single clock cycle which is ten nano seconds due to the board having a 100 MHz clock frequency.

![image](https://user-images.githubusercontent.com/61804317/175791455-af8af432-a443-4a03-bb3c-78f02107e227.png)


Figure 20 shows the FPGA Utilization.  Because the design consists of only a few digital components, the hardware implementation only utilized 2% of the FPGA.  Because this utilization is so little, one may want to consider using a smaller and less expensive FPGA than the one selected for the prototype.

![image](https://user-images.githubusercontent.com/61804317/175791463-9bc140da-9ac7-4b58-abca-3045a9dd1120.png)

## 4.0 Software optimizations

### 4.1 C Level Optimizations

With the functional architecture that was chosen. There were not operator level optimizations that could have been made that would have resulted in a significant difference in runtime or compile time speed. Instead, only minor improvements were made such as operator strength reduction and loop unrolling to improve the run time of the program. Additionally, we intentionally made use of preprocessor commands for both test cases and to improve the overall performance and cleanness of the program. 

### 4.2 𝜇 Law Lookup Table Software Solution

A lookup table was created to implement 𝜇 Law.  The lookup table maps every possible input to a return value using a switch statement.  By not requiring any computation to perform 𝜇 Law compression, the software solution has a small execution time compared to other solutions. 
 
The drawback of using a lookup table is that it requires a large amount of memory to store.  If the lookup table is too large to be stored in cache, the processor will be required to fetch data from memory.  Cache misses and memory fetches are extremely costly for execution time and stall the processor’s pipeline.  The lookup table used in the project has a file size of 958,712 bytes which is 130 times larger than the second largest software solution’s file size.  The look up table’s performance and file size is discussed further in section 5.0 of the report. While the ARM processor was able to implement the lookup table, the lookup table may not be able to be used by other embedded devices due to its large memory requirement.  The lookup table solution’s performance and file size relative to other solutions is detailed further in section 5.  Figure 21 shows a high-level description of the lookup table algorithm.

![image](https://user-images.githubusercontent.com/61804317/175791508-9b52f1ba-907d-49ea-9b7d-58c70253b5f9.png)

### 4.3 Optimized 𝜇 Law with If Statements Reverse Software Solution

To further optimize the software solution, the if statements from the Operator Strength Reduction 𝜇 Law Software Solution were ordered from the largest input value to the smallest input value.  The Optimized 𝜇 Law with If Statements Reverse Software Solution uses much of the same code as the Operator Strength Resection code, however, the ordering of the if statements is reversed. 


After comparing the execution times of the Operator Strength Reduction 𝜇 Law Software Solution to the Optimized 𝜇 Law with If Statements Reverse Software Solution, it was determined that the If Statement Reversed solution had an execution time 17% lower than the Operator Strength Reduction Solution.  The difference in performance is likely because the audio file that the solutions were tested on mainly consisted of silence and quiet sounds.  Quiet sounds require less bits to represent in the audio file.  When the software solutions read through the audio the Operator Strength Reduction Solution begins its if statements looking for large values before moving to smaller values.  The optimized, If Statement Reversed Solution does the opposite, first looking for small values before continuing to larger values.  By looking for quiet sounds first, the if statement branches are taken sooner and the software runs faster. 

### 4.5 Switch Statement

To further optimize the code, an alternative software solution was considered.  In the alternative software solution, the if statements in the Operator Strength Reduction Solution were replaced by a switch statement.  The challenge with creating the Switch Statement solution is that a switch statement requires a fixed input value unlike if statements that support condition checks.  To accommodate this requirement the conditional check is processed before the switch statement.  The fixed integer value for the switch statement is determined by iterating through a while loop.  In each iteration a counter value named “NumberOfBits” is increased while the input value is shifted one bit to the right.  The loop exits once the input bits are shifted to zero.  The counter value is then used as an input to the switch statement. 

### 4.6 Assembly Level Optimizations

After compiling the Optimized 𝜇 Law with If Statements Reverse Software Solution, it was evident additional optimizations could be applied to the assembly.  Looking at the assembly for the compression and decompression, one can see optimizations made towards the compression also apply for optimizations made for the decompression.  One such optimization is removing instructions that would store data and then immediately load the same data from memory.  This occurred in both the assembly for the compression and decompression.  Attempts were made at the C level to help the compiler not include these errors by having all five valuables used in the compression function kept in registers.  Despite making this adjustment to the C code, the compiler continued to insist on making unnecessary accesses to memory.  As a result, the optimizations must be applied in the assembly.  This is a significant Optimization as load and store operations are expensive and require many processor cycles to perform.  The Unoptimized and Optimized assembly may be seen in the following table.

![image](https://user-images.githubusercontent.com/61804317/175791627-7c04eb2e-2ef6-4a02-b1c6-b6a200839c71.png)

Further Optimizations were made to the assembly by removing a register move operation. As
shown in Table 10, the instruction, mov r0, r3, that moves the contents of register 3 to register 0 can be
implemented in the load instruction above, ldr r3, [fp, #-20] by loading data into register 0 directly. This
adjustment will remove a processor cycle allowing for the program to have a smaller execution time. The
optimization of replacing the move operation by directly writing to the destination register was found in
both the compression and decompression assembly. An example showcasing this optimization may be
seen in teh following table.

![image](https://user-images.githubusercontent.com/61804317/175791632-c3085857-f7df-4c3a-864a-a44c66320a7a.png)

After applying the optimizations, the processor cycle count was reduced by 21 cycles. Aside
from the Optimizations discussed, it was determined that the GCC compiler was effective in compiling
29 the C code and did not create any necessary pipeline bubbles with unnecessary branch statements.
Additionally, the compiler kept all local variables in registers, minimizing the processor’s memory
accesses and further reducing pipeline bubbles.

It was noted that the assembly generated from the Lookup Table software solution featured many
memory access instructions, indicating that the 16 KB lookup table could not be kept in cache. As a
result of the memory access instructions the software solution was slower than expected and ranked
second to the Reverse If Statement Solution when running on the ARM processor. The solutions were
later tested on an Intel Core i7-9750H CPU @ 2.60GHz processor with a cache size of 14 MB. It was
determined that the Lookup Table solution ran quickest beating out the Reverse If Statement Solution.
From the results of the tests, one may conclude that the Lookup Table solution requires too much memory
for an embedded system processor and an alternative solution such as the reverse if statement solution
would be best.




## 5.0 Performance

To evaluate performance of the software solutions discussed in section 3 of this report
The four software solutions, Operator Strength Reduction 𝜇 Law, Optimized 𝜇 Law with If
Statements Reversed, Optimized 𝜇 Law with Switch Statement, and 𝜇 Law Lookup Table, have been run
on the S3C2440A 32-Bit CMOS Microcontroller and compared with one another as well as the original,
Unoptimized 𝜇 Law Software Solution, software solution [1]. The testing regime included evaluating
each solution based on execution time required to compress and decompress a 1 MB Wav file. The audio
file consisted of a voice speaking. This choice was made as 𝜇 Law audio compression has been designed
to compress and decompress voice traffic. To ensure accurate results each solution was run nine times.
The run times are recorded in Tables 12 to 16. The execution times were averaged and are presented in
the Table 11 and Figure 22.

![image](https://user-images.githubusercontent.com/61804317/175791662-1574a806-c04f-4163-a0c6-f5b08427c6ac.png)

![image](https://user-images.githubusercontent.com/61804317/175791676-0b2c36eb-05b3-406f-b0a7-71bf855d6162.png)

![image](https://user-images.githubusercontent.com/61804317/175791680-479363d5-58e8-4ce2-a8d2-e5598d104f8f.png)


![image](https://user-images.githubusercontent.com/61804317/175791702-9a917636-92d6-4f85-87be-b379080ef8c0.png)

![image](https://user-images.githubusercontent.com/61804317/175791706-056bb39b-8504-4cb6-a8b0-16af34fdb919.png)


![image](https://user-images.githubusercontent.com/61804317/175791712-fc1d09fd-11bc-46e5-baf0-6dd84415f9c2.png)


![image](https://user-images.githubusercontent.com/61804317/175791714-c5482381-0be8-4f32-89cd-930e564ef20b.png)


Comparing the software solutions to one another, one may see that by using the fastest software solution, the If Statement Reversed, one may achieve a speed up of 31% over the original, Unoptimized solution.   While this is a significant improvement, one may also wish to consider the speed of up a hardware solution.  From the simulations discussed in, section 3.2, Hardware Solutions, results show an execution time of 90 micro-seconds.  Comparing the hardware solution’s performance to the original, Unoptimized solution, one may observe a decrease in execution time by a factor of 9355.  Comparing this value to the software solution’s decrease in execution time by a factor of 1.44, one may see that the hardware solution may provide a significant increase in performance.   While the simulated results of the hardware solution are promising, it is a greater challenge to implement and would likely be financially expensive.  Determining whether to choose the optimized software solution or the hardware solution would ultimately be dictated by whether the performance offered by the hardware solution is worth the financial cost over the less expensive software solution.

### 5.1 Audio Compression

As shown in Figure 22, the audio compression has a greater variance in execution times. This
outcome is expected as all the software solutions feature different compression methods and the same
decompression methods. From the figure one may note that the If Statement Reversed has the smallest
35 execution time and has a file size like other solutions. Due to the solution’s supervisor performance, it is
the primary recommendation for implementing 𝜇 Law audio compression and decompression.
Unexpectedly, the lookup table solution has the second smallest execution time oppose the first
smallest. The cause of its slower execution time is likely due to cache misses. When comparing the
lookup table solution to the if Statement Revered Solution using an Intel Core i7-9750H CPU @
2.60GHz, one may observe that the lookup table runs fastest as the entirety of the 16 KB lookup table
may be kept in cache.


## 5.2 Audio Decompression

The optimized software solutions, Operator Strength Reduction, If Statement Reversed, Lookup
Table, and Switch Statement, feature the same decompression function. After reviewing the assembly for
each software solution, it was found that the GCC compiler incorporated different memory management
methods for the different software solutions, leading to different decompression execution times.


![image](https://user-images.githubusercontent.com/61804317/175791737-d8dd73fd-dbbd-4270-92e8-ce1d3012879c.png)

Comparing the file size of the software solutions, one can observe the significantly larger file size
of the lookup table. The lookup table file slide is large because the lookup table is composed of 16,383
entities. Due to the numerous entries the file size of the lookup table totaled 958,162 bytes. The original,
Operator Strength Reduction, If Statement Reversed, and Switch software solutions has file sizes of
7,034, 7,252, 7,249, 7,417 bytes respectively. The reason they are all so similar is because they all
contained a similar amount of branch statements. Additionally, they all used the same decompression
method.

## 6.0 Results

When running out executable file on the lab machine, on “Matts-Voice.wav” the following compressed
files was created:

![image](https://user-images.githubusercontent.com/61804317/175791747-e11c8d94-0f85-4717-a592-1416fc8cced1.png)


Above, shows the created compressed.wav file showing that the solution was successful in
reducing the size of the WAV file by half and then decompressed to achieve a file that was fairly close to
the same size as the original file. The resulting audio was coherent; however the quality was diminished
significantly. The difference in audio quality could be attributed to the data being lost during the original
compression stage that was effectively compensated for during the decompression stage.
The program was able to compress the original audio file with a file size of 1,007,876 bytes to a
compressed audio file with a file size 503,960 bytes, achieving a compression ratio of 2. Following the
compression, the program was able to receive the compressed file and decompress it. Following
decompression, the audio file was restored to its original file size. The decompressed audio file had
significant noise compared to the original file, however, the audio is audible and coherent.

## 7.0 Conclusions

This project explored several software and compile time optimizations to improve the runtime
performance of a 𝜇 Law audio compression and decompression algorithm implemented on an embedded
S3C2440A 32-Bit CMOS Microcontroller. The following C programming optimization techniques that
were made included: Operator Strength Reduction, If Statement Reversed, Lookup Table, and Switch
Statement. Each of these techniques incorporated the same algorithm for decompression algorithm
throughout the different code revisions.
After empirically testing these revisions on the embedded linux lab machine, the Reverse If
Statement technique performed the best, yielding a 31% faster runtime than the original, unoptimized
code. When testing each of these on the Intel Core i7-9750H CPU @ 2.60GHz onboard one of the team
member’s personal Windows Machines, it was observe that the lookup table performed better, yielding
the fastest execution time, due to the entirety of the 16 KB table may be kept in the processor’s cache.
The smaller cache size of the embedded processor likely diminished any performance advantages of the
lookup table where its enormous file size likely resulted in cache misses on the embedded processor.
These results were consistent with our theoretical predictions.
When optimizing the assembly instructions through removing unnecessary memory store and
load operations, as an attempt to further improve this operation we also declared all variables as the
register keyword. Despite these optimizations, for this architecture, optimization techniques did not show
any performance enhancements as the compiler continued to atomically create unnecessary stores and
loads on new variables. In the future, this could be mitigated through assembly inclining.
Ultimately, the fastest solution would be to implement this entire algorithm in hardware, as
shown by the results that were simulated in this report. However, a designated hardware solution for this
algorithm would be significantly more expensive financially due to the complexity, materials and
overhead of implementing that entire solution onto an FPGA. Therefore, the optimal solution would be
determined by the consumer as a trade-off between performance offered by the hardware solution
compared to the overall financial benefits of the software solution.



## 8.0 References

![image](https://user-images.githubusercontent.com/61804317/175791890-229dba4d-bd95-4b59-86a6-541ce9ab85b9.png)


