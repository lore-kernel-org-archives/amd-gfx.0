From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO
Date: Mon, 28 Oct 2019 13:02:47 +0000
Message-ID: <DM5PR12MB182097D97D4F53977C9F368EF7660@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191028101432.16464-1-jianzh@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1230302795=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191028101432.16464-1-jianzh-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Zhao, Jiange" <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>, "Nieto, David M" <David.Nieto-5C7GfCeVMHo@public.gmane.org>

--===============1230302795==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_"

--_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of jianzh@a=
md.com <jianzh-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, October 28, 2019 6:14 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Zhao, Jiange <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>; N=
ieto, David M <David.Nieto-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO

From: Jiange Zhao <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>

SRIOV VF doesn't support BACO.

Only PF with BACO capability can do it.

Signed-off-by: Jiange Zhao <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 22ab1955b923..a55a2e83fb19 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -299,7 +299,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
         struct smu_context *smu =3D &adev->smu;

-       if (smu_baco_is_support(smu))
+       if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
                 return AMD_RESET_METHOD_BACO;
         else
                 return AMD_RESET_METHOD_MODE1;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of jianzh-5C7GfCeVMHo@public.gmane.org &lt;jianzh@amd=
.com&gt;<br>
<b>Sent:</b> Monday, October 28, 2019 6:14 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; Zhao, Jiange &lt;Jiange.=
Zhao-5C7GfCeVMHo@public.gmane.org&gt;; Nieto, David M &lt;David.Nieto-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiange Zhao &lt;Jiange.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
SRIOV VF doesn't support BACO.<br>
<br>
Only PF with BACO capability can do it.<br>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 22ab1955b923..a55a2e83fb19 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -299,7 &#43;299,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D &amp;adev-&gt;smu;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_baco_is_support(smu))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&=
amp; smu_baco_is_support(smu))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_BACO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_MODE1;<br>
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

--_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_--

--===============1230302795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1230302795==--
