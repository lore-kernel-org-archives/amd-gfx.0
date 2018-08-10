From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: check vrefresh when when changing
 displays
Date: Fri, 10 Aug 2018 05:58:31 +0000
Message-ID: <BYAPR12MB2775546AB3262A18FF962106FB240@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <20180809201623.3039-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0108496657=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180809201623.3039-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0108496657==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775546AB3262A18FF962106FB240BYAPR12MB2775namp_"

--_000_BYAPR12MB2775546AB3262A18FF962106FB240BYAPR12MB2775namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch is Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Thanks.



Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, August 10, 2018 4:16:23 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/powerplay: check vrefresh when when changing di=
splays

Compare the current vrefresh in addition to the number of displays
when determining whether or not the smu needs updates when changing
modes. The SMU needs to be updated if the vbi timeout changes due
to a different refresh rate.  Fixes flickering around mode changes
in some cases on polaris parts.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c        | 3 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h        | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c        | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c      | 3 ++-
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c   | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c     | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c     | 1 +
 8 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 380f282a64ba..ab759e38e4ea 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4132,6 +4132,9 @@ smu7_check_smc_update_required_for_display_configurat=
ion(struct pp_hwmgr *hwmgr)
         if (data->display_timing.num_existing_displays !=3D hwmgr->display=
_config->num_display)
                 is_update_required =3D true;

+       if (data->display_timing.vrefresh !=3D hwmgr->display_config->vrefr=
esh)
+               is_update_required =3D true;
+
         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_P=
latformCaps_SclkDeepSleep)) {
                 if (data->display_timing.min_clock_in_sr !=3D hwmgr->displ=
ay_config->min_core_set_clock_in_sr &&
                         (data->display_timing.min_clock_in_sr >=3D SMU7_MI=
NIMUM_ENGINE_CLOCK ||
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
index 3784ce6e50ab..69d361f8dfca 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
@@ -156,6 +156,7 @@ struct smu7_vbios_boot_state {
 struct smu7_display_timing {
         uint32_t  min_clock_in_sr;
         uint32_t  num_existing_displays;
+       uint32_t  vrefresh;
 };

 struct smu7_dpmlevel_enable_mask {
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/ci_smumgr.c
index fbe3ef4ee45c..18643e06bc6f 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -1231,6 +1231,7 @@ static int ci_populate_single_memory_level(
         memory_level->DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;

         data->display_timing.num_existing_displays =3D hwmgr->display_conf=
ig->num_display;
+       data->display_timing.vrefresh =3D hwmgr->display_config->vrefresh;

         /* stutter mode not support on ci */

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 18048f8e2f13..ec14798e87b6 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -1210,7 +1210,8 @@ static int fiji_populate_single_memory_level(struct p=
p_hwmgr *hwmgr,
          * PECI_GetNumberOfActiveDisplays(hwmgr->pPECI,
          * &(data->DisplayTiming.numExistingDisplays));
          */
-       data->display_timing.num_existing_displays =3D 1;
+       data->display_timing.num_existing_displays =3D hwmgr->display_confi=
g->num_display;
+       data->display_timing.vrefresh =3D hwmgr->display_config->vrefresh;

         if (mclk_stutter_mode_threshold &&
                 (clock <=3D mclk_stutter_mode_threshold) &&
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 9299b93aa09a..73aa368a454e 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -1280,6 +1280,7 @@ static int iceland_populate_single_memory_level(
         memory_level->DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;

         data->display_timing.num_existing_displays =3D hwmgr->display_conf=
ig->num_display;
+       data->display_timing.vrefresh =3D hwmgr->display_config->vrefresh;

         /* stutter mode not support on iceland */

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 1276f168ff68..872d3824337b 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -1103,6 +1103,7 @@ static int polaris10_populate_single_memory_level(str=
uct pp_hwmgr *hwmgr,
         mem_level->DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;

         data->display_timing.num_existing_displays =3D hwmgr->display_conf=
ig->num_display;
+       data->display_timing.vrefresh =3D hwmgr->display_config->vrefresh;

         if (mclk_stutter_mode_threshold &&
                 (clock <=3D mclk_stutter_mode_threshold) &&
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 7dabc6c456e1..ae8378ed32ee 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -1004,6 +1004,7 @@ static int tonga_populate_single_memory_level(
         memory_level->DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;

         data->display_timing.num_existing_displays =3D hwmgr->display_conf=
ig->num_display;
+       data->display_timing.vrefresh =3D hwmgr->display_config->vrefresh;

         if ((mclk_stutter_mode_threshold !=3D 0) &&
             (memory_clock <=3D mclk_stutter_mode_threshold) &&
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 57420d7caa4e..3d415fabbd93 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1009,6 +1009,7 @@ static int vegam_populate_single_memory_level(struct =
pp_hwmgr *hwmgr,
         mem_level->DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;

         data->display_timing.num_existing_displays =3D hwmgr->display_conf=
ig->num_display;
+       data->display_timing.vrefresh =3D hwmgr->display_config->vrefresh;

         if (mclk_stutter_mode_threshold &&
                 (clock <=3D mclk_stutter_mode_threshold) &&
--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BYAPR12MB2775546AB3262A18FF962106FB240BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Patch is<span> Reviewed-by: <span=
>Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Thanks.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Best Regards</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Rex</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Friday, August 10, 2018 4:16:23 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu/powerplay: check vrefresh when when chan=
ging displays</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Compare the current vrefresh in addition to the nu=
mber of displays<br>
when determining whether or not the smu needs updates when changing<br>
modes. The SMU needs to be updated if the vbi timeout changes due<br>
to a different refresh rate.&nbsp; Fixes flickering around mode changes<br>
in some cases on polaris parts.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c&nbsp;&nbsp; | 1=
 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 1 &#43;<br>
&nbsp;8 files changed, 11 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 380f282a64ba..ab759e38e4ea 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -4132,6 &#43;4132,9 @@ smu7_check_smc_update_required_for_display_config=
uration(struct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;display_timin=
g.num_existing_displays !=3D hwmgr-&gt;display_config-&gt;num_display)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; is_update_required =3D true;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;display_timing.vrefr=
esh !=3D hwmgr-&gt;display_config-&gt;vrefresh)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; is_update_required =3D true;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-=
&gt;platform_descriptor.platformCaps, PHM_PlatformCaps_SclkDeepSleep)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (data-&gt;display_timing.min_clock_in_sr !=3D hwmg=
r-&gt;display_config-&gt;min_core_set_clock_in_sr &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data=
-&gt;display_timing.min_clock_in_sr &gt;=3D SMU7_MINIMUM_ENGINE_CLOCK ||<br=
>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
index 3784ce6e50ab..69d361f8dfca 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
@@ -156,6 &#43;156,7 @@ struct smu7_vbios_boot_state {<br>
&nbsp;struct smu7_display_timing {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; min_clock_i=
n_sr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; num_existin=
g_displays;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; vrefresh;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct smu7_dpmlevel_enable_mask {<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
index fbe3ef4ee45c..18643e06bc6f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
@@ -1231,6 &#43;1231,7 @@ static int ci_populate_single_memory_level(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory_level-&gt;DisplayWa=
termark =3D PPSMC_DISPLAY_WATERMARK_LOW;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.nu=
m_existing_displays =3D hwmgr-&gt;display_config-&gt;num_display;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.vrefresh =
=3D hwmgr-&gt;display_config-&gt;vrefresh;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stutter mode not suppor=
t on ci */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
index 18048f8e2f13..ec14798e87b6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
@@ -1210,7 &#43;1210,8 @@ static int fiji_populate_single_memory_level(stru=
ct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PECI_GetNumberOfAc=
tiveDisplays(hwmgr-&gt;pPECI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &amp;(data-&gt;Dis=
playTiming.numExistingDisplays));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.num_existing_=
displays =3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.num_exist=
ing_displays =3D hwmgr-&gt;display_config-&gt;num_display;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.vrefresh =
=3D hwmgr-&gt;display_config-&gt;vrefresh;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_stutter_mode_thre=
shold &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (clock &lt;=3D mclk_stutter_mode_threshold) &amp;&amp=
;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
index 9299b93aa09a..73aa368a454e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
@@ -1280,6 &#43;1280,7 @@ static int iceland_populate_single_memory_level(<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory_level-&gt;DisplayWa=
termark =3D PPSMC_DISPLAY_WATERMARK_LOW;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.nu=
m_existing_displays =3D hwmgr-&gt;display_config-&gt;num_display;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.vrefresh =
=3D hwmgr-&gt;display_config-&gt;vrefresh;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stutter mode not suppor=
t on iceland */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
index 1276f168ff68..872d3824337b 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<b=
r>
@@ -1103,6 &#43;1103,7 @@ static int polaris10_populate_single_memory_level=
(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_level-&gt;DisplayWater=
mark =3D PPSMC_DISPLAY_WATERMARK_LOW;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.nu=
m_existing_displays =3D hwmgr-&gt;display_config-&gt;num_display;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.vrefresh =
=3D hwmgr-&gt;display_config-&gt;vrefresh;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_stutter_mode_thre=
shold &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (clock &lt;=3D mclk_stutter_mode_threshold) &amp;&amp=
;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
index 7dabc6c456e1..ae8378ed32ee 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
@@ -1004,6 &#43;1004,7 @@ static int tonga_populate_single_memory_level(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory_level-&gt;DisplayWa=
termark =3D PPSMC_DISPLAY_WATERMARK_LOW;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.nu=
m_existing_displays =3D hwmgr-&gt;display_config-&gt;num_display;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.vrefresh =
=3D hwmgr-&gt;display_config-&gt;vrefresh;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((mclk_stutter_mode_thr=
eshold !=3D 0) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (m=
emory_clock &lt;=3D mclk_stutter_mode_threshold) &amp;&amp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
index 57420d7caa4e..3d415fabbd93 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
@@ -1009,6 &#43;1009,7 @@ static int vegam_populate_single_memory_level(str=
uct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_level-&gt;DisplayWater=
mark =3D PPSMC_DISPLAY_WATERMARK_LOW;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.nu=
m_existing_displays =3D hwmgr-&gt;display_config-&gt;num_display;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;display_timing.vrefresh =
=3D hwmgr-&gt;display_config-&gt;vrefresh;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_stutter_mode_thre=
shold &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (clock &lt;=3D mclk_stutter_mode_threshold) &amp;&amp=
;<br>
-- <br>
2.13.6<br>
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

--_000_BYAPR12MB2775546AB3262A18FF962106FB240BYAPR12MB2775namp_--

--===============0108496657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0108496657==--
