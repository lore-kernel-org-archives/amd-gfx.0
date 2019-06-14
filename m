From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: detect version of smu backend
Date: Fri, 14 Jun 2019 13:13:35 +0000
Message-ID: <BN6PR12MB18098EE94146CE430C417DB1F7EE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1560495689-12881-1-git-send-email-Prike.Liang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0368821962=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1560495689-12881-1-git-send-email-Prike.Liang-5C7GfCeVMHo@public.gmane.org>
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
To: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

--===============0368821962==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18098EE94146CE430C417DB1F7EE0BN6PR12MB1809namp_"

--_000_BN6PR12MB18098EE94146CE430C417DB1F7EE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Prike Li=
ang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, June 14, 2019 3:01 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liang, Prike; Huang, Ray; Feng, Kenneth; Quan, Evan
Subject: [PATCH] drm/amd/powerplay: detect version of smu backend

Change-Id: Ib050c8cf0c2c5af4c1f747cf596860f9be01a2d3
Signed-off-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c             | 1 +
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h               | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c        | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c      | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c   | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c     | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c      | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c     | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c    | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c    | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c    | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c     | 1 +
 13 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index f1d326c..b996819 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -194,6 +194,7 @@ int hwmgr_sw_init(struct pp_hwmgr *hwmgr)
                 return -EINVAL;

         phm_register_irq_handlers(hwmgr);
+       pr_info("hwmgr_sw_init smu backed is %s\n",hwmgr->smumgr_funcs->nam=
e);

         return hwmgr->smumgr_funcs->smu_init(hwmgr);
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index c92999a..47dbecc 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -190,6 +190,7 @@ struct phm_vce_clock_voltage_dependency_table {
 };

 struct pp_smumgr_func {
+       char *name;
         int (*smu_init)(struct pp_hwmgr  *hwmgr);
         int (*smu_fini)(struct pp_hwmgr  *hwmgr);
         int (*start_smu)(struct pp_hwmgr  *hwmgr);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/ci_smumgr.c
index 9ef57fc..022f3c8 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2935,6 +2935,7 @@ static int ci_update_smc_table(struct pp_hwmgr *hwmgr=
, uint32_t type)
 }

 const struct pp_smumgr_func ci_smu_funcs =3D {
+       .name =3D "ci_smu",
         .smu_init =3D ci_smu_init,
         .smu_fini =3D ci_smu_fini,
         .start_smu =3D ci_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 0ce85b7..da025b1 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -2643,6 +2643,7 @@ static int fiji_update_dpm_settings(struct pp_hwmgr *=
hwmgr,
 }

 const struct pp_smumgr_func fiji_smu_funcs =3D {
+       .name =3D "fiji_smu",
         .smu_init =3D &fiji_smu_init,
         .smu_fini =3D &smu7_smu_fini,
         .start_smu =3D &fiji_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index f24f13d..f414f22 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2661,6 +2661,7 @@ static bool iceland_is_dpm_running(struct pp_hwmgr *h=
wmgr)
 }

 const struct pp_smumgr_func iceland_smu_funcs =3D {
+       .name =3D "iceland_smu",
         .smu_init =3D &iceland_smu_init,
         .smu_fini =3D &smu7_smu_fini,
         .start_smu =3D &iceland_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 0d8958e..fbac2d3 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -2550,6 +2550,7 @@ static int polaris10_update_dpm_settings(struct pp_hw=
mgr *hwmgr,
 }

 const struct pp_smumgr_func polaris10_smu_funcs =3D {
+       .name =3D "polaris10_smu",
         .smu_init =3D polaris10_smu_init,
         .smu_fini =3D smu7_smu_fini,
         .start_smu =3D polaris10_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
index 6d11076a..ca66035 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
@@ -291,6 +291,7 @@ static int smu10_smc_table_manager(struct pp_hwmgr *hwm=
gr, uint8_t *table, uint1


 const struct pp_smumgr_func smu10_smu_funcs =3D {
+       .name =3D "smu10_smu",
         .smu_init =3D &smu10_smu_init,
         .smu_fini =3D &smu10_smu_fini,
         .start_smu =3D &smu10_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index e2787e1..8189fe4 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -881,6 +881,7 @@ static bool smu8_is_dpm_running(struct pp_hwmgr *hwmgr)
 }

 const struct pp_smumgr_func smu8_smu_funcs =3D {
+       .name =3D "smu8_smu",
         .smu_init =3D smu8_smu_init,
         .smu_fini =3D smu8_smu_fini,
         .start_smu =3D smu8_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 060c0f7..be5b7df 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -3240,6 +3240,7 @@ static int tonga_update_dpm_settings(struct pp_hwmgr =
*hwmgr,
 }

 const struct pp_smumgr_func tonga_smu_funcs =3D {
+       .name =3D "tonga_smu",
         .smu_init =3D &tonga_smu_init,
         .smu_fini =3D &smu7_smu_fini,
         .start_smu =3D &tonga_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
index c81acc3..7bfef8d 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
@@ -346,6 +346,7 @@ static int vega10_smc_table_manager(struct pp_hwmgr *hw=
mgr, uint8_t *table,
 }

 const struct pp_smumgr_func vega10_smu_funcs =3D {
+       .name =3D "vega10_smu",
         .smu_init =3D &vega10_smu_init,
         .smu_fini =3D &vega10_smu_fini,
         .start_smu =3D &vega10_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
index 1eaf0fa..9ad07a91c 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
@@ -386,6 +386,7 @@ static int vega12_smc_table_manager(struct pp_hwmgr *hw=
mgr, uint8_t *table,
 }

 const struct pp_smumgr_func vega12_smu_funcs =3D {
+       .name =3D"vega12_smu",
         .smu_init =3D &vega12_smu_init,
         .smu_fini =3D &vega12_smu_fini,
         .start_smu =3D &vega12_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index f301a73..957446c 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -592,6 +592,7 @@ static int vega20_smc_table_manager(struct pp_hwmgr *hw=
mgr, uint8_t *table,
 }

 const struct pp_smumgr_func vega20_smu_funcs =3D {
+       .name =3D "vega20_smu",
         .smu_init =3D &vega20_smu_init,
         .smu_fini =3D &vega20_smu_fini,
         .start_smu =3D &vega20_start_smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index d499204..7c960b0 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -2279,6 +2279,7 @@ static int vegam_thermal_setup_fan_table(struct pp_hw=
mgr *hwmgr)
 }

 const struct pp_smumgr_func vegam_smu_funcs =3D {
+       .name =3D "vegam_smu",
         .smu_init =3D vegam_smu_init,
         .smu_fini =3D smu7_smu_fini,
         .start_smu =3D vegam_start_smu,
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18098EE94146CE430C417DB1F7EE0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Prike Liang &lt;Prike.Liang@a=
md.com&gt;<br>
<b>Sent:</b> Friday, June 14, 2019 3:01 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Liang, Prike; Huang, Ray; Feng, Kenneth; Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: detect version of smu backend</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: Ib050c8cf0c2c5af4c1f747cf596860f9be01a2=
d3<br>
Signed-off-by: Prike Liang &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c&nbsp;&nbsp; | 1=
 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c&nbsp;&nbsp;&nbsp=
; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c&nbsp;&nbsp;&nbsp=
; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c&nbsp;&nbsp;&nbsp=
; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 1 &#43;<br>
&nbsp;13 files changed, 13 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index f1d326c..b996819 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -194,6 &#43;194,7 @@ int hwmgr_sw_init(struct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_register_irq_handlers(=
hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;hwmgr_sw_init smu b=
acked is %s\n&quot;,hwmgr-&gt;smumgr_funcs-&gt;name);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;smumgr_fu=
ncs-&gt;smu_init(hwmgr);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index c92999a..47dbecc 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -190,6 &#43;190,7 @@ struct phm_vce_clock_voltage_dependency_table {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct pp_smumgr_func {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *name;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_init)(struct pp_=
hwmgr&nbsp; *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_fini)(struct pp_=
hwmgr&nbsp; *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*start_smu)(struct pp=
_hwmgr&nbsp; *hwmgr);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
index 9ef57fc..022f3c8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
@@ -2935,6 &#43;2935,7 @@ static int ci_update_smc_table(struct pp_hwmgr *h=
wmgr, uint32_t type)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func ci_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;ci_smu&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D ci_smu_init,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D ci_smu_fini,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D ci_start_sm=
u,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
index 0ce85b7..da025b1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
@@ -2643,6 &#43;2643,7 @@ static int fiji_update_dpm_settings(struct pp_hwm=
gr *hwmgr,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func fiji_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;fiji_smu&quot;,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D &amp;fiji_sm=
u_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;smu7_sm=
u_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;fiji_s=
tart_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
index f24f13d..f414f22 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
@@ -2661,6 &#43;2661,7 @@ static bool iceland_is_dpm_running(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func iceland_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;iceland_smu&quot;=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D &amp;iceland=
_smu_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;smu7_sm=
u_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;icelan=
d_start_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
index 0d8958e..fbac2d3 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<b=
r>
@@ -2550,6 &#43;2550,7 @@ static int polaris10_update_dpm_settings(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func polaris10_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;polaris10_smu&quo=
t;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D polaris10_sm=
u_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D smu7_smu_fin=
i,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D polaris10_s=
tart_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
index 6d11076a..ca66035 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
@@ -291,6 &#43;291,7 @@ static int smu10_smc_table_manager(struct pp_hwmgr =
*hwmgr, uint8_t *table, uint1<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func smu10_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;smu10_smu&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D &amp;smu10_s=
mu_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;smu10_s=
mu_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;smu10_=
start_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
index e2787e1..8189fe4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
@@ -881,6 &#43;881,7 @@ static bool smu8_is_dpm_running(struct pp_hwmgr *hw=
mgr)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func smu8_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;smu8_smu&quot;,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D smu8_smu_ini=
t,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D smu8_smu_fin=
i,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D smu8_start_=
smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
index 060c0f7..be5b7df 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
@@ -3240,6 &#43;3240,7 @@ static int tonga_update_dpm_settings(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func tonga_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;tonga_smu&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D &amp;tonga_s=
mu_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;smu7_sm=
u_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;tonga_=
start_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
index c81acc3..7bfef8d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
@@ -346,6 &#43;346,7 @@ static int vega10_smc_table_manager(struct pp_hwmgr=
 *hwmgr, uint8_t *table,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func vega10_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;vega10_smu&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D &amp;vega10_=
smu_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;vega10_=
smu_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;vega10=
_start_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c<br>
index 1eaf0fa..9ad07a91c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c<br>
@@ -386,6 &#43;386,7 @@ static int vega12_smc_table_manager(struct pp_hwmgr=
 *hwmgr, uint8_t *table,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func vega12_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D&quot;vega12_smu&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D &amp;vega12_=
smu_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;vega12_=
smu_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;vega12=
_start_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c<br>
index f301a73..957446c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c<br>
@@ -592,6 &#43;592,7 @@ static int vega20_smc_table_manager(struct pp_hwmgr=
 *hwmgr, uint8_t *table,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func vega20_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;vega20_smu&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D &amp;vega20_=
smu_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;vega20_=
smu_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;vega20=
_start_smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
index d499204..7c960b0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
@@ -2279,6 &#43;2279,7 @@ static int vegam_thermal_setup_fan_table(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct pp_smumgr_func vegam_smu_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;vegam_smu&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_init =3D vegam_smu_in=
it,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D smu7_smu_fin=
i,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D vegam_start=
_smu,<br>
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

--_000_BN6PR12MB18098EE94146CE430C417DB1F7EE0BN6PR12MB1809namp_--

--===============0368821962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0368821962==--
