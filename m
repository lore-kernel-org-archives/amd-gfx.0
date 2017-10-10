From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Regression: Crash/freeze when resuming from suspend or locked
 screen
Date: Tue, 10 Oct 2017 15:01:56 +0000
Message-ID: <CY4PR12MB168768E4CC5B9BBD98611FB6FB750@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <mailman.10603.1507217137.1832.amd-gfx@lists.freedesktop.org>
 <1507308193.2877.4.camel@online.de>
 <624136700.113676.1507618522363@mailxchange.de>,
 <CY4PR12MB16533EE2F12BC8E8BF9BD4EFF7750@CY4PR12MB1653.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1254659199=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16533EE2F12BC8E8BF9BD4EFF7750-rpdhrqHFk06apTa93KjAaQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, 'Martin Babutzka' <martin.babutzka-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1254659199==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168768E4CC5B9BBD98611FB6FB750CY4PR12MB1687namp_"

--_000_CY4PR12MB168768E4CC5B9BBD98611FB6FB750CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Can you try to reproduce this issue with amdgpu.dc=3D0 when modprobe amdgpu

Best Regards
Rex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, October 10, 2017 10:41:29 PM
To: 'Martin Babutzka'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: Regression: Crash/freeze when resuming from suspend or locked =
screen

We haven't had a chance to look into it yet.

Alex

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of M=
artin Babutzka
Sent: Tuesday, October 10, 2017 2:55 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Fwd: Regression: Crash/freeze when resuming from suspend or locked=
 screen


Dear AMD developers,

Are there no comments/questions on this issue or did the mail just got lost=
 in between the flood of patches?

Many regards,
Martin



---------- Urspr=FCngliche Nachricht ----------
Von: Martin Babutzka <martin.babutzka-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org<mailto:martin.babutzka@onli=
ne.de>>
An: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Datum: 6. Oktober 2017 um 18:43
Betreff: Regression: Crash/freeze when resuming from suspend or locked scre=
en

Hello there,

Sorry it is me again with another regression. I just built the latest
amd-staging-drm-next and the issue which was already reported here:
https://github.com/M-Bab/linux-kernel-amdgpu-binaries/issues/29
and which I can confirm is still existing.

The issue is caused occasionally when re-enabling the display from
either suspend or from a locked screen. The frozen image can be black,
a weird colorful pattern or the login screen. Attached you can find the
kernel crash+trace error I just caught.

So far I have no idea when it was exactly introduced. I asked the other
users if they are able to give me a time range I will try to bisect it.

My setup: Xubuntu 17.04, patched amd-staging-drm-next kernel, R9 380

Many regards,
Martin

--_000_CY4PR12MB168768E4CC5B9BBD98611FB6FB750CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
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
Hi Martin,<br>
<br>
Can you try to reproduce this issue with amdgpu.dc=3D0 when modprobe amdgpu=
<br>
<br>
Best Regards<br>
Rex
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 10, 2017 10:41:29 PM<br>
<b>To:</b> 'Martin Babutzka'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: Regression: Crash/freeze when resuming from suspend or =
locked screen</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">We haven't had a chance t=
o look into it yet.<o:p></o:p></span></p>
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
<b>On Behalf Of </b>Martin Babutzka<br>
<b>Sent:</b> Tuesday, October 10, 2017 2:55 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Fwd: Regression: Crash/freeze when resuming from suspend or=
 locked screen<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p>Dear AMD developers,<br>
<br>
Are there no comments/questions on this issue or did the mail just got lost=
 in between the flood of patches?<br>
<br>
Many regards,<br>
Martin<o:p></o:p></p>
<p><o:p>&nbsp;</o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p>---------- Urspr=FCngliche Nachricht ----------<br>
Von: Martin Babutzka &lt;<a href=3D"mailto:martin.babutzka-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org">marti=
n.babutzka-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org</a>&gt;<br>
An: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Datum: 6. Oktober 2017 um 18:43<br>
Betreff: Regression: Crash/freeze when resuming from suspend or locked scre=
en<o:p></o:p></p>
<p>Hello there,<o:p></o:p></p>
<p>Sorry it is me again with another regression. I just built the latest<br=
>
amd-staging-drm-next and the issue which was already reported here:<br>
<a href=3D"https://github.com/M-Bab/linux-kernel-amdgpu-binaries/issues/29"=
>https://github.com/M-Bab/linux-kernel-amdgpu-binaries/issues/29</a><br>
and which I can confirm is still existing.<o:p></o:p></p>
<p>The issue is caused occasionally when re-enabling the display from<br>
either suspend or from a locked screen. The frozen image can be black,<br>
a weird colorful pattern or the login screen. Attached you can find the<br>
kernel crash&#43;trace error I just caught.<o:p></o:p></p>
<p>So far I have no idea when it was exactly introduced. I asked the other<=
br>
users if they are able to give me a time range I will try to bisect it.<o:p=
></o:p></p>
<p>My setup: Xubuntu 17.04, patched amd-staging-drm-next kernel, R9 380<o:p=
></o:p></p>
<p>Many regards,<br>
Martin<o:p></o:p></p>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB168768E4CC5B9BBD98611FB6FB750CY4PR12MB1687namp_--

--===============1254659199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1254659199==--
