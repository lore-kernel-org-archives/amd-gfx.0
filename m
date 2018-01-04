From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/pp: Add and initialize OD_dpm_table for CI/VI.
Date: Thu, 4 Jan 2018 14:31:22 +0000
Message-ID: <BN6PR12MB16524BDD07B60799CBF41A4CF71F0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1515059910-29827-1-git-send-email-Rex.Zhu@amd.com>,
 <1515059910-29827-2-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0586891290=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515059910-29827-2-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============0586891290==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16524BDD07B60799CBF41A4CF71F0BN6PR12MB1652namp_"

--_000_BN6PR12MB16524BDD07B60799CBF41A4CF71F0BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please include a commit message.  Something like:

Add initial infrastructure for manual dpm control.

With that fixed:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, January 4, 2018 4:58:30 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 2/2] drm/amd/pp: Add and initialize OD_dpm_table for CI/VI.

Change-Id: I05db3fe2a274ce9666a5074c82448bf8bd6e7ee8
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 73 ++++++++++++++++++++=
++++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h | 14 +++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 9b17cec..863f0d6 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -792,6 +792,74 @@ static int smu7_setup_dpm_tables_v1(struct pp_hwmgr *h=
wmgr)
         return 0;
 }

+static int smu7_get_voltage_dependency_table(
+                       const struct phm_ppt_v1_clock_voltage_dependency_ta=
ble *allowed_dep_table,
+                       struct phm_ppt_v1_clock_voltage_dependency_table *d=
ep_table)
+{
+       uint8_t i =3D 0;
+       PP_ASSERT_WITH_CODE((0 !=3D allowed_dep_table->count),
+                               "Voltage Lookup Table empty",
+                               return -EINVAL);
+
+       dep_table->count =3D allowed_dep_table->count;
+       for (i=3D0; i<dep_table->count; i++) {
+               dep_table->entries[i].clk =3D allowed_dep_table->entries[i]=
.clk;
+               dep_table->entries[i].vddInd =3D allowed_dep_table->entries=
[i].vddInd;
+               dep_table->entries[i].vdd_offset =3D allowed_dep_table->ent=
ries[i].vdd_offset;
+               dep_table->entries[i].vddc =3D allowed_dep_table->entries[i=
].vddc;
+               dep_table->entries[i].vddgfx =3D allowed_dep_table->entries=
[i].vddgfx;
+               dep_table->entries[i].vddci =3D allowed_dep_table->entries[=
i].vddci;
+               dep_table->entries[i].mvdd =3D allowed_dep_table->entries[i=
].mvdd;
+               dep_table->entries[i].phases =3D allowed_dep_table->entries=
[i].phases;
+               dep_table->entries[i].cks_enable =3D allowed_dep_table->ent=
ries[i].cks_enable;
+               dep_table->entries[i].cks_voffset =3D allowed_dep_table->en=
tries[i].cks_voffset;
+       }
+
+       return 0;
+}
+
+static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
+{
+       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
+       struct smu7_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
+       struct phm_ppt_v1_information *table_info =3D
+                       (struct phm_ppt_v1_information *)(hwmgr->pptable);
+       uint32_t i;
+
+       struct phm_ppt_v1_clock_voltage_dependency_table *dep_sclk_table;
+       struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table;
+
+       if (table_info =3D=3D NULL)
+               return -EINVAL;
+
+       dep_sclk_table =3D table_info->vdd_dep_on_sclk;
+       dep_mclk_table =3D table_info->vdd_dep_on_mclk;
+
+       odn_table->odn_core_clock_dpm_levels.number_of_performance_levels =
=3D
+                                               data->dpm_table.sclk_table.=
count;
+       for (i=3D0; i<data->dpm_table.sclk_table.count; i++) {
+               odn_table->odn_core_clock_dpm_levels.entries[i].clock =3D
+                                       data->dpm_table.sclk_table.dpm_leve=
ls[i].value;
+               odn_table->odn_core_clock_dpm_levels.entries[i].enabled =3D=
 true;
+       }
+
+       smu7_get_voltage_dependency_table(dep_sclk_table,
+               (struct phm_ppt_v1_clock_voltage_dependency_table *)&(odn_t=
able->vdd_dependency_on_sclk));
+
+       odn_table->odn_memory_clock_dpm_levels.number_of_performance_levels=
 =3D
+                                               data->dpm_table.mclk_table.=
count;
+       for (i=3D0; i<data->dpm_table.sclk_table.count; i++) {
+               odn_table->odn_memory_clock_dpm_levels.entries[i].clock =3D
+                                       data->dpm_table.mclk_table.dpm_leve=
ls[i].value;
+               odn_table->odn_memory_clock_dpm_levels.entries[i].enabled =
=3D true;
+       }
+
+       smu7_get_voltage_dependency_table(dep_mclk_table,
+               (struct phm_ppt_v1_clock_voltage_dependency_table *)&(odn_t=
able->vdd_dependency_on_mclk));
+
+       return 0;
+}
+
 static int smu7_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
@@ -808,6 +876,11 @@ static int smu7_setup_default_dpm_tables(struct pp_hwm=
gr *hwmgr)
         /* save a copy of the default DPM table */
         memcpy(&(data->golden_dpm_table), &(data->dpm_table),
                         sizeof(struct smu7_dpm_table));
+
+       /* initialize ODN table */
+       if (hwmgr->od_enabled)
+               smu7_odn_initial_default_setting(hwmgr);
+
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
index beba25c..8eec974 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
@@ -178,9 +178,23 @@ struct smu7_pcie_perf_range {
         uint16_t  min;
 };

+struct smu7_odn_clock_voltage_dependency_table {
+       uint32_t count;
+       phm_ppt_v1_clock_voltage_dependency_record entries[MAX_REGULAR_DPM_=
NUMBER];
+};
+
+struct smu7_odn_dpm_table {
+       struct phm_odn_clock_levels             odn_core_clock_dpm_levels;
+       struct phm_odn_clock_levels             odn_memory_clock_dpm_levels=
;
+       struct smu7_odn_clock_voltage_dependency_table  vdd_dependency_on_s=
clk;
+       struct smu7_odn_clock_voltage_dependency_table  vdd_dependency_on_m=
clk;
+       uint32_t                                        odn_mclk_min_limit;
+};
+
 struct smu7_hwmgr {
         struct smu7_dpm_table                   dpm_table;
         struct smu7_dpm_table                   golden_dpm_table;
+       struct smu7_odn_dpm_table               odn_dpm_table;

         uint32_t                                                voting_rig=
hts_clients[8];
         uint32_t                                                static_scr=
een_threshold_unit;
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16524BDD07B60799CBF41A4CF71F0BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Please include a commit message.&=
nbsp; Something like:</p>
<p style=3D"margin-top:0;margin-bottom:0">Add initial infrastructure for ma=
nual dpm control.</p>
<p style=3D"margin-top:0;margin-bottom:0">With that fixed:</p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Reviewed-by: Alex Deucher &=
lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Thursday, January 4, 2018 4:58:30 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pp: Add and initialize OD_dpm_table for=
 CI/VI.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: I05db3fe2a274ce9666a5074c82448bf8bd6e7e=
e8<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 73 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h | 14 &#43;&#43;&#43;=
&#43;&#43;<br>
&nbsp;2 files changed, 87 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 9b17cec..863f0d6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -792,6 &#43;792,74 @@ static int smu7_setup_dpm_tables_v1(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu7_get_voltage_dependency_table(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct=
 phm_ppt_v1_clock_voltage_dependency_table *allowed_dep_table,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_p=
pt_v1_clock_voltage_dependency_table *dep_table)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t i =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((0 !=3D allow=
ed_dep_table-&gt;count),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Voltage Lookup Table empty&quot;,=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_table-&gt;count =3D allowed_d=
ep_table-&gt;count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;dep_table-&gt;co=
unt; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].clk =3D allowed_dep_table-&gt;entri=
es[i].clk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].vddInd =3D allowed_dep_table-&gt;en=
tries[i].vddInd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].vdd_offset =3D allowed_dep_table-&g=
t;entries[i].vdd_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].vddc =3D allowed_dep_table-&gt;entr=
ies[i].vddc;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].vddgfx =3D allowed_dep_table-&gt;en=
tries[i].vddgfx;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].vddci =3D allowed_dep_table-&gt;ent=
ries[i].vddci;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].mvdd =3D allowed_dep_table-&gt;entr=
ies[i].mvdd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].phases =3D allowed_dep_table-&gt;en=
tries[i].phases;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].cks_enable =3D allowed_dep_table-&g=
t;entries[i].cks_enable;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dep_table-&gt;entries[i].cks_voffset =3D allowed_dep_table-&=
gt;entries[i].cks_voffset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)<br=
>
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
ependency_table *dep_sclk_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_voltage_d=
ependency_table *dep_mclk_table;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_info =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_sclk_table =3D table_info-&gt=
;vdd_dep_on_sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_mclk_table =3D table_info-&gt=
;vdd_dep_on_mclk;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_table-&gt;odn_core_clock_dpm_=
levels.number_of_performance_levels =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table=
.sclk_table.count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;dpm_tab=
le.sclk_table.count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; odn_table-&gt;odn_core_clock_dpm_levels.entries[i].clock =3D=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data-&gt;dpm_table.sclk_table.dpm_levels[i].value;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; odn_table-&gt;odn_core_clock_dpm_levels.entries[i].enabled =
=3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_get_voltage_dependency_table=
(dep_sclk_table,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (struct phm_ppt_v1_clock_voltage_dependency_table *)&amp;(od=
n_table-&gt;vdd_dependency_on_sclk));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_table-&gt;odn_memory_clock_dp=
m_levels.number_of_performance_levels =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table=
.mclk_table.count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;dpm_tab=
le.sclk_table.count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].clock =
=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data-&gt;dpm_table.mclk_table.dpm_levels[i].value;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].enabled=
 =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_get_voltage_dependency_table=
(dep_mclk_table,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (struct phm_ppt_v1_clock_voltage_dependency_table *)&amp;(od=
n_table-&gt;vdd_dependency_on_mclk));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int smu7_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
@@ -808,6 &#43;876,11 @@ static int smu7_setup_default_dpm_tables(struct pp=
_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save a copy of the defa=
ult DPM table */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;(data-&gt;gold=
en_dpm_table), &amp;(data-&gt;dpm_table),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeo=
f(struct smu7_dpm_table));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize ODN table */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu7_odn_initial_default_setting(hwmgr);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
index beba25c..8eec974 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
@@ -178,9 &#43;178,23 @@ struct smu7_pcie_perf_range {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp; min;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct smu7_odn_clock_voltage_dependency_table {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_ppt_v1_clock_voltage_dependen=
cy_record entries[MAX_REGULAR_DPM_NUMBER];<br>
&#43;};<br>
&#43;<br>
&#43;struct smu7_odn_dpm_table {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_odn_clock_levels&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_core=
_clock_dpm_levels;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_odn_clock_levels&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_memo=
ry_clock_dpm_levels;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_odn_clock_voltage_dep=
endency_table&nbsp; vdd_dependency_on_sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_odn_clock_voltage_dep=
endency_table&nbsp; vdd_dependency_on_mclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_mclk_min_li=
mit;<br>
&#43;};<br>
&#43;<br>
&nbsp;struct smu7_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_dpm_table&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_dpm_table&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_dpm_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_odn_dpm_table&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; odn_dpm_table;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voting_rights_clients[8];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static_screen_threshold_unit;<br>
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

--_000_BN6PR12MB16524BDD07B60799CBF41A4CF71F0BN6PR12MB1652namp_--

--===============0586891290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0586891290==--
