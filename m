From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Add a new pp feature mask bit for OD
 feature
Date: Thu, 4 Jan 2018 14:28:30 +0000
Message-ID: <BN6PR12MB16524FE11B6CC348B7EFB997F71F0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1515059910-29827-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1321936013=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515059910-29827-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1321936013==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16524FE11B6CC348B7EFB997F71F0BN6PR12MB1652namp_"

--_000_BN6PR12MB16524FE11B6CC348B7EFB997F71F0BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, January 4, 2018 4:58:29 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 1/2] drm/amd/pp: Add a new pp feature mask bit for OD featu=
re

when this bit was set on module load,
driver will allow the user over/under gpu
clock and voltage through sysfs.

by default, this bit was not set.

Change-Id: I4ec2d3a689ae946d4af9f904c59b42da5b929181
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 3 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 6 ++----
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 7 ++-----
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          | 2 ++
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 50afcf6..defe73a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -119,7 +119,7 @@
 uint amdgpu_sdma_phase_quantum =3D 32;
 char *amdgpu_disable_cu =3D NULL;
 char *amdgpu_virtual_display =3D NULL;
-uint amdgpu_pp_feature_mask =3D 0xffffffff;
+uint amdgpu_pp_feature_mask =3D 0x2fff;
 int amdgpu_ngg =3D 0;
 int amdgpu_prim_buf_per_se =3D 0;
 int amdgpu_pos_buf_per_se =3D 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index e35bdc5..ebfbbcf 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -935,6 +935,9 @@ int hwmgr_set_user_specify_caps(struct pp_hwmgr *hwmgr)
                         PHM_PlatformCaps_CAC);
         }

+       if (hwmgr->feature_mask & PP_OVER_DRIVER_MASK)
+               hwmgr->od_enabled =3D true;
+
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index fdbe117..9b17cec 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3606,8 +3606,7 @@ static int smu7_populate_and_upload_sclk_mclk_dpm_lev=
els(
                 dpm_table->sclk_table.dpm_levels
                 [dpm_table->sclk_table.count - 1].value =3D sclk;

-               if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
, PHM_PlatformCaps_OD6PlusinACSupport) ||
-                   phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
, PHM_PlatformCaps_OD6PlusinDCSupport)) {
+               if (hwmgr->od_enabled) {
                 /* Need to do calculation based on the golden DPM table
                  * as the Heatmap GPU Clock axis is also based on the defa=
ult values
                  */
@@ -3652,8 +3651,7 @@ static int smu7_populate_and_upload_sclk_mclk_dpm_lev=
els(
                 dpm_table->mclk_table.dpm_levels
                         [dpm_table->mclk_table.count - 1].value =3D mclk;

-               if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
, PHM_PlatformCaps_OD6PlusinACSupport) ||
-                   phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
, PHM_PlatformCaps_OD6PlusinDCSupport)) {
+               if (hwmgr->od_enabled) {

                         PP_ASSERT_WITH_CODE(
                                         (golden_dpm_table->mclk_table.dpm_=
levels
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 7e6feed..4219004 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3394,8 +3394,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_l=
evels(
                                 dpm_table->
                                 gfx_table.dpm_levels[dpm_table->gfx_table.=
count - 1].
                                 value =3D sclk;
-                               if (PP_CAP(PHM_PlatformCaps_OD6PlusinACSupp=
ort) ||
-                                   PP_CAP(PHM_PlatformCaps_OD6PlusinDCSupp=
ort)) {
+                               if (hwmgr->od_enabled) {
                                         /* Need to do calculation based on=
 the golden DPM table
                                          * as the Heatmap GPU Clock axis i=
s also based on
                                          * the default values
@@ -3449,9 +3448,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_l=
evels(
                         mem_table.dpm_levels[dpm_table->mem_table.count - =
1].
                         value =3D mclk;

-                       if (PP_CAP(PHM_PlatformCaps_OD6PlusinACSupport) ||
-                           PP_CAP(PHM_PlatformCaps_OD6PlusinDCSupport)) {
-
+                       if (hwmgr->od_enabled) {
                                 PP_ASSERT_WITH_CODE(
                                         golden_dpm_table->mem_table.dpm_le=
vels
                                         [golden_dpm_table->mem_table.count=
 - 1].value,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index f37f211..5d92f13 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -84,6 +84,7 @@ enum PP_FEATURE_MASK {
         PP_OD_FUZZY_FAN_CONTROL_MASK =3D 0x800,
         PP_SOCCLK_DPM_MASK =3D 0x1000,
         PP_DCEFCLK_DPM_MASK =3D 0x2000,
+       PP_OVER_DRIVER_MASK =3D 0x4000,
 };

 enum PHM_BackEnd_Magic {
@@ -750,6 +751,7 @@ struct pp_hwmgr {
         struct amd_pp_profile default_compute_power_profile;
         enum amd_pp_profile_type current_power_profile;
         bool en_umd_pstate;
+       bool od_enabled;
 };

 struct cgs_irq_src_funcs {
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16524FE11B6CC348B7EFB997F71F0BN6PR12MB1652namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Thursday, January 4, 2018 4:58:29 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/pp: Add a new pp feature mask bit for O=
D feature</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">when this bit was set on module load,<br>
driver will allow the user over/under gpu<br>
clock and voltage through sysfs.<br>
<br>
by default, this bit was not set.<br>
<br>
Change-Id: I4ec2d3a689ae946d4af9f904c59b42da5b929181<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; | 6 &#43=
;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 7 &#43;&#43;----=
-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;&#43;<br>
&nbsp;5 files changed, 10 insertions(&#43;), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 50afcf6..defe73a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -119,7 &#43;119,7 @@<br>
&nbsp;uint amdgpu_sdma_phase_quantum =3D 32;<br>
&nbsp;char *amdgpu_disable_cu =3D NULL;<br>
&nbsp;char *amdgpu_virtual_display =3D NULL;<br>
-uint amdgpu_pp_feature_mask =3D 0xffffffff;<br>
&#43;uint amdgpu_pp_feature_mask =3D 0x2fff;<br>
&nbsp;int amdgpu_ngg =3D 0;<br>
&nbsp;int amdgpu_prim_buf_per_se =3D 0;<br>
&nbsp;int amdgpu_pos_buf_per_se =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index e35bdc5..ebfbbcf 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -935,6 &#43;935,9 @@ int hwmgr_set_user_specify_caps(struct pp_hwmgr *hw=
mgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_P=
latformCaps_CAC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;feature_mask &amp; =
PP_OVER_DRIVER_MASK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;od_enabled =3D true;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index fdbe117..9b17cec 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -3606,8 &#43;3606,7 @@ static int smu7_populate_and_upload_sclk_mclk_dpm=
_levels(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;sclk_table.dpm_levels<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [dpm_table-&gt;sclk_table.count - 1].value =3D sclk;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platform_descriptor.platformCaps, =
PHM_PlatformCaps_OD6PlusinACSupport) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_enabled(hwmgr-&gt;platform_descr=
iptor.platformCaps, PHM_PlatformCaps_OD6PlusinDCSupport)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Need to do calculation based on the golden DPM tab=
le<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * as the Heatmap GPU Clock axis is also based o=
n the default values<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
@@ -3652,8 &#43;3651,7 @@ static int smu7_populate_and_upload_sclk_mclk_dpm=
_levels(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;mclk_table.dpm_levels<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [dpm_=
table-&gt;mclk_table.count - 1].value =3D mclk;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platform_descriptor.platformCaps, =
PHM_PlatformCaps_OD6PlusinACSupport) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_enabled(hwmgr-&gt;platform_descr=
iptor.platformCaps, PHM_PlatformCaps_OD6PlusinDCSupport)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_AS=
SERT_WITH_CODE(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (golden_dpm_table-&gt;mclk_table.dpm_levels<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 7e6feed..4219004 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -3394,8 &#43;3394,7 @@ static int vega10_populate_and_upload_sclk_mclk_d=
pm_levels(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_table.dpm_levels[dpm_table-&=
gt;gfx_table.count - 1].<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D sclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_OD6PlusinACSupp=
ort) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_CAP(PHM_Platform=
Caps_OD6PlusinDCSupport)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Need to do calculation based on the golden DPM table<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * as the Heatmap GPU Clock axis is also based on<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * the default values<br>
@@ -3449,9 &#43;3448,7 @@ static int vega10_populate_and_upload_sclk_mclk_d=
pm_levels(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_t=
able.dpm_levels[dpm_table-&gt;mem_table.count - 1].<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value=
 =3D mclk;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_P=
latformCaps_OD6PlusinACSupport) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PP_CAP(PHM_PlatformCaps_OD6PlusinDCSupport)) {<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&g=
t;od_enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; golden_dpm_table-&gt;mem_table.dpm_levels<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; [golden_dpm_table-&gt;mem_table.count - 1].value,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index f37f211..5d92f13 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -84,6 &#43;84,7 @@ enum PP_FEATURE_MASK {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_OD_FUZZY_FAN_CONTROL_MA=
SK =3D 0x800,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SOCCLK_DPM_MASK =3D 0x1=
000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_DCEFCLK_DPM_MASK =3D 0x=
2000,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_OVER_DRIVER_MASK =3D 0x4000,<b=
r>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum PHM_BackEnd_Magic {<br>
@@ -750,6 &#43;751,7 @@ struct pp_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile defa=
ult_compute_power_profile;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_profile_type c=
urrent_power_profile;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en_umd_pstate;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool od_enabled;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct cgs_irq_src_funcs {<br>
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

--_000_BN6PR12MB16524FE11B6CC348B7EFB997F71F0BN6PR12MB1652namp_--

--===============1321936013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1321936013==--
