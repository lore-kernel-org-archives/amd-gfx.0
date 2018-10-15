From: "Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development
 Dep)" <sunnanyong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: amd gpu hung with opensource driver
Date: Mon, 15 Oct 2018 09:50:46 +0000
Message-ID: <EB021AE3BDDC1742A899855D00BABEB0010BD220@dggemm526-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1241836242=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: zh-CN
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
To: "'amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org'" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1241836242==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_EB021AE3BDDC1742A899855D00BABEB0010BD220dggemm526mbxchi_"

--_000_EB021AE3BDDC1742A899855D00BABEB0010BD220dggemm526mbxchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
    When use amd radeon pro wx5100 with opensource driver(mesa17.2.8 , kern=
el v4.17, Ubuntu17.10), GPU hung happened:
     [260362.362835] amdgpu 0005:01:00.0: GPU fault detected: 146 0x02c0082=
c
[260362.369366] amdgpu 0005:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   =
0x00100058
[260362.377099] amdgpu 0005:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS =
0x0400802C
[260362.384781] amdgpu 0005:01:00.0: VM fault (0x2c, vmid 2, pasid 32792) a=
t page 1048664, read from 'TC0' (0x54433000) (8)
[260372.423402] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout=
, last signaled seq=3D132702874, last emitted seq=3D132702877
[260372.435267] [drm] IP block:gfx_v8_0 is hung!
[260372.435276] [drm] GPU recovery disabled.

It is happened accidentally when play games.
How to debug and solve this problem ?

Please help, Thanks : )

--_000_EB021AE3BDDC1742A899855D00BABEB0010BD220dggemm526mbxchi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
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
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Hi All,=
 <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;When use amd radeon pro wx5100 with opensource driver(mesa=
17.2.8 , kernel v4.17, Ubuntu17.10), GPU hung happened:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;[260362.362835] amdgpu 0005:01:00.0: GPU fault detec=
ted: 146 0x02c0082c<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.5pt"><span lang=3D"EN-US" st=
yle=3D"color:#1F497D">[260362.369366] amdgpu 0005:01:00.0:&nbsp;&nbsp; VM_C=
ONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x00100058<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.5pt"><span lang=3D"EN-US" st=
yle=3D"color:#1F497D">[260362.377099] amdgpu 0005:01:00.0:&nbsp;&nbsp; VM_C=
ONTEXT1_PROTECTION_FAULT_STATUS 0x0400802C<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:10.5pt;mso-para-margin-left:1.0=
gd"><span lang=3D"EN-US" style=3D"color:#1F497D">[260362.384781] amdgpu 000=
5:01:00.0: VM fault (0x2c, vmid 2, pasid 32792) at page 1048664, read from =
'TC0' (0x54433000) (8)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:10.5pt;mso-para-margin-left:1.0=
gd"><span lang=3D"EN-US" style=3D"color:#1F497D">[260372.423402] [drm:amdgp=
u_job_timedout [amdgpu]] *ERROR* ring gfx timeout, last signaled seq=3D1327=
02874, last emitted seq=3D132702877<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:10.5pt;mso-para-margin-left:1.0=
gd"><span lang=3D"EN-US" style=3D"color:#1F497D">[260372.435267] [drm] IP b=
lock:gfx_v8_0 is hung!<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:10.5pt;mso-para-margin-left:1.0=
gd"><span lang=3D"EN-US" style=3D"color:#1F497D">[260372.435276] [drm] GPU =
recovery disabled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">It is h=
appened accidentally when play games.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">How to =
debug and solve this problem ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Please =
help, Thanks : )<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_EB021AE3BDDC1742A899855D00BABEB0010BD220dggemm526mbxchi_--

--===============1241836242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1241836242==--
