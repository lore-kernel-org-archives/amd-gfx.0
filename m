From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add callback function of
 get_thermal_temperature_range
Date: Tue, 23 Jul 2019 09:36:02 +0000
Message-ID: <MN2PR12MB3296C871CFC59740F88F4407A2C70@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190723093109.2701-1-kevin1.wang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1664978991=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190723093109.2701-1-kevin1.wang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============1664978991==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296C871CFC59740F88F4407A2C70MN2PR12MB3296namp_"

--_000_MN2PR12MB3296C871CFC59740F88F4407A2C70MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

@Feng, Kenneth<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>


please help me review this patch, this patch is reveiwed before.

but this patch is missed from navi10 topic branch.


Best Regards,
Kevin

________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, July 23, 2019 5:31:47 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; W=
ang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org=
>
Subject: [PATCH] drm/amd/powerplay: add callback function of get_thermal_te=
mperature_range

1. the thermal temperature is asic related data, move the code logic to
xxx_ppt.c.
2. replace data structure PP_TemperatureRange with
smu_temperature_range.
3. change temperature uint from temp*1000 to temp (temperature uint).

Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
Acked-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 17 ++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++++----
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 34 ++++++-------------
 4 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index 34093ddca105..7105f8041088 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -439,7 +439,6 @@ struct smu_table_context
         struct smu_table                *tables;
         uint32_t                        table_count;
         struct smu_table                memory_pool;
-       uint16_t                        software_shutdown_temp;
         uint8_t                         thermal_controller_type;
         uint16_t                        TDPODLimit;

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 46e2913e4af4..a4c4d4997189 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1638,6 +1638,22 @@ static int navi10_set_performance_level(struct smu_c=
ontext *smu, enum amd_dpm_fo
         return ret;
 }

+static int navi10_get_thermal_temperature_range(struct smu_context *smu,
+                                               struct smu_temperature_rang=
e *range)
+{
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       struct smu_11_0_powerplay_table *powerplay_table =3D table_context-=
>power_play_table;
+
+       if (!range || !powerplay_table)
+               return -EINVAL;
+
+       /* The unit is temperature */
+       range->min =3D 0;
+       range->max =3D powerplay_table->software_shutdown_temp;
+
+       return 0;
+}
+
 static const struct pptable_funcs navi10_ppt_funcs =3D {
         .tables_init =3D navi10_tables_init,
         .alloc_dpm_context =3D navi10_allocate_dpm_context,
@@ -1674,6 +1690,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
         .get_ppfeature_status =3D navi10_get_ppfeature_status,
         .set_ppfeature_status =3D navi10_set_ppfeature_status,
         .set_performance_level =3D navi10_set_performance_level,
+       .get_thermal_temperature_range =3D navi10_get_thermal_temperature_r=
ange,
 };

 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 76bc157525d0..4ad9e0c5a637 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1147,10 +1147,8 @@ static int smu_v11_0_set_thermal_range(struct smu_co=
ntext *smu,
                                        struct smu_temperature_range *range=
)
 {
         struct amdgpu_device *adev =3D smu->adev;
-       int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP;
+       int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP;
         uint32_t val;

         if (!range)
@@ -1161,6 +1159,9 @@ static int smu_v11_0_set_thermal_range(struct smu_con=
text *smu,
         if (high > range->max)
                 high =3D range->max;

+       low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP, range->min);
+       high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, range->max);
+
         if (low > high)
                 return -EINVAL;

@@ -1169,8 +1170,8 @@ static int smu_v11_0_set_thermal_range(struct smu_con=
text *smu,
         val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, =
1);
         val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, =
0);
         val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, =
0);
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (h=
igh / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES));
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (l=
ow / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (h=
igh & 0xff));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (l=
ow & 0xff));
         val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);

         WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
@@ -1209,7 +1210,10 @@ static int smu_v11_0_start_thermal_control(struct sm=
u_context *smu)

         if (!smu->pm_enabled)
                 return ret;
+
         ret =3D smu_get_thermal_temperature_range(smu, &range);
+       if (ret)
+               return ret;

         if (smu->smu_table.thermal_controller_type) {
                 ret =3D smu_v11_0_set_thermal_range(smu, &range);
@@ -1234,6 +1238,8 @@ static int smu_v11_0_start_thermal_control(struct smu=
_context *smu)
         adev->pm.dpm.thermal.min_mem_temp =3D range.mem_min;
         adev->pm.dpm.thermal.max_mem_crit_temp =3D range.mem_crit_max;
         adev->pm.dpm.thermal.max_mem_emergency_temp =3D range.mem_emergenc=
y_max;
+       adev->pm.dpm.thermal.min_temp =3D range.min * SMU_TEMPERATURE_UNITS=
_PER_CENTIGRADES;
+       adev->pm.dpm.thermal.max_temp =3D range.max * SMU_TEMPERATURE_UNITS=
_PER_CENTIGRADES;

         return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index bcd0efaf7bbd..deb102ffedc2 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -463,7 +463,6 @@ static int vega20_store_powerplay_table(struct smu_cont=
ext *smu)
         memcpy(table_context->driver_pptable, &powerplay_table->smcPPTable=
,
                sizeof(PPTable_t));

-       table_context->software_shutdown_temp =3D powerplay_table->usSoftwa=
reShutdownTemp;
         table_context->thermal_controller_type =3D powerplay_table->ucTher=
malControllerType;
         table_context->TDPODLimit =3D le32_to_cpu(powerplay_table->OverDri=
ve8Table.ODSettingsMax[ATOM_VEGA20_ODSETTING_POWERPERCENTAGE]);

@@ -3235,35 +3234,24 @@ static int vega20_set_watermarks_table(struct smu_c=
ontext *smu,
         return 0;
 }

-static const struct smu_temperature_range vega20_thermal_policy[] =3D
-{
-       {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 990=
00},
-       { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 1=
20000},
-};
-
 static int vega20_get_thermal_temperature_range(struct smu_context *smu,
                                                 struct smu_temperature_ran=
ge*range)
 {
-
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       ATOM_Vega20_POWERPLAYTABLE *powerplay_table =3D table_context->powe=
r_play_table;
         PPTable_t *pptable =3D smu->smu_table.driver_pptable;

-       if (!range)
+       if (!range || !powerplay_table)
                 return -EINVAL;

-       memcpy(range, &vega20_thermal_policy[0], sizeof(struct smu_temperat=
ure_range));
-
-       range->max =3D pptable->TedgeLimit *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       range->edge_emergency_max =3D (pptable->TedgeLimit + CTF_OFFSET_EDG=
E) *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       range->hotspot_crit_max =3D pptable->ThotspotLimit *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       range->hotspot_emergency_max =3D (pptable->ThotspotLimit + CTF_OFFS=
ET_HOTSPOT) *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       range->mem_crit_max =3D pptable->ThbmLimit *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       range->mem_emergency_max =3D (pptable->ThbmLimit + CTF_OFFSET_HBM)*
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       /* The unit is temperature */
+       range->min =3D 0;
+       range->max =3D powerplay_table->usSoftwareShutdownTemp;
+       range->edge_emergency_max =3D (pptable->TedgeLimit + CTF_OFFSET_EDG=
E);
+       range->hotspot_crit_max =3D pptable->ThotspotLimit;
+       range->hotspot_emergency_max =3D (pptable->ThotspotLimit + CTF_OFFS=
ET_HOTSPOT);
+       range->mem_crit_max =3D pptable->ThbmLimit;
+       range->mem_emergency_max =3D (pptable->ThbmLimit + CTF_OFFSET_HBM);


         return 0;
--
2.22.0


--_000_MN2PR12MB3296C871CFC59740F88F4407A2C70MN2PR12MB3296namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><a class=3D"mention ms-bgc-nlr ms=
-fcl-b" id=3D"OWAAM679094" href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">@Feng, Kenn=
eth</a></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">please help me review this patch,=
 this patch is reveiwed before.</p>
<p style=3D"margin-top:0;margin-bottom:0">but&nbsp;this patch is missed fro=
m navi10 topic branch.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards,<br>
Kevin</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, July 23, 2019 5:31:47 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.H=
uang-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenn=
eth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: add callback function of get_the=
rmal_temperature_range</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">1. the thermal temperature is asic related data, m=
ove the code logic to<br>
xxx_ppt.c.<br>
2. replace data structure PP_TemperatureRange with<br>
smu_temperature_range.<br>
3. change temperature uint from temp*1000 to temp (temperature uint).<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&nbsp; =
1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; | 17 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 1=
8 &#43;&#43;&#43;&#43;&#43;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp; | 34 &#4=
3;&#43;&#43;&#43;&#43;&#43;-------------<br>
&nbsp;4 files changed, 40 insertions(&#43;), 30 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 34093ddca105..7105f8041088 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -439,7 &#43;439,6 @@ struct smu_table_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *tables;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; memory_pool;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; software_shutdown_temp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thermal_controller_type;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TDPODLimit;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 46e2913e4af4..a4c4d4997189 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -1638,6 &#43;1638,22 @@ static int navi10_set_performance_level(struct s=
mu_context *smu, enum amd_dpm_fo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int navi10_get_thermal_temperature_range(struct smu_context *sm=
u,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_tempera=
ture_range *range)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_c=
ontext =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *=
powerplay_table =3D table_context-&gt;power_play_table;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range || !powerplay_table)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The unit is temperature */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;min =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table=
-&gt;software_shutdown_temp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pptable_funcs navi10_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tables_init =3D navi10_ta=
bles_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .alloc_dpm_context =3D nav=
i10_allocate_dpm_context,<br>
@@ -1674,6 &#43;1690,7 @@ static const struct pptable_funcs navi10_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D =
navi10_get_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D =
navi10_set_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_performance_level =3D=
 navi10_set_performance_level,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_thermal_temperature_range =
=3D navi10_get_thermal_temperature_range,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void navi10_set_ppt_funcs(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 76bc157525d0..4ad9e0c5a637 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1147,10 &#43;1147,8 @@ static int smu_v11_0_set_thermal_range(struct sm=
u_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_temperature_range *range)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MINIMUM_ALERT=
_TEMP *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_MAXIMUM_ALER=
T_TEMP *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MINIMUM_A=
LERT_TEMP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_MAXIMUM_=
ALERT_TEMP;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
@@ -1161,6 &#43;1159,9 @@ static int smu_v11_0_set_thermal_range(struct smu=
_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (high &gt; range-&gt;ma=
x)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; high =3D range-&gt;max;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_A=
LERT_TEMP, range-&gt;min);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min(SMU_THERMAL_MAXIMUM_=
ALERT_TEMP, range-&gt;max);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
@@ -1169,8 &#43;1170,8 @@ static int smu_v11_0_set_thermal_range(struct smu=
_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val,=
 THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val,=
 THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val,=
 THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, DIG_THERM_INTH, (high / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES))=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, DIG_THERM_INTL, (low / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES));=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTH, (high &amp; 0xff));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTL, (low &amp; 0xff));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D val &amp; (~THM_TH=
ERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM=
_THERMAL_INT_CTRL, val);<br>
@@ -1209,7 &#43;1210,10 @@ static int smu_v11_0_start_thermal_control(struc=
t smu_context *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_thermal_te=
mperature_range(smu, &amp;range);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smu_table.ther=
mal_controller_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_set_thermal_range(smu, &amp;range);=
<br>
@@ -1234,6 &#43;1238,8 @@ static int smu_v11_0_start_thermal_control(struct=
 smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.mi=
n_mem_temp =3D range.mem_min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.ma=
x_mem_crit_temp =3D range.mem_crit_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.ma=
x_mem_emergency_temp =3D range.mem_emergency_max;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_temp =
=3D range.min * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_temp =
=3D range.max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index bcd0efaf7bbd..deb102ffedc2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -463,7 &#43;463,6 @@ static int vega20_store_powerplay_table(struct smu_=
context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(table_context-&gt;d=
river_pptable, &amp;powerplay_table-&gt;smcPPTable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sizeof(PPTable_t));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;software_shutdown_t=
emp =3D powerplay_table-&gt;usSoftwareShutdownTemp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_=
controller_type =3D powerplay_table-&gt;ucThermalControllerType;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;TDPODLim=
it =3D le32_to_cpu(powerplay_table-&gt;OverDrive8Table.ODSettingsMax[ATOM_V=
EGA20_ODSETTING_POWERPERCENTAGE]);<br>
&nbsp;<br>
@@ -3235,35 &#43;3234,24 @@ static int vega20_set_watermarks_table(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static const struct smu_temperature_range vega20_thermal_policy[] =3D<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {-273150,&nbsp; 99000, 99000, -273150=
, 99000, 99000, -273150, 99000, 99000},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 120000, 120000, 120000, 120000, 120=
000, 120000, 120000, 120000, 120000},<br>
-};<br>
-<br>
&nbsp;static int vega20_get_thermal_temperature_range(struct smu_context *s=
mu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_=
temperature_range*range)<br>
&nbsp;{<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_c=
ontext =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATOM_Vega20_POWERPLAYTABLE *power=
play_table =3D table_context-&gt;power_play_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D smu=
-&gt;smu_table.driver_pptable;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range || !powerplay_table)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(range, &amp;vega20_thermal_pol=
icy[0], sizeof(struct smu_temperature_range));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D pptable-&gt;TedgeLi=
mit *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_max =3D (ppt=
able-&gt;TedgeLimit &#43; CTF_OFFSET_EDGE) *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D pptabl=
e-&gt;ThotspotLimit *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_emergency_max =3D (=
pptable-&gt;ThotspotLimit &#43; CTF_OFFSET_HOTSPOT) *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D pptable-&g=
t;ThbmLimit *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_max =3D (ppta=
ble-&gt;ThbmLimit &#43; CTF_OFFSET_HBM)*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The unit is temperature */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;min =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table=
-&gt;usSoftwareShutdownTemp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_max =3D =
(pptable-&gt;TedgeLimit &#43; CTF_OFFSET_EDGE);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D pp=
table-&gt;ThotspotLimit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_emergency_max =
=3D (pptable-&gt;ThotspotLimit &#43; CTF_OFFSET_HOTSPOT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D pptabl=
e-&gt;ThbmLimit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_max =3D (=
pptable-&gt;ThbmLimit &#43; CTF_OFFSET_HBM);<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.22.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296C871CFC59740F88F4407A2C70MN2PR12MB3296namp_--

--===============1664978991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1664978991==--
