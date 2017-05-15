From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add missing extern "C" headers
Date: Mon, 15 May 2017 02:39:59 +0000
Message-ID: <MWHPR1201MB00458FBE22404D8AF12A043EF2E10@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <MWHPR1201MB0045E9D90A0D03FCCFBF7BC1F2E10@MWHPR1201MB0045.namprd12.prod.outlook.com>,
 <5a6edb32-1899-697c-156b-ddeaeaa67147@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0989257094=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5a6edb32-1899-697c-156b-ddeaeaa67147-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0989257094==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB00458FBE22404D8AF12A043EF2E10MWHPR1201MB0045_"

--_000_MWHPR1201MB00458FBE22404D8AF12A043EF2E10MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Michel,


This patch was from Nicolai.


Though there are two amdgpu.h, one header is in kernel and the other header=
 is in libdrm. But their content are irrelevant. They are not synchronized.


I think include/drm/README is not applicable to this case.


Thanks,

Alex Bin Xie

________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Sunday, May 14, 2017 10:09 PM
To: Xie, AlexBin; Haehnle, Nicolai
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH libdrm] amdgpu: add missing extern "C" headers

On 15/05/17 10:10 AM, Xie, AlexBin wrote:
>  amdgpu/amdgpu.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

This header is synchronized with the kernel, see include/drm/README.


BTW, don't send patches for review as HTML. Ideally use git send-email.


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--_000_MWHPR1201MB00458FBE22404D8AF12A043EF2E10MWHPR1201MB0045_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Michel,</p>
<p><br>
</p>
<p>This patch was from Nicolai.</p>
<p><br>
</p>
<p>Though there are two amdgpu.h, one header is in kernel and the other hea=
der is in libdrm. But their content are irrelevant. They are not synchroniz=
ed.
<br>
</p>
<p><br>
</p>
<p>I think include/drm/README is not applicable to this case.<br>
</p>
<br>
<p>Thanks,</p>
<p>Alex Bin Xie<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Michel D=E4nzer &lt=
;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
<b>Sent:</b> Sunday, May 14, 2017 10:09 PM<br>
<b>To:</b> Xie, AlexBin; Haehnle, Nicolai<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH libdrm] amdgpu: add missing extern &quot;C&quot;=
 headers</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 15/05/17 10:10 AM, Xie, AlexBin wrote:<br>
&gt;&nbsp; amdgpu/amdgpu.h | 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 8 insertions(&#43;)<br>
<br>
This header is synchronized with the kernel, see include/drm/README.<br>
<br>
<br>
BTW, don't send patches for review as HTML. Ideally use git send-email.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
" id=3D"LPlnk7787" previewremoved=3D"true">
http://www.amd.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB00458FBE22404D8AF12A043EF2E10MWHPR1201MB0045_--

--===============0989257094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0989257094==--
