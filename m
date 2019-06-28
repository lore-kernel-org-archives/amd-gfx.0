From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix a missing break in a switch statement
Date: Fri, 28 Jun 2019 15:10:37 +0000
Message-ID: <DM6PR12MB320959692BDD1D04CF096469FEFC0@DM6PR12MB3209.namprd12.prod.outlook.com>
References: <20190628143320.5182-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1042161036=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190628143320.5182-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1042161036==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB320959692BDD1D04CF096469FEFC0DM6PR12MB3209namp_"

--_000_DM6PR12MB320959692BDD1D04CF096469FEFC0DM6PR12MB3209namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Colin Ki=
ng <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sent: Friday, June 28, 2019 10:33:20 AM
To: Zhang, Hawking; Deucher, Alexander; Koenig, Christian; Zhou, David(Chun=
Ming); David Airlie; Daniel Vetter; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-deve=
l@lists.freedesktop.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amdgpu: fix a missing break in a switch statement

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

Currently for the AMDGPU_IRQ_STATE_DISABLE there is a missing break
causing the code to fall through to the AMDGPU_IRQ_STATE_ENABLE case.
Fix this by adding in the missing break statement.

Addresses-Coverity: ("Missing break in switch")
Fixes: a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")
Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 2932ade7dbd0..c165200361b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4608,6 +4608,7 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_d=
evice *adev,
                 cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RIN=
G0,
                                             TIME_STAMP_INT_ENABLE, 0);
                 WREG32(cp_int_cntl_reg, cp_int_cntl);
+               break;
         case AMDGPU_IRQ_STATE_ENABLE:
                 cp_int_cntl =3D RREG32(cp_int_cntl_reg);
                 cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RIN=
G0,
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB320959692BDD1D04CF096469FEFC0DM6PR12MB3209namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Slava Abramov &lt;slava=
.abramov-5C7GfCeVMHo@public.gmane.org&gt;</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Colin King &lt;colin.king@can=
onical.com&gt;<br>
<b>Sent:</b> Friday, June 28, 2019 10:33:20 AM<br>
<b>To:</b> Zhang, Hawking; Deucher, Alexander; Koenig, Christian; Zhou, Dav=
id(ChunMing); David Airlie; Daniel Vetter; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; d=
ri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br=
>
<b>Subject:</b> [PATCH] drm/amdgpu: fix a missing break in a switch stateme=
nt</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Colin Ian King &lt;colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&=
gt;<br>
<br>
Currently for the AMDGPU_IRQ_STATE_DISABLE there is a missing break<br>
causing the code to fall through to the AMDGPU_IRQ_STATE_ENABLE case.<br>
Fix this by adding in the missing break statement.<br>
<br>
Addresses-Coverity: (&quot;Missing break in switch&quot;)<br>
Fixes: a644d85a5cd4 (&quot;drm/amdgpu: add gfx v10 implementation (v10)&quo=
t;)<br>
Signed-off-by: Colin Ian King &lt;colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 2932ade7dbd0..c165200361b2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4608,6 &#43;4608,7 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNT=
L_RING0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32(cp_int_cntl_reg, cp_int_cntl);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENAB=
LE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cp_int_cntl =3D RREG32(cp_int_cntl_reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNT=
L_RING0,<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB320959692BDD1D04CF096469FEFC0DM6PR12MB3209namp_--

--===============1042161036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1042161036==--
