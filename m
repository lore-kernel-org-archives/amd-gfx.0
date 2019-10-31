From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: support xgmi pstate setting on
 powerplay routine V2
Date: Thu, 31 Oct 2019 14:23:28 +0000
Message-ID: <BN6SPR00MB1827F35F7FC4DC953BB9758F7630@BN6SPR00MB182.namprd12.prod.outlook.com>
References: <20191031072205.27537-1-evan.quan@amd.com>,
 <20191031072205.27537-3-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1062293775=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191031072205.27537-3-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Kim, Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>

--===============1062293775==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6SPR00MB1827F35F7FC4DC953BB9758F7630BN6SPR00MB182namp_"

--_000_BN6SPR00MB1827F35F7FC4DC953BB9758F7630BN6SPR00MB182namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, October 31, 2019 3:22 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Kim, Jonathan <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deu=
cher-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amd/powerplay: support xgmi pstate setting on powe=
rplay routine V2

Add xgmi pstate setting on powerplay routine.

Change-Id: If1a49aa14c16f133e43ac1298c6b14eaeb44d79d
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

V2: split the change of is_support_sw_smu_xgmi into a separate patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c       |  5 +++++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  4 ++++
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c  | 18 ++++++++++++++++++
 .../gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h      |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      |  5 +----
 6 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 00371713c671..167d9fbd2c4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -285,6 +285,11 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev,=
 int pstate)

         if (is_support_sw_smu_xgmi(adev))
                 ret =3D smu_set_xgmi_pstate(&adev->smu, pstate);
+       else if (adev->powerplay.pp_funcs &&
+                adev->powerplay.pp_funcs->set_xgmi_pstate)
+               ret =3D adev->powerplay.pp_funcs->set_xgmi_pstate(adev->pow=
erplay.pp_handle,
+                                                               pstate);
+
         if (ret)
                 dev_err(adev->dev,
                         "XGMI: Set pstate failure on device %llx, hive %ll=
x, ret %d",
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 5902f80d1fce..a7f92d0b3a90 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -220,6 +220,9 @@ enum pp_df_cstate {
                 ((group) << PP_GROUP_SHIFT | (block) << PP_BLOCK_SHIFT | \
                 (support) << PP_STATE_SUPPORT_SHIFT | (state) << PP_STATE_=
SHIFT)

+#define XGMI_MODE_PSTATE_D3 0
+#define XGMI_MODE_PSTATE_D0 1
+
 struct seq_file;
 enum amd_pp_clock_type;
 struct amd_pp_simple_clock_info;
@@ -318,6 +321,7 @@ struct amd_pm_funcs {
         int (*set_ppfeature_status)(void *handle, uint64_t ppfeature_masks=
);
         int (*asic_reset_mode_2)(void *handle);
         int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
+       int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 };

 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index f4ff15378e61..031447675203 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1566,6 +1566,23 @@ static int pp_set_df_cstate(void *handle, enum pp_df=
_cstate state)
         return 0;
 }

+static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)
+{
+       struct pp_hwmgr *hwmgr =3D handle;
+
+       if (!hwmgr)
+               return -EINVAL;
+
+       if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_xgmi_pstate)
+               return 0;
+
+       mutex_lock(&hwmgr->smu_lock);
+       hwmgr->hwmgr_func->set_xgmi_pstate(hwmgr, pstate);
+       mutex_unlock(&hwmgr->smu_lock);
+
+       return 0;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs =3D {
         .load_firmware =3D pp_dpm_load_fw,
         .wait_for_fw_loading_complete =3D pp_dpm_fw_loading_complete,
@@ -1625,4 +1642,5 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
         .asic_reset_mode_2 =3D pp_asic_reset_mode_2,
         .smu_i2c_bus_access =3D pp_smu_i2c_bus_access,
         .set_df_cstate =3D pp_set_df_cstate,
+       .set_xgmi_pstate =3D pp_set_xgmi_pstate,
 };
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 9295bd90b792..5bcf0d684151 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -4176,6 +4176,20 @@ static int vega20_set_df_cstate(struct pp_hwmgr *hwm=
gr,
         return ret;
 }

+static int vega20_set_xgmi_pstate(struct pp_hwmgr *hwmgr,
+                                 uint32_t pstate)
+{
+       int ret;
+
+       ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
+                                                 PPSMC_MSG_SetXgmiMode,
+                                                 pstate ? XGMI_MODE_PSTATE=
_D0 : XGMI_MODE_PSTATE_D3);
+       if (ret)
+               pr_err("SetXgmiPstate failed!\n");
+
+       return ret;
+}
+
 static const struct pp_hwmgr_func vega20_hwmgr_funcs =3D {
         /* init/fini related */
         .backend_init =3D vega20_hwmgr_backend_init,
@@ -4245,6 +4259,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs =
=3D {
         .set_mp1_state =3D vega20_set_mp1_state,
         .smu_i2c_bus_access =3D vega20_smu_i2c_bus_access,
         .set_df_cstate =3D vega20_set_df_cstate,
+       .set_xgmi_pstate =3D vega20_set_xgmi_pstate,
 };

 int vega20_hwmgr_init(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index bd8c922dfd3e..40403bc76f1b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -356,6 +356,7 @@ struct pp_hwmgr_func {
         int (*asic_reset)(struct pp_hwmgr *hwmgr, enum SMU_ASIC_RESET_MODE=
 mode);
         int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool aquire);
         int (*set_df_cstate)(struct pp_hwmgr *hwmgr, enum pp_df_cstate sta=
te);
+       int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
 };

 struct pp_table_func {
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 7e882999abad..5877857760be 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1463,16 +1463,13 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context =
*smu,
         return ret;
 }

-#define XGMI_STATE_D0 1
-#define XGMI_STATE_D3 0
-
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
                                      uint32_t pstate)
 {
         int ret =3D 0;
         ret =3D smu_send_smc_msg_with_param(smu,
                                           SMU_MSG_SetXgmiMode,
-                                         pstate ? XGMI_STATE_D0 : XGMI_STA=
TE_D3);
+                                         pstate ? XGMI_MODE_PSTATE_D0 : XG=
MI_MODE_PSTATE_D3);
         return ret;
 }

--
2.23.0


--_000_BN6SPR00MB1827F35F7FC4DC953BB9758F7630BN6SPR00MB182namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 31, 2019 3:22 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Kim, Jonathan &lt;Jonathan.Kim-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &=
lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/powerplay: support xgmi pstate setting =
on powerplay routine V2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add xgmi pstate setting on powerplay routine.<br>
<br>
Change-Id: If1a49aa14c16f133e43ac1298c6b14eaeb44d79d<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
V2: split the change of is_support_sw_smu_xgmi into a separate patch<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 5 &#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/include/kgd_pp_interface.h |&nbsp; 4 &#43;&#43;&#=
43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp; | 18 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 15 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 5 &#43;----<br>
&nbsp;6 files changed, 44 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index 00371713c671..167d9fbd2c4f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -285,6 &#43;285,11 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *a=
dev, int pstate)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu_xgmi=
(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_xgmi_pstate(&amp;adev-&gt;smu, pstate=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_fu=
ncs &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;set_xgmi_pstate)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D adev-&gt;powerplay.pp_funcs-&gt;set_xgmi_pstate(adev=
-&gt;powerplay.pp_handle,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; pstate);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;XGMI: Set pstate failure on device %llx, hive %llx, ret %d&quot;,<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 5902f80d1fce..a7f92d0b3a90 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -220,6 &#43;220,9 @@ enum pp_df_cstate {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((group) &lt;&lt; PP_GROUP_SHIFT | (block) &lt;&lt; P=
P_BLOCK_SHIFT | \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (support) &lt;&lt; PP_STATE_SUPPORT_SHIFT | (state) &=
lt;&lt; PP_STATE_SHIFT)<br>
&nbsp;<br>
&#43;#define XGMI_MODE_PSTATE_D3 0<br>
&#43;#define XGMI_MODE_PSTATE_D0 1<br>
&#43;<br>
&nbsp;struct seq_file;<br>
&nbsp;enum amd_pp_clock_type;<br>
&nbsp;struct amd_pp_simple_clock_info;<br>
@@ -318,6 &#43;321,7 @@ struct amd_pm_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_ppfeature_status=
)(void *handle, uint64_t ppfeature_masks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*asic_reset_mode_2)(v=
oid *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_df_cstate)(void =
*handle, enum pp_df_cstate state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_xgmi_pstate)(void *hand=
le, uint32_t pstate);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index f4ff15378e61..031447675203 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -1566,6 &#43;1566,23 @@ static int pp_set_df_cstate(void *handle, enum p=
p_df_cstate state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm_en || !hwmgr-&g=
t;hwmgr_func-&gt;set_xgmi_pstate)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_xgmi=
_pstate(hwmgr, pstate);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct amd_pm_funcs pp_dpm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_firmware =3D pp_dpm_=
load_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_fw_loading_compl=
ete =3D pp_dpm_fw_loading_complete,<br>
@@ -1625,4 &#43;1642,5 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_reset_mode_2 =3D pp_=
asic_reset_mode_2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_i2c_bus_access =3D pp=
_smu_i2c_bus_access,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_df_cstate =3D pp_set_=
df_cstate,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_xgmi_pstate =3D pp_set_xgmi_=
pstate,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 9295bd90b792..5bcf0d684151 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -4176,6 &#43;4176,20 @@ static int vega20_set_df_cstate(struct pp_hwmgr =
*hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int vega20_set_xgmi_pstate(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc_with=
_parameter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_SetXgmiMode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate=
 ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;SetXgmiPstate failed!\n&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pp_hwmgr_func vega20_hwmgr_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init/fini related */<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D vega20_h=
wmgr_backend_init,<br>
@@ -4245,6 &#43;4259,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D vega20_=
set_mp1_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_i2c_bus_access =3D ve=
ga20_smu_i2c_bus_access,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_df_cstate =3D vega20_=
set_df_cstate,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_xgmi_pstate =3D vega20_set_x=
gmi_pstate,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int vega20_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index bd8c922dfd3e..40403bc76f1b 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -356,6 &#43;356,7 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*asic_reset)(struct p=
p_hwmgr *hwmgr, enum SMU_ASIC_RESET_MODE mode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_i2c_bus_access)(=
struct pp_hwmgr *hwmgr, bool aquire);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_df_cstate)(struc=
t pp_hwmgr *hwmgr, enum pp_df_cstate state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_xgmi_pstate)(struct pp_=
hwmgr *hwmgr, uint32_t pstate);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct pp_table_func {<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 7e882999abad..5877857760be 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1463,16 &#43;1463,13 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-#define XGMI_STATE_D0 1<br>
-#define XGMI_STATE_D3 0<br>
-<br>
&nbsp;int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt32_t pstate)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_w=
ith_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetXgmiMode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; pstate ? XGMI_STATE_D0 : XGMI_STATE_D3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.23.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6SPR00MB1827F35F7FC4DC953BB9758F7630BN6SPR00MB182namp_--

--===============1062293775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1062293775==--
