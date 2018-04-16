From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Adding set_watermarks_for_clocks_ranges
 for SMU10
Date: Mon, 16 Apr 2018 15:25:28 +0000
Message-ID: <BN6PR12MB1809FD1A43A6F7E6637122A2F7B00@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1523892166-9037-1-git-send-email-mikita.lipski@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1582765938=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523892166-9037-1-git-send-email-mikita.lipski-5C7GfCeVMHo@public.gmane.org>
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
To: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1582765938==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809FD1A43A6F7E6637122A2F7B00BN6PR12MB1809namp_"

--_000_BN6PR12MB1809FD1A43A6F7E6637122A2F7B00BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of mikita.l=
ipski-5C7GfCeVMHo@public.gmane.org <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, April 16, 2018 11:22:46 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry; Zhu, Rex; Deucher, Alex=
ander
Cc: Lipski, Mikita
Subject: [PATCH 1/2] drm/amd/pp: Adding set_watermarks_for_clocks_ranges fo=
r SMU10

From: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>

The function is never implemented for raven on linux.
It follows similair implementation as on windows.

SMU still needs to notify SMC and copy WM table, which is added
here. But on other Asics such as Vega this step is not implemented.

Signed-off-by: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 13 +++++++++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 6ba3b1f..b712d16 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -992,6 +992,18 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, i=
nt idx,
         return ret;
 }

+static int smu10_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
+               struct pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ra=
nges)
+{
+       struct smu10_hwmgr *data =3D hwmgr->backend;
+       Watermarks_t *table =3D &(data->water_marks_table);
+       int result =3D 0;
+
+       smu_set_watermarks_for_clocks_ranges(table,wm_with_clock_ranges);
+       smum_smc_table_manager(hwmgr, (uint8_t *)table, (uint16_t)SMU10_WMT=
ABLE, false);
+       data->water_marks_exist =3D true;
+       return result;
+}
 static int smu10_set_mmhub_powergating_by_smu(struct pp_hwmgr *hwmgr)
 {
         return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PowerGateMmHub);
@@ -1021,6 +1033,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs =
=3D {
         .get_current_shallow_sleep_clocks =3D smu10_get_current_shallow_sl=
eep_clocks,
         .get_clock_by_type_with_latency =3D smu10_get_clock_by_type_with_l=
atency,
         .get_clock_by_type_with_voltage =3D smu10_get_clock_by_type_with_v=
oltage,
+       .set_watermarks_for_clocks_ranges =3D smu10_set_watermarks_for_cloc=
ks_ranges,
         .get_max_high_clocks =3D smu10_get_max_high_clocks,
         .read_sensor =3D smu10_read_sensor,
         .set_active_display_count =3D smu10_set_active_display_count,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
index 175c3a5..f68b218 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
@@ -290,6 +290,7 @@ struct smu10_hwmgr {
         bool                           vcn_dpg_mode;

         bool                           gfx_off_controled_by_driver;
+       bool                           water_marks_exist;
         Watermarks_t                      water_marks_table;
         struct smu10_clock_voltage_information   clock_vol_info;
         DpmClocks_t                       clock_table;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809FD1A43A6F7E6637122A2F7B00BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of mikita.lipski-5C7GfCeVMHo@public.gmane.org &lt;mik=
ita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, April 16, 2018 11:22:46 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry; Zhu, Rex; Deuche=
r, Alexander<br>
<b>Cc:</b> Lipski, Mikita<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/pp: Adding set_watermarks_for_clocks_ra=
nges for SMU10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
<br>
The function is never implemented for raven on linux.<br>
It follows similair implementation as on windows.<br>
<br>
SMU still needs to notify SMC and copy WM table, which is added<br>
here. But on other Asics such as Vega this step is not implemented.<br>
<br>
Signed-off-by: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 13 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h |&nbsp; 1 &#43;<br>
&nbsp;2 files changed, 14 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index 6ba3b1f..b712d16 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -992,6 &#43;992,18 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmg=
r, int idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu10_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwm=
gr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ran=
ges)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *data =3D hwmg=
r-&gt;backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Watermarks_t *table =3D &amp;(dat=
a-&gt;water_marks_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_set_watermarks_for_clocks_ran=
ges(table,wm_with_clock_ranges);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_smc_table_manager(hwmgr, (ui=
nt8_t *)table, (uint16_t)SMU10_WMTABLE, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;water_marks_exist =3D tr=
ue;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&#43;}<br>
&nbsp;static int smu10_set_mmhub_powergating_by_smu(struct pp_hwmgr *hwmgr)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smum_send_msg_to_sm=
c(hwmgr, PPSMC_MSG_PowerGateMmHub);<br>
@@ -1021,6 &#43;1033,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_current_shallow_sleep=
_clocks =3D smu10_get_current_shallow_sleep_clocks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type_with_la=
tency =3D smu10_get_clock_by_type_with_latency,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type_with_vo=
ltage =3D smu10_get_clock_by_type_with_voltage,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_for_clocks_ranges=
 =3D smu10_set_watermarks_for_clocks_ranges,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_high_clocks =3D s=
mu10_get_max_high_clocks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D smu10_rea=
d_sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_active_display_count =
=3D smu10_set_active_display_count,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.h<br>
index 175c3a5..f68b218 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h<br>
@@ -290,6 &#43;290,7 @@ struct smu10_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_dpg_mode;<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_control=
ed_by_driver;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; water_marks_exist;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Watermarks_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; water_marks_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_clock_voltage=
_information&nbsp;&nbsp; clock_vol_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmClocks_t&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_table;<br>
-- <br>
2.7.4<br>
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

--_000_BN6PR12MB1809FD1A43A6F7E6637122A2F7B00BN6PR12MB1809namp_--

--===============1582765938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1582765938==--
