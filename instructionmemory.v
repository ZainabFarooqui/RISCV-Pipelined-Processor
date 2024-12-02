`timescale 1ns / 1ps

module instructionmemory(
    input [31:0] Inst_Address, // 32-bit address bc addressing byte offsets
    output reg [31:0] Instruction
);
    
    reg [7:0] memory [184:0]; // A 256-byte memory for storing instructions
    
    // Initializing the memory with the provided instruction values
    initial begin
        // Replacing the dummy data with your values
        
      // 10000513	addi x10 x0 256	li x10, 0x100
memory[3] = 32'h10;
memory[2] = 32'h00;
memory[1] = 32'h05;
memory[0] = 32'h13;

// 00553023	sd x5 0(x10)	sd x5, 0(x10)
memory[7] = 32'h00;
memory[6] = 32'h55;
memory[5] = 32'h30;
memory[4] = 32'h23;

// 00653423	sd x6 8(x10)	sd x6, 8(x10)
memory[11] = 32'h00;
memory[10] = 32'h65;
memory[9] = 32'h34;
memory[8] = 32'h23;

// 00753823	sd x7 16(x10)	sd x7, 16(x10)
memory[15] = 32'h00;
memory[14] = 32'h75;
memory[13] = 32'h38;
memory[12] = 32'h23;

// 01c53c23	sd x28 24(x10)	sd x28, 24(x10)
memory[19] = 32'h01;
memory[18] = 32'hc5;
memory[17] = 32'h3c;
memory[16] = 32'h23;

// 03d53023	sd x29 32(x10)	sd x29, 32(x10)
memory[23] = 32'h03;
memory[22] = 32'hd5;
memory[21] = 32'h30;
memory[20] = 32'h23;

// 03e53423	sd x30 40(x10)	sd x30, 40(x10)
memory[27] = 32'h03;
memory[26] = 32'he5;
memory[25] = 32'h34;
memory[24] = 32'h23;

// 00600593	addi x11 x0 6	li x11, 6
memory[31] = 32'h00;
memory[30] = 32'h60;
memory[29] = 32'h05;
memory[28] = 32'h93;

// 020000ef	jal x1 32	    jal x1, sort
memory[35] = 32'h02;
memory[34] = 32'h00;
memory[33] = 32'h00;
memory[32] = 32'hef;

// 00359313	slli x6 x11 3	slli x6, x11, 3 # reg x6 = k * 8 // changed to 3 from 2
memory[39] = 32'h00;
memory[38] = 32'h35;
memory[37] = 32'h93;
memory[36] = 32'h13;

// 00650333	add x6 x10 x6	add x6, x10, x6 #reg x6 = v + (k * 4)
memory[43] = 32'h00;
memory[42] = 32'h65;
memory[41] = 32'h03;
memory[40] = 32'h33;

// 00033283	ld x5 0(x6)	    ld x5, 0(x6) #reg x5 (temp) = v[k]
memory[47] = 32'h00;
memory[46] = 32'h03;
memory[45] = 32'h32;
memory[44] = 32'h83;

// 00833383	ld x7 8(x6)	    ld x7, 8(x6) #reg x7 = v[k + 1]
memory[51] = 32'h00;
memory[50] = 32'h83;
memory[49] = 32'h33;
memory[48] = 32'h83;

// 00733023	sd x7 0(x6)	    sd x7, 0(x6) #v[k] = reg x7
memory[55] = 32'h00;
memory[54] = 32'h73;
memory[53] = 32'h30;
memory[52] = 32'h23;

// 00533423	sd x5 8(x6)	    sd x5, 8(x6) #v[k+1] = reg x5 (temp)
memory[59] = 32'h00;
memory[58] = 32'h53;
memory[57] = 32'h34;
memory[56] = 32'h23;

// 00008067	jalr x0 x1 0	jalr x0, 0(x1) #return to calling routine
memory[63] = 32'h00;
memory[62] = 32'h00;
memory[61] = 32'h80;
memory[60] = 32'h67;

// fd810113	addi x2 x2 -40	addi sp, sp, -40
memory[67] = 32'hfd;
memory[66] = 32'h81;
memory[65] = 32'h01;
memory[64] = 32'h13;

// 02113023	sd x1 32(x2)	sd x1, 32(sp)
memory[71] = 32'h02;
memory[70] = 32'h11;
memory[69] = 32'h30;
memory[68] = 32'h23;

// 01613c23	sd x22 24(x2)	sd x22, 24(sp)
memory[75] = 32'h01;
memory[74] = 32'h61;
memory[73] = 32'h3c;
memory[72] = 32'h23;

// 01513823	sd x21 16(x2)	sd x21, 16(sp)
memory[79] = 32'h01;
memory[78] = 32'h51;
memory[77] = 32'h38;
memory[76] = 32'h23;

// 01413423	sd x20 8(x2)	sd x20, 8(sp)
memory[83] = 32'h01;
memory[82] = 32'h41;
memory[81] = 32'h34;
memory[80] = 32'h23;

// 01313023	sd x19 0(x2)	sd x19, 0(sp)
memory[87] = 32'h01;
memory[86] = 32'h31;
memory[85] = 32'h30;
memory[84] = 32'h23;

// 00050a93	addi x21 x10 0	addi x21, x10, 0
memory[91] = 32'h00;
memory[90] = 32'h05;
memory[89] = 32'h0a;
memory[88] = 32'h93;

// 00058b13	addi x22 x11 0	addi x22, x11, 0
memory[95] = 32'h00;
memory[94] = 32'h05;
memory[93] = 32'h8b;
memory[92] = 32'h13;

// 00000993	addi x19 x0 0	addi x19,x0, 0
memory[99] = 32'h00;
memory[98] = 32'h00;
memory[97] = 32'h09;
memory[96] = 32'h93;

// 03698e63	beq x19 x22 60	beq x19, x22, exit1 #used to be bge
memory[103] = 32'h03;
memory[102] = 32'h69;
memory[101] = 32'h8e;
memory[100] = 32'h63;

// fff98a13	addi x20 x19 -1	addi x20, x19, -1
memory[107] = 32'hff;
memory[106] = 32'hf9;
memory[105] = 32'h8a;
memory[104] = 32'h13;

// 03fa0663	beq x20 x31 44	beq x20, x31, exit2 #used to be blt
memory[111] = 32'h03;
memory[110] = 32'hfa;
memory[109] = 32'h06;
memory[108] = 32'h63;

// 002a1293	slli x5 x20 2	slli x5, x20, 2
memory[115] = 32'h00;
memory[114] = 32'h2a;
memory[113] = 32'h12;
memory[112] = 32'h93;

// 005a82b3	add x5 x21 x5	add x5, x21, x5
memory[119] = 32'h00;
memory[118] = 32'h5a;
memory[117] = 32'h82;
memory[116] = 32'hb3;

// 0002b303	ld x6 0(x5)	    ld x6, 0(x5)
memory[123] = 32'h00;
memory[122] = 32'h02;
memory[121] = 32'hb3;
memory[120] = 32'h03;

// 0082b383	ld x7 8(x5)	    ld x7, 8(x5)
memory[127] = 32'h00;
memory[126] = 32'h82;
memory[125] = 32'hb3;
memory[124] = 32'h83;

// 00730c63	beq x6 x7 24	beq x6, x7, exit2 #used to be ble
memory[131] = 32'h00;
memory[130] = 32'h73;
memory[129] = 32'h0c;
memory[128] = 32'h63;

// 000a8513	addi x10 x21 0	addi x10, x21, 0
memory[135] = 32'h00;
memory[134] = 32'h0a;
memory[133] = 32'h85;
memory[132] = 32'h13;

// 000a0593	addi x11 x20 0	addi x11, x20, 0
memory[139] = 32'h00;
memory[138] = 32'h0a;
memory[137] = 32'h05;
memory[136] = 32'h93;

// f99ff0ef	jal x1 -104	    jal x1, swap
memory[143] = 32'hf9;
memory[142] = 32'h9f;
memory[141] = 32'hf0;
memory[140] = 32'hef;

// fffa0a13	addi x20 x20 -1	addi x20, x20, -1
memory[147] = 32'hff;
memory[146] = 32'hfa;
memory[145] = 32'h0a;
memory[144] = 32'h13;

// fd9ff06f	jal x0 -40	    jal, x0 for2tst
memory[151] = 32'hfd;
memory[150] = 32'h9f;
memory[149] = 32'hf0;
memory[148] = 32'h6f;

// 00198993	addi x19 x19 1	addi x19, x19, 1
memory[155] = 32'h00;
memory[154] = 32'h19;
memory[153] = 32'h89;
memory[152] = 32'h93;

// fc9ff06f	jal x0 -56	    jal, x0 for1tst
memory[159] = 32'hfc;
memory[158] = 32'h9f;
memory[157] = 32'hf0;
memory[156] = 32'h6f;

// 00013983	ld x19 0(x2)	ld x19, 0(sp)
memory[163] = 32'h00;
memory[162] = 32'h01;
memory[161] = 32'h39;
memory[160] = 32'h83;

// 00813a03	ld x20 8(x2)	ld x20, 8(sp)
memory[167] = 32'h00;
memory[166] = 32'h81;
memory[165] = 32'h3a;
memory[164] = 32'h03;

// 01013a83	ld x21 16(x2)	ld x21, 16(sp)
memory[171] = 32'h01;
memory[170] = 32'h01;
memory[169] = 32'h3a;
memory[168] = 32'h83;

// 01813b03	ld x22 24(x2)	ld x22, 24(sp)
memory[175] = 32'h01;
memory[174] = 32'h81;
memory[173] = 32'h3b;
memory[172] = 32'h03;

// 02013083	ld x1 32(x2)	ld x1, 32(sp)
memory[179] = 32'h02;
memory[178] = 32'h01;
memory[177] = 32'h30;
memory[176] = 32'h83;

// 02810113	addi x2 x2 40	addi sp, sp, 40
memory[183] = 32'h02;
memory[182] = 32'h81;
memory[181] = 32'h01;
memory[180] = 32'h13;

// 0040006f	jal x0 4	    jal x0, exit
memory[187] = 32'h00;
memory[186] = 32'h40;
memory[185] = 32'h00;
memory[184] = 32'h6f;



//         (The remaining instructions follow the same pattern...)

//         Fill the rest of the `memory` with zeros for unused locations
//        for (integer i = 216; i < 256; i = i + 1) begin
//            memory[i] = 8'h00;
//        end
end

    // Read instructions from memory
    always @(Inst_Address) begin
            Instruction = {memory[Inst_Address + 3], memory[Inst_Address + 2], memory[Inst_Address + 1], memory[Inst_Address]};
    end
endmodule
