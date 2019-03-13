From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: enable gfxoff again on raven series
Date: Wed, 13 Mar 2019 14:06:47 +0000
Message-ID: <BN6PR12MB1809AE1D3301D82B544F1A6AF74A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1552480051-11978-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0095457884=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1552480051-11978-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0095457884==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809AE1D3301D82B544F1A6AF74A0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809AE1D3301D82B544F1A6AF74A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Huang Ru=
i <ray.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, March 13, 2019 8:27 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang, Ray
Subject: [PATCH] drm/amdgpu: enable gfxoff again on raven series

This patch enables gfxoff and stutter mode again, since we take more testin=
g on
raven series. For raven2 and picasso, we can enable it directly. And for ra=
ven,
we need check the RLC ucode version cannot be less than #531.

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 21 +++++++++++++++++++=
++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 13 ++++---------
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 95cd3b7..02c1125 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1508,6 +1508,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)
         }

         adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
+       if (amdgpu_sriov_vf(adev))
+               adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;

         for (i =3D 0; i < adev->num_ip_blocks; i++) {
                 if ((amdgpu_ip_block_mask & (1 << i)) =3D=3D 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 4a8c422..5681a41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -118,8 +118,8 @@ uint amdgpu_pg_mask =3D 0xffffffff;
 uint amdgpu_sdma_phase_quantum =3D 32;
 char *amdgpu_disable_cu =3D NULL;
 char *amdgpu_virtual_display =3D NULL;
-/* OverDrive(bit 14),gfxoff(bit 15),stutter mode(bit 17) disabled by defau=
lt*/
-uint amdgpu_pp_feature_mask =3D 0xfffd3fff;
+/* OverDrive(bit 14) disabled by default*/
+uint amdgpu_pp_feature_mask =3D 0xffffbfff;
 int amdgpu_ngg =3D 0;
 int amdgpu_prim_buf_per_se =3D 0;
 int amdgpu_pos_buf_per_se =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 60c582c..6b48d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -578,6 +578,26 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu=
_device *adev)
         }
 }

+static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
+{
+       switch (adev->asic_type) {
+       case CHIP_VEGA10:
+       case CHIP_VEGA12:
+       case CHIP_VEGA20:
+               break;
+       case CHIP_RAVEN:
+               if (adev->rev_id >=3D 0x8 || adev->pdev->device =3D=3D 0x15=
d8)
+                       break;
+               if ((adev->gfx.rlc_fw_version < 531) ||
+                   (adev->gfx.rlc_feature_version < 1) ||
+                   !adev->gfx.rlc.is_rlc_v2_1)
+                       adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
+               break;
+       default:
+               break;
+       }
+}
+
 static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 {
         const char *chip_name;
@@ -830,6 +850,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device=
 *adev)
         }

 out:
+       gfx_v9_0_check_if_need_gfxoff(adev);
         gfx_v9_0_check_fw_write_wait(adev);
         if (err) {
                 dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 0ad8fe4..f32e3d0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -114,11 +114,6 @@ static int smu10_initialize_dpm_defaults(struct pp_hwm=
gr *hwmgr)
         smu10_data->num_active_display =3D 0;
         smu10_data->deep_sleep_dcefclk =3D 0;

-       if (hwmgr->feature_mask & PP_GFXOFF_MASK)
-               smu10_data->gfx_off_controled_by_driver =3D true;
-       else
-               smu10_data->gfx_off_controled_by_driver =3D false;
-
         phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
                                         PHM_PlatformCaps_SclkDeepSleep);

@@ -330,9 +325,9 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)

 static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
 {
-       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->ba=
ckend);
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       if (smu10_data->gfx_off_controled_by_driver) {
+       if (adev->pm.pp_feature & PP_GFXOFF_MASK) {
                 smum_send_msg_to_smc(hwmgr, PPSMC_MSG_DisableGfxOff);

                 /* confirm gfx is back to "on" state */
@@ -350,9 +345,9 @@ static int smu10_disable_dpm_tasks(struct pp_hwmgr *hwm=
gr)

 static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
 {
-       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->ba=
ckend);
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       if (smu10_data->gfx_off_controled_by_driver)
+       if (adev->pm.pp_feature & PP_GFXOFF_MASK)
                 smum_send_msg_to_smc(hwmgr, PPSMC_MSG_EnableGfxOff);

         return 0;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809AE1D3301D82B544F1A6AF74A0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Huang Rui &lt;ray.huang@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, March 13, 2019 8:27 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Huang, Ray<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable gfxoff again on raven series</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch enables gfxoff and stutter mode again, =
since we take more testing on<br>
raven series. For raven2 and picasso, we can enable it directly. And for ra=
ven,<br>
we need check the RLC ucode version cannot be less than #531.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 21 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 13 &#43;&#43;&#43=
;&#43;---------<br>
&nbsp;4 files changed, 29 insertions(&#43;), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 95cd3b7..02c1125 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1508,6 &#43;1508,8 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature =3D=
 amdgpu_pp_feature_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;num_ip_blocks; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_block_mask &amp; (1 &lt;&lt; i)) =3D=
=3D 0) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 4a8c422..5681a41 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -118,8 &#43;118,8 @@ uint amdgpu_pg_mask =3D 0xffffffff;<br>
&nbsp;uint amdgpu_sdma_phase_quantum =3D 32;<br>
&nbsp;char *amdgpu_disable_cu =3D NULL;<br>
&nbsp;char *amdgpu_virtual_display =3D NULL;<br>
-/* OverDrive(bit 14),gfxoff(bit 15),stutter mode(bit 17) disabled by defau=
lt*/<br>
-uint amdgpu_pp_feature_mask =3D 0xfffd3fff;<br>
&#43;/* OverDrive(bit 14) disabled by default*/<br>
&#43;uint amdgpu_pp_feature_mask =3D 0xffffbfff;<br>
&nbsp;int amdgpu_ngg =3D 0;<br>
&nbsp;int amdgpu_prim_buf_per_se =3D 0;<br>
&nbsp;int amdgpu_pos_buf_per_se =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 60c582c..6b48d4c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -578,6 &#43;578,26 @@ static void gfx_v9_0_check_fw_write_wait(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)<=
br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;rev_id &gt;=3D 0x8 || adev-&gt;pdev-&gt;device =
=3D=3D 0x15d8)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if ((adev-&gt;gfx.rlc_fw_version &lt; 531) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.rlc_feature_version &l=
t; 1) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gfx.rlc.is_rlc_v2_1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.=
pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *chip_name;<br>
@@ -830,6 &#43;850,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;out:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_check_if_need_gfxoff(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_check_fw_write_wa=
it(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index 0ad8fe4..f32e3d0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -114,11 &#43;114,6 @@ static int smu10_initialize_dpm_defaults(struct pp=
_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_data-&gt;num_active_=
display =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_data-&gt;deep_sleep_=
dcefclk =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;feature_mask &amp; PP_G=
FXOFF_MASK)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;gfx_off_controled_by_driver =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;gfx_off_controled_by_driver =3D false;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_unset(hwmgr-&gt;pl=
atform_descriptor.platformCaps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PHM_PlatformCaps_SclkDeepSleep);<br>
&nbsp;<br>
@@ -330,9 &#43;325,9 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)=
<br>
&nbsp;<br>
&nbsp;static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =3D (s=
truct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;gfx_off_controled_=
by_driver) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; =
PP_GFXOFF_MASK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_DisableGfxOff);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* confirm gfx is back to &quot;on&quot; state */<br>
@@ -350,9 &#43;345,9 @@ static int smu10_disable_dpm_tasks(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;<br>
&nbsp;static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =3D (s=
truct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;gfx_off_controled_=
by_driver)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; =
PP_GFXOFF_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_EnableGfxOff);<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809AE1D3301D82B544F1A6AF74A0BN6PR12MB1809namp_--

--===============0095457884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0095457884==--
