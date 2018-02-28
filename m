From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: weird reservation issues
Date: Wed, 28 Feb 2018 10:37:22 +0000
Message-ID: <BLUPR12MB044995B6521FBE9C389BBE7184C70@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0380860175=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0380860175==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB044995B6521FBE9C389BBE7184C70BLUPR12MB0449namp_"

--_000_BLUPR12MB044995B6521FBE9C389BBE7184C70BLUPR12MB0449namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Christian

In amdgpu_cs_parser_bos(), it calls ttm_eu_backoff_reservation() if @need_p=
ages not empty, is it safe ?

You see that if two threads in parallel running in cs_parser_bos(), if the =
thread1 did call backoff_reservation and continue, that leaves
All following reservation functions on root BO executed without protection =
from the lock, Meanwhile if this time thread2 call cs_parser_bos() in paral=
lel, it can
Get the lock of the reservation object on root BO (assume thread 1/2 share =
the same VM) immediately, so both of those threads consider they are
Under protection of lock of reservation on the root bo. Do you think it's a=
 race issue ?

You know that I recently hit BUG() in reservation.c, and also found some we=
ird bugs can be fixed by removing the kfree(obj->staged)
In reservation_object_reserve_shared(), and I think you right on the "stage=
d" part that it shouldn't be freed if everything go with rules (
Always held the lock of the bo)


Thanks
/Monk


--_000_BLUPR12MB044995B6521FBE9C389BBE7184C70BLUPR12MB0449namp_
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
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
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Christian <o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">In amdgpu_cs_parser_bos(), it c=
alls ttm_eu_backoff_reservation() if @need_pages not empty, is it safe ?<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">You see that if two threads in =
parallel running in cs_parser_bos(), if the thread1 did call backoff_reserv=
ation and continue, that leaves
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">All following reservation funct=
ions on root BO executed without protection from the lock, Meanwhile if thi=
s time thread2 call cs_parser_bos() in parallel, it can
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Get the lock of the reservation=
 object on root BO (assume thread 1/2 share the same VM) immediately, so bo=
th of those threads consider they are
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Under protection of lock of res=
ervation on the root bo. Do you think it&#8217;s a race issue ?<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">You know that I recently hit BU=
G() in reservation.c, and also found some weird bugs can be fixed by removi=
ng the kfree(obj-&gt;staged)
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">In reservation_object_reserve_s=
hared(), and I think you right on the &#8220;staged&#8221; part that it sho=
uldn&#8217;t be freed if everything go with rules (<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Always held the lock of the bo)=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/Monk<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_BLUPR12MB044995B6521FBE9C389BBE7184C70BLUPR12MB0449namp_--

--===============0380860175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0380860175==--
