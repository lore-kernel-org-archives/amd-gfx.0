From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: do proper cleanups on hw_fini
Date: Sun, 8 Sep 2019 23:05:37 +0000
Message-ID: <BN6PR12MB180948FD8E64A35AA01A4A94F7B40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190903034336.16005-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0407824335=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190903034336.16005-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--===============0407824335==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180948FD8E64A35AA01A4A94F7B40BN6PR12MB1809namp_"

--_000_BN6PR12MB180948FD8E64A35AA01A4A94F7B40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We should probably also add the callbacks for set_mp1_state like we have fo=
r the older powerplay code so we properly send the SMU shutdown or reset me=
ssage on GPU reset and driver unload.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 2, 2019 11:44 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Li, Candice <Candice.Li-5C7GfCeVMHo@public.gmane.org>; Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>; Quan, E=
van <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: do proper cleanups on hw_fini

These are needed for smu_reset support.

Change-Id: If29ede4b99758adb08fd4e16665f44fd893ec99b
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 17 +++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  3 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index d5ee13a78eb7..3cf8d944f890 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1286,6 +1286,11 @@ static int smu_hw_init(void *handle)
         return ret;
 }

+static int smu_stop_dpms(struct smu_context *smu)
+{
+       return smu_send_smc_msg(smu, SMU_MSG_DisableAllSmuFeatures);
+}
+
 static int smu_hw_fini(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -1298,6 +1303,18 @@ static int smu_hw_fini(void *handle)
                 smu_powergate_vcn(&adev->smu, true);
         }

+       ret =3D smu_stop_thermal_control(smu);
+       if (ret) {
+               pr_warn("Fail to stop thermal control!\n");
+               return ret;
+       }
+
+       ret =3D smu_stop_dpms(smu);
+       if (ret) {
+               pr_warn("Fail to stop Dpms!\n");
+               return ret;
+       }
+
         kfree(table_context->driver_pptable);
         table_context->driver_pptable =3D NULL;

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index b19224cb6d6d..8e4b0ad24712 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -498,6 +498,7 @@ struct smu_funcs
         int (*get_current_clk_freq)(struct smu_context *smu, enum smu_clk_=
type clk_id, uint32_t *value);
         int (*init_max_sustainable_clocks)(struct smu_context *smu);
         int (*start_thermal_control)(struct smu_context *smu);
+       int (*stop_thermal_control)(struct smu_context *smu);
         int (*read_sensor)(struct smu_context *smu, enum amd_pp_sensors se=
nsor,
                            void *data, uint32_t *size);
         int (*set_deep_sleep_dcefclk)(struct smu_context *smu, uint32_t cl=
k);
@@ -647,6 +648,8 @@ struct smu_funcs
         ((smu)->ppt_funcs->set_thermal_fan_table ? (smu)->ppt_funcs->set_t=
hermal_fan_table((smu)) : 0)
 #define smu_start_thermal_control(smu) \
         ((smu)->funcs->start_thermal_control? (smu)->funcs->start_thermal_=
control((smu)) : 0)
+#define smu_stop_thermal_control(smu) \
+       ((smu)->funcs->stop_thermal_control? (smu)->funcs->stop_thermal_con=
trol((smu)) : 0)
 #define smu_read_sensor(smu, sensor, data, size) \
         ((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor((smu=
), (sensor), (data), (size)) : 0)
 #define smu_smc_read_sensor(smu, sensor, data, size) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index db5e94ce54af..1a38af84394e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1209,6 +1209,15 @@ static int smu_v11_0_start_thermal_control(struct sm=
u_context *smu)
         return ret;
 }

+static int smu_v11_0_stop_thermal_control(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, 0);
+
+       return 0;
+}
+
 static uint16_t convert_to_vddc(uint8_t vid)
 {
         return (uint16_t) ((6200 - (vid * 25)) / SMU11_VOLTAGE_SCALE);
@@ -1783,6 +1792,7 @@ static const struct smu_funcs smu_v11_0_funcs =3D {
         .get_current_clk_freq =3D smu_v11_0_get_current_clk_freq,
         .init_max_sustainable_clocks =3D smu_v11_0_init_max_sustainable_cl=
ocks,
         .start_thermal_control =3D smu_v11_0_start_thermal_control,
+       .stop_thermal_control =3D smu_v11_0_stop_thermal_control,
         .read_sensor =3D smu_v11_0_read_sensor,
         .set_deep_sleep_dcefclk =3D smu_v11_0_set_deep_sleep_dcefclk,
         .display_clock_voltage_request =3D smu_v11_0_display_clock_voltage=
_request,
--
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180948FD8E64A35AA01A4A94F7B40BN6PR12MB1809namp_
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
We should probably also add the callbacks for set_mp1_state like we have fo=
r the older powerplay code so we properly send the SMU shutdown or reset me=
ssage on GPU reset and driver unload.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Monday, September 2, 2019 11:44 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li-5C7GfCeVMHo@public.gmane.org&gt;; Gui, Jack &lt;Jack.Gui@a=
md.com&gt;; Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: do proper cleanups on hw_fini</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">These are needed for smu_reset support.<br>
<br>
Change-Id: If29ede4b99758adb08fd4e16665f44fd893ec99b<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | =
17 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |&nbsp; 3 &#43;&#43;&#=
43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 10 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;3 files changed, 30 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index d5ee13a78eb7..3cf8d944f890 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1286,6 &#43;1286,11 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu_stop_dpms(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg(smu, SMU_=
MSG_DisableAllSmuFeatures);<br>
&#43;}<br>
&#43;<br>
&nbsp;static int smu_hw_fini(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -1298,6 &#43;1303,18 @@ static int smu_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_powergate_vcn(&amp;adev-&gt;smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_stop_thermal_control(=
smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_warn(&quot;Fail to stop thermal control!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_stop_dpms(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_warn(&quot;Fail to stop Dpms!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(table_context-&gt;dr=
iver_pptable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;driver_p=
ptable =3D NULL;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index b19224cb6d6d..8e4b0ad24712 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -498,6 &#43;498,7 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_current_clk_freq=
)(struct smu_context *smu, enum smu_clk_type clk_id, uint32_t *value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_max_sustainable=
_clocks)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*start_thermal_contro=
l)(struct smu_context *smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*stop_thermal_control)(struc=
t smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_sensor)(struct =
smu_context *smu, enum amd_pp_sensors sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; void *data, uint32_t *size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_deep_sleep_dcefc=
lk)(struct smu_context *smu, uint32_t clk);<br>
@@ -647,6 &#43;648,8 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;s=
et_thermal_fan_table ? (smu)-&gt;ppt_funcs-&gt;set_thermal_fan_table((smu))=
 : 0)<br>
&nbsp;#define smu_start_thermal_control(smu) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;start=
_thermal_control? (smu)-&gt;funcs-&gt;start_thermal_control((smu)) : 0)<br>
&#43;#define smu_stop_thermal_control(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;stop_thermal=
_control? (smu)-&gt;funcs-&gt;stop_thermal_control((smu)) : 0)<br>
&nbsp;#define smu_read_sensor(smu, sensor, data, size) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;r=
ead_sensor? (smu)-&gt;ppt_funcs-&gt;read_sensor((smu), (sensor), (data), (s=
ize)) : 0)<br>
&nbsp;#define smu_smc_read_sensor(smu, sensor, data, size) \<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index db5e94ce54af..1a38af84394e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1209,6 &#43;1209,15 @@ static int smu_v11_0_start_thermal_control(struc=
t smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu_v11_0_stop_thermal_control(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_ENA, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static uint16_t convert_to_vddc(uint8_t vid)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (uint16_t) ((6200 -=
 (vid * 25)) / SMU11_VOLTAGE_SCALE);<br>
@@ -1783,6 &#43;1792,7 @@ static const struct smu_funcs smu_v11_0_funcs =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_current_clk_freq =3D =
smu_v11_0_get_current_clk_freq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_max_sustainable_cloc=
ks =3D smu_v11_0_init_max_sustainable_clocks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_thermal_control =3D=
 smu_v11_0_start_thermal_control,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop_thermal_control =3D smu_v11=
_0_stop_thermal_control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D smu_v11_0=
_read_sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_deep_sleep_dcefclk =
=3D smu_v11_0_set_deep_sleep_dcefclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_req=
uest =3D smu_v11_0_display_clock_voltage_request,<br>
-- <br>
2.23.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180948FD8E64A35AA01A4A94F7B40BN6PR12MB1809namp_--

--===============0407824335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0407824335==--
