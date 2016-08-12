From: Jarkko Korpi <jarkko_korpi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Adjusting memory speed according to display
Date: Fri, 12 Aug 2016 14:24:43 +0000
Message-ID: <AM3PR08MB0277EE673A9569D49FC86CC0E91F0@AM3PR08MB0277.eurprd08.prod.outlook.com>
References: <DB3PR08MB0281EA56C2099894FA675529E91F0@DB3PR08MB0281.eurprd08.prod.outlook.com>,
 <MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049872011=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1049872011==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM3PR08MB0277EE673A9569D49FC86CC0E91F0AM3PR08MB0277eurp_"

--_000_AM3PR08MB0277EE673A9569D49FC86CC0E91F0AM3PR08MB0277eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Can you give me correct command to manually set up clocks high or low? ARCH=
 based quides are usully really good, but not all the commands it suggests =
dont work. I get no permission errors. Most likely I am trying the wrong di=
rectory/gpu. I got intel skylake 6600K, which has integrated intel gpu.


It's hard to remember the exact locations of directories so I made myself a=
 script that prints the output of current clocks.


cat /sys/class/drm/card0/device/pp_dpm_sclk
cat /sys/class/drm/card0/device/pp_dpm_mclk
cat /sys/class/drm/card0/device/power_dpm_state


These lines work just fine. So I assume the ati is card0. It's also used vi=
a DP.


Also lowering the voltage or speed of memory would help a bit. But either o=
f these is manually adjustable?


________________________________
From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, August 12, 2016 2:08 PM
To: 'Jarkko Korpi'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: Adjusting memory speed according to display


You have to set up the display to send audio data over HDMI.  The audio is =
embedded in the stream.  You have to set up the video stream to use audio. =
 You need to raise the memory clocks to provide the necessary bandwidth for=
 multiple display and dynamic mclk switching is not supported with multiple=
 displays enabled because the switches are done during the vertical blankin=
g period.  If you have multiple displays with different timing, the blankin=
g periods do not match so glitch free switching is not possible.



If you want more control, you can use the sysfs files to either manually fo=
rce the clocks low or high or manually  enable only specific clock levels f=
or sclk and mclk.



Alex



From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of J=
arkko Korpi
Sent: Thursday, August 11, 2016 9:45 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Adjusting memory speed according to display



I have rx480 which I connect into 1920x1080 pc screen via DP and audio into=
 external amplifier via HDMI. This causes rx480 to raise the memory speed t=
o 2000 while doing really simple tasks like watching youtube. I really dont=
 need thatkind of speed for memory. And I am not aware that it's possible t=
o change between 300mhz 2000mhz memory speeds, but gpu supports this in ste=
ps which would be really great for memory too. I only need the audio data s=
ubmited to the amplifier. Is it possible somehow to form a patch that it so=
mehow recognizes my amplifier and understands that I am sending audio that =
I dont need/want it to max the memory speed? I would be really happy for su=
ch patch for personal use. If it's too hacky to be merged into upstream.

--_000_AM3PR08MB0277EE673A9569D49FC86CC0E91F0AM3PR08MB0277eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Can you give me correct command to manually set up clocks high or low? A=
RCH based quides are usully really good, but not all the commands it sugges=
ts dont work. I get no permission errors. Most likely I am trying the wrong=
 directory/gpu. I got intel skylake
 6600K, which has integrated intel gpu. <br>
</p>
<p><br>
</p>
<p>It's hard to remember the exact locations of directories so I made mysel=
f a script that prints the output of current clocks.<br>
</p>
<p><br>
</p>
<div>cat /sys/class/drm/card0/device/pp_dpm_sclk<br>
cat /sys/class/drm/card0/device/pp_dpm_mclk<br>
cat /sys/class/drm/card0/device/power_dpm_state <br>
</div>
<br>
<p>These lines work just fine. So I assume the ati is card0. It's also used=
 via DP.
<br>
</p>
<p><br>
</p>
<p>Also lowering the voltage or speed of memory would help a bit.&nbsp;But =
either of these is manually adjustable?<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Deucher, Alexander =
&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, August 12, 2016 2:08 PM<br>
<b>To:</b> 'Jarkko Korpi'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: Adjusting memory speed according to display</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">You have to set up the display to send audio d=
ata over HDMI.&nbsp; The audio is embedded in the stream.&nbsp; You have to=
 set up the video stream to use audio.&nbsp; You need to raise the memory
 clocks to provide the necessary bandwidth for multiple display and dynamic=
 mclk switching is not supported with multiple displays enabled because the=
 switches are done during the vertical blanking period.&nbsp; If you have m=
ultiple displays with different timing,
 the blanking periods do not match so glitch free switching is not possible=
.</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">If you want more control, you can use the sysf=
s files to either manually force the clocks low or high or manually&nbsp; e=
nable only specific clock levels for sclk and mclk.</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">Alex</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
<b><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt; font-famil=
y:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx [mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>Jarkko Korpi<br>
<b>Sent:</b> Thursday, August 11, 2016 9:45 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Adjusting memory speed according to display</span></p>
</div>
</div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;,&quot;serif&quot;;">
&nbsp;</p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">I have rx480 which I connect into 19=
20x1080 pc screen via DP and audio into external amplifier via HDMI. This c=
auses rx480 to raise the memory speed to 2000 while doing
 really simple tasks like watching youtube. I really dont need thatkind of =
speed for memory. And I am not aware that it's possible to change between 3=
00mhz 2000mhz memory speeds, but gpu supports this in steps which would be =
really great for memory too. I only
 need the audio data submited to the amplifier. Is it possible somehow to f=
orm a patch that it somehow recognizes my amplifier and understands that I =
am sending audio that I dont need/want it to max the memory speed? I would =
be really happy for such patch for
 personal use. If it's too hacky to be merged into upstream.</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_AM3PR08MB0277EE673A9569D49FC86CC0E91F0AM3PR08MB0277eurp_--

--===============1049872011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1049872011==--
