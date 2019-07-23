From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 0/2] This series enables S/G for Picasso.
Date: Tue, 23 Jul 2019 20:34:31 +0000
Message-ID: <BN6PR12MB180920487D95300E617D9A75F7C70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1563906335-12949-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0120053067=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1563906335-12949-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

--===============0120053067==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180920487D95300E617D9A75F7C70BN6PR12MB1809namp_"

--_000_BN6PR12MB180920487D95300E617D9A75F7C70BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is: Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Andrey G=
rodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, July 23, 2019 2:25 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Grodzovsky, Andrey <And=
rey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>; Wu, Hersen <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>; Koenig, Christia=
n <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 0/2] This series enables S/G for Picasso.

First patch fix a hard hang introduced by placing the display
BO in GTT memory because of HW issues with cached mappings
and the second patch enables S/G.

Andrey Grodzovsky (1):
  drm/amdgpu: Fix hard hang for S/G display BOs.

Shirish S (1):
  drm/amd: enable S/G for RAVEN chip

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c            |  7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c           |  3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 4 files changed, 17 insertions(+), 8 deletions(-)

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180920487D95300E617D9A75F7C70BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is: Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Andrey Grodzovsky &lt;andrey.=
grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, July 23, 2019 2:25 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Grodzovsky=
, Andrey &lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;; Wu, Hersen &lt;hersenxs.wu@amd.=
com&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; S, Shirish &lt=
;Shirish.S-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH v2 0/2] This series enables S/G for Picasso.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">First patch fix a hard hang introduced by placing =
the display<br>
BO in GTT memory because of HW issues with cached mappings<br>
and the second patch enables S/G.<br>
<br>
Andrey Grodzovsky (1):<br>
&nbsp; drm/amdgpu: Fix hard hang for S/G display BOs.<br>
<br>
Shirish S (1):<br>
&nbsp; drm/amd: enable S/G for RAVEN chip<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 13 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 &#43;&#43;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |&nbsp; 2 &#43;-<br=
>
&nbsp;4 files changed, 17 insertions(&#43;), 8 deletions(-)<br>
<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180920487D95300E617D9A75F7C70BN6PR12MB1809namp_--

--===============0120053067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0120053067==--
