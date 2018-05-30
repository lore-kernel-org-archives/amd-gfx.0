From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer when load kfd driver with PP
 block is disabled
Date: Wed, 30 May 2018 22:42:05 +0000
Message-ID: <BN6PR12MB180940C8DDD8C346EAC7D382F76C0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1527717921-28021-1-git-send-email-Shaoyun.Liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1990485137=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527717921-28021-1-git-send-email-Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1990485137==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180940C8DDD8C346EAC7D382F76C0BN6PR12MB1809namp_"

--_000_BN6PR12MB180940C8DDD8C346EAC7D382F76C0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Shaoyun =
Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, May 30, 2018 6:05:21 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liu, Shaoyun
Subject: [PATCH] drm/amdgpu: Fix NULL pointer when load kfd driver with PP =
block is disabled

When PP block is disabled, return a fix value(100M) for mclk and sclk on
bare-metal mode. This will cover the emulation mode as well.

Change-Id: If34e3517b6cb6f31e898bbe7921485fbddb79fb9
Signed-off-by: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 887702c..8fd21cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -310,15 +310,12 @@ void get_local_mem_info(struct kgd_dev *kgd,
                         mem_info->local_mem_size_public,
                         mem_info->local_mem_size_private);

-       if (amdgpu_emu_mode =3D=3D 1) {
-               mem_info->mem_clk_max =3D 100;
-               return;
-       }
-
         if (amdgpu_sriov_vf(adev))
                 mem_info->mem_clk_max =3D adev->clock.default_mclk / 100;
-       else
+       else if (adev->powerplay.pp_funcs)
                 mem_info->mem_clk_max =3D amdgpu_dpm_get_mclk(adev, false)=
 / 100;
+       else
+               mem_info->mem_clk_max =3D 100;
 }

 uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)
@@ -335,13 +332,12 @@ uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *=
kgd)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;

         /* the sclk is in quantas of 10kHz */
-       if (amdgpu_emu_mode =3D=3D 1)
-               return 100;
-
         if (amdgpu_sriov_vf(adev))
                 return adev->clock.default_sclk / 100;
-
-       return amdgpu_dpm_get_sclk(adev, false) / 100;
+       else if (adev->powerplay.pp_funcs)
+               return amdgpu_dpm_get_sclk(adev, false) / 100;
+       else
+               return 100;
 }

 void get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180940C8DDD8C346EAC7D382F76C0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Shaoyun Liu &lt;Shaoyun.Liu@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, May 30, 2018 6:05:21 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Liu, Shaoyun<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix NULL pointer when load kfd driver w=
ith PP block is disabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When PP block is disabled, return a fix value(100M=
) for mclk and sclk on<br>
bare-metal mode. This will cover the emulation mode as well.<br>
<br>
Change-Id: If34e3517b6cb6f31e898bbe7921485fbddb79fb9<br>
Signed-off-by: Shaoyun Liu &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 18 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;-----------<br>
&nbsp;1 file changed, 7 insertions(&#43;), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 887702c..8fd21cd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -310,15 &#43;310,12 @@ void get_local_mem_info(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_i=
nfo-&gt;local_mem_size_public,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_i=
nfo-&gt;local_mem_size_private);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D 1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mem_info-&gt;mem_clk_max =3D 100;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mem_info-&gt;mem_clk_max =3D adev-&gt;clock.default_m=
clk / 100;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_fu=
ncs)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mem_info-&gt;mem_clk_max =3D amdgpu_dpm_get_mclk(adev=
, false) / 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mem_info-&gt;mem_clk_max =3D 100;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)<br>
@@ -335,13 &#43;332,12 @@ uint32_t get_max_engine_clock_in_mhz(struct kgd_d=
ev *kgd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)kgd;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the sclk is in quantas =
of 10kHz */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 100;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return adev-&gt;clock.default_sclk / 100;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dpm_get_sclk(adev, fals=
e) / 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_fu=
ncs)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return amdgpu_dpm_get_sclk(adev, false) / 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 100;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)<br=
>
-- <br>
1.9.1<br>
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

--_000_BN6PR12MB180940C8DDD8C346EAC7D382F76C0BN6PR12MB1809namp_--

--===============1990485137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1990485137==--
