From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: no job timeout setting on compute queues
Date: Mon, 19 Mar 2018 01:46:31 +0000
Message-ID: <DM5PR1201MB2489E0DEA55F61E4314CE1EEE4D40@DM5PR1201MB2489.namprd12.prod.outlook.com>
References: <1521175952-21758-1-git-send-email-evan.quan@amd.com>
 <CY4PR12MB1653E72F547ABAECAC0A91A3F7D70@CY4PR12MB1653.namprd12.prod.outlook.com>,
 <bc7b30b9-7230-fdfe-4fd1-0f4dcd26a38d@daenzer.net>
 <CY4PR12MB16535036642155291C39F030F7D70@CY4PR12MB1653.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1548731964=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16535036642155291C39F030F7D70-rpdhrqHFk06apTa93KjAaQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1548731964==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB2489E0DEA55F61E4314CE1EEE4D40DM5PR1201MB2489_"

--_000_DM5PR1201MB2489E0DEA55F61E4314CE1EEE4D40DM5PR1201MB2489_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

That's fine for me. Will update the patch accordingly.

Regards,
Evan
From: Deucher, Alexander
Sent: Saturday, March 17, 2018 1:17 AM
To: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: no job timeout setting on compute queues


How about something like this:

/* Disable timeout when GPU reset is disabled to avoid confusing timeout me=
ssages in the kernel log */

If (amdgpu_gpu_recovery =3D=3D 0 || amdgpu_gpu_recovery =3D=3D -1)

    amdgpu_lockup_timeout =3D MAX_SCHEDULE_TIMEOUT;



Alex

________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org<mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>>
Sent: Friday, March 16, 2018 12:25:03 PM
To: Deucher, Alexander; Quan, Evan
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: no job timeout setting on compute queues

On 2018-03-16 05:14 PM, Deucher, Alexander wrote:
> Since GPU reset is not enabled yet anyway, a timeout will just print a
> message, can we just change amdgpu_lockup_timeout to
> MAX_SCHEDULE_TIMEOUT until we enable GPU reset?

Wouldn't that be rather surprising for somebody who sets
amdgpu.gpu_recovery=3D1 ?


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--_000_DM5PR1201MB2489E0DEA55F61E4314CE1EEE4D40DM5PR1201MB2489_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">That&#8217;s fine for me. Will update the patch acco=
rdingly.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander <br>
<b>Sent:</b> Saturday, March 17, 2018 1:17 AM<br>
<b>To:</b> Michel D=E4nzer &lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;; Quan, Evan &lt;Evan.=
Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: no job timeout setting on compute q=
ueues<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">How about something like th=
is:<o:p></o:p></span></p>
<p><span style=3D"font-size:10.0pt;color:black">/* Disable timeout when GPU=
 reset is disabled to avoid confusing timeout messages in the kernel log */=
</span><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
<p><span style=3D"font-size:10.0pt;color:black">If (amdgpu_gpu_recovery =3D=
=3D 0 || amdgpu_gpu_recovery =3D=3D -1)
</span><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">&nbsp;&nbsp;&nbsp; </span><=
span style=3D"color:black">amdgpu_lockup_timeout</span><span style=3D"font-=
size:12.0pt;color:black"> =3D
</span><span style=3D"color:black">MAX_SCHEDULE_TIMEOUT;</span><span style=
=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
<p><span style=3D"color:black"><br>
<br>
</span><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
<p><span style=3D"color:black">Alex</span><span style=3D"font-size:12.0pt;c=
olor:black"><o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Michel D=E4nzer &lt;<a href=3D"mailto:michel@daenze=
r.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, March 16, 2018 12:25:03 PM<br>
<b>To:</b> Deucher, Alexander; Quan, Evan<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: no job timeout setting on compute q=
ueues</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On 2018-03-16 05:14 PM, Deucher, Alexander wrote:<br=
>
&gt; Since GPU reset is not enabled yet anyway, a timeout will just print a=
<br>
&gt; message, can we just change amdgpu_lockup_timeout to<br>
&gt; MAX_SCHEDULE_TIMEOUT until we enable GPU reset?<br>
<br>
Wouldn't that be rather surprising for somebody who sets<br>
amdgpu.gpu_recovery=3D1 ?<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
">
http://www.amd.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR1201MB2489E0DEA55F61E4314CE1EEE4D40DM5PR1201MB2489_--

--===============1548731964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1548731964==--
