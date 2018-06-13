From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Add S3 support for OD feature
Date: Wed, 13 Jun 2018 13:53:42 +0000
Message-ID: <BN6PR12MB18096D89550876FBA6C55773F77E0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1528886084-7432-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2050744621=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528886084-7432-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============2050744621==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18096D89550876FBA6C55773F77E0BN6PR12MB1809namp_"

--_000_BN6PR12MB18096D89550876FBA6C55773F77E0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, June 13, 2018 6:34:44 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Add S3 support for OD feature

make custom values survive when S3 sleep transitions.
so not reset the od table if it is not null.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 126 +++++++++++------=
----
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  79 +++++++------
 2 files changed, 107 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 00614d0..b73e200 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -885,6 +885,60 @@ static void smu7_setup_voltage_range_from_vbios(struct=
 pp_hwmgr *hwmgr)
         data->odn_dpm_table.max_vddc =3D max_vddc;
 }

+static void smu7_check_dpm_table_updated(struct pp_hwmgr *hwmgr)
+{
+       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
+       struct smu7_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
+       struct phm_ppt_v1_information *table_info =3D
+                       (struct phm_ppt_v1_information *)(hwmgr->pptable);
+       uint32_t i;
+
+       struct phm_ppt_v1_clock_voltage_dependency_table *dep_table;
+       struct phm_ppt_v1_clock_voltage_dependency_table *odn_dep_table;
+
+       if (table_info =3D=3D NULL)
+               return;
+
+       for (i =3D 0; i < data->dpm_table.sclk_table.count; i++) {
+               if (odn_table->odn_core_clock_dpm_levels.entries[i].clock !=
=3D
+                                       data->dpm_table.sclk_table.dpm_leve=
ls[i].value) {
+                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_SCLK;
+                       break;
+               }
+       }
+
+       for (i =3D 0; i < data->dpm_table.mclk_table.count; i++) {
+               if (odn_table->odn_memory_clock_dpm_levels.entries[i].clock=
 !=3D
+                                       data->dpm_table.mclk_table.dpm_leve=
ls[i].value) {
+                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_MCLK;
+                       break;
+               }
+       }
+
+       dep_table =3D table_info->vdd_dep_on_mclk;
+       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dependency_on_mclk);
+
+       for (i =3D 0; i < dep_table->count; i++) {
+               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
+                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_VDDC | DPMTABLE_OD_UPDATE_MCLK;
+                       return;
+               }
+       }
+
+       dep_table =3D table_info->vdd_dep_on_sclk;
+       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dependency_on_sclk);
+       for (i =3D 0; i < dep_table->count; i++) {
+               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
+                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_VDDC | DPMTABLE_OD_UPDATE_SCLK;
+                       return;
+               }
+       }
+       if (data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_VDDC) {
+               data->need_update_smu7_dpm_table &=3D ~DPMTABLE_OD_UPDATE_V=
DDC;
+               data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_SC=
LK | DPMTABLE_OD_UPDATE_MCLK;
+       }
+}
+
 static int smu7_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
@@ -904,10 +958,13 @@ static int smu7_setup_default_dpm_tables(struct pp_hw=
mgr *hwmgr)

         /* initialize ODN table */
         if (hwmgr->od_enabled) {
-               smu7_setup_voltage_range_from_vbios(hwmgr);
-               smu7_odn_initial_default_setting(hwmgr);
+               if (data->odn_dpm_table.max_vddc) {
+                       smu7_check_dpm_table_updated(hwmgr);
+               } else {
+                       smu7_setup_voltage_range_from_vbios(hwmgr);
+                       smu7_odn_initial_default_setting(hwmgr);
+               }
         }
-
         return 0;
 }

@@ -3717,8 +3774,9 @@ static int smu7_trim_single_dpm_states(struct pp_hwmg=
r *hwmgr,
         uint32_t i;

         for (i =3D 0; i < dpm_table->count; i++) {
-               if ((dpm_table->dpm_levels[i].value < low_limit)
-               || (dpm_table->dpm_levels[i].value > high_limit))
+       /*skip the trim if od is enabled*/
+               if (!hwmgr->od_enabled && (dpm_table->dpm_levels[i].value <=
 low_limit
+                       || dpm_table->dpm_levels[i].value > high_limit))
                         dpm_table->dpm_levels[i].enabled =3D false;
                 else
                         dpm_table->dpm_levels[i].enabled =3D true;
@@ -3762,10 +3820,8 @@ static int smu7_generate_dpm_level_enable_mask(
         const struct smu7_power_state *smu7_ps =3D
                         cast_const_phw_smu7_power_state(states->pnew_state=
);

-       /*skip the trim if od is enabled*/
-       if (!hwmgr->od_enabled)
-               result =3D smu7_trim_dpm_states(hwmgr, smu7_ps);

+       result =3D smu7_trim_dpm_states(hwmgr, smu7_ps);
         if (result)
                 return result;

@@ -4738,60 +4794,6 @@ static bool smu7_check_clk_voltage_valid(struct pp_h=
wmgr *hwmgr,
         return true;
 }

-static void smu7_check_dpm_table_updated(struct pp_hwmgr *hwmgr)
-{
-       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
-       struct smu7_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
-       struct phm_ppt_v1_information *table_info =3D
-                       (struct phm_ppt_v1_information *)(hwmgr->pptable);
-       uint32_t i;
-
-       struct phm_ppt_v1_clock_voltage_dependency_table *dep_table;
-       struct phm_ppt_v1_clock_voltage_dependency_table *odn_dep_table;
-
-       if (table_info =3D=3D NULL)
-               return;
-
-       for (i=3D0; i<data->dpm_table.sclk_table.count; i++) {
-               if (odn_table->odn_core_clock_dpm_levels.entries[i].clock !=
=3D
-                                       data->dpm_table.sclk_table.dpm_leve=
ls[i].value) {
-                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_SCLK;
-                       break;
-               }
-       }
-
-       for (i=3D0; i<data->dpm_table.mclk_table.count; i++) {
-               if (odn_table->odn_memory_clock_dpm_levels.entries[i].clock=
 !=3D
-                                       data->dpm_table.mclk_table.dpm_leve=
ls[i].value) {
-                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_MCLK;
-                       break;
-               }
-       }
-
-       dep_table =3D table_info->vdd_dep_on_mclk;
-       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dependency_on_mclk);
-
-       for (i=3D0; i < dep_table->count; i++) {
-               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
-                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_VDDC | DPMTABLE_OD_UPDATE_MCLK;
-                       return;
-               }
-       }
-
-       dep_table =3D table_info->vdd_dep_on_sclk;
-       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dependency_on_sclk);
-       for (i=3D0; i < dep_table->count; i++) {
-               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
-                       data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_U=
PDATE_VDDC | DPMTABLE_OD_UPDATE_SCLK;
-                       return;
-               }
-       }
-       if (data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_VDDC) {
-               data->need_update_smu7_dpm_table &=3D ~DPMTABLE_OD_UPDATE_V=
DDC;
-               data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_SC=
LK | DPMTABLE_OD_UPDATE_MCLK;
-       }
-}
-
 static int smu7_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
                                         enum PP_OD_DPM_TABLE_COMMAND type,
                                         long *input, uint32_t size)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 3fe2873..3b8d36d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -2414,6 +2414,40 @@ static int vega10_populate_and_upload_avfs_fuse_over=
ride(struct pp_hwmgr *hwmgr)
         return result;
 }

+static void vega10_check_dpm_table_updated(struct pp_hwmgr *hwmgr)
+{
+       struct vega10_hwmgr *data =3D hwmgr->backend;
+       struct vega10_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
+       struct phm_ppt_v2_information *table_info =3D hwmgr->pptable;
+       struct phm_ppt_v1_clock_voltage_dependency_table *dep_table;
+       struct phm_ppt_v1_clock_voltage_dependency_table *odn_dep_table;
+       uint32_t i;
+
+       dep_table =3D table_info->vdd_dep_on_mclk;
+       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dep_on_mclk);
+
+       for (i =3D 0; i < dep_table->count; i++) {
+               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
+                       data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE=
_VDDC | DPMTABLE_OD_UPDATE_MCLK;
+                       return;
+               }
+       }
+
+       dep_table =3D table_info->vdd_dep_on_sclk;
+       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dep_on_sclk);
+       for (i =3D 0; i < dep_table->count; i++) {
+               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
+                       data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE=
_VDDC | DPMTABLE_OD_UPDATE_SCLK;
+                       return;
+               }
+       }
+
+       if (data->need_update_dpm_table & DPMTABLE_OD_UPDATE_VDDC) {
+               data->need_update_dpm_table &=3D ~DPMTABLE_OD_UPDATE_VDDC;
+               data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK | =
DPMTABLE_OD_UPDATE_MCLK;
+       }
+}
+
 /**
 * Initializes the SMC table and uploads it
 *
@@ -2430,6 +2464,7 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwm=
gr)
         PPTable_t *pp_table =3D &(data->smc_state_table.pp_table);
         struct pp_atomfwctrl_voltage_table voltage_table;
         struct pp_atomfwctrl_bios_boot_up_values boot_up_values;
+       struct vega10_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);

         result =3D vega10_setup_default_dpm_tables(hwmgr);
         PP_ASSERT_WITH_CODE(!result,
@@ -2437,8 +2472,14 @@ static int vega10_init_smc_table(struct pp_hwmgr *hw=
mgr)
                         return result);

         /* initialize ODN table */
-       if (hwmgr->od_enabled)
-               vega10_odn_initial_default_setting(hwmgr);
+       if (hwmgr->od_enabled) {
+               if (odn_table->max_vddc) {
+                       data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE=
_SCLK | DPMTABLE_OD_UPDATE_MCLK;
+                       vega10_check_dpm_table_updated(hwmgr);
+               } else {
+                       vega10_odn_initial_default_setting(hwmgr);
+               }
+       }

         pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
                         VOLTAGE_OBJ_SVID2,  &voltage_table);
@@ -4696,40 +4737,6 @@ static bool vega10_check_clk_voltage_valid(struct pp=
_hwmgr *hwmgr,
         return true;
 }

-static void vega10_check_dpm_table_updated(struct pp_hwmgr *hwmgr)
-{
-       struct vega10_hwmgr *data =3D hwmgr->backend;
-       struct vega10_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
-       struct phm_ppt_v2_information *table_info =3D hwmgr->pptable;
-       struct phm_ppt_v1_clock_voltage_dependency_table *dep_table;
-       struct phm_ppt_v1_clock_voltage_dependency_table *odn_dep_table;
-       uint32_t i;
-
-       dep_table =3D table_info->vdd_dep_on_mclk;
-       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dep_on_mclk);
-
-       for (i =3D 0; i < dep_table->count; i++) {
-               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
-                       data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE=
_VDDC | DPMTABLE_OD_UPDATE_MCLK;
-                       return;
-               }
-       }
-
-       dep_table =3D table_info->vdd_dep_on_sclk;
-       odn_dep_table =3D (struct phm_ppt_v1_clock_voltage_dependency_table=
 *)&(odn_table->vdd_dep_on_sclk);
-       for (i =3D 0; i < dep_table->count; i++) {
-               if (dep_table->entries[i].vddc !=3D odn_dep_table->entries[=
i].vddc) {
-                       data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE=
_VDDC | DPMTABLE_OD_UPDATE_SCLK;
-                       return;
-               }
-       }
-
-       if (data->need_update_dpm_table & DPMTABLE_OD_UPDATE_VDDC) {
-               data->need_update_dpm_table &=3D ~DPMTABLE_OD_UPDATE_VDDC;
-               data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK | =
DPMTABLE_OD_UPDATE_MCLK;
-       }
-}
-
 static void vega10_odn_update_soc_table(struct pp_hwmgr *hwmgr,
                                                 enum PP_OD_DPM_TABLE_COMMA=
ND type)
 {
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18096D89550876FBA6C55773F77E0BN6PR12MB1809namp_
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
<b>Sent:</b> Wednesday, June 13, 2018 6:34:44 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Add S3 support for OD feature</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">make custom values survive when S3 sleep transitio=
ns.<br>
so not reset the od table if it is not null.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; | 126 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |&nbsp; 79 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;2 files changed, 107 insertions(&#43;), 98 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 00614d0..b73e200 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -885,6 &#43;885,60 @@ static void smu7_setup_voltage_range_from_vbios(st=
ruct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;odn_dpm_table.max=
_vddc =3D max_vddc;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void smu7_check_dpm_table_updated(struct pp_hwmgr *hwmgr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (stru=
ct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_odn_dpm_table *odn_ta=
ble =3D &amp;(data-&gt;odn_dpm_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_information *ta=
ble_info =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct phm_=
ppt_v1_information *)(hwmgr-&gt;pptable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_d=
ependency_table *dep_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_d=
ependency_table *odn_dep_table;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_info =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; data-&gt;dpm=
_table.sclk_table.count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (odn_table-&gt;odn_core_clock_dpm_levels.entries[i].clock=
 !=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data-&gt;dpm_table.sclk_table.dpm_levels[i].value) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;nee=
d_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; data-&gt;dpm=
_table.mclk_table.count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].clo=
ck !=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data-&gt;dpm_table.mclk_table.dpm_levels[i].value) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;nee=
d_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_MCLK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_=
dep_on_mclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt=
_v1_clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dependency_on_=
mclk);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dep_table-&g=
t;count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;ent=
ries[i].vddc) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;nee=
d_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_M=
CLK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_=
dep_on_sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt=
_v1_clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dependency_on_=
sclk);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dep_table-&g=
t;count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;ent=
ries[i].vddc) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;nee=
d_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_S=
CLK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;need_update_smu7_dpm=
_table &amp; DPMTABLE_OD_UPDATE_VDDC) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;need_update_smu7_dpm_table &amp;=3D ~DPMTABLE_OD_UP=
DATE_VDDC;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_=
SCLK | DPMTABLE_OD_UPDATE_MCLK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;static int smu7_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
@@ -904,10 &#43;958,13 @@ static int smu7_setup_default_dpm_tables(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize ODN table */=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_setup_voltage_range_from_vbios(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_odn_initial_default_setting(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (data-&gt;odn_dpm_table.max_vddc) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_check_d=
pm_table_updated(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_setup_v=
oltage_range_from_vbios(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_odn_ini=
tial_default_setting(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -3717,8 &#43;3774,9 @@ static int smu7_trim_single_dpm_states(struct pp_=
hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dpm_t=
able-&gt;count; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((dpm_table-&gt;dpm_levels[i].value &lt; low_limit)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (dpm_table-&gt;dpm_levels[i].value &gt; high_limit))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*skip the trim if od is enabled*=
/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!hwmgr-&gt;od_enabled &amp;&amp; (dpm_table-&gt;dpm_leve=
ls[i].value &lt; low_limit<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || dpm_table=
-&gt;dpm_levels[i].value &gt; high_limit))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_t=
able-&gt;dpm_levels[i].enabled =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_t=
able-&gt;dpm_levels[i].enabled =3D true;<br>
@@ -3762,10 &#43;3820,8 @@ static int smu7_generate_dpm_level_enable_mask(<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smu7_power_st=
ate *smu7_ps =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_=
const_phw_smu7_power_state(states-&gt;pnew_state);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*skip the trim if od is enabled*/<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;od_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D smu7_trim_dpm_states(hwmgr, smu7_ps);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D smu7_trim_dpm_states(h=
wmgr, smu7_ps);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;<br>
@@ -4738,60 &#43;4794,6 @@ static bool smu7_check_clk_voltage_valid(struct =
pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
-static void smu7_check_dpm_table_updated(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (struct s=
mu7_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_odn_dpm_table *odn_table =
=3D &amp;(data-&gt;odn_dpm_table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_information *table_=
info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct phm_ppt_=
v1_information *)(hwmgr-&gt;pptable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_depen=
dency_table *dep_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_depen=
dency_table *odn_dep_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_info =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;dpm_table.s=
clk_table.count; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (odn_table-&gt;odn_core_clock_dpm_levels.entries[i].clock !=
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; data-&gt;dpm_table.sclk_table.dpm_levels[i].value) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;need_up=
date_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;dpm_table.m=
clk_table.count; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].clock !=
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; data-&gt;dpm_table.mclk_table.dpm_levels[i].value) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;need_up=
date_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_MCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_dep_=
on_mclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt_v1_=
clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dependency_on_mclk=
);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i &lt; dep_table-&gt;coun=
t; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;entries=
[i].vddc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;need_up=
date_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_MCLK;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_dep_=
on_sclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt_v1_=
clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dependency_on_sclk=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i &lt; dep_table-&gt;coun=
t; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;entries=
[i].vddc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;need_up=
date_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_SCLK;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;need_update_smu7_dpm_tab=
le &amp; DPMTABLE_OD_UPDATE_VDDC) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;need_update_smu7_dpm_table &amp;=3D ~DPMTABLE_OD_UPDATE=
_VDDC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK=
 | DPMTABLE_OD_UPDATE_MCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
&nbsp;static int smu7_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; long *input, uint32_t size)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 3fe2873..3b8d36d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -2414,6 &#43;2414,40 @@ static int vega10_populate_and_upload_avfs_fuse_=
override(struct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void vega10_check_dpm_table_updated(struct pp_hwmgr *hwmgr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_odn_dpm_table *odn_=
table =3D &amp;(data-&gt;odn_dpm_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v2_information *ta=
ble_info =3D hwmgr-&gt;pptable;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_d=
ependency_table *dep_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_d=
ependency_table *odn_dep_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_=
dep_on_mclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt=
_v1_clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dep_on_mclk);<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dep_table-&g=
t;count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;ent=
ries[i].vddc) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;nee=
d_update_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_MCLK;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_=
dep_on_sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt=
_v1_clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dep_on_sclk);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dep_table-&g=
t;count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;ent=
ries[i].vddc) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;nee=
d_update_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_SCLK;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;need_update_dpm_tabl=
e &amp; DPMTABLE_OD_UPDATE_VDDC) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;need_update_dpm_table &amp;=3D ~DPMTABLE_OD_UPDATE_=
VDDC;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK =
| DPMTABLE_OD_UPDATE_MCLK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp;* Initializes the SMC table and uploads it<br>
&nbsp;*<br>
@@ -2430,6 &#43;2464,7 @@ static int vega10_init_smc_table(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pp_table =3D &a=
mp;(data-&gt;smc_state_table.pp_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_atomfwctrl_volta=
ge_table voltage_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_atomfwctrl_bios_=
boot_up_values boot_up_values;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_odn_dpm_table *odn_=
table =3D &amp;(data-&gt;odn_dpm_table);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega10_setup_de=
fault_dpm_tables(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!resul=
t,<br>
@@ -2437,8 &#43;2472,14 @@ static int vega10_init_smc_table(struct pp_hwmgr=
 *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n result);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize ODN table */=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega10_odn_initial_default_setting(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (odn_table-&gt;max_vddc) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;nee=
d_update_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_OD_UPDATE_MCLK;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_check=
_dpm_table_updated(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_odn_i=
nitial_default_setting(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_atomfwctrl_get_voltage_=
table_v4(hwmgr, VOLTAGE_TYPE_VDDC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VOLTA=
GE_OBJ_SVID2,&nbsp; &amp;voltage_table);<br>
@@ -4696,40 &#43;4737,6 @@ static bool vega10_check_clk_voltage_valid(struc=
t pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
-static void vega10_check_dpm_table_updated(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =3D hwmgr-&=
gt;backend;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_odn_dpm_table *odn_tabl=
e =3D &amp;(data-&gt;odn_dpm_table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v2_information *table_=
info =3D hwmgr-&gt;pptable;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_depen=
dency_table *dep_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_depen=
dency_table *odn_dep_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_dep_=
on_mclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt_v1_=
clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dep_on_mclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dep_table-&gt;co=
unt; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;entries=
[i].vddc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;need_up=
date_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_MCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table =3D table_info-&gt;vdd_dep_=
on_sclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dep_table =3D (struct phm_ppt_v1_=
clock_voltage_dependency_table *)&amp;(odn_table-&gt;vdd_dep_on_sclk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dep_table-&gt;co=
unt; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dep_table-&gt;entries[i].vddc !=3D odn_dep_table-&gt;entries=
[i].vddc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;need_up=
date_dpm_table |=3D DPMTABLE_OD_UPDATE_VDDC | DPMTABLE_OD_UPDATE_SCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;need_update_dpm_table &a=
mp; DPMTABLE_OD_UPDATE_VDDC) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;need_update_dpm_table &amp;=3D ~DPMTABLE_OD_UPDATE_VDDC=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK | DP=
MTABLE_OD_UPDATE_MCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
&nbsp;static void vega10_odn_update_soc_table(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_OD_=
DPM_TABLE_COMMAND type)<br>
&nbsp;{<br>
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

--_000_BN6PR12MB18096D89550876FBA6C55773F77E0BN6PR12MB1809namp_--

--===============2050744621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2050744621==--
