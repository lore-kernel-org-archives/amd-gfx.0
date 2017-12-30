From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amd/powerplay: removed hwmgr_handle_task unused
 parameter and given a better name for other parameter
Date: Sat, 30 Dec 2017 18:31:47 +0000
Message-ID: <BN6PR12MB16521CE9DDA6A72C4B20EF3FF71A0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1514533479-14038-1-git-send-email-evan.quan@amd.com>,
 <1514533479-14038-3-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1926963842=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1514533479-14038-3-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============1926963842==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16521CE9DDA6A72C4B20EF3FF71A0BN6PR12MB1652namp_"

--_000_BN6PR12MB16521CE9DDA6A72C4B20EF3FF71A0BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, December 29, 2017 2:44:38 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH 3/4] drm/amd/powerplay: removed hwmgr_handle_task unused pa=
rameter and given a better name for other parameter

Change-Id: Iea827bdd8346da1286da8928044fb564c22ca63b
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c         | 10 +++++-----
 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  2 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c  | 12 ++++++------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c    |  8 +++-----
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h      |  2 +-
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.h
index a8437a3..8a8d09dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -328,8 +328,8 @@ enum amdgpu_pcie_gen {
 #define amdgpu_dpm_set_mclk_od(adev, value) \
                 ((adev)->powerplay.pp_funcs->set_mclk_od((adev)->powerplay=
.pp_handle, value))

-#define amdgpu_dpm_dispatch_task(adev, task_id, input, output)         \
-               ((adev)->powerplay.pp_funcs->dispatch_tasks)((adev)->powerp=
lay.pp_handle, (task_id), (input), (output))
+#define amdgpu_dpm_dispatch_task(adev, task_id, user_state)            \
+               ((adev)->powerplay.pp_funcs->dispatch_tasks)((adev)->powerp=
lay.pp_handle, (task_id), (user_state))

 #define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
                 ((adev)->powerplay.pp_funcs->check_state_equal((adev)->pow=
erplay.pp_handle, (cps), (rps), (equal)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 91f809e..b4ade14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -114,7 +114,7 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
         }

         if (adev->powerplay.pp_funcs->dispatch_tasks) {
-               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STAT=
E, &state, NULL);
+               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STAT=
E, &state);
         } else {
                 mutex_lock(&adev->pm.mutex);
                 adev->pm.dpm.user_state =3D state;
@@ -314,7 +314,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device =
*dev,
                 if (state !=3D POWER_STATE_TYPE_INTERNAL_BOOT &&
                     state !=3D POWER_STATE_TYPE_DEFAULT) {
                         amdgpu_dpm_dispatch_task(adev,
-                                       AMD_PP_TASK_ENABLE_USER_STATE, &sta=
te, NULL);
+                                       AMD_PP_TASK_ENABLE_USER_STATE, &sta=
te);
                         adev->pp_force_state_enabled =3D true;
                 }
         }
@@ -528,7 +528,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev=
,
                 amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);

         if (adev->powerplay.pp_funcs->dispatch_tasks) {
-               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_S=
TATE, NULL, NULL);
+               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_S=
TATE, NULL);
         } else {
                 adev->pm.dpm.current_ps =3D adev->pm.dpm.boot_ps;
                 amdgpu_pm_compute_clocks(adev);
@@ -572,7 +572,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev=
,
                 amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);

         if (adev->powerplay.pp_funcs->dispatch_tasks) {
-               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_S=
TATE, NULL, NULL);
+               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_S=
TATE, NULL);
         } else {
                 adev->pm.dpm.current_ps =3D adev->pm.dpm.boot_ps;
                 amdgpu_pm_compute_clocks(adev);
@@ -1459,7 +1459,7 @@ void amdgpu_pm_compute_clocks(struct amdgpu_device *a=
dev)
         }

         if (adev->powerplay.pp_funcs->dispatch_tasks) {
-               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_C=
HANGE, NULL, NULL);
+               amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_C=
HANGE, NULL);
         } else {
                 mutex_lock(&adev->pm.mutex);
                 adev->pm.dpm.new_active_crtcs =3D 0;
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index ed27626..0f89d2a8 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -256,7 +256,7 @@ struct amd_pm_funcs {
         void (*powergate_vce)(void *handle, bool gate);
         struct amd_vce_state *(*get_vce_clock_state)(void *handle, u32 idx=
);
         int (*dispatch_tasks)(void *handle, enum amd_pp_task task_id,
-                                  void *input, void *output);
+                       enum amd_pm_state_type *user_state);
         int (*load_firmware)(void *handle);
         int (*wait_for_fw_loading_complete)(void *handle);
         int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 9d3bdad..f3888dd 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -33,7 +33,7 @@
 #define PP_DPM_DISABLED 0xCCCC

 static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
-               void *input, void *output);
+               enum amd_pm_state_type *user_state);

 static inline int pp_check(struct pp_instance *handle)
 {
@@ -198,7 +198,7 @@ static int pp_late_init(void *handle)
         ret =3D pp_check(pp_handle);
         if (ret =3D=3D 0)
                 pp_dpm_dispatch_tasks(pp_handle,
-                                       AMD_PP_TASK_COMPLETE_INIT, NULL, NU=
LL);
+                                       AMD_PP_TASK_COMPLETE_INIT, NULL);

         return 0;
 }
@@ -397,7 +397,7 @@ static int pp_dpm_force_performance_level(void *handle,
         mutex_lock(&pp_handle->pp_lock);
         pp_dpm_en_umd_pstate(hwmgr, &level);
         hwmgr->request_dpm_level =3D level;
-       hwmgr_handle_task(pp_handle, AMD_PP_TASK_READJUST_POWER_STATE, NULL=
, NULL);
+       hwmgr_handle_task(pp_handle, AMD_PP_TASK_READJUST_POWER_STATE, NULL=
);
         ret =3D hwmgr->hwmgr_func->force_dpm_level(hwmgr, level);
         if (!ret)
                 hwmgr->dpm_level =3D hwmgr->request_dpm_level;
@@ -519,7 +519,7 @@ static void pp_dpm_powergate_uvd(void *handle, bool gat=
e)
 }

 static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
-               void *input, void *output)
+               enum amd_pm_state_type *user_state)
 {
         int ret =3D 0;
         struct pp_instance *pp_handle =3D (struct pp_instance *)handle;
@@ -530,7 +530,7 @@ static int pp_dpm_dispatch_tasks(void *handle, enum amd=
_pp_task task_id,
                 return ret;

         mutex_lock(&pp_handle->pp_lock);
-       ret =3D hwmgr_handle_task(pp_handle, task_id, input, output);
+       ret =3D hwmgr_handle_task(pp_handle, task_id, user_state);
         mutex_unlock(&pp_handle->pp_lock);

         return ret;
@@ -805,7 +805,7 @@ static int amd_powerplay_reset(void *handle)
         if (ret)
                 return ret;

-       return hwmgr_handle_task(instance, AMD_PP_TASK_COMPLETE_INIT, NULL,=
 NULL);
+       return hwmgr_handle_task(instance, AMD_PP_TASK_COMPLETE_INIT, NULL)=
;
 }

 static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index 38f7d0d..56de107 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -373,7 +373,7 @@ static enum PP_StateUILabel power_state_convert(enum am=
d_pm_state_type  state)
 }

 int hwmgr_handle_task(struct pp_instance *handle, enum amd_pp_task task_id=
,
-               void *input, void *output)
+               enum amd_pm_state_type *user_state)
 {
         int ret =3D 0;
         struct pp_hwmgr *hwmgr;
@@ -395,17 +395,15 @@ int hwmgr_handle_task(struct pp_instance *handle, enu=
m amd_pp_task task_id,
                 break;
         case AMD_PP_TASK_ENABLE_USER_STATE:
         {
-               enum amd_pm_state_type ps;
                 enum PP_StateUILabel requested_ui_label;
                 struct pp_power_state *requested_ps =3D NULL;

-               if (input =3D=3D NULL) {
+               if (user_state =3D=3D NULL) {
                         ret =3D -EINVAL;
                         break;
                 }
-               ps =3D *(unsigned long *)input;

-               requested_ui_label =3D power_state_convert(ps);
+               requested_ui_label =3D power_state_convert(*user_state);
                 ret =3D psm_set_user_performance_state(hwmgr, requested_ui=
_label, &requested_ps);
                 if (ret)
                         return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 80d35d8..bf0bf47 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -815,7 +815,7 @@ extern int hwmgr_hw_suspend(struct pp_instance *handle)=
;
 extern int hwmgr_hw_resume(struct pp_instance *handle);
 extern int hwmgr_handle_task(struct pp_instance *handle,
                                 enum amd_pp_task task_id,
-                               void *input, void *output);
+                               enum amd_pm_state_type *user_state);
 extern int phm_wait_on_register(struct pp_hwmgr *hwmgr, uint32_t index,
                                 uint32_t value, uint32_t mask);

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16521CE9DDA6A72C4B20EF3FF71A0BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span>Acked-by: Alex Deucher &lt;=
alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, December 29, 2017 2:44:38 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH 3/4] drm/amd/powerplay: removed hwmgr_handle_task un=
used parameter and given a better name for other parameter</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: Iea827bdd8346da1286da8928044fb564c22ca6=
3b<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/include/kgd_pp_interface.h |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp; | 12 &#43;&#43;&#=
43;&#43;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nbsp; |&nbsp;=
 8 &#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 2 &#43;-<br>
&nbsp;6 files changed, 18 insertions(&#43;), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.h<br>
index a8437a3..8a8d09dd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
@@ -328,8 &#43;328,8 @@ enum amdgpu_pcie_gen {<br>
&nbsp;#define amdgpu_dpm_set_mclk_od(adev, value) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_mclk_od((adev)=
-&gt;powerplay.pp_handle, value))<br>
&nbsp;<br>
-#define amdgpu_dpm_dispatch_task(adev, task_id, input, output)&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;dispatch_tasks)((adev)-&gt;po=
werplay.pp_handle, (task_id), (input), (output))<br>
&#43;#define amdgpu_dpm_dispatch_task(adev, task_id, user_state)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;dispatch_tasks)((adev)-&g=
t;powerplay.pp_handle, (task_id), (user_state))<br>
&nbsp;<br>
&nbsp;#define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;check_state_equal(=
(adev)-&gt;powerplay.pp_handle, (cps), (rps), (equal)))<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 91f809e..b4ade14 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -114,7 &#43;114,7 @@ static ssize_t amdgpu_set_dpm_state(struct device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;dispatch_tasks) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &a=
mp;state, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE=
, &amp;state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.user_state =3D state;<br>
@@ -314,7 &#43;314,7 @@ static ssize_t amdgpu_set_pp_force_state(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (state !=3D POWER_STATE_TYPE_INTERNAL_BOOT &amp;&a=
mp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state !=3D POWER_STATE_TYPE_D=
EFAULT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_dpm_dispatch_task(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMD_PP_TASK_ENABLE_USER_STATE, &amp;state, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; AMD_PP_TASK_ENABLE_USER_STATE, &amp;state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pp_force_state_enabled =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -528,7 &#43;528,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device =
*dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;dispatch_tasks) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_STATE,=
 NULL, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_ST=
ATE, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.current_ps =3D adev-&gt;pm.dpm.boot_p=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_pm_compute_clocks(adev);<br>
@@ -572,7 &#43;572,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device =
*dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;dispatch_tasks) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_STATE,=
 NULL, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_ST=
ATE, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.current_ps =3D adev-&gt;pm.dpm.boot_p=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_pm_compute_clocks(adev);<br>
@@ -1459,7 &#43;1459,7 @@ void amdgpu_pm_compute_clocks(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_=
funcs-&gt;dispatch_tasks) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE=
, NULL, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CH=
ANGE, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.new_active_crtcs =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index ed27626..0f89d2a8 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -256,7 &#43;256,7 @@ struct amd_pm_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*powergate_vce)(void=
 *handle, bool gate);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_vce_state *(*ge=
t_vce_clock_state)(void *handle, u32 idx);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*dispatch_tasks)(void=
 *handle, enum amd_pp_task task_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *input, void *output=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_=
state_type *user_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*load_firmware)(void =
*handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*wait_for_fw_loading_=
complete)(void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_clockgating_by_s=
mu)(void *handle, uint32_t msg_id);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 9d3bdad..f3888dd 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -33,7 &#43;33,7 @@<br>
&nbsp;#define PP_DPM_DISABLED 0xCCCC<br>
&nbsp;<br>
&nbsp;static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_=
id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; void *input, void *output);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; enum amd_pm_state_type *user_state);<br>
&nbsp;<br>
&nbsp;static inline int pp_check(struct pp_instance *handle)<br>
&nbsp;{<br>
@@ -198,7 &#43;198,7 @@ static int pp_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(pp_handle=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_dpm_dispatch_tasks(pp_handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMD_PP_TASK_COMPLETE_INIT, NULL, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; AMD_PP_TASK_COMPLETE_INIT, NULL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -397,7 &#43;397,7 @@ static int pp_dpm_force_performance_level(void *han=
dle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pp_handle-=
&gt;pp_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_dpm_en_umd_pstate(hwmgr=
, &amp;level);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;request_dpm_leve=
l =3D level;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_handle_task(pp_handle, AMD_PP_T=
ASK_READJUST_POWER_STATE, NULL, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_handle_task(pp_handle, AMD_=
PP_TASK_READJUST_POWER_STATE, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_fu=
nc-&gt;force_dpm_level(hwmgr, level);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dpm_level =3D hwmgr-&gt;request_dpm_level;<=
br>
@@ -519,7 &#43;519,7 @@ static void pp_dpm_powergate_uvd(void *handle, bool=
 gate)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_=
id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; void *input, void *output)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; enum amd_pm_state_type *user_state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_instance *pp_han=
dle =3D (struct pp_instance *)handle;<br>
@@ -530,7 &#43;530,7 @@ static int pp_dpm_dispatch_tasks(void *handle, enum=
 amd_pp_task task_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pp_handle-=
&gt;pp_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_handle_task(pp_handle, =
task_id, input, output);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_handle_task(pp_hand=
le, task_id, user_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pp_handl=
e-&gt;pp_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -805,7 &#43;805,7 @@ static int amd_powerplay_reset(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr_handle_task(instance, AM=
D_PP_TASK_COMPLETE_INIT, NULL, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr_handle_task(instance=
, AMD_PP_TASK_COMPLETE_INIT, NULL);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t =
size)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index 38f7d0d..56de107 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -373,7 &#43;373,7 @@ static enum PP_StateUILabel power_state_convert(enu=
m amd_pm_state_type&nbsp; state)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int hwmgr_handle_task(struct pp_instance *handle, enum amd_pp_task ta=
sk_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; void *input, void *output)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; enum amd_pm_state_type *user_state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr;<br=
>
@@ -395,17 &#43;395,15 @@ int hwmgr_handle_task(struct pp_instance *handle,=
 enum amd_pp_task task_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_PP_TASK_ENABLE_US=
ER_STATE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum amd_pm_state_type ps;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum PP_StateUILabel requested_ui_label;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_power_state *requested_ps =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (input =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (user_state =3D=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ps =3D *(unsigned long *)input;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; requested_ui_label =3D power_state_convert(ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; requested_ui_label =3D power_state_convert(*user_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psm_set_user_performance_state(hwmgr, request=
ed_ui_label, &amp;requested_ps);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 80d35d8..bf0bf47 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -815,7 &#43;815,7 @@ extern int hwmgr_hw_suspend(struct pp_instance *han=
dle);<br>
&nbsp;extern int hwmgr_hw_resume(struct pp_instance *handle);<br>
&nbsp;extern int hwmgr_handle_task(struct pp_instance *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_task task_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *input, void *output);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type *user_state);<br=
>
&nbsp;extern int phm_wait_on_register(struct pp_hwmgr *hwmgr, uint32_t inde=
x,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value, uint32_t mask);<=
br>
&nbsp;<br>
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

--_000_BN6PR12MB16521CE9DDA6A72C4B20EF3FF71A0BN6PR12MB1652namp_--

--===============1926963842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1926963842==--
