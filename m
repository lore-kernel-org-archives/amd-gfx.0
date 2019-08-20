From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct SW smu11 thermal range settings
Date: Tue, 20 Aug 2019 02:09:47 +0000
Message-ID: <MN2PR12MB334407D4ABFF5E4F1CC02518E4AB0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190816093144.21892-1-evan.quan@amd.com>
 <MN2PR12MB3296E3E1C79504DD56058410A2AF0@MN2PR12MB3296.namprd12.prod.outlook.com>
 <MN2PR12MB3344E88B19DF4DA83279BBF2E4A80@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB35981C5C1B0A12B8C8C1CD468EA80@MN2PR12MB3598.namprd12.prod.outlook.com>
 <MN2PR12MB334468A94B93D7D848596611E4A80@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1129162297=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB334468A94B93D7D848596611E4A80-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============1129162297==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB334407D4ABFF5E4F1CC02518E4AB0MN2PR12MB3344namp_"

--_000_MN2PR12MB334407D4ABFF5E4F1CC02518E4AB0MN2PR12MB3344namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping..

From: Quan, Evan
Sent: Monday, August 19, 2019 1:27 PM
To: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang@am=
d.com>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amd/powerplay: correct SW smu11 thermal range sett=
ings

Yes, the lowest settings for thermal controller is 0.

Regards
Evan
From: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, August 19, 2019 1:12 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; Wang, Kevin(Y=
ang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct SW smu11 thermal range sett=
ings

Hi Evan,
So due to the below code, we don't get a chance to set -273.15, right?
+       low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+       high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+                       range.max / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of Q=
uan, Evan
Sent: Monday, August 19, 2019 10:16 AM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct SW smu11 thermal range sett=
ings

[CAUTION: External Email]
Comment inline

From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, August 16, 2019 7:04 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct SW smu11 thermal range sett=
ings

Hi Evan,

the temperature min value should be 0, not -273 on smu11.
you can refrence window driver code or register spec.
        output_ptr->operating_temperature_min_Limit =3D 0;
        output_ptr->operating_temperature_max_Limit =3D ppt_info->software_=
shutdown_temp;
[Quan, Evan] There was a discussion over the min value(0 or -273.15) and we=
 decided to use the later considering the OD case.
All the existing and coming ASICs should  follow this design.
and in smu11, the thermal control has a 8bit register to set min and max va=
lue, and the unit is temperature.
[Quan, Evan] That is still honored, no violation here.
so there is something wrong with this patch.

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:e=
van.quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, August 16, 2019 5:31 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH] drm/amd/powerplay: correct SW smu11 thermal range settings

Problems with current settings:
1. The min value was overrided to 0 on Vega20 & Navi10. While
   the expected should be -273.15 C.
2. The thermal min/max threshold was output in wrong unit on
   Navi10 & Arcturus. As TEMP_RANGE_MIN/MAX is already in
   millicelsius. And "*1000" in smu_v11_0_start_thermal_control
   makes the output wrongly.

Change-Id: I2f1866edd1baf264f521310343f492eaede26c33
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 10 ----
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  6 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  5 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 51 +++++++------------
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 20 +++++---
 5 files changed, 38 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 4060607fbb35..1a1f64a9e1e0 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -880,23 +880,14 @@ static int arcturus_force_clk_levels(struct smu_conte=
xt *smu,
         return ret;
 }

-static const struct smu_temperature_range arcturus_thermal_policy[] =3D
-{
-       {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 990=
00},
-       { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 1=
20000},
-};
-
 static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
                                                 struct smu_temperature_ran=
ge *range)
 {
-
         PPTable_t *pptable =3D smu->smu_table.driver_pptable;

         if (!range)
                 return -EINVAL;

-       memcpy(range, &arcturus_thermal_policy[0], sizeof(struct smu_temper=
ature_range));
-
         range->max =3D pptable->TedgeLimit *
                 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
         range->edge_emergency_max =3D (pptable->TedgeLimit + CTF_OFFSET_ED=
GE) *
@@ -910,7 +901,6 @@ static int arcturus_get_thermal_temperature_range(struc=
t smu_context *smu,
         range->mem_emergency_max =3D (pptable->TmemLimit + CTF_OFFSET_HBM)=
*
                 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;

-
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index 0a22fa48ff5a..59b2045e37e4 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -64,6 +64,12 @@
 #define WORKLOAD_MAP(profile, workload) \
         [profile] =3D {1, (workload)}

+static const struct smu_temperature_range smu11_thermal_policy[] =3D
+{
+       {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 990=
00},
+       { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 1=
20000},
+};
+
 struct smu_11_0_cmn2aisc_mapping {
         int     valid_mapping;
         int     map_to;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index d7d4186b762f..e804d18f61d0 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1505,9 +1505,8 @@ static int navi10_get_thermal_temperature_range(struc=
t smu_context *smu,
         if (!range || !powerplay_table)
                 return -EINVAL;

-       /* The unit is temperature */
-       range->min =3D 0;
-       range->max =3D powerplay_table->software_shutdown_temp;
+       range->max =3D powerplay_table->software_shutdown_temp *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index df7b65360ac7..5f5fd3a88e48 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1125,23 +1125,17 @@ static int smu_v11_0_get_current_clk_freq(struct sm=
u_context *smu,
 }

 static int smu_v11_0_set_thermal_range(struct smu_context *smu,
-                                      struct smu_temperature_range *range)
+                                      struct smu_temperature_range range)
 {
         struct amdgpu_device *adev =3D smu->adev;
         int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP;
         int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP;
         uint32_t val;

-       if (!range)
-               return -EINVAL;
-
-       if (low < range->min)
-               low =3D range->min;
-       if (high > range->max)
-               high =3D range->max;
-
-       low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP, range->min);
-       high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, range->max);
+       low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+       high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+                       range.max / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);

         if (low > high)
                 return -EINVAL;
@@ -1177,27 +1171,20 @@ static int smu_v11_0_enable_thermal_alert(struct sm=
u_context *smu)
 static int smu_v11_0_start_thermal_control(struct smu_context *smu)
 {
         int ret =3D 0;
-       struct smu_temperature_range range =3D {
-               TEMP_RANGE_MIN,
-               TEMP_RANGE_MAX,
-               TEMP_RANGE_MAX,
-               TEMP_RANGE_MIN,
-               TEMP_RANGE_MAX,
-               TEMP_RANGE_MAX,
-               TEMP_RANGE_MIN,
-               TEMP_RANGE_MAX,
-               TEMP_RANGE_MAX};
+       struct smu_temperature_range range;
         struct amdgpu_device *adev =3D smu->adev;

         if (!smu->pm_enabled)
                 return ret;

+       memcpy(&range, &smu11_thermal_policy[0], sizeof(struct smu_temperat=
ure_range));
+
         ret =3D smu_get_thermal_temperature_range(smu, &range);
         if (ret)
                 return ret;

         if (smu->smu_table.thermal_controller_type) {
-               ret =3D smu_v11_0_set_thermal_range(smu, &range);
+               ret =3D smu_v11_0_set_thermal_range(smu, range);
                 if (ret)
                         return ret;

@@ -1210,17 +1197,15 @@ static int smu_v11_0_start_thermal_control(struct s=
mu_context *smu)
                         return ret;
         }

-       adev->pm.dpm.thermal.min_temp =3D range.min * SMU_TEMPERATURE_UNITS=
_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.max_temp =3D range.max * SMU_TEMPERATURE_UNITS=
_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.max_edge_emergency_temp =3D range.edge_emergen=
cy_max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.min_hotspot_temp =3D range.hotspot_min * SMU_T=
EMPERATURE_UNITS_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.max_hotspot_crit_temp =3D range.hotspot_crit_m=
ax * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.max_hotspot_emergency_temp =3D range.hotspot_e=
mergency_max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.min_mem_temp =3D range.mem_min * SMU_TEMPERATU=
RE_UNITS_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.max_mem_crit_temp =3D range.mem_crit_max * SMU=
_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.max_mem_emergency_temp =3D range.mem_emergency=
_max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.min_temp =3D range.min * SMU_TEMPERATURE_UNITS=
_PER_CENTIGRADES;
-       adev->pm.dpm.thermal.max_temp =3D range.max * SMU_TEMPERATURE_UNITS=
_PER_CENTIGRADES;
+       adev->pm.dpm.thermal.min_temp =3D range.min;
+       adev->pm.dpm.thermal.max_temp =3D range.max;
+       adev->pm.dpm.thermal.max_edge_emergency_temp =3D range.edge_emergen=
cy_max;
+       adev->pm.dpm.thermal.min_hotspot_temp =3D range.hotspot_min;
+       adev->pm.dpm.thermal.max_hotspot_crit_temp =3D range.hotspot_crit_m=
ax;
+       adev->pm.dpm.thermal.max_hotspot_emergency_temp =3D range.hotspot_e=
mergency_max;
+       adev->pm.dpm.thermal.min_mem_temp =3D range.mem_min;
+       adev->pm.dpm.thermal.max_mem_crit_temp =3D range.mem_crit_max;
+       adev->pm.dpm.thermal.max_mem_emergency_temp =3D range.mem_emergency=
_max;

         return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index acf075393c13..e14363182691 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3113,14 +3113,18 @@ static int vega20_get_thermal_temperature_range(str=
uct smu_context *smu,
         if (!range || !powerplay_table)
                 return -EINVAL;

-       /* The unit is temperature */
-       range->min =3D 0;
-       range->max =3D powerplay_table->usSoftwareShutdownTemp;
-       range->edge_emergency_max =3D (pptable->TedgeLimit + CTF_OFFSET_EDG=
E);
-       range->hotspot_crit_max =3D pptable->ThotspotLimit;
-       range->hotspot_emergency_max =3D (pptable->ThotspotLimit + CTF_OFFS=
ET_HOTSPOT);
-       range->mem_crit_max =3D pptable->ThbmLimit;
-       range->mem_emergency_max =3D (pptable->ThbmLimit + CTF_OFFSET_HBM);
+       range->max =3D powerplay_table->usSoftwareShutdownTemp *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->edge_emergency_max =3D (pptable->TedgeLimit + CTF_OFFSET_EDG=
E) *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->hotspot_crit_max =3D pptable->ThotspotLimit *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->hotspot_emergency_max =3D (pptable->ThotspotLimit + CTF_OFFS=
ET_HOTSPOT) *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->mem_crit_max =3D pptable->ThbmLimit *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->mem_emergency_max =3D (pptable->ThbmLimit + CTF_OFFSET_HBM) =
*
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;


         return 0;
--
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB334407D4ABFF5E4F1CC02518E4AB0MN2PR12MB3344namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Ping..<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Quan, Evan <br>
<b>Sent:</b> Monday, August 19, 2019 1:27 PM<br>
<b>To:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &l=
t;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: correct SW smu11 thermal ran=
ge settings<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes, the lowest settings for thermal controller is 0=
.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Feng, Kenneth &lt;<a href=3D"mailto:Ken=
neth.Feng-5C7GfCeVMHo@public.gmane.org">Kenneth.Feng-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Monday, August 19, 2019 1:12 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org"=
>Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: correct SW smu11 thermal ran=
ge settings<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hi Evan,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">So due to the below co=
de, we don&#8217;t get a chance to set -273.15, right?<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&#43;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range.min / =
SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min(SMU_THERMAL_MAXIMUM_=
ALERT_TEMP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range.max / =
SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);<span style=3D"color:#1F497D"><o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx [<a href=3D"mailto:amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>=
]
<b>On Behalf Of </b>Quan, Evan<br>
<b>Sent:</b> Monday, August 19, 2019 10:16 AM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: correct SW smu11 thermal ran=
ge settings<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,serif">[CAUTION: External Email]
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal">Comment inline<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto=
:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Friday, August 16, 2019 7:04 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: correct SW smu11 thermal ran=
ge settings<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Evan=
,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">the tem=
perature min value should be 0, not -273 on smu11.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">you can=
 refrence window driver code or register spec.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><i><span style=3D"font-size:12.0pt;color:black">&nbs=
p; &nbsp; &nbsp; &nbsp; output_ptr-&gt;operating_temperature_min_Limit =3D =
0; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp;
<br>
&nbsp; &nbsp; &nbsp; &nbsp; output_ptr-&gt;operating_temperature_max_Limit =
=3D ppt_info-&gt;software_shutdown_temp;<o:p></o:p></span></i></p>
<p class=3D"MsoNormal"><b><i>[Quan, Evan] There was a discussion over the m=
in value(0 or -273.15) and we decided to use the later considering the OD c=
ase.<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>All the existing and coming ASICs should &nbsp=
;follow this design.</i></b><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">and in =
smu11, the thermal control has a 8bit register to set min and max value, an=
d the unit is temperature.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><i>[Quan, Evan] That is still honored, no violati=
on here.</i></b><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">so ther=
e is something wrong with this patch.<o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
Kevin<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br>
<b>Sent:</b> Friday, August 16, 2019 5:31 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: correct SW smu11 thermal range s=
ettings</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Problems with current settings:<br>
1. The min value was overrided to 0 on Vega20 &amp; Navi10. While<br>
&nbsp;&nbsp; the expected should be -273.15 C.<br>
2. The thermal min/max threshold was output in wrong unit on<br>
&nbsp;&nbsp; Navi10 &amp; Arcturus. As TEMP_RANGE_MIN/MAX is already in<br>
&nbsp;&nbsp; millicelsius. And &quot;*1000&quot; in smu_v11_0_start_thermal=
_control<br>
&nbsp;&nbsp; makes the output wrongly.<br>
<br>
Change-Id: I2f1866edd1baf264f521310343f492eaede26c33<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp; | 10 ----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |&nbsp; 6 &#43;&#43;&#4=
3;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
5 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 5=
1 &#43;&#43;&#43;&#43;&#43;&#43;&#43;------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp; | 20 &#4=
3;&#43;&#43;&#43;&#43;---<br>
&nbsp;5 files changed, 38 insertions(&#43;), 54 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 4060607fbb35..1a1f64a9e1e0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -880,23 &#43;880,14 @@ static int arcturus_force_clk_levels(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static const struct smu_temperature_range arcturus_thermal_policy[] =3D<br=
>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {-273150,&nbsp; 99000, 99000, -273150=
, 99000, 99000, -273150, 99000, 99000},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 120000, 120000, 120000, 120000, 120=
000, 120000, 120000, 120000, 120000},<br>
-};<br>
-<br>
&nbsp;static int arcturus_get_thermal_temperature_range(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_=
temperature_range *range)<br>
&nbsp;{<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D smu=
-&gt;smu_table.driver_pptable;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(range, &amp;arcturus_thermal_p=
olicy[0], sizeof(struct smu_temperature_range));<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D pptable-=
&gt;TedgeLimit *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_m=
ax =3D (pptable-&gt;TedgeLimit &#43; CTF_OFFSET_EDGE) *<br>
@@ -910,7 &#43;901,6 @@ static int arcturus_get_thermal_temperature_range(s=
truct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_ma=
x =3D (pptable-&gt;TmemLimit &#43; CTF_OFFSET_HBM)*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index 0a22fa48ff5a..59b2045e37e4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -64,6 &#43;64,12 @@<br>
&nbsp;#define WORKLOAD_MAP(profile, workload) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [profile] =3D {1, (workloa=
d)}<br>
&nbsp;<br>
&#43;static const struct smu_temperature_range smu11_thermal_policy[] =3D<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {-273150,&nbsp; 99000, 99000, -27=
3150, 99000, 99000, -273150, 99000, 99000},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 120000, 120000, 120000, 120000,=
 120000, 120000, 120000, 120000, 120000},<br>
&#43;};<br>
&#43;<br>
&nbsp;struct smu_11_0_cmn2aisc_mapping {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp=
; valid_mapping;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp=
; map_to;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index d7d4186b762f..e804d18f61d0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -1505,9 &#43;1505,8 @@ static int navi10_get_thermal_temperature_range(s=
truct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range || !powerplay_t=
able)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The unit is temperature */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;min =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table-&gt=
;software_shutdown_temp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table=
-&gt;software_shutdown_temp *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index df7b65360ac7..5f5fd3a88e48 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1125,23 &#43;1125,17 @@ static int smu_v11_0_get_current_clk_freq(struc=
t smu_context *smu,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu_v11_0_set_thermal_range(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_temperature_range *range)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; struct smu_temperature_range range)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MI=
NIMUM_ALERT_TEMP;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_M=
AXIMUM_ALERT_TEMP;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &lt; range-&gt;min)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; low =3D range-&gt;min;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (high &gt; range-&gt;max)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; high =3D range-&gt;max;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_ALERT=
_TEMP, range-&gt;min);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min(SMU_THERMAL_MAXIMUM_ALER=
T_TEMP, range-&gt;max);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_A=
LERT_TEMP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range.min / =
SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min(SMU_THERMAL_MAXIMUM_=
ALERT_TEMP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range.max / =
SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1177,27 &#43;1171,20 @@ static int smu_v11_0_enable_thermal_alert(struc=
t smu_context *smu)<br>
&nbsp;static int smu_v11_0_start_thermal_control(struct smu_context *smu)<b=
r>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_temperature_range range =
=3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MIN,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MAX,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MAX,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MIN,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MAX,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MAX,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MIN,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MAX,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEMP_RANGE_MAX};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_temperature_range rang=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;range, &amp;smu11_the=
rmal_policy[0], sizeof(struct smu_temperature_range));<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_thermal_te=
mperature_range(smu, &amp;range);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smu_table.ther=
mal_controller_type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v11_0_set_thermal_range(smu, &amp;range);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_v11_0_set_thermal_range(smu, range);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
@@ -1210,17 &#43;1197,15 @@ static int smu_v11_0_start_thermal_control(stru=
ct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_temp =3D =
range.min * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_temp =3D =
range.max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_edge_emer=
gency_temp =3D range.edge_emergency_max * SMU_TEMPERATURE_UNITS_PER_CENTIGR=
ADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_hotspot_t=
emp =3D range.hotspot_min * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_hotspot_c=
rit_temp =3D range.hotspot_crit_max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_hotspot_e=
mergency_temp =3D range.hotspot_emergency_max * SMU_TEMPERATURE_UNITS_PER_C=
ENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_mem_temp =
=3D range.mem_min * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_mem_crit_=
temp =3D range.mem_crit_max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_mem_emerg=
ency_temp =3D range.mem_emergency_max * SMU_TEMPERATURE_UNITS_PER_CENTIGRAD=
ES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_temp =3D =
range.min * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_temp =3D =
range.max * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_temp =
=3D range.min;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_temp =
=3D range.max;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_edge_=
emergency_temp =3D range.edge_emergency_max;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_hotsp=
ot_temp =3D range.hotspot_min;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_hotsp=
ot_crit_temp =3D range.hotspot_crit_max;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_hotsp=
ot_emergency_temp =3D range.hotspot_emergency_max;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_mem_t=
emp =3D range.mem_min;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_mem_c=
rit_temp =3D range.mem_crit_max;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_mem_e=
mergency_temp =3D range.mem_emergency_max;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index acf075393c13..e14363182691 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -3113,14 &#43;3113,18 @@ static int vega20_get_thermal_temperature_range=
(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range || !powerplay_t=
able)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The unit is temperature */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;min =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table-&gt=
;usSoftwareShutdownTemp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_max =3D (ppt=
able-&gt;TedgeLimit &#43; CTF_OFFSET_EDGE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D pptabl=
e-&gt;ThotspotLimit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_emergency_max =3D (=
pptable-&gt;ThotspotLimit &#43; CTF_OFFSET_HOTSPOT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D pptable-&g=
t;ThbmLimit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_max =3D (ppta=
ble-&gt;ThbmLimit &#43; CTF_OFFSET_HBM);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table=
-&gt;usSoftwareShutdownTemp *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_max =3D =
(pptable-&gt;TedgeLimit &#43; CTF_OFFSET_EDGE) *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D pp=
table-&gt;ThotspotLimit *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_emergency_max =
=3D (pptable-&gt;ThotspotLimit &#43; CTF_OFFSET_HOTSPOT) *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D pptabl=
e-&gt;ThbmLimit *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_max =3D (=
pptable-&gt;ThbmLimit &#43; CTF_OFFSET_HBM) *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.22.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB334407D4ABFF5E4F1CC02518E4AB0MN2PR12MB3344namp_--

--===============1129162297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1129162297==--
