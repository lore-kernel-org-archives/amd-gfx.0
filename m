From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: change smu_read_sensor sequence in smu
Date: Tue, 23 Jul 2019 15:06:13 +0000
Message-ID: <BN6PR12MB1809826E34BDEAA5E1F5D7AFF7C70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1563874746-6318-1-git-send-email-kenneth.feng@amd.com>,
 <MN2PR12MB3296043F281A9E7345179AE1A2C70@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1101161715=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3296043F281A9E7345179AE1A2C70-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1101161715==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809826E34BDEAA5E1F5D7AFF7C70BN6PR12MB1809namp_"

--_000_BN6PR12MB1809826E34BDEAA5E1F5D7AFF7C70BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Looks good to me.

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, July 23, 2019 5:43 AM
To: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org=
>
Subject: Re: [PATCH] drm/amd/powerplay: change smu_read_sensor sequence in =
smu


it looks fine for me,

please @Deucher, Alexander<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> double check c=
onfirm.

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kenneth =
Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, July 23, 2019 5:39 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: change smu_read_sensor sequence in smu

change the smu_read_sensor sequence to:

asic specific sensor read -> smu v11 specific sensor read -> smu v11 common=
 sensor read

Signed-off-by: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 3 +++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 4 ++--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 5 ++++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 8 ++++----
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c     | 5 ++++-
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 416f9a8..8ff18c8 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -315,6 +315,9 @@ int smu_common_read_sensor(struct smu_context *smu, enu=
m amd_pp_sensors sensor,
 {
         int ret =3D 0;

+       if(!data || !size)
+               return -EINVAL;
+
         switch (sensor) {
         case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
                 *((uint32_t *)data) =3D smu->pstate_sclk;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index b702c9e..fabb373 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -819,9 +819,9 @@ struct smu_funcs
 #define smu_start_thermal_control(smu) \
         ((smu)->funcs->start_thermal_control? (smu)->funcs->start_thermal_=
control((smu)) : 0)
 #define smu_read_sensor(smu, sensor, data, size) \
-       ((smu)->funcs->read_sensor? (smu)->funcs->read_sensor((smu), (senso=
r), (data), (size)) : 0)
-#define smu_asic_read_sensor(smu, sensor, data, size) \
         ((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor((smu=
), (sensor), (data), (size)) : 0)
+#define smu_smc_read_sensor(smu, sensor, data, size) \
+       ((smu)->funcs->read_sensor? (smu)->funcs->read_sensor((smu), (senso=
r), (data), (size)) : -EINVAL)
 #define smu_get_power_profile_mode(smu, buf) \
         ((smu)->ppt_funcs->get_power_profile_mode ? (smu)->ppt_funcs->get_=
power_profile_mode((smu), buf) : 0)
 #define smu_set_power_profile_mode(smu, param, param_size) \
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index c8ce9bb..6409718 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1366,6 +1366,9 @@ static int navi10_read_sensor(struct smu_context *smu=
,
         struct smu_table_context *table_context =3D &smu->smu_table;
         PPTable_t *pptable =3D table_context->driver_pptable;

+       if(!data || !size)
+               return -EINVAL;
+
         switch (sensor) {
         case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
                 *(uint32_t *)data =3D pptable->FanMaximumRpm;
@@ -1387,7 +1390,7 @@ static int navi10_read_sensor(struct smu_context *smu=
,
                 *size =3D 4;
                 break;
         default:
-               return -EINVAL;
+               ret =3D smu_smc_read_sensor(smu, sensor, data, size);
         }

         return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index e3a1784..5267b68 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1267,6 +1267,10 @@ static int smu_v11_0_read_sensor(struct smu_context =
*smu,
                                  void *data, uint32_t *size)
 {
         int ret =3D 0;
+
+       if(!data || !size)
+               return -EINVAL;
+
         switch (sensor) {
         case AMDGPU_PP_SENSOR_GFX_MCLK:
                 ret =3D smu_get_current_clk_freq(smu, SMU_UCLK, (uint32_t =
*)data);
@@ -1289,10 +1293,6 @@ static int smu_v11_0_read_sensor(struct smu_context =
*smu,
                 break;
         }

-       /* try get sensor data by asic */
-       if (ret)
-               ret =3D smu_asic_read_sensor(smu, sensor, data, size);
-
         if (ret)
                 *size =3D 0;

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 9ead361..e864a54 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3163,6 +3163,9 @@ static int vega20_read_sensor(struct smu_context *smu=
,
         struct smu_table_context *table_context =3D &smu->smu_table;
         PPTable_t *pptable =3D table_context->driver_pptable;

+       if(!data || !size)
+               return -EINVAL;
+
         switch (sensor) {
         case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
                 *(uint32_t *)data =3D pptable->FanMaximumRpm;
@@ -3186,7 +3189,7 @@ static int vega20_read_sensor(struct smu_context *smu=
,
                 *size =3D 4;
                 break;
         default:
-               return -EINVAL;
+               ret =3D smu_smc_read_sensor(smu, sensor, data, size);
         }

         return ret;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.


--_000_BN6PR12MB1809826E34BDEAA5E1F5D7AFF7C70BN6PR12MB1809namp_
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
Looks good to me.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, July 23, 2019 5:43 AM<br>
<b>To:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: change smu_read_sensor seque=
nce in smu</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"font-size:12pt">i=
t looks fine for me,&nbsp;</span><br>
</p>
<div>please <a class=3D"x_mention x_ms-bgc-nlr x_ms-fcl-b" id=3D"OWAAM92817=
9" href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">
@Deucher, Alexander</a>&nbsp;double check confirm.</div>
<div><br>
</div>
<div>Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div><br>
</div>
<div>Best Regards,<br>
Kevin<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kenneth Feng &lt;kenneth.fe=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, July 23, 2019 5:39 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: change smu_read_sensor sequence =
in smu</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">change the smu_read_sensor sequence to:<br>
<br>
asic specific sensor read -&gt; smu v11 specific sensor read -&gt; smu v11 =
common sensor read<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | =
3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbsp; | =
5 &#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 8 &#43;&#43;&#43;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp;&nbsp; | =
5 &#43;&#43;&#43;&#43;-<br>
&nbsp;5 files changed, 17 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 416f9a8..8ff18c8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -315,6 &#43;315,9 @@ int smu_common_read_sensor(struct smu_context *smu,=
 enum amd_pp_sensors sensor,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!data || !size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_STAB=
LE_PSTATE_SCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *((uint32_t *)data) =3D smu-&gt;pstate_sclk;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index b702c9e..fabb373 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -819,9 &#43;819,9 @@ struct smu_funcs<br>
&nbsp;#define smu_start_thermal_control(smu) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;start=
_thermal_control? (smu)-&gt;funcs-&gt;start_thermal_control((smu)) : 0)<br>
&nbsp;#define smu_read_sensor(smu, sensor, data, size) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;read_sensor? (sm=
u)-&gt;funcs-&gt;read_sensor((smu), (sensor), (data), (size)) : 0)<br>
-#define smu_asic_read_sensor(smu, sensor, data, size) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;r=
ead_sensor? (smu)-&gt;ppt_funcs-&gt;read_sensor((smu), (sensor), (data), (s=
ize)) : 0)<br>
&#43;#define smu_smc_read_sensor(smu, sensor, data, size) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;read_sensor?=
 (smu)-&gt;funcs-&gt;read_sensor((smu), (sensor), (data), (size)) : -EINVAL=
)<br>
&nbsp;#define smu_get_power_profile_mode(smu, buf) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;g=
et_power_profile_mode ? (smu)-&gt;ppt_funcs-&gt;get_power_profile_mode((smu=
), buf) : 0)<br>
&nbsp;#define smu_set_power_profile_mode(smu, param, param_size) \<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index c8ce9bb..6409718 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -1366,6 &#43;1366,9 @@ static int navi10_read_sensor(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
table_context =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D tab=
le_context-&gt;driver_pptable;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!data || !size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_MAX_=
FAN_RPM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint32_t *)data =3D pptable-&gt;FanMaximumRpm;<br>
@@ -1387,7 &#43;1390,7 @@ static int navi10_read_sensor(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_smc_read_sensor(smu, sensor, data, size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index e3a1784..5267b68 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1267,6 &#43;1267,10 @@ static int smu_v11_0_read_sensor(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, uint32_t *size=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!data || !size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_=
MCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_current_clk_freq(smu, SMU_UCLK, (uint=
32_t *)data);<br>
@@ -1289,10 &#43;1293,6 @@ static int smu_v11_0_read_sensor(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* try get sensor data by asic */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_asic_read_sensor(smu, sensor, data, size);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 9ead361..e864a54 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -3163,6 &#43;3163,9 @@ static int vega20_read_sensor(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
table_context =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D tab=
le_context-&gt;driver_pptable;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!data || !size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_MAX_=
FAN_RPM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint32_t *)data =3D pptable-&gt;FanMaximumRpm;<br>
@@ -3186,7 &#43;3189,7 @@ static int vega20_read_sensor(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_smc_read_sensor(smu, sensor, data, size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk308364" class=3D"x_OWAAutoLink">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a></div>
<div id=3D"LPBorder_GT_15638749518470.02267473158651634" style=3D"margin-bo=
ttom:20px; overflow:auto; width:100%; text-indent:0px">
<table id=3D"LPContainer_15638749518450.8626503153022167" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width:90%; background-color:rgb(255,255,255=
); overflow:auto; padding-top:20px; padding-bottom:20px; margin-top:20px; b=
order-top:1px dotted rgb(200,200,200); border-bottom:1px dotted rgb(200,200=
,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"x_TextCell_15638749518460.7609342713450393" colspan=3D"2" style=
=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPRemovePreviewContainer_15638749518460.24310328073303422"></div=
>
<div id=3D"LPTitle_15638749518460.7214757521911543" style=3D"top:0px; color=
:rgb(0,120,215); font-weight:400; font-size:21px; font-family:wf_segoe-ui_l=
ight,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&q=
uot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-height:21px">
<a id=3D"LPUrlAnchor_15638749518460.9823406329165418" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration:none">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15638749518470.8057760659421027" style=3D"margin:10px=
 0px 16px; color:rgb(102,102,102); font-weight:400; font-family:wf_segoe-ui=
_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; =
font-size:14px; line-height:14px">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15638749518470.6436677658830974" style=3D"display:=
block; color:rgb(102,102,102); font-weight:400; font-family:wf_segoe-ui_nor=
mal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font=
-size:14px; line-height:20px; max-height:100px; overflow:hidden">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1809826E34BDEAA5E1F5D7AFF7C70BN6PR12MB1809namp_--

--===============1101161715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1101161715==--
