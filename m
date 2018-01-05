From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Store stable Pstate clocks
Date: Fri, 5 Jan 2018 15:43:01 +0000
Message-ID: <BN6PR12MB1652FBD6A2B9EAFB2C25BD82F71C0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1515152305-17549-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0650947133=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515152305-17549-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============0650947133==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652FBD6A2B9EAFB2C25BD82F71C0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652FBD6A2B9EAFB2C25BD82F71C0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, January 5, 2018 6:38 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 1/2] drm/amd/pp: Store stable Pstate clocks

User can use to calculate profiling ratios when
set UMD Pstate.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Change-Id: I3c6b82ebface57eb969d474c57149e8658ab7014
---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |  2 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     |  3 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 14 ++++++++++++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  5 +++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  2 ++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/d=
rm/amd/powerplay/hwmgr/cz_hwmgr.c
index 0b8aa44..b83fe97 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
@@ -1189,6 +1189,8 @@ static int cz_phm_unforce_dpm_levels(struct pp_hwmgr =
*hwmgr)

         cz_hwmgr->sclk_dpm.soft_min_clk =3D table->entries[0].clk;
         cz_hwmgr->sclk_dpm.hard_min_clk =3D table->entries[0].clk;
+       hwmgr->pstate_sclk =3D table->entries[0].clk;
+       hwmgr->pstate_mclk =3D 0;

         level =3D cz_get_max_sclk_level(hwmgr) - 1;

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu/d=
rm/amd/powerplay/hwmgr/rv_hwmgr.c
index 569073e..409a56b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
@@ -451,6 +451,9 @@ static int rv_hwmgr_backend_init(struct pp_hwmgr *hwmgr=
)

         hwmgr->platform_descriptor.minimumClocksReductionPercentage =3D 50=
;

+       hwmgr->pstate_sclk =3D RAVEN_UMD_PSTATE_GFXCLK;
+       hwmgr->pstate_mclk =3D RAVEN_UMD_PSTATE_FCLK;
+
         return result;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 2cde7a8..72031bd 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -2652,8 +2652,10 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *h=
wmgr, enum amd_dpm_forced_le
                                 break;
                         }
                 }
-               if (count < 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_SCLK)
+               if (count < 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_SCLK) {
                         *sclk_mask =3D 0;
+                       tmp_sclk =3D hwmgr->dyn_state.vddc_dependency_on_sc=
lk->entries[0].clk;
+               }

                 if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
                         *sclk_mask =3D hwmgr->dyn_state.vddc_dependency_on=
_sclk->count-1;
@@ -2668,8 +2670,10 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *h=
wmgr, enum amd_dpm_forced_le
                                 break;
                         }
                 }
-               if (count < 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_SCLK)
+               if (count < 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_SCLK) {
                         *sclk_mask =3D 0;
+                       tmp_sclk =3D  table_info->vdd_dep_on_sclk->entries[=
0].clk;
+               }

                 if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
                         *sclk_mask =3D table_info->vdd_dep_on_sclk->count =
- 1;
@@ -2681,6 +2685,9 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hw=
mgr, enum amd_dpm_forced_le
                 *mclk_mask =3D golden_dpm_table->mclk_table.count - 1;

         *pcie_mask =3D data->dpm_table.pcie_speed_table.count - 1;
+       hwmgr->pstate_sclk =3D tmp_sclk;
+       hwmgr->pstate_mclk =3D tmp_mclk;
+
         return 0;
 }

@@ -2692,6 +2699,9 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmg=
r,
         uint32_t mclk_mask =3D 0;
         uint32_t pcie_mask =3D 0;

+       if (hwmgr->pstate_sclk =3D=3D 0)
+               smu7_get_profiling_clk(hwmgr, level, &sclk_mask, &mclk_mask=
, &pcie_mask);
+
         switch (level) {
         case AMD_DPM_FORCED_LEVEL_HIGH:
                 ret =3D smu7_force_dpm_highest(hwmgr);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 4219004..cb35f4f 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -4172,6 +4172,8 @@ static int vega10_get_profiling_clk_mask(struct pp_hw=
mgr *hwmgr, enum amd_dpm_fo
                 *sclk_mask =3D VEGA10_UMD_PSTATE_GFXCLK_LEVEL;
                 *soc_mask =3D VEGA10_UMD_PSTATE_SOCCLK_LEVEL;
                 *mclk_mask =3D VEGA10_UMD_PSTATE_MCLK_LEVEL;
+               hwmgr->pstate_sclk =3D table_info->vdd_dep_on_sclk->entries=
[VEGA10_UMD_PSTATE_GFXCLK_LEVEL].clk;
+               hwmgr->pstate_mclk =3D table_info->vdd_dep_on_mclk->entries=
[VEGA10_UMD_PSTATE_MCLK_LEVEL].clk;
         }

         if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
@@ -4213,6 +4215,9 @@ static int vega10_dpm_force_dpm_level(struct pp_hwmgr=
 *hwmgr,
         uint32_t mclk_mask =3D 0;
         uint32_t soc_mask =3D 0;

+       if (hwmgr->pstate_sclk =3D=3D 0)
+               vega10_get_profiling_clk_mask(hwmgr, level, &sclk_mask, &mc=
lk_mask, &soc_mask);
+
         switch (level) {
         case AMD_DPM_FORCED_LEVEL_HIGH:
                 ret =3D vega10_force_dpm_highest(hwmgr);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 5d92f13..0ac61e0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -752,6 +752,8 @@ struct pp_hwmgr {
         enum amd_pp_profile_type current_power_profile;
         bool en_umd_pstate;
         bool od_enabled;
+       uint32_t pstate_sclk;
+       uint32_t pstate_mclk;
 };

 struct cgs_irq_src_funcs {
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652FBD6A2B9EAFB2C25BD82F71C0BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Friday, January 5, 2018 6:38 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/pp: Store stable Pstate clocks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">User can use to calculate profiling ratios when<br=
>
set UMD Pstate.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Change-Id: I3c6b82ebface57eb969d474c57149e8658ab7014<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; | 14 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |&nbsp; 5 &#43;&#4=
3;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;&#43;<br>
&nbsp;5 files changed, 24 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/d=
rm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
index 0b8aa44..b83fe97 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
@@ -1189,6 &#43;1189,8 @@ static int cz_phm_unforce_dpm_levels(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_hwmgr-&gt;sclk_dpm.soft=
_min_clk =3D table-&gt;entries[0].clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_hwmgr-&gt;sclk_dpm.hard=
_min_clk =3D table-&gt;entries[0].clk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_sclk =3D table-&=
gt;entries[0].clk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_mclk =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level =3D cz_get_max_sclk_=
level(hwmgr) - 1;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu/d=
rm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
index 569073e..409a56b 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
@@ -451,6 &#43;451,9 @@ static int rv_hwmgr_backend_init(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platform_descrip=
tor.minimumClocksReductionPercentage =3D 50;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_sclk =3D RAVEN_U=
MD_PSTATE_GFXCLK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_mclk =3D RAVEN_U=
MD_PSTATE_FCLK;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 2cde7a8..72031bd 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -2652,8 &#43;2652,10 @@ static int smu7_get_profiling_clk(struct pp_hwmg=
r *hwmgr, enum amd_dpm_forced_le<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (count &lt; 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MI=
N_SCLK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (count &lt; 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFIL=
E_MIN_SCLK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sclk=
_mask =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_sclk =3D=
 hwmgr-&gt;dyn_state.vddc_dependency_on_sclk-&gt;entries[0].clk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sclk=
_mask =3D hwmgr-&gt;dyn_state.vddc_dependency_on_sclk-&gt;count-1;<br>
@@ -2668,8 &#43;2670,10 @@ static int smu7_get_profiling_clk(struct pp_hwmg=
r *hwmgr, enum amd_dpm_forced_le<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (count &lt; 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MI=
N_SCLK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (count &lt; 0 || level =3D=3D AMD_DPM_FORCED_LEVEL_PROFIL=
E_MIN_SCLK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sclk=
_mask =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_sclk =3D=
&nbsp; table_info-&gt;vdd_dep_on_sclk-&gt;entries[0].clk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sclk=
_mask =3D table_info-&gt;vdd_dep_on_sclk-&gt;count - 1;<br>
@@ -2681,6 &#43;2685,9 @@ static int smu7_get_profiling_clk(struct pp_hwmgr=
 *hwmgr, enum amd_dpm_forced_le<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *mclk_mask =3D golden_dpm_table-&gt;mclk_table.count =
- 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pcie_mask =3D data-&gt;dp=
m_table.pcie_speed_table.count - 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_sclk =3D tmp_scl=
k;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_mclk =3D tmp_mcl=
k;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2692,6 &#43;2699,9 @@ static int smu7_force_dpm_level(struct pp_hwmgr *=
hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mclk_mask =3D 0;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_mask =3D 0;<=
br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;pstate_sclk =3D=3D =
0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu7_get_profiling_clk(hwmgr, level, &amp;sclk_mask, &amp;mc=
lk_mask, &amp;pcie_mask);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
HIGH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu7_force_dpm_highest(hwmgr);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 4219004..cb35f4f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -4172,6 &#43;4172,8 @@ static int vega10_get_profiling_clk_mask(struct p=
p_hwmgr *hwmgr, enum amd_dpm_fo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *sclk_mask =3D VEGA10_UMD_PSTATE_GFXCLK_LEVEL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *soc_mask =3D VEGA10_UMD_PSTATE_SOCCLK_LEVEL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *mclk_mask =3D VEGA10_UMD_PSTATE_MCLK_LEVEL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;pstate_sclk =3D table_info-&gt;vdd_dep_on_sclk-&gt=
;entries[VEGA10_UMD_PSTATE_GFXCLK_LEVEL].clk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;pstate_mclk =3D table_info-&gt;vdd_dep_on_mclk-&gt=
;entries[VEGA10_UMD_PSTATE_MCLK_LEVEL].clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (level =3D=3D AMD_DPM_F=
ORCED_LEVEL_PROFILE_MIN_SCLK) {<br>
@@ -4213,6 &#43;4215,9 @@ static int vega10_dpm_force_dpm_level(struct pp_h=
wmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mclk_mask =3D 0;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t soc_mask =3D 0;<b=
r>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;pstate_sclk =3D=3D =
0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega10_get_profiling_clk_mask(hwmgr, level, &amp;sclk_mask, =
&amp;mclk_mask, &amp;soc_mask);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
HIGH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D vega10_force_dpm_highest(hwmgr);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 5d92f13..0ac61e0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -752,6 &#43;752,8 @@ struct pp_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_profile_type c=
urrent_power_profile;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en_umd_pstate;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool od_enabled;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate_sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate_mclk;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct cgs_irq_src_funcs {<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk477021" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652FBD6A2B9EAFB2C25BD82F71C0BN6PR12MB1652namp_--

--===============0650947133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0650947133==--
