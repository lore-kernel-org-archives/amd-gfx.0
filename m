From: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Subject: RE: Shared semaphores for amdgpu
Date: Thu, 5 Jan 2017 04:13:38 +0000
Message-ID: <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890408045=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <544E607D03B20249AA404517E498FC469A558B-Lp/cVzEoVyaisxZYEgh0i620KmCxYQEWVpNB7YpNyf8@public.gmane.org>
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
To: Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

--===============0890408045==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN4PR12MB0787AE3A185BE4D6916CE42AEE600BN4PR12MB0787namp_"

--_000_BN4PR12MB0787AE3A185BE4D6916CE42AEE600BN4PR12MB0787namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andres,
We have a local change made yesterday which eliminate the need to get unuse=
d fd in the creation time.
If everything goes well, I expect the change could be sent out for review n=
ext week.

Best Regards,
David

From: Andres Rodriguez [mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org]
Sent: Thursday, January 5, 2017 12:10 PM
To: Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; Mao, David <David.Mao@amd.=
com>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>; Dave Airlie <airlie=
d@redhat.com>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Shared semaphores for amdgpu

Hey guys,

Just curious if there are any updates on the topic of shared semaphores for=
 amdgpu discussed here:
https://lists.freedesktop.org/archives/amd-gfx/2016-December/003777.html

I wasn't subscribed to amd-gfx yet when the topic started, so replying to i=
t directly is cumbersome.

Regards,
Andres

--_000_BN4PR12MB0787AE3A185BE4D6916CE42AEE600BN4PR12MB0787namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
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
	font-family:"Times New Roman",serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Hi Andres,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">We have a local change made yesterday=
 which eliminate the need to get unused fd in the creation time.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">If everything goes well, I expect the=
 change could be sent out for review next week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Best Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">David<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Andres Rodriguez [mailto:andre=
sr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org]
<br>
<b>Sent:</b> Thursday, January 5, 2017 12:10 PM<br>
<b>To:</b> Zhou, David(ChunMing) &lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;; Mao, David &l=
t;David.Mao-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
<b>Cc:</b> Pierre-Loup Griffais &lt;pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org&gt;; Dave A=
irlie &lt;airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Shared semaphores for amdgpu<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,sans-serif;color:black">Hey guys,<br>
<br>
Just curious if there are any updates on the topic of shared semaphores for=
 amdgpu discussed here:<br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2016-December/003=
777.html" target=3D"_blank">https://lists.freedesktop.org/archives/amd-gfx/=
2016-December/003777.html</a><br>
<br>
I wasn't subscribed to amd-gfx yet when the topic started, so replying to i=
t directly is cumbersome.<br>
<br>
Regards,<br>
Andres<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_BN4PR12MB0787AE3A185BE4D6916CE42AEE600BN4PR12MB0787namp_--

--===============0890408045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0890408045==--
