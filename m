From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Add DMCU fw loading on raven
Date: Wed, 12 Sep 2018 15:56:23 +0000
Message-ID: <BN6PR12MB18095CB6ED07F76744297789F71B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180912143445.10610-1-David.Francis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1657296800=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180912143445.10610-1-David.Francis-5C7GfCeVMHo@public.gmane.org>
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
To: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1657296800==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18095CB6ED07F76744297789F71B0BN6PR12MB1809namp_"

--_000_BN6PR12MB18095CB6ED07F76744297789F71B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of David Fr=
ancis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 12, 2018 10:34:42 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Francis, David
Subject: [PATCH v2 0/3] Add DMCU fw loading on raven

v2: measure intv offset in bytes instead of words

David Francis (3):
  drm/amd: Add ucode DMCU support
  drm/amd: Add PSP DMCU support
  drm/amd: Add DM DMCU support

 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 21 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     | 10 ++
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  6 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 91 ++++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
 5 files changed, 127 insertions(+), 3 deletions(-)

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18095CB6ED07F76744297789F71B0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of David Francis &lt;David.Franc=
is-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, September 12, 2018 10:34:42 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Francis, David<br>
<b>Subject:</b> [PATCH v2 0/3] Add DMCU fw loading on raven</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">v2: measure intv offset in bytes instead of words<=
br>
<br>
David Francis (3):<br>
&nbsp; drm/amd: Add ucode DMCU support<br>
&nbsp; drm/amd: Add PSP DMCU support<br>
&nbsp; drm/amd: Add DM DMCU support<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c&nbsp;&nbsp;&nbsp;&nbsp; | 2=
1 &#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h&nbsp;&nbsp;&nbsp;&nbsp; | 1=
0 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 &#43;&#43;<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 91 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<b=
r>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp; 2 &#43;<br>
&nbsp;5 files changed, 127 insertions(&#43;), 3 deletions(-)<br>
<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18095CB6ED07F76744297789F71B0BN6PR12MB1809namp_--

--===============1657296800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1657296800==--
