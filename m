From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: error out when force clock level under
 auto dpm mode
Date: Wed, 17 Oct 2018 14:25:53 +0000
Message-ID: <BN6PR12MB1809EBA4593E4ABED4909FCEF7FF0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181017084116.30005-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1520249616=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181017084116.30005-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1520249616==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809EBA4593E4ABED4909FCEF7FF0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809EBA4593E4ABED4909FCEF7FF0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 17, 2018 4:41:16 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Quan, Evan; Zhu, Rex
Subject: [PATCH] drm/amd/powerplay: error out when force clock level under =
auto dpm mode

Forcing clock level is supported under manual dpm mode only. Error out
when trying to set under manual mode. Instead of doing nothing and
reporting success.

Change-Id: I2af32be5ebd4323a98cb48da88b22177a68fbdb0
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  5 ++++-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 11 +++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 94055a485e01..c2efd79d9a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -704,7 +704,10 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *d=
ev,
                 return ret;

         if (adev->powerplay.pp_funcs->force_clock_level)
-               amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
+               ret =3D amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
+
+       if (ret)
+               return -EINVAL;

         return count;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index e8964cae6b93..da9ff2cc2777 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -723,11 +723,14 @@ static int pp_dpm_force_clock_level(void *handle,
                 pr_info("%s was not implemented.\n", __func__);
                 return 0;
         }
+
+       if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
+               pr_info("force clock level is for dpm manual mode only.\n")=
;
+               return -EINVAL;
+       }
+
         mutex_lock(&hwmgr->smu_lock);
-       if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)
-               ret =3D hwmgr->hwmgr_func->force_clock_level(hwmgr, type, m=
ask);
-       else
-               ret =3D -EINVAL;
+       ret =3D hwmgr->hwmgr_func->force_clock_level(hwmgr, type, mask);
         mutex_unlock(&hwmgr->smu_lock);
         return ret;
 }
--
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809EBA4593E4ABED4909FCEF7FF0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, October 17, 2018 4:41:16 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan; Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: error out when force clock level=
 under auto dpm mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Forcing clock level is supported under manual dpm =
mode only. Error out<br>
when trying to set under manual mode. Instead of doing nothing and<br>
reporting success.<br>
<br>
Change-Id: I2af32be5ebd4323a98cb48da88b22177a68fbdb0<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 5 &#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 11 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;----<br>
&nbsp;2 files changed, 11 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 94055a485e01..c2efd79d9a39 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -704,7 &#43;704,10 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct devic=
e *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;force_clock_level)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index e8964cae6b93..da9ff2cc2777 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -723,11 &#43;723,14 @@ static int pp_dpm_force_clock_level(void *handle,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func=
__);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=3D AMD_=
DPM_FORCED_LEVEL_MANUAL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;force clock level is for dpm manual mode only.=
\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;=
smu_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DP=
M_FORCED_LEVEL_MANUAL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;force_clock_level(hwmgr, type, =
mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;=
force_clock_level(hwmgr, type, mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&g=
t;smu_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.19.1<br>
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

--_000_BN6PR12MB1809EBA4593E4ABED4909FCEF7FF0BN6PR12MB1809namp_--

--===============1520249616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1520249616==--
