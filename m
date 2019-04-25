From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: value of amdgpu_sriov_vf cannot be set into
 F32_POLL_ENABLE
Date: Thu, 25 Apr 2019 14:28:52 +0000
Message-ID: <BN6PR12MB18099AEDBAC97CB63552E025F73D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1556167841-26122-1-git-send-email-Wentao.Lou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0115066688=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1556167841-26122-1-git-send-email-Wentao.Lou-5C7GfCeVMHo@public.gmane.org>
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
To: "Lou, Wentao" <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0115066688==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18099AEDBAC97CB63552E025F73D0BN6PR12MB1809namp_"

--_000_BN6PR12MB18099AEDBAC97CB63552E025F73D0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Please fix up your mail client or git config so your email address matches =
your signed off line.  E.g.,
wentalou <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>
vs.
Wentao Lou <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>

Thanks,

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of wentalou=
 <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, April 25, 2019 12:50 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Lou, Wentao
Subject: [PATCH] drm/amdgpu: value of amdgpu_sriov_vf cannot be set into F3=
2_POLL_ENABLE

amdgpu_sriov_vf would return 0x0 or 0x4 to indicate if sriov.
but F32_POLL_ENABLE need 0x0 or 0x1 to determine if enabled.
set 0x4 into F32_POLL_ENABLE would make SDMA0_GFX_RB_WPTR_POLL_CNTL not wor=
king.

Change-Id: I7d13ed35469ebd7bdf10c90341181977c6cfd38d
Signed-off-by: Wentao Lou <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 1ec60f5..1be85b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -851,7 +851,7 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_device *=
adev, unsigned int i)
         wptr_poll_cntl =3D RREG32_SDMA(i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL);
         wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl,
                                        SDMA0_GFX_RB_WPTR_POLL_CNTL,
-                                      F32_POLL_ENABLE, amdgpu_sriov_vf(ade=
v));
+                                      F32_POLL_ENABLE, amdgpu_sriov_vf(ade=
v)? 1 : 0);
         WREG32_SDMA(i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL, wptr_poll_cntl);

         /* enable DMA RB */
@@ -942,7 +942,7 @@ static void sdma_v4_0_page_resume(struct amdgpu_device =
*adev, unsigned int i)
         wptr_poll_cntl =3D RREG32_SDMA(i, mmSDMA0_PAGE_RB_WPTR_POLL_CNTL);
         wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl,
                                        SDMA0_PAGE_RB_WPTR_POLL_CNTL,
-                                      F32_POLL_ENABLE, amdgpu_sriov_vf(ade=
v));
+                                      F32_POLL_ENABLE, amdgpu_sriov_vf(ade=
v)? 1 : 0);
         WREG32_SDMA(i, mmSDMA0_PAGE_RB_WPTR_POLL_CNTL, wptr_poll_cntl);

         /* enable DMA RB */
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18099AEDBAC97CB63552E025F73D0BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please fix up your mail client or git config so your email address matches =
your signed off line.&nbsp; E.g.,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
wentalou &lt;Wentao.Lou-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
vs.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Wentao Lou &lt;Wentao.Lou@a=
md.com&gt;</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of wentalou &lt;Wentao.Lou@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, April 25, 2019 12:50 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Lou, Wentao<br>
<b>Subject:</b> [PATCH] drm/amdgpu: value of amdgpu_sriov_vf cannot be set =
into F32_POLL_ENABLE</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">amdgpu_sriov_vf would return 0x0 or 0x4 to indicat=
e if sriov.<br>
but F32_POLL_ENABLE need 0x0 or 0x1 to determine if enabled.<br>
set 0x4 into F32_POLL_ENABLE would make SDMA0_GFX_RB_WPTR_POLL_CNTL not wor=
king.<br>
<br>
Change-Id: I7d13ed35469ebd7bdf10c90341181977c6cfd38d<br>
Signed-off-by: Wentao Lou &lt;Wentao.Lou-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 &#43;&#43;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 1ec60f5..1be85b7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -851,7 &#43;851,7 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_devi=
ce *adev, unsigned int i)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_poll_cntl =3D RREG32_=
SDMA(i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_poll_cntl =3D REG_SET=
_FIELD(wptr_poll_cntl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; SDMA0_GFX_RB_WPTR_POLL_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F=
32_POLL_ENABLE, amdgpu_sriov_vf(adev));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; F32_POLL_ENABLE, amdgpu_sriov_vf(adev)? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SDMA(i, mmSDMA0_GFX=
_RB_WPTR_POLL_CNTL, wptr_poll_cntl);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable DMA RB */<br>
@@ -942,7 &#43;942,7 @@ static void sdma_v4_0_page_resume(struct amdgpu_dev=
ice *adev, unsigned int i)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_poll_cntl =3D RREG32_=
SDMA(i, mmSDMA0_PAGE_RB_WPTR_POLL_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_poll_cntl =3D REG_SET=
_FIELD(wptr_poll_cntl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; SDMA0_PAGE_RB_WPTR_POLL_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F=
32_POLL_ENABLE, amdgpu_sriov_vf(adev));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; F32_POLL_ENABLE, amdgpu_sriov_vf(adev)? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SDMA(i, mmSDMA0_PAG=
E_RB_WPTR_POLL_CNTL, wptr_poll_cntl);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable DMA RB */<br>
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

--_000_BN6PR12MB18099AEDBAC97CB63552E025F73D0BN6PR12MB1809namp_--

--===============0115066688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0115066688==--
