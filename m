From: Rigo Reddig <rigo.reddig-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: amdgpu multi monitor - clock, heat and power problem
Date: Mon, 08 Apr 2019 22:18:40 +0200
Message-ID: <14039132.b7AKeVp86W@jupiter>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0630359707=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0630359707==
Content-Type: multipart/signed; boundary="nextPart4008687.lkW1hLRMS3"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4008687.lkW1hLRMS3
Content-Type: multipart/alternative; boundary="nextPart16572276.77HFospuyH"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart16572276.77HFospuyH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I have 2 Gigabyte RX580's in my desktop workstation. 
I'm running Arch Linux with KDE Plasma on the 5.0.6 kernel.

The cards themselves work fine, except,
I have two 1080p HDMI monitors plugged into one of these cards.
One in a native HDMI port, one in a passive DVI->HDMI adapter.

This causes the following problem for idle usage:

 1. Memory clock is effectively locked at 200Mhz always
 2. Core clock is constantly at high frequency P-state
 3. Temperatures are increased
 4. Power consumption is increased (significantly)
 5. PCI bus is always at full speed
 6. Forcing core clock to 300Mhz, uses a higher than usual voltage

Below is an excerpt from the rocm-smi utility for the automatic defaults 
(I have omitted overclock and powercap values for formatting purposes)


2 Monitors connected to GPU 0, No monitors connected to GPU 1
ROCm System Management Interface        
==========================================================================
=====
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    GPU%
0     44.0c  36.193W  1145Mhz 2000Mhz 8.0GT/s, x16   40.0%   auto    0%       
1     37.0c  28.104W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    auto    0%       
==========================================================================
=====
End of ROCm SMI Log              

GPU 0 is idle and yet running SCLK and MCLK at unnecessary power levels
GPU 1 is truly idle
Regarding GPU 0 temperature, I have actually setup a daemon to run the fan at a 
consistent rate to prevent it from constantly peaking.

-------------------------------------------------------------------------------

1 Monitors connected to GPU 0, No monitors connected to GPU 1
ROCm System Management Interface        
==========================================================================
=====
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    GPU%
0     36.0c  28.103W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    auto    0%       
1     37.0c  28.104W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    auto    0%       
==========================================================================
=====

2 Monitors connected to GPU 0, No monitors connected to GPU 1

2 Monitors connected to GPU 0, No monitors connected to GPU 1
ROCm System Management Interface        
==========================================================================
=====
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    GPU%
0     44.0c  31.086W  300Mhz 2000Mhz  2.5GT/s, x8   40.0%    low    0%       
1     37.0c  28.104W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    low    0%       
==========================================================================
=====

Peculiarly even with low power state forced, the GPU runs at a voltage (950mV) in excess 
of what is required for 300Mhz (750mV)


==========================================================================
=====
cat /sys/kernel/debug/dri/0/amdgpu_pm_info                                                                                                                                                                                         
jupiter: Mon Apr  8 21:57:29 2019

Clock Gating Flags Mask: 0x3fbcf
        Graphics Medium Grain Clock Gating: On
        Graphics Medium Grain memory Light Sleep: On
        Graphics Coarse Grain Clock Gating: On
        Graphics Coarse Grain memory Light Sleep: On
        Graphics Coarse Grain Tree Shader Clock Gating: Off
        Graphics Coarse Grain Tree Shader Light Sleep: Off
        Graphics Command Processor Light Sleep: On
        Graphics Run List Controller Light Sleep: On
        Graphics 3D Coarse Grain Clock Gating: Off
        Graphics 3D Coarse Grain memory Light Sleep: Off
        Memory Controller Light Sleep: On
        Memory Controller Medium Grain Clock Gating: On
        System Direct Memory Access Light Sleep: Off
        System Direct Memory Access Medium Grain Clock Gating: On
        Bus Interface Medium Grain Clock Gating: Off
        Bus Interface Light Sleep: On
        Unified Video Decoder Medium Grain Clock Gating: On
        Video Compression Engine Medium Grain Clock Gating: On
        Host Data Path Light Sleep: On
        Host Data Path Medium Grain Clock Gating: On
        Digital Right Management Medium Grain Clock Gating: Off
        Digital Right Management Light Sleep: Off
        Rom Medium Grain Clock Gating: On
        Data Fabric Medium Grain Clock Gating: Off

GFX Clocks and Power:
        2000 MHz (MCLK)
        300 MHz (SCLK)
        600 MHz (PSTATE_SCLK)
        1000 MHz (PSTATE_MCLK)
        950 mV (VDDGFX)
        31.14 W (average GPU)

GPU Temperature: 43 C
GPU Load: 0 %

UVD: Disabled

VCE: Disabled
==========================================================================
=====

--nextPart16572276.77HFospuyH
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="us-ascii"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Noto Sans'; font-size:10pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">I have 2 Gigabyte RX580's in my desktop workstation. </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">I'm running Arch Linux with KDE Plasma on the 5.0.6 kernel.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">The cards themselves work fine, except,</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">I have two 1080p HDMI monitors plugged into one of these cards.</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">One in a native HDMI port, one in a passive DVI-&gt;HDMI adapter.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">This causes the following problem for idle usage:</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';"> 1. Memory clock is effectively locked at 200Mhz always</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';"> 2. Core clock is constantly at high frequency P-state</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';"> 3. Temperatures are increased</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';"> 4. Power consumption is increased (significantly)</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';"> 5. PCI bus is always at full speed</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';"> 6. Forcing core clock to 300Mhz, uses a higher than usual voltage</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Below is an excerpt from the rocm-smi utility for the automatic defaults </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">(I have omitted overclock and powercap values for formatting purposes)</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">2 Monitors connected to GPU 0, No monitors connected to GPU 1</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">ROCm System Management Interface        </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    GPU%</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">0     44.0c  36.193W  1145Mhz 2000Mhz 8.0GT/s, x16   40.0%   auto    0%       </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">1     37.0c  28.104W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    auto    0%       </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">End of ROCm SMI Log              </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GPU 0 is idle and yet running SCLK and MCLK at unnecessary power levels</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GPU 1 is truly idle</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Regarding GPU 0 temperature, I have actually setup a daemon to run the fan at a consistent rate to prevent it from constantly peaking.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">-------------------------------------------------------------------------------</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">1 Monitors connected to GPU 0, No monitors connected to GPU 1</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">ROCm System Management Interface        </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    GPU%</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">0     36.0c  28.103W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    auto    0%       </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">1     37.0c  28.104W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    auto    0%       </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">2 Monitors connected to GPU 0, No monitors connected to GPU 1</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">2 Monitors connected to GPU 0, No monitors connected to GPU 1</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">ROCm System Management Interface        </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    GPU%</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">0     44.0c  31.086W  300Mhz 2000Mhz  2.5GT/s, x8   40.0%    low    0%       </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">1     37.0c  28.104W  300Mhz  300Mhz  2.5GT/s, x8    0.0%    low    0%       </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Peculiarly even with low power state forced, the GPU runs at a voltage (950mV) in excess of what is required for 300Mhz (750mV)</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">cat /sys/kernel/debug/dri/0/amdgpu_pm_info                                                                                                                                                                                         jupiter: Mon Apr  8 21:57:29 2019</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Clock Gating Flags Mask: 0x3fbcf</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Medium Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Medium Grain memory Light Sleep: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Coarse Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Coarse Grain memory Light Sleep: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Coarse Grain Tree Shader Clock Gating: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Coarse Grain Tree Shader Light Sleep: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Command Processor Light Sleep: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics Run List Controller Light Sleep: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics 3D Coarse Grain Clock Gating: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Graphics 3D Coarse Grain memory Light Sleep: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Memory Controller Light Sleep: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Memory Controller Medium Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        System Direct Memory Access Light Sleep: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        System Direct Memory Access Medium Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Bus Interface Medium Grain Clock Gating: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Bus Interface Light Sleep: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Unified Video Decoder Medium Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Video Compression Engine Medium Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Host Data Path Light Sleep: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Host Data Path Medium Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Digital Right Management Medium Grain Clock Gating: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Digital Right Management Light Sleep: Off</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Rom Medium Grain Clock Gating: On</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        Data Fabric Medium Grain Clock Gating: Off</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GFX Clocks and Power:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        2000 MHz (MCLK)</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        300 MHz (SCLK)</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        600 MHz (PSTATE_SCLK)</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        1000 MHz (PSTATE_MCLK)</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        950 mV (VDDGFX)</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">        31.14 W (average GPU)</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GPU Temperature: 43 C</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">GPU Load: 0 %</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">UVD: Disabled</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">VCE: Disabled</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">===============================================================================</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Using amdgpu.ppfeaturemask=0xffffffff I am able to work around all of the above issues, but requires me to manually set idle and performance clock speeds as required. 300mhz memory and core drive 2 HDMI 1080p displays just fine.</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">But this leads to screen tearing/green visible artefacting when *changing* core clock speeds. Like there is a synchronization issue. But when running at a fixed speed, all is well.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">The temperatures alone show that power is being wasted.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">I have a UPS that can reasonably accurately (16W steps) measure system power consumption. At idle with default settings letting the kernel and gpu's deal with things themselves I sometimes read ~196W idle power!</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">2 Monitors (auto)      -&gt; 196W Idle</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">2 Monitors (low)       -&gt; 160W Idle</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">2 Monitors (Force 300) -&gt; 112-128W Idle</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">1 monitor              -&gt; 96-128W Idle</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Even if my UPS isn't giving the exact true values, that delta is concerning. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">It is a longstanding issue which has been bugging me for a while now.<br />I'm not sure if it's come up yet or why this has been going on for so long.</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">But it should really be fixed as the issue carries a quite large associated thermal and power burden.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">I have tried poking through the source code to figure this out, but no luck. Have I missed something? Is there a problem synchronizing display VSYNC on clock changes? Why is this happening? It's clearly not the right behaviour.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">What can be done to fix this? Can I help?</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Best Regards</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=" font-family:'DejaVu Sans Mono';">Rigo Reddig</span></p></body></html>
--nextPart16572276.77HFospuyH--

--nextPart4008687.lkW1hLRMS3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4+1nb72TPcbRD5ZVwQtP10cF+QsFAlyrrKAACgkQwQtP10cF
+QuP3w//QlCEvhowuS1BxR6HhvimJZrver+pKu3SFjIztEWH6cMCv2qZxqr4s8GW
4wl06Ec1o3GJRC4a7NwSAYBiieVRyJjigUztg3vmJh0Fscunhuz/3AFuJ/Akt4+L
HM1WwkySJP73K48OQeHcO0dppGzvup1AgbFGsg2sVHKavzqXLI7TYWGMRaL5Id5H
Q8hESc7SFaDNu4/7kh/bHhPWsAoYM6ykDK7EPYkXD6xPsPn72HUyUF5NnKo2ZWFU
64hNDAcnjhm+L5SYSoBfbqiZTntkFHZgHWhgOtnOQo2eeJG/PFM5oueiSOlLiXzB
Wj4uktaOV0I1Mpy1kAaQ5qwO6wH8Jsh4Bxlaljdz3eBhOjKGehiZ9PQxuOF3Ch2/
BQwZw1h5Yln9TEXRFqIEHlDUcbKRDa+DE4TkesbGzJojy5qCueL2fgRrmT2fMxSn
6wA9C5mo5S7JrQQFoGX8mFQLAOAmGqf2ICeuCy7caDa9YiXV3Gt4VDU2e24j3fwE
ImTg0h4ngP/wG7ZIK0C6BoPbGVNsvb4GHKBTnI4P2kAdKVUCVxc6rvAn4lg/W2BN
3+BAfseUM+l9BZ8Xk3YI2WDHnE36l1qfAQ0Vog/HEK/AzBTMvKS9W46N3Fh2wV4k
C5FSjI6cqJ1h+lj9ZQAOzLpDohojTLfajkIwZWww9vU751y7I18=
=isdY
-----END PGP SIGNATURE-----

--nextPart4008687.lkW1hLRMS3--




--===============0630359707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0630359707==--
