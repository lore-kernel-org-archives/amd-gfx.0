From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: Adjusting memory speed according to display
Date: Fri, 12 Aug 2016 16:34:53 +0000
Message-ID: <MWHPR12MB1694F898CF87A32C5D448769F71F0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <DB3PR08MB0281EA56C2099894FA675529E91F0@DB3PR08MB0281.eurprd08.prod.outlook.com>,
 <MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0@MWHPR12MB1694.namprd12.prod.outlook.com>
 <AM3PR08MB0277EE673A9569D49FC86CC0E91F0@AM3PR08MB0277.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0190309172=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <AM3PR08MB0277EE673A9569D49FC86CC0E91F0-tWJG53+nB0BVys3uQg+TMSkoKrxaZxrJvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: 'Jarkko Korpi' <jarkko_korpi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0190309172==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1694F898CF87A32C5D448769F71F0MWHPR12MB1694namp_"

--_000_MWHPR12MB1694F898CF87A32C5D448769F71F0MWHPR12MB1694namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You have to be root to make changes to the sysfs files.  To force the clock=
s low or high or auto (dynamically adjust based on load) or manual (select =
individual clock levels):

echo XXX > /sys/class/drm/card0/device/power_dpm_force_performance_level
where XXX is low or high or auto or manual

To manually select clock levels from the available clocks use the pp_dpm_sc=
lk and mclk files.  Read the files back to get the current setting.  First =
select manual using the above command, then select the clock levels to enab=
le.  E.g.,

echo 4 > /sys/class/drm/card0/device/pp_dpm_sclk

Will manually select the 4th clock level for sclk.

Alex

From: Jarkko Korpi [mailto:jarkko_korpi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org]
Sent: Friday, August 12, 2016 10:25 AM
To: Deucher, Alexander
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: Adjusting memory speed according to display


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
From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Friday, August 12, 2016 2:08 PM
To: 'Jarkko Korpi'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

--_000_MWHPR12MB1694F898CF87A32C5D448769F71F0MWHPR12MB1694namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">You have to be root to ma=
ke changes to the sysfs files.&nbsp; To force the clocks low or high or aut=
o (dynamically adjust based on load) or manual (select individual
 clock levels):<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">echo XXX &gt; /sys/class/=
drm/card0/device/power_dpm_force_performance_level<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">where XXX is low or high =
or auto or manual<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">To manually select clock =
levels from the available clocks use the pp_dpm_sclk and mclk files.&nbsp; =
Read the files back to get the current setting.&nbsp; First select
 manual using the above command, then select the clock levels to enable.&nb=
sp; E.g.,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">echo 4 &gt; /sys/class/dr=
m/card0/device/pp_dpm_sclk<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Will manually select the =
4<sup>th</sup> clock level for sclk.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Jarkko K=
orpi [mailto:jarkko_korpi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org]
<br>
<b>Sent:</b> Friday, August 12, 2016 10:25 AM<br>
<b>To:</b> Deucher, Alexander<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: Adjusting memory speed according to display<o:p></o:p><=
/span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Can you give me correct command to ma=
nually set up clocks high or low? ARCH based quides are usully really good,=
 but not all the commands it suggests dont work. I get no
 permission errors. Most likely I am trying the wrong directory/gpu. I got =
intel skylake 6600K, which has integrated intel gpu.
<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">It's hard to remember the exact locat=
ions of directories so I made myself a script that prints the output of cur=
rent clocks.<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">cat /sys/class/dr=
m/card0/device/pp_dpm_sclk<br>
cat /sys/class/drm/card0/device/pp_dpm_mclk<br>
cat /sys/class/drm/card0/device/power_dpm_state <o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p>=
</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">These lines work just fine. So I assu=
me the ati is card0. It's also used via DP.
<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Also lowering the voltage or speed of=
 memory would help a bit.&nbsp;But either of these is manually adjustable?<=
o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white"><spa=
n style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><o:p>&nbsp;</o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color=
:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">From:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,&quot;sans-serif&quot;;color:black"> Deucher, Alexander &lt;<a href=
=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, August 12, 2016 2:08 PM<br>
<b>To:</b> 'Jarkko Korpi'; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"=
>amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> RE: Adjusting memory speed according to display</span><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p>=
</span></p>
</div>
</div>
<div>
<div>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">You have to set up=
 the display to send audio data over HDMI.&nbsp; The audio is embedded in t=
he stream.&nbsp; You have to set up the video stream to use audio.&nbsp;
 You need to raise the memory clocks to provide the necessary bandwidth for=
 multiple display and dynamic mclk switching is not supported with multiple=
 displays enabled because the switches are done during the vertical blankin=
g period.&nbsp; If you have multiple
 displays with different timing, the blanking periods do not match so glitc=
h free switching is not possible.</span><span style=3D"color:black"><o:p></=
o:p></span></p>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;</span><span=
 style=3D"color:black"><o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">If you want more c=
ontrol, you can use the sysfs files to either manually force the clocks low=
 or high or manually&nbsp; enable only specific clock levels
 for sclk and mclk.</span><span style=3D"color:black"><o:p></o:p></span></p=
>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;</span><span=
 style=3D"color:black"><o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex</span><span s=
tyle=3D"color:black"><o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;</span><span=
 style=3D"color:black"><o:p></o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p style=3D"background:white"><b><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><s=
pan style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-ser=
if&quot;;color:black"> amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
<b>On Behalf Of </b>Jarkko Korpi<br>
<b>Sent:</b> Thursday, August 11, 2016 9:45 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> Adjusting memory speed according to display</span><span sty=
le=3D"color:black"><o:p></o:p></span></p>
</div>
</div>
<p style=3D"background:white"><span style=3D"color:black">&nbsp;<o:p></o:p>=
</span></p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">I have rx480 which I connect into 192=
0x1080 pc screen via DP and audio into external amplifier via HDMI. This ca=
uses rx480 to raise the memory speed to 2000 while doing
 really simple tasks like watching youtube. I really dont need thatkind of =
speed for memory. And I am not aware that it's possible to change between 3=
00mhz 2000mhz memory speeds, but gpu supports this in steps which would be =
really great for memory too. I only
 need the audio data submited to the amplifier. Is it possible somehow to f=
orm a patch that it somehow recognizes my amplifier and understands that I =
am sending audio that I dont need/want it to max the memory speed? I would =
be really happy for such patch for
 personal use. If it's too hacky to be merged into upstream.<o:p></o:p></sp=
an></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB1694F898CF87A32C5D448769F71F0MWHPR12MB1694namp_--

--===============0190309172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0190309172==--
