From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/9] PSP cleanup
Date: Wed, 2 Jan 2019 10:21:03 +0000
Message-ID: <BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0@BYAPR12MB2632.namprd12.prod.outlook.com>
References: <20190102092141.2196-1-evan.quan@amd.com>,
 <070000a9-9abf-1c23-9294-03e8ff6041dd@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0366120928=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <070000a9-9abf-1c23-9294-03e8ff6041dd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Xu,
 Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============0366120928==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0BYAPR12MB2632namp_"

--_000_BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0BYAPR12MB2632namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'd prefer to keep the old structures: common interfaces in amdgpu_psp.c/.h=
, and IP specific ones in IP specific file.


No matter it's something related to ASD,TMR, or XGMI.etc, all of these are =
just communication/handshake jobs between driver and psp fw. Driver plays m=
essenger role with several psp cmd that are shared among ASIC generations. =
a unified amdgpu_psp.c file is good enough to hold all the common stuffs.


Regards,
Hawking

________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, January 2, 2019 6:01:56 PM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Xu, Feifei; Huang, Ray; Zhang, Hawking
Subject: Re: [PATCH 0/9] PSP cleanup

The general idea looks good, but can we change the file and symbol
naming a bit?

So far we have named all non-ip version related functions amdgpu_* and
ip related functions ip_version.

E.g. following this xgmi functions should go into amdgpu_xgmi.c and not
psp_xgmi.c

Christian.

Am 02.01.19 um 10:21 schrieb Evan Quan:
> *** BLURB HERE ***
>
> Evan Quan (9):
>    drm/amdgpu: separate the PSP ring related APIs
>    drm/amdgpu: separate commonly used PSP APIs
>    drm/amdgpu: separate the xgmi related APIs
>    drm/amdgpu: separate the tmr related APIs
>    drm/amdgpu: separate the asd related APIs
>    drm/amdgpu: drop useless PSP APIs and structures
>    drm/amdgpu: check PSP support before adding the ip block
>    drm/amdgpu: make PSP sub modules(ASD/XGMI/TMR) support configurable
>    drm/amdgpu: move psp_funcs related to a more proper place
>
>   drivers/gpu/drm/amd/amdgpu/Makefile     |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 504 +++-------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  93 +---
>   drivers/gpu/drm/amd/amdgpu/psp_asd.c    |  86 ++++
>   drivers/gpu/drm/amd/amdgpu/psp_asd.h    |  32 ++
>   drivers/gpu/drm/amd/amdgpu/psp_cmn.c    | 289 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/psp_cmn.h    |  84 ++++
>   drivers/gpu/drm/amd/amdgpu/psp_funcs.h  |  98 +++++
>   drivers/gpu/drm/amd/amdgpu/psp_ring.c   | 354 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/psp_ring.h   |  43 ++
>   drivers/gpu/drm/amd/amdgpu/psp_tmr.c    |  84 ++++
>   drivers/gpu/drm/amd/amdgpu/psp_tmr.h    |  32 ++
>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 381 +----------------
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 539 +-----------------------
>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 480 +--------------------
>   drivers/gpu/drm/amd/amdgpu/psp_xgmi.c   | 207 +++++++++
>   drivers/gpu/drm/amd/amdgpu/psp_xgmi.h   |  33 ++
>   drivers/gpu/drm/amd/amdgpu/soc15.c      |  13 +-
>   18 files changed, 1493 insertions(+), 1866 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_asd.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_asd.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_cmn.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_cmn.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_funcs.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_ring.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_ring.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_tmr.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_tmr.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_xgmi.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_xgmi.h
>


--_000_BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0BYAPR12MB2632namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">I'd prefer to keep the ol=
d structures: common interfaces in amdgpu_psp.c/.h, and IP specific ones in=
 IP specific file.</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">No matter it's something&=
nbsp;related to ASD,TMR, or XGMI.etc, all of these are just communication/h=
andshake jobs between driver and psp fw. Driver plays messenger role with s=
everal psp cmd that are shared among ASIC
 generations. a unified amdgpu_psp.c file is good enough to hold all the co=
mmon stuffs.
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Regards,<br>
Hawking<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 2, 2019 6:01:56 PM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Xu, Feifei; Huang, Ray; Zhang, Hawking<br>
<b>Subject:</b> Re: [PATCH 0/9] PSP cleanup</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The general idea looks good, but can we change the=
 file and symbol
<br>
naming a bit?<br>
<br>
So far we have named all non-ip version related functions amdgpu_* and <br>
ip related functions ip_version.<br>
<br>
E.g. following this xgmi functions should go into amdgpu_xgmi.c and not <br=
>
psp_xgmi.c<br>
<br>
Christian.<br>
<br>
Am 02.01.19 um 10:21 schrieb Evan Quan:<br>
&gt; *** BLURB HERE ***<br>
&gt;<br>
&gt; Evan Quan (9):<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: separate the PSP ring related APIs<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: separate commonly used PSP APIs<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: separate the xgmi related APIs<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: separate the tmr related APIs<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: separate the asd related APIs<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: drop useless PSP APIs and structures<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: check PSP support before adding the ip b=
lock<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: make PSP sub modules(ASD/XGMI/TMR) suppo=
rt configurable<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: move psp_funcs related to a more proper =
place<br>
&gt;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 7 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 504 &#43;&#43;&#=
43;-------------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 93 &#43;--=
-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_asd.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 86 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_asd.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 32 &#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_cmn.c&nbsp;&nbsp;&nbsp; | 2=
89 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_cmn.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 84 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_funcs.h&nbsp; |&nbsp; 98 &#=
43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_ring.c&nbsp;&nbsp; | 354 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_ring.h&nbsp;&nbsp; |&nbsp; =
43 &#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_tmr.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 84 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_tmr.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 32 &#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp; | 381 &#43;--=
--------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp; | 539 &#43;--=
---------------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v3_1.c&nbsp;&nbsp; | 480 &#=
43;--------------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_xgmi.c&nbsp;&nbsp; | 207 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_xgmi.h&nbsp;&nbsp; |&nbsp; =
33 &#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 13 &#43;-<br>
&gt;&nbsp;&nbsp; 18 files changed, 1493 insertions(&#43;), 1866 deletions(-=
)<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_asd.c<br=
>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_asd.h<br=
>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_cmn.c<br=
>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_cmn.h<br=
>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_funcs.h<=
br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_ring.c<b=
r>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_ring.h<b=
r>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_tmr.c<br=
>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_tmr.h<br=
>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_xgmi.c<b=
r>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_xgmi.h<b=
r>
&gt;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0BYAPR12MB2632namp_--

--===============0366120928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0366120928==--
