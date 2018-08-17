From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: set correct base for THM/NBIF/MP1 IP
Date: Fri, 17 Aug 2018 02:53:29 +0000
Message-ID: <BN6PR12MB180993F97EBF9F4807480CE7F73D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180817023632.29104-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1048929684=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180817023632.29104-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>

--===============1048929684==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180993F97EBF9F4807480CE7F73D0BN6PR12MB1809namp_"

--_000_BN6PR12MB180993F97EBF9F4807480CE7F73D0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 16, 2018 10:36:32 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Xu, Feifei; Quan, Evan
Subject: [PATCH] drm/amd/powerplay: set correct base for THM/NBIF/MP1 IP

Set correct address base for vega20.

Change-Id: I7435980e2ca156ee2b443a97899d40aaba4876cb
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega20_reg_init.c
index 52778de93ab0..2d4473557b0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
@@ -38,6 +38,7 @@ int vega20_reg_base_init(struct amdgpu_device *adev)
                 adev->reg_offset[ATHUB_HWIP][i] =3D (uint32_t *)(&(ATHUB_B=
ASE.instance[i]));
                 adev->reg_offset[NBIO_HWIP][i] =3D (uint32_t *)(&(NBIO_BAS=
E.instance[i]));
                 adev->reg_offset[MP0_HWIP][i] =3D (uint32_t *)(&(MP0_BASE.=
instance[i]));
+               adev->reg_offset[MP1_HWIP][i] =3D (uint32_t *)(&(MP1_BASE.i=
nstance[i]));
                 adev->reg_offset[UVD_HWIP][i] =3D (uint32_t *)(&(UVD_BASE.=
instance[i]));
                 adev->reg_offset[VCE_HWIP][i] =3D (uint32_t *)(&(VCE_BASE.=
instance[i]));
                 adev->reg_offset[DF_HWIP][i] =3D (uint32_t *)(&(DF_BASE.in=
stance[i]));
@@ -46,6 +47,8 @@ int vega20_reg_base_init(struct amdgpu_device *adev)
                 adev->reg_offset[SDMA0_HWIP][i] =3D (uint32_t *)(&(SDMA0_B=
ASE.instance[i]));
                 adev->reg_offset[SDMA1_HWIP][i] =3D (uint32_t *)(&(SDMA1_B=
ASE.instance[i]));
                 adev->reg_offset[SMUIO_HWIP][i] =3D (uint32_t *)(&(SMUIO_B=
ASE.instance[i]));
+               adev->reg_offset[NBIF_HWIP][i] =3D (uint32_t *)(&(NBIO_BASE=
.instance[i]));
+               adev->reg_offset[THM_HWIP][i] =3D (uint32_t *)(&(THM_BASE.i=
nstance[i]));
         }
         return 0;
 }
--
2.18.0


--_000_BN6PR12MB180993F97EBF9F4807480CE7F73D0BN6PR12MB1809namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Evan Quan &lt;evan.qu=
an-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 16, 2018 10:36:32 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Xu, Feifei; Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: set correct base for THM/NBIF/MP=
1 IP</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Set correct address base for vega20.<br>
<br>
Change-Id: I7435980e2ca156ee2b443a97899d40aaba4876cb<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c | 3 &#43;&#43;&#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega20_reg_init.c<br>
index 52778de93ab0..2d4473557b0d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
@@ -38,6 &#43;38,7 @@ int vega20_reg_base_init(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[ATHUB_HWIP][i] =3D (uint32_t *)(&=
amp;(ATHUB_BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[NBIO_HWIP][i] =3D (uint32_t *)(&a=
mp;(NBIO_BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[MP0_HWIP][i] =3D (uint32_t *)(&am=
p;(MP0_BASE.instance[i]));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;reg_offset[MP1_HWIP][i] =3D (uint32_t *)(&amp;(MP1_=
BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[UVD_HWIP][i] =3D (uint32_t *)(&am=
p;(UVD_BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[VCE_HWIP][i] =3D (uint32_t *)(&am=
p;(VCE_BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[DF_HWIP][i] =3D (uint32_t *)(&amp=
;(DF_BASE.instance[i]));<br>
@@ -46,6 &#43;47,8 @@ int vega20_reg_base_init(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[SDMA0_HWIP][i] =3D (uint32_t *)(&=
amp;(SDMA0_BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[SDMA1_HWIP][i] =3D (uint32_t *)(&=
amp;(SDMA1_BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reg_offset[SMUIO_HWIP][i] =3D (uint32_t *)(&=
amp;(SMUIO_BASE.instance[i]));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;reg_offset[NBIF_HWIP][i] =3D (uint32_t *)(&amp;(NBI=
O_BASE.instance[i]));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;reg_offset[THM_HWIP][i] =3D (uint32_t *)(&amp;(THM_=
BASE.instance[i]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.18.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180993F97EBF9F4807480CE7F73D0BN6PR12MB1809namp_--

--===============1048929684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1048929684==--
