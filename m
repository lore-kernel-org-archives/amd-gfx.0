From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sdma4:fix sdma engine hang
Date: Fri, 30 Mar 2018 12:55:12 +0000
Message-ID: <BN6PR12MB1809BFA58237B2C3C27FE1E3F7A10@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1522398248-9518-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2111556876=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1522398248-9518-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2111556876==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BFA58237B2C3C27FE1E3F7A10BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BFA58237B2C3C27FE1E3F7A10BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The spec claims it does and we use it for HDP flush...

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Emily De=
ng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, March 30, 2018 4:24:08 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deng, Emily
Subject: [PATCH] drm/amdgpu/sdma4:fix sdma engine hang

The sdma doesn't support register write and wait in one command.
Use this will make sdma engine hang.

Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 9ac28b2..84d148d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1178,13 +1178,6 @@ static void sdma_v4_0_ring_emit_reg_wait(struct amdg=
pu_ring *ring, uint32_t reg,
         sdma_v4_0_wait_reg_mem(ring, 0, 0, reg, 0, val, mask, 10);
 }

-static void sdma_v4_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *rin=
g,
-                                                  uint32_t reg0, uint32_t =
reg1,
-                                                  uint32_t ref, uint32_t m=
ask)
-{
-       sdma_v4_0_wait_reg_mem(ring, 0, 1, reg0, reg1, ref, mask, 10);
-}
-
 static int sdma_v4_0_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -1626,7 +1619,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_=
funcs =3D {
         .pad_ib =3D sdma_v4_0_ring_pad_ib,
         .emit_wreg =3D sdma_v4_0_ring_emit_wreg,
         .emit_reg_wait =3D sdma_v4_0_ring_emit_reg_wait,
-       .emit_reg_write_reg_wait =3D sdma_v4_0_ring_emit_reg_write_reg_wait=
,
+       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_he=
lper,
 };

 static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809BFA58237B2C3C27FE1E3F7A10BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">The spec claims it does and we us=
e it for HDP flush...</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Emily Deng &lt;Emily.Deng@amd=
.com&gt;<br>
<b>Sent:</b> Friday, March 30, 2018 4:24:08 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deng, Emily<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sdma4:fix sdma engine hang</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The sdma doesn't support register write and wait i=
n one command.<br>
Use this will make sdma engine hang.<br>
<br>
Signed-off-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 9 &#43;--------<br>
&nbsp;1 file changed, 1 insertion(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 9ac28b2..84d148d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -1178,13 &#43;1178,6 @@ static void sdma_v4_0_ring_emit_reg_wait(struct =
amdgpu_ring *ring, uint32_t reg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v4_0_wait_reg_mem(rin=
g, 0, 0, reg, 0, val, mask, 10);<br>
&nbsp;}<br>
&nbsp;<br>
-static void sdma_v4_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *rin=
g,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t reg0, uint32_t reg1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t ref, uint32_t mask)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v4_0_wait_reg_mem(ring, 0, 1, re=
g0, reg1, ref, mask, 10);<br>
-}<br>
-<br>
&nbsp;static int sdma_v4_0_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -1626,7 &#43;1619,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_r=
ing_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D sdma_v4_0_ring=
_pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D sdma_v4_0_r=
ing_emit_wreg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_wait =3D sdma_v4=
_0_ring_emit_reg_wait,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =3D sdma_v4_=
0_ring_emit_reg_write_reg_wait,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =3D amdg=
pu_ring_emit_reg_write_reg_wait_helper,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev)<br>
-- <br>
2.7.4<br>
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

--_000_BN6PR12MB1809BFA58237B2C3C27FE1E3F7A10BN6PR12MB1809namp_--

--===============2111556876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2111556876==--
