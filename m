From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: Adjusting memory speed according to display
Date: Fri, 12 Aug 2016 14:08:35 +0000
Message-ID: <MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <DB3PR08MB0281EA56C2099894FA675529E91F0@DB3PR08MB0281.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0924262339=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DB3PR08MB0281EA56C2099894FA675529E91F0-aD6Q2MAZY6U/irYQV7fBLikoKrxaZxrJvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: 'Jarkko Korpi' <jarkko_korpi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0924262339==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0MWHPR12MB1694namp_"

--_000_MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0MWHPR12MB1694namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0MWHPR12MB1694namp_
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
<style><!--
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
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
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">You have to set up the di=
splay to send audio data over HDMI.&nbsp; The audio is embedded in the stre=
am.&nbsp; You have to set up the video stream to use audio.&nbsp; You need
 to raise the memory clocks to provide the necessary bandwidth for multiple=
 display and dynamic mclk switching is not supported with multiple displays=
 enabled because the switches are done during the vertical blanking period.=
&nbsp; If you have multiple displays
 with different timing, the blanking periods do not match so glitch free sw=
itching is not possible.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">If you want more control,=
 you can use the sysfs files to either manually force the clocks low or hig=
h or manually&nbsp; enable only specific clock levels for sclk
 and mclk.<o:p></o:p></span></p>
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
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>Jarkko Korpi<br>
<b>Sent:</b> Thursday, August 11, 2016 9:45 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Adjusting memory speed according to display<o:p></o:p></spa=
n></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
</body>
</html>

--_000_MWHPR12MB1694052EA89D3EC1DFD29E7EF71F0MWHPR12MB1694namp_--

--===============0924262339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0924262339==--
