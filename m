From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/gfx9: Update gc goldensetting for vega20.
Date: Thu, 31 May 2018 13:16:58 +0000
Message-ID: <DM5PR12MB18204F46CB669768C5B03BF3F7630@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1527772256-21175-1-git-send-email-Feifei.Xu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1228506815=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527772256-21175-1-git-send-email-Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
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
To: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1228506815==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18204F46CB669768C5B03BF3F7630DM5PR12MB1820namp_"

--_000_DM5PR12MB18204F46CB669768C5B03BF3F7630DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Feifei X=
u <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, May 31, 2018 9:10:56 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xu, Feifei
Subject: [PATCH] drm/gfx9: Update gc goldensetting for vega20.

Update mmCB_DCC_CONFIG register goldensetting.

Signed-off-by: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index eb50d86..3647729 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -112,6 +112,7 @@ static const struct soc15_reg_golden golden_settings_gc=
_9_0_vg10[] =3D

 static const struct soc15_reg_golden golden_settings_gc_9_0_vg20[] =3D
 {
+       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_DCC_CONFIG, 0x0f000080, 0x040000=
80),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_2, 0x0f000000, 0x0a0=
00000),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_3, 0x30000000, 0x100=
00000),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0xf3e777ff, 0x2201=
4042),
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18204F46CB669768C5B03BF3F7630DM5PR12MB1820namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Feifei Xu &lt;Feifei.Xu@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, May 31, 2018 9:10:56 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Xu, Feifei<br>
<b>Subject:</b> [PATCH] drm/gfx9: Update gc goldensetting for vega20.</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update mmCB_DCC_CONFIG register goldensetting.<br>
<br>
Signed-off-by: Feifei Xu &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index eb50d86..3647729 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -112,6 &#43;112,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_9_0_vg10[] =3D<br>
&nbsp;<br>
&nbsp;static const struct soc15_reg_golden golden_settings_gc_9_0_vg20[] =
=3D<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmC=
B_DCC_CONFIG, 0x0f000080, 0x04000080),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCB_HW_CONTROL_2, 0x0f000000, 0x0a000000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCB_HW_CONTROL_3, 0x30000000, 0x10000000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmGB_ADDR_CONFIG, 0xf3e777ff, 0x22014042),<br>
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

--_000_DM5PR12MB18204F46CB669768C5B03BF3F7630DM5PR12MB1820namp_--

--===============1228506815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1228506815==--
