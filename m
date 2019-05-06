From: Yanik Yiannakis <yanik-4pJZyYNR0dgOIzVOb1FTxg@public.gmane.org>
Subject: Re: Bug Report: [PowerPlay] MCLK can't be set above 1107MHz on Vega 64
Date: Mon, 6 May 2019 12:55:39 +0200
Message-ID: <077d0738-d545-b1f1-bfa4-f242288047c3@yiannakis.de>
References: <f0312882-75cf-f79e-9fe8-fd95adf739b9@yiannakis.de>
 <MN2PR12MB3344B68A267771FF8D12C0ECE4300@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2035051631=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344B68A267771FF8D12C0ECE4300-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============2035051631==
Content-Type: multipart/alternative;
 boundary="------------85638EB5C2B8B837063CE18B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------85638EB5C2B8B837063CE18B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Evan,

Yes I always used that command to commit my changes. I also have 
amdgpu.ppfeaturemask=0xffffffff as a boot parameter and I set 
power_dpm_force_performance_level to manual. Sorry for omitting that I 
assumed it was evident.

I have heard that the MCLK can only be as high as the SOCCLK. That would 
make sense because the SOCCLK of my Vega 64 is 1107MHz in its highest 
state. I noticed that on Windows the SOCCLK is raised automatically if 
the user sets the MCLK high enough through Wattman.

To replicate this on Linux I manually edited the pp_table to change the 
MCLK to 1175MHz and the SOCCLK to 1180MHz. The new SOCCLK was displayed 
in pp_dpm_socclk and in Unigine Superposition the FPS increased as 
expected (compared to an MCLK of 1107MHz). As a final test I edited the 
pp_table to set the MCLK to 1220MHz (this was unstable on Windows) and 
the SOCCLK to 1250MHz. This resulted in a crash (just like on Windows) 
which indicates that the MCLK really was set to 1220MHz.

My understanding of the situation is that powerplay doesn't 
automatically raise the SOCCLK like Wattman.
It would be cool if the user had the ability to overclock the SOCCLK 
through powerplay.

Greetings,
Yanik


On 06.05.19 10:13, Quan, Evan wrote:
>
> +Alex,
>
> Hi Yanik,
>
> Did you ever run the following command to let your OD settings take 
> effect (before running games)? Otherwise, they did not take effect 
> actually.
>
> echo "c" > 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage
>
> Regards,
>
> Evan
>
> *From:*Yanik Yiannakis <yanik-4pJZyYNR0dgOIzVOb1FTxg@public.gmane.org>
> *Sent:* Monday, April 29, 2019 7:44 AM
> *To:* rex.zhu-5C7GfCeVMHo@public.gmane.org; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Bug Report: [PowerPlay] MCLK can't be set above 1107MHz on 
> Vega 64
>
> Hello,
>
> I experience a bug that prevents me from setting the MCLK of my Vega 
> 64 LC above 1107MHz.
>
> I am using Unigine Superposition 1.1 in "Game"-mode to check the 
> performance by watching the FPS.
>
> *Behaviour with a single monitor:*
>
> First I set the MCLK to a known stable value below 1108MHz:
>
> /$ echo "m 3 1100 950" > 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage/
>
> In Unigine Superposition the FPS increase as expected.
>
> pp_dpm_mclk also confirms the change.
>
> /$ watch cat 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_dpm_mclk/
>
>     0: 167Mhz
>     1: 500Mhz
>     2: 800Mhz
>     3: 1100Mhz *
>
> After that I set the MCLK to a stable value above 1107MHz:
>
> /$ echo "m 3 1200 950" > 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage/
>
> In Unigine Superposition the FPS drop drastically.
>
> pp_dpm_mclk indicates that the MCLK is stuck in state 0 (167MHz):
>
>     0: 167Mhz *
>     1: 500Mhz
>     2: 800Mhz
>     3: 1200Mhz
>
> *Behaviour with multiple monitors that have different refresh rates:*
>
> My monitors have different refresh rates. This causes the MCLK to stay 
> in state 3 (945MHz stock) which is the expected behaviour as I 
> understand it.
>
> Now I try to set the MCLK to a value above 1107MHz:
>
> /$ echo "m 3 1200 950" > 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage/
>
> The FPS in Unigine Superposition remain the same as they were with 945MHz.
>
> pp_dpm_mclk shows however that the value was set:
>
>     0: 167Mhz
>     1: 500Mhz
>     2: 800Mhz
>     3: 1200Mhz *
>
> Then I set the MCLK to a value of 1107MHz or lower:
>
> /$ echo "m 3 1100 950" > 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage/
>
> The FPS in Unigine Superposition *increase*.
>
> pp_dpm_mclk again confirms the set value:
>
>     0: 167Mhz
>     1: 500Mhz
>     2: 800Mhz
>     3: 1100Mhz *
>
> Finally I increase MCLK to a known unstable value:
>
> /$ echo "m 3 1300 950" > 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage/
>
> The FPS in Unigine Superposition remain the same. I therefore believe 
> the value was not actually applied.
>
> However pp_dpm_mclk shows that it was:
>
>     0: 167Mhz
>     1: 500Mhz
>     2: 800Mhz
>     3: 1300Mhz *
>
> amdgpu_pm_info also claims that the value was set:
>
> /$ sudo watch cat /sys/kernel/debug/dri/1/amdgpu_pm_info/
>
>     GFX Clocks and Power:
>             1300 MHz (MCLK)
>             27 MHz (SCLK)
>             1348 MHz (PSTATE_SCLK)
>             800 MHz (PSTATE_MCLK)
>             825 mV (VDDGFX)
>             4.0 W (average GPU)
>
> Again, I think the displayed MCLK is false and the memory still runs 
> at 1100MHz because the performance in Unigine Superposition indicates 
> this and 1300MHz would cause a crash immediately.
>
> A stable value (e.g. 1200MHz) causes the same behaviour. I just chose 
> 1300MHz to be sure.
>
> Tested on these Kernels:
>
>     Arch-Linux 5.0.9 (Arch)
>
>     Linux 5.1-rc6 (Ubuntu)
>
>     Linux 5.0 with amd-staging-drm-next (Ubuntu)
>     (https://github.com/M-Bab/linux-kernel-amdgpu-binaries)
>
> (Same behaviour on every kernel.)
>
> Tested on this hardware:
>
>     CPU: Intel i7-8700k
>
>     Motherboard: MSI Z370 Gaming Pro Carbon
>
>     GPU: Powercolor Vega 64 Liquid Cooled (Memory stable below
>     1220MHz, tested on Windows 10 with Wattman and Unigine Superposition)
>
> Unigine Superposition "Game"-Mode settings:
>
>     Preset: Custom
>
>     Fullscreen: Disabled
>
>     Resolution: 3840x2160 (4K UHD)
>
>     Shaders Quality: Extreme
>
>     Textures Quality: High
>
>     Vsync: Off
>
>     Depth of Field: On
>
>     Motion Blur: On
>
> I hope this helps.
>
> Yanik Yiannakis
>

--------------85638EB5C2B8B837063CE18B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hello Evan,<br>
      <br>
      Yes I always used that command to commit my changes. I also have
      amdgpu.ppfeaturemask=0xffffffff as a boot parameter and I set
      power_dpm_force_performance_level to manual. Sorry for omitting
      that I assumed it was evident.<br>
      <br>
      I have heard that the MCLK can only be as high as the SOCCLK. That
      would make sense because the SOCCLK of my Vega 64 is 1107MHz in
      its highest state. I noticed that on Windows the SOCCLK is raised
      automatically if the user sets the MCLK high enough through
      Wattman.<br>
      <br>
      To replicate this on Linux I manually edited the pp_table to
      change the MCLK to 1175MHz and the SOCCLK to 1180MHz. The new
      SOCCLK was displayed in pp_dpm_socclk and in Unigine Superposition
      the FPS increased as expected (compared to an MCLK of 1107MHz). As
      a final test I edited the pp_table to set the MCLK to 1220MHz
      (this was unstable on Windows) and the SOCCLK to 1250MHz. This
      resulted in a crash (just like on Windows) which indicates that
      the MCLK really was set to 1220MHz.<br>
      <br>
      My understanding of the situation is that powerplay doesn't
      automatically raise the SOCCLK like Wattman. <br>
      It would be cool if the user had the ability to overclock the
      SOCCLK through powerplay.<br>
      <br>
      Greetings,<br>
      Yanik</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06.05.19 10:13, Quan, Evan wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB3344B68A267771FF8D12C0ECE4300-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="color:windowtext">+Alex,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">Hi Yanik,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">Did you ever
            run the following command to let your OD settings take
            effect (before running games)? Otherwise, they did not take
            effect actually.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">echo "c"
            &gt;
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">Regards,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">Evan<o:p></o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                  style="color:windowtext"> Yanik Yiannakis
                  <a class="moz-txt-link-rfc2396E" href="mailto:yanik-4pJZyYNR0dgOIzVOb1FTxg@public.gmane.org">&lt;yanik-4pJZyYNR0dgOIzVOb1FTxg@public.gmane.org&gt;</a>
                  <br>
                  <b>Sent:</b> Monday, April 29, 2019 7:44 AM<br>
                  <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:rex.zhu-5C7GfCeVMHo@public.gmane.org">rex.zhu-5C7GfCeVMHo@public.gmane.org</a>; Quan, Evan
                  <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">&lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Bug Report: [PowerPlay] MCLK can't be
                  set above 1107MHz on Vega 64<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p>Hello,<o:p></o:p></p>
          <p>I experience a bug that prevents me from setting the MCLK
            of my Vega 64 LC above 1107MHz.
            <o:p></o:p></p>
          <p>I am using Unigine Superposition 1.1 in "Game"-mode to
            check the performance by watching the FPS.<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p><b>Behaviour with a single monitor:</b><o:p></o:p></p>
          <p>First I set the MCLK to a known stable value below 1108MHz:<o:p></o:p></p>
          <p><i>$ echo "m 3 1100 950" &gt;
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage</i><o:p></o:p></p>
          <p>In Unigine Superposition the FPS increase as expected. <o:p></o:p></p>
          <p>pp_dpm_mclk also confirms the change. <o:p></o:p></p>
          <p><i>$ watch cat
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_dpm_mclk</i><o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>0: 167Mhz<br>
              1: 500Mhz<br>
              2: 800Mhz<br>
              3: 1100Mhz *<o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
          <p>After that I set the MCLK to a stable value above 1107MHz:<o:p></o:p></p>
          <p><i>$ echo "m 3 1200 950" &gt;
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage</i><o:p></o:p></p>
          <p>In Unigine Superposition the FPS drop drastically.<o:p></o:p></p>
          <p>pp_dpm_mclk indicates that the MCLK is stuck in state 0
            (167MHz):<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>0: 167Mhz *<br>
              1: 500Mhz<br>
              2: 800Mhz<br>
              3: 1200Mhz<o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
          <p><b>Behaviour with multiple monitors that have different
              refresh rates:</b><o:p></o:p></p>
          <p>My monitors have different refresh rates. This causes the
            MCLK to stay in state 3 (945MHz stock) which is the expected
            behaviour as I understand it.<o:p></o:p></p>
          <p><o:p> </o:p></p>
          <p>Now I try to set the MCLK to a value above 1107MHz:<o:p></o:p></p>
          <p><i>$ echo "m 3 1200 950" &gt;
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage</i><o:p></o:p></p>
          <p>The FPS in Unigine Superposition remain the same as they
            were with 945MHz.<o:p></o:p></p>
          <p>pp_dpm_mclk shows however that the value was set:<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>0: 167Mhz<br>
              1: 500Mhz<br>
              2: 800Mhz<br>
              3: 1200Mhz *<o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
          <p>Then I set the MCLK to a value of 1107MHz or lower:<o:p></o:p></p>
          <p><i>$ echo "m 3 1100 950" &gt;
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage</i><o:p></o:p></p>
          <p>The FPS in Unigine Superposition <b>increase</b>.<o:p></o:p></p>
          <p>pp_dpm_mclk again confirms the set value:<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>0: 167Mhz<br>
              1: 500Mhz<br>
              2: 800Mhz<br>
              3: 1100Mhz *<o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
          <p class="MsoNormal">Finally I increase MCLK to a known
            unstable value:<o:p></o:p></p>
          <p><i>$ echo "m 3 1300 950" &gt;
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/pp_od_clk_voltage</i><o:p></o:p></p>
          <p>The FPS in Unigine Superposition remain the same. I
            therefore believe the value was not actually applied.<o:p></o:p></p>
          <p>However pp_dpm_mclk shows that it was:<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>0: 167Mhz<br>
              1: 500Mhz<br>
              2: 800Mhz<br>
              3: 1300Mhz *<o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
          <p>amdgpu_pm_info also claims that the value was set:<o:p></o:p></p>
          <p><i>$ sudo watch cat /sys/kernel/debug/dri/1/amdgpu_pm_info</i><o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>GFX Clocks and Power:<br>
                      1300 MHz (MCLK)<br>
                      27 MHz (SCLK)<br>
                      1348 MHz (PSTATE_SCLK)<br>
                      800 MHz (PSTATE_MCLK)<br>
                      825 mV (VDDGFX)<br>
                      4.0 W (average GPU)<o:p></o:p></p>
          </blockquote>
          <p>Again, I think the displayed MCLK is false and the memory
            still runs at 1100MHz because the performance in Unigine
            Superposition indicates this and 1300MHz would cause a crash
            immediately.<o:p></o:p></p>
          <p>A stable value (e.g. 1200MHz) causes the same behaviour. I
            just chose 1300MHz to be sure.<o:p></o:p></p>
          <p><o:p> </o:p></p>
          <p><o:p> </o:p></p>
          <p>Tested on these Kernels:<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>Arch-Linux 5.0.9 (Arch)<o:p></o:p></p>
            <p>Linux 5.1-rc6 (Ubuntu)<o:p></o:p></p>
            <p>Linux 5.0 with amd-staging-drm-next (Ubuntu) (<a
                href="https://github.com/M-Bab/linux-kernel-amdgpu-binaries"
                moz-do-not-send="true">https://github.com/M-Bab/linux-kernel-amdgpu-binaries</a>)<o:p></o:p></p>
          </blockquote>
          <p>(Same behaviour on every kernel.)<o:p></o:p></p>
          <p><o:p> </o:p></p>
          <p>Tested on this hardware:<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>CPU: Intel i7-8700k<o:p></o:p></p>
            <p>Motherboard: MSI Z370 Gaming Pro Carbon<o:p></o:p></p>
            <p>GPU: Powercolor Vega 64 Liquid Cooled (Memory stable
              below 1220MHz, tested on Windows 10 with Wattman and
              Unigine Superposition)<o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
          <p>Unigine Superposition "Game"-Mode settings: <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p>Preset: Custom<o:p></o:p></p>
            <p>Fullscreen: Disabled<o:p></o:p></p>
            <p>Resolution: 3840x2160 (4K UHD)<o:p></o:p></p>
            <p>Shaders Quality: Extreme<o:p></o:p></p>
            <p>Textures Quality: High<o:p></o:p></p>
            <p>Vsync: Off<o:p></o:p></p>
            <p>Depth of Field: On<o:p></o:p></p>
            <p>Motion Blur: On<o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
          <p>I hope this helps.<o:p></o:p></p>
          <p>Yanik Yiannakis<o:p></o:p></p>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------85638EB5C2B8B837063CE18B--

--===============2035051631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2035051631==--
