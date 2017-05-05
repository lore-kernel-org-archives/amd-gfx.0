From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH 5/5] drm/amd/powerplay: refine pwm1_enable callback
 functions on CI.
Date: Fri, 5 May 2017 12:43:04 +0000
Message-ID: <CY4PR12MB16874EC46858BE7390DB5D6FFBEB0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1493978213-19943-1-git-send-email-Rex.Zhu@amd.com>,
 <1493978213-19943-5-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0849771791=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493978213-19943-5-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============0849771791==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16874EC46858BE7390DB5D6FFBEB0CY4PR12MB1687namp_"

--_000_CY4PR12MB16874EC46858BE7390DB5D6FFBEB0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Change-Id: Ieb05cfa95e4072357e18f631ab71780de0688008
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/ci_dpm.c
index a6dda34..6dc1410 100644
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
@@ -1267,30 +1267,33 @@ static int ci_dpm_set_fan_speed_percent(struct amdg=
pu_device *adev,

 static void ci_dpm_set_fan_control_mode(struct amdgpu_device *adev, u32 mo=
de)
 {
-       if (mode) {
-               /* stop auto-manage */
+       switch (mode) {
+       case AMD_FAN_CTRL_NONE:
                 if (adev->pm.dpm.fan.ucode_fan_control)
                         ci_fan_ctrl_stop_smc_fan_control(adev);
-               ci_fan_ctrl_set_static_mode(adev, mode);
-       } else {
-               /* restart auto-manage */
+               ci_dpm_set_fan_speed_percent(adev, 100);
+               break;
+       case AMD_FAN_CTRL_MANUAL:
+               if (adev->pm.dpm.fan.ucode_fan_control)
+                       ci_fan_ctrl_stop_smc_fan_control(adev);
+               break;
+       case AMD_FAN_CTRL_AUTO:
                 if (adev->pm.dpm.fan.ucode_fan_control)
                         ci_thermal_start_smc_fan_control(adev);
-               else
-                       ci_fan_ctrl_set_default_mode(adev);
+               break;
+       default:
+               break;
         }
 }

 static u32 ci_dpm_get_fan_control_mode(struct amdgpu_device *adev)
 {
         struct ci_power_info *pi =3D ci_get_pi(adev);
-       u32 tmp;

         if (pi->fan_is_controlled_by_smc)
-               return 0;
-
-       tmp =3D RREG32_SMC(ixCG_FDO_CTRL2) & CG_FDO_CTRL2__FDO_PWM_MODE_MAS=
K;
-       return (tmp >> CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT);
+               return AMD_FAN_CTRL_AUTO;
+       else
+               return AMD_FAN_CTRL_MANUAL;
 }

 #if 0
--
1.9.1


--_000_CY4PR12MB16874EC46858BE7390DB5D6FFBEB0CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr">
<div></div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Change-Id: Ieb05cfa95e4072357e18f631ab71780de06880=
08<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 27 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------------<br>
&nbsp;1 file changed, 15 insertions(&#43;), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/ci_dpm.c<br>
index a6dda34..6dc1410 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
@@ -1267,30 &#43;1267,33 @@ static int ci_dpm_set_fan_speed_percent(struct =
amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;static void ci_dpm_set_fan_control_mode(struct amdgpu_device *adev, u=
32 mode)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mode) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* stop auto-manage */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mode) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_NONE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm.fan.ucode_fan_control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ci_fa=
n_ctrl_stop_smc_fan_control(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ci_fan_ctrl_set_static_mode(adev, mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* restart auto-manage */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ci_dpm_set_fan_speed_percent(adev, 100);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_MANUAL:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;pm.dpm.fan.ucode_fan_control)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ci_fan_ctrl_=
stop_smc_fan_control(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_AUTO:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm.fan.ucode_fan_control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ci_th=
ermal_start_smc_fan_control(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ci_fan_ctrl_set_=
default_mode(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static u32 ci_dpm_get_fan_control_mode(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_info *pi =
=3D ci_get_pi(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pi-&gt;fan_is_controll=
ed_by_smc)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SMC(ixCG_FDO_CTRL2) &a=
mp; CG_FDO_CTRL2__FDO_PWM_MODE_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (tmp &gt;&gt; CG_FDO_CTRL2__FD=
O_PWM_MODE__SHIFT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return AMD_FAN_CTRL_AUTO;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return AMD_FAN_CTRL_MANUAL;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;#if 0<br>
-- <br>
1.9.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB16874EC46858BE7390DB5D6FFBEB0CY4PR12MB1687namp_--

--===============0849771791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0849771791==--
