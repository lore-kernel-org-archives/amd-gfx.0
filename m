From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix null pointer dereference around
 dpm state relates
Date: Thu, 25 Jul 2019 12:56:16 +0000
Message-ID: <BN6PR12MB1809FBE4FABB39A03C5D40F2F7C10@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190725042354.1931-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0161186923=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190725042354.1931-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============0161186923==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809FBE4FABB39A03C5D40F2F7C10BN6PR12MB1809namp_"

--_000_BN6PR12MB1809FBE4FABB39A03C5D40F2F7C10BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, July 25, 2019 12:23 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix null pointer dereference around dpm=
 state relates

DPM state relates are not supported on the new SW SMU ASICs. But still
it's not OK to trigger null pointer dereference on accessing them.

Change-Id: I368d108fbea438ed5d9e3b849d006ddd5308052b
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 18 +++++++++++++-----
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  3 ++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 304626b21a8c..61312b02b5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -209,12 +209,16 @@ static ssize_t amdgpu_get_dpm_state(struct device *de=
v,
         struct amdgpu_device *adev =3D ddev->dev_private;
         enum amd_pm_state_type pm;

-       if (is_support_sw_smu(adev) && adev->smu.ppt_funcs->get_current_pow=
er_state)
-               pm =3D amdgpu_smu_get_current_power_state(adev);
-       else if (adev->powerplay.pp_funcs->get_current_power_state)
+       if (is_support_sw_smu(adev)) {
+               if (adev->smu.ppt_funcs->get_current_power_state)
+                       pm =3D amdgpu_smu_get_current_power_state(adev);
+               else
+                       pm =3D adev->pm.dpm.user_state;
+       } else if (adev->powerplay.pp_funcs->get_current_power_state) {
                 pm =3D amdgpu_dpm_get_current_power_state(adev);
-       else
+       } else {
                 pm =3D adev->pm.dpm.user_state;
+       }

         return snprintf(buf, PAGE_SIZE, "%s\n",
                         (pm =3D=3D POWER_STATE_TYPE_BATTERY) ? "battery" :
@@ -241,7 +245,11 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev=
,
                 goto fail;
         }

-       if (adev->powerplay.pp_funcs->dispatch_tasks) {
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               adev->pm.dpm.user_state =3D state;
+               mutex_unlock(&adev->pm.mutex);
+       } else if (adev->powerplay.pp_funcs->dispatch_tasks) {
                 amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STA=
TE, &state);
         } else {
                 mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index a5079b93caa3..3ecd67e6e65c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -304,7 +304,8 @@ int smu_get_power_num_states(struct smu_context *smu,

         /* not support power state */
         memset(state_info, 0, sizeof(struct pp_states_info));
-       state_info->nums =3D 0;
+       state_info->nums =3D 1;
+       state_info->states[0] =3D POWER_STATE_TYPE_DEFAULT;

         return 0;
 }
--
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809FBE4FABB39A03C5D40F2F7C10BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, July 25, 2019 12:23 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: fix null pointer dereference aro=
und dpm state relates</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">DPM state relates are not supported on the new SW =
SMU ASICs. But still<br>
it's not OK to trigger null pointer dereference on accessing them.<br>
<br>
Change-Id: I368d108fbea438ed5d9e3b849d006ddd5308052b<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp; | 18 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |&nbsp; 3 &#43;&#43;-<br>
&nbsp;2 files changed, 15 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 304626b21a8c..61312b02b5c7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -209,12 &#43;209,16 @@ static ssize_t amdgpu_get_dpm_state(struct device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm;=
<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev) &amp;&amp=
; adev-&gt;smu.ppt_funcs-&gt;get_current_power_state)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm =3D amdgpu_smu_get_current_power_state(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;get_current_power_state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;smu.ppt_funcs-&gt;get_current_power_state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm =3D amdgp=
u_smu_get_current_power_state(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm =3D adev-=
&gt;pm.dpm.user_state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_=
funcs-&gt;get_current_power_state) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm =3D amdgpu_dpm_get_current_power_state(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm =3D adev-&gt;pm.dpm.user_state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_=
SIZE, &quot;%s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pm =
=3D=3D POWER_STATE_TYPE_BATTERY) ? &quot;battery&quot; :<br>
@@ -241,7 &#43;245,11 @@ static ssize_t amdgpu_set_dpm_state(struct device =
*dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;d=
ispatch_tasks) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;pm.dpm.user_state =3D state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_=
funcs-&gt;dispatch_tasks) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USE=
R_STATE, &amp;state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index a5079b93caa3..3ecd67e6e65c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -304,7 &#43;304,8 @@ int smu_get_power_num_states(struct smu_context *sm=
u,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* not support power state=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(state_info, 0, size=
of(struct pp_states_info));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_info-&gt;nums =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_info-&gt;nums =3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_info-&gt;states[0] =3D POWE=
R_STATE_TYPE_DEFAULT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.22.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809FBE4FABB39A03C5D40F2F7C10BN6PR12MB1809namp_--

--===============0161186923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0161186923==--
