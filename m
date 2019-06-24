From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure for uvd_4/5/6
Date: Mon, 24 Jun 2019 12:08:15 +0000
Message-ID: <MN2PR12MB2974DEB333EFC573700D0B5895E00@MN2PR12MB2974.namprd12.prod.outlook.com>
References: <1561377497-2257-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0529045552=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1561377497-2257-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0529045552==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2974DEB333EFC573700D0B5895E00MN2PR12MB2974namp_"

--_000_MN2PR12MB2974DEB333EFC573700D0B5895E00MN2PR12MB2974namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Tianci Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, June 24, 2019 19:58
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Yin, Tianci (Rico)
Cc: Zhang, Hawking
Subject: [PATCH] drm/amdgpu: fix modprobe failure for uvd_4/5/6

For uvd_4/5/6, amdgpu driver will only power on them when
there are jobs assigned to decode/enc rings.uvd_4/5/6 dpm was broken
since amdgpu_dpm_set_powergating_by_smu only covers gfx block.

The change would add more IP block support in amdgpu_dpm_set_powergating_by=
_smu
For GFX/UVD/VCN/VCE, if the new SMU driver is supported, invoke new
power gate helper function smu_dpm_set_power_gate, otherwise, fallback to
legacy powerplay helper function pp_set_powergating_by_smu. For other IP bl=
ocks
always invoke legacy powerplay helper function.

Signed-off-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 11 ++++++++++-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.c
index f54a1ef..357e45f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -948,12 +948,21 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_d=
evice *adev, uint32_t block

         switch (block_type) {
         case AMD_IP_BLOCK_TYPE_GFX:
+       case AMD_IP_BLOCK_TYPE_UVD:
+       case AMD_IP_BLOCK_TYPE_VCN:
+       case AMD_IP_BLOCK_TYPE_VCE:
                 if (swsmu)
-                       ret =3D smu_gfx_off_control(&adev->smu, gate);
+                       ret =3D smu_dpm_set_power_gate(&adev->smu, block_ty=
pe, gate);
                 else
                         ret =3D ((adev)->powerplay.pp_funcs->set_powergati=
ng_by_smu(
                                 (adev)->powerplay.pp_handle, block_type, g=
ate));
                 break;
+       case AMD_IP_BLOCK_TYPE_GMC:
+       case AMD_IP_BLOCK_TYPE_ACP:
+       case AMD_IP_BLOCK_TYPE_SDMA:
+               ret =3D ((adev)->powerplay.pp_funcs->set_powergating_by_smu=
(
+                               (adev)->powerplay.pp_handle, block_type, ga=
te));
+               break;
         default:
                 break;
         }
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index edd1da6..f61ecbf 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -233,6 +233,9 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uin=
t32_t block_type,
         case AMD_IP_BLOCK_TYPE_VCE:
                 ret =3D smu_dpm_set_vce_enable(smu, gate);
                 break;
+       case AMD_IP_BLOCK_TYPE_GFX:
+               ret =3D smu_gfx_off_control(smu, gate);
+               break;
         default:
                 break;
         }
--
2.7.4


--_000_MN2PR12MB2974DEB333EFC573700D0B5895E00MN2PR12MB2974namp_
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
Reviewed-by: Tianci Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hawking Zhang &lt;Haw=
king.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, June 24, 2019 19:58<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Yin, Tianci (=
Rico)<br>
<b>Cc:</b> Zhang, Hawking<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix modprobe failure for uvd_4/5/6</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For uvd_4/5/6, amdgpu driver will only power on th=
em when<br>
there are jobs assigned to decode/enc rings.uvd_4/5/6 dpm was broken<br>
since amdgpu_dpm_set_powergating_by_smu only covers gfx block.<br>
<br>
The change would add more IP block support in amdgpu_dpm_set_powergating_by=
_smu<br>
For GFX/UVD/VCN/VCE, if the new SMU driver is supported, invoke new<br>
power gate helper function smu_dpm_set_power_gate, otherwise, fallback to<b=
r>
legacy powerplay helper function pp_set_powergating_by_smu. For other IP bl=
ocks<br>
always invoke legacy powerplay helper function.<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c&nbsp;&nbsp;&nbsp; | 11 &#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |&nbsp; 3 &#43;&#43;&#43;<=
br>
&nbsp;2 files changed, 13 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.c<br>
index f54a1ef..357e45f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c<br>
@@ -948,12 &#43;948,21 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdg=
pu_device *adev, uint32_t block<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (block_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_GFX=
:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_UVD:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCN:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (swsmu)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_gfx_=
off_control(&amp;adev-&gt;smu, gate);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_=
dpm_set_power_gate(&amp;adev-&gt;smu, block_type, gate);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D ((adev)-&gt;powerplay.pp_funcs-&gt;set_powergating_by_smu(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;powerplay.pp_handle, =
block_type, gate));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_GMC:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_ACP:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_SDMA:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D ((adev)-&gt;powerplay.pp_funcs-&gt;set_powergating_b=
y_smu(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;powerplay.pp_handle, block_t=
ype, gate));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index edd1da6..f61ecbf 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -233,6 &#43;233,9 @@ int smu_dpm_set_power_gate(struct smu_context *smu,=
 uint32_t block_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCE=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_dpm_set_vce_enable(smu, gate);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_GFX:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_gfx_off_control(smu, gate);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB2974DEB333EFC573700D0B5895E00MN2PR12MB2974namp_--

--===============0529045552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0529045552==--
