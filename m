From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add support for ATOM GFXCLK table v2.
Date: Mon, 19 Jun 2017 11:00:02 +0000
Message-ID: <CY1PR12MB04745029F2EFA65CF8415FF88CC40@CY1PR12MB0474.namprd12.prod.outlook.com>
References: <1497866716-32089-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0458527922=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1497866716-32089-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============0458527922==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB04745029F2EFA65CF8415FF88CC40CY1PR12MB0474namp_"

--_000_CY1PR12MB04745029F2EFA65CF8415FF88CC40CY1PR12MB0474namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Ken Wang<Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, June 19, 2017 6:05:16 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/powerplay: add support for ATOM GFXCLK table v2.

Change-Id: I42e3d7b684ee903ce3ced6135f954cea0d113503
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 14 +++++---
 .../gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h   |  9 +++++
 .../amd/powerplay/hwmgr/vega10_processpptables.c   | 42 +++++++++++++++++-=
----
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index d9744b6..e2e2822 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -2864,6 +2864,7 @@ static int vega10_get_pp_table_entry_callback_func(st=
ruct pp_hwmgr *hwmgr,
                 void *state, struct pp_power_state *power_state,
                 void *pp_table, uint32_t classification_flag)
 {
+       ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_V2;
         struct vega10_power_state *vega10_power_state =3D
                         cast_phw_vega10_power_state(&(power_state->hardwar=
e));
         struct vega10_performance_level *performance_level;
@@ -2940,11 +2941,16 @@ static int vega10_get_pp_table_entry_callback_func(=
struct pp_hwmgr *hwmgr,

         performance_level =3D &(vega10_power_state->performance_levels
                                 [vega10_power_state->performance_level_cou=
nt++]);
-
         performance_level->soc_clock =3D socclk_dep_table->entries
-                       [state_entry->ucSocClockIndexHigh].ulClk;
-       performance_level->gfx_clock =3D gfxclk_dep_table->entries
+                               [state_entry->ucSocClockIndexHigh].ulClk;
+       if (gfxclk_dep_table->ucRevId =3D=3D 0) {
+               performance_level->gfx_clock =3D gfxclk_dep_table->entries
                         [state_entry->ucGfxClockIndexHigh].ulClk;
+       } else if (gfxclk_dep_table->ucRevId =3D=3D 1) {
+               patom_record_V2 =3D (ATOM_Vega10_GFXCLK_Dependency_Record_V=
2 *)gfxclk_dep_table->entries;
+               performance_level->gfx_clock =3D patom_record_V2[state_entr=
y->ucGfxClockIndexHigh].ulClk;
+       }
+
         performance_level->mem_clock =3D mclk_dep_table->entries
                         [state_entry->ucMemClockIndexHigh].ulMemClk;
         return 0;
@@ -3348,7 +3354,6 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_l=
evels(
                                 dpm_table->
                                 gfx_table.dpm_levels[dpm_table->gfx_table.=
count - 1].
                                 value =3D sclk;
-
                                 if (phm_cap_enabled(hwmgr->platform_descri=
ptor.platformCaps,
                                                 PHM_PlatformCaps_OD6Plusin=
ACSupport) ||
                                         phm_cap_enabled(hwmgr->platform_de=
scriptor.platformCaps,
@@ -3471,7 +3476,6 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_l=
evels(
                                         return result);
                 }
         }
-
         return result;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h
index 52beea3..b3e6300 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h
@@ -144,6 +144,15 @@
         USHORT usAVFSOffset;                                        /* AVF=
S Voltage offset */
 } ATOM_Vega10_GFXCLK_Dependency_Record;

+typedef struct _ATOM_Vega10_GFXCLK_Dependency_Record_V2 {
+       ULONG  ulClk;
+       UCHAR  ucVddInd;
+       USHORT usCKSVOffsetandDisable;
+       USHORT usAVFSOffset;
+       UCHAR  ucACGEnable;
+       UCHAR  ucReserved[3];
+} ATOM_Vega10_GFXCLK_Dependency_Record_V2;
+
 typedef struct _ATOM_Vega10_MCLK_Dependency_Record {
         ULONG  ulMemClk;                                            /* Clo=
ck Frequency */
         UCHAR  ucVddInd;                                            /* SOC=
_VDD index */
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b=
/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
index 2b892e4..1623644 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
@@ -585,6 +585,7 @@ static int get_gfxclk_voltage_dependency_table(
         uint32_t table_size, i;
         struct phm_ppt_v1_clock_voltage_dependency_table
                                 *clk_table;
+       ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;

         PP_ASSERT_WITH_CODE((clk_dep_table->ucNumEntries !=3D 0),
                         "Invalid PowerPlay Table!", return -1);
@@ -601,18 +602,41 @@ static int get_gfxclk_voltage_dependency_table(

         clk_table->count =3D clk_dep_table->ucNumEntries;

-       for (i =3D 0; i < clk_table->count; i++) {
-               clk_table->entries[i].vddInd =3D
+       if (clk_dep_table->ucRevId =3D=3D 0) {
+               for (i =3D 0; i < clk_table->count; i++) {
+                       clk_table->entries[i].vddInd =3D
                                 clk_dep_table->entries[i].ucVddInd;
-               clk_table->entries[i].clk =3D
+                       clk_table->entries[i].clk =3D
                                 le32_to_cpu(clk_dep_table->entries[i].ulCl=
k);
-               clk_table->entries[i].cks_enable =3D
-                               (((clk_dep_table->entries[i].usCKSVOffsetan=
dDisable & 0x8000)
+                       clk_table->entries[i].cks_enable =3D
+                               (((le16_to_cpu(clk_dep_table->entries[i].us=
CKSVOffsetandDisable) & 0x8000)
                                                 >> 15) =3D=3D 0) ? 1 : 0;
-               clk_table->entries[i].cks_voffset =3D
-                               (clk_dep_table->entries[i].usCKSVOffsetandD=
isable & 0x7F);
-               clk_table->entries[i].sclk_offset =3D
-                               clk_dep_table->entries[i].usAVFSOffset;
+                       clk_table->entries[i].cks_voffset =3D
+                               le16_to_cpu(clk_dep_table->entries[i].usCKS=
VOffsetandDisable) & 0x7F;
+                       clk_table->entries[i].sclk_offset =3D
+                               le16_to_cpu(clk_dep_table->entries[i].usAVF=
SOffset);
+               }
+       } else if (clk_dep_table->ucRevId =3D=3D 1) {
+               patom_record_v2 =3D (ATOM_Vega10_GFXCLK_Dependency_Record_V=
2 *)clk_dep_table->entries;
+               for (i =3D 0; i < clk_table->count; i++) {
+                       clk_table->entries[i].vddInd =3D
+                                       patom_record_v2->ucVddInd;
+                       clk_table->entries[i].clk =3D
+                                       le32_to_cpu(patom_record_v2->ulClk)=
;
+                       clk_table->entries[i].cks_enable =3D
+                                       (((le16_to_cpu(patom_record_v2->usC=
KSVOffsetandDisable) & 0x8000)
+                                                       >> 15) =3D=3D 0) ? =
1 : 0;
+                       clk_table->entries[i].cks_voffset =3D
+                                       le16_to_cpu(patom_record_v2->usCKSV=
OffsetandDisable) & 0x7F;
+                       clk_table->entries[i].sclk_offset =3D
+                                       le16_to_cpu(patom_record_v2->usAVFS=
Offset);
+                       patom_record_v2++;
+               }
+       } else {
+               kfree(clk_table);
+               PP_ASSERT_WITH_CODE(false,
+                       "Unsupported GFXClockDependencyTable Revision!",
+                       return -EINVAL);
         }

         *pp_vega10_clk_dep_table =3D clk_table;
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY1PR12MB04745029F2EFA65CF8415FF88CC40CY1PR12MB0474namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Reviewed-by: Ken Wang&lt;Qingqing.Wang-5C7GfCeVMHo@public.gmane.org&gt;</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Monday, June 19, 2017 6:05:16 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: add support for ATOM GFXCLK tabl=
e v2.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Change-Id: I42e3d7b684ee903ce3ced6135f954cea0d1135=
03<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 14 &#43;&#43;&#4=
3;&#43;&#43;---<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h&nbsp;&nbsp; |&nbsp; =
9 &#43;&#43;&#43;&#43;&#43;<br>
&nbsp;.../amd/powerplay/hwmgr/vega10_processpptables.c&nbsp;&nbsp; | 42 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;-----<br>
&nbsp;3 files changed, 51 insertions(&#43;), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index d9744b6..e2e2822 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -2864,6 &#43;2864,7 @@ static int vega10_get_pp_table_entry_callback_fun=
c(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *state, struct pp_power_state *power_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *pp_table, uint32_t classification_flag)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATOM_Vega10_GFXCLK_Dependency_Rec=
ord_V2 *patom_record_V2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_power_state =
*vega10_power_state =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_=
phw_vega10_power_state(&amp;(power_state-&gt;hardware));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_performance_=
level *performance_level;<br>
@@ -2940,11 &#43;2941,16 @@ static int vega10_get_pp_table_entry_callback_f=
unc(struct pp_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performance_level =3D &amp=
;(vega10_power_state-&gt;performance_levels<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [vega10_power_state-&gt;performa=
nce_level_count&#43;&#43;]);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performance_level-&gt;soc_=
clock =3D socclk_dep_table-&gt;entries<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [state_entry-&gt=
;ucSocClockIndexHigh].ulClk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performance_level-&gt;gfx_clock =3D g=
fxclk_dep_table-&gt;entries<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [state_entry-&gt;ucSocClockIndexHigh].u=
lClk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfxclk_dep_table-&gt;ucRevId =
=3D=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; performance_level-&gt;gfx_clock =3D gfxclk_dep_table-&gt;ent=
ries<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [stat=
e_entry-&gt;ucGfxClockIndexHigh].ulClk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (gfxclk_dep_table-&gt;u=
cRevId =3D=3D 1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; patom_record_V2 =3D (ATOM_Vega10_GFXCLK_Dependency_Record_V2=
 *)gfxclk_dep_table-&gt;entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; performance_level-&gt;gfx_clock =3D patom_record_V2[state_en=
try-&gt;ucGfxClockIndexHigh].ulClk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performance_level-&gt;mem_=
clock =3D mclk_dep_table-&gt;entries<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [stat=
e_entry-&gt;ucMemClockIndexHigh].ulMemClk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -3348,7 &#43;3354,6 @@ static int vega10_populate_and_upload_sclk_mclk_d=
pm_levels(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_table.dpm_levels[dpm_table-&=
gt;gfx_table.count - 1].<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D sclk;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;pl=
atform_descriptor.platformCaps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_Platfor=
mCaps_OD6PlusinACSupport) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; phm_cap_enabled(hwmgr-&gt;platform_descriptor.platformCaps,=
<br>
@@ -3471,7 &#43;3476,6 @@ static int vega10_populate_and_upload_sclk_mclk_d=
pm_levels(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return result);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h<br>
index 52beea3..b3e6300 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h<br>
@@ -144,6 &#43;144,15 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USHORT usAVFSOffset;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* AVFS Voltage offset */<br>
&nbsp;} ATOM_Vega10_GFXCLK_Dependency_Record;<br>
&nbsp;<br>
&#43;typedef struct _ATOM_Vega10_GFXCLK_Dependency_Record_V2 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ULONG&nbsp; ulClk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCHAR&nbsp; ucVddInd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USHORT usCKSVOffsetandDisable;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USHORT usAVFSOffset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCHAR&nbsp; ucACGEnable;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCHAR&nbsp; ucReserved[3];<br>
&#43;} ATOM_Vega10_GFXCLK_Dependency_Record_V2;<br>
&#43;<br>
&nbsp;typedef struct _ATOM_Vega10_MCLK_Dependency_Record {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ULONG&nbsp; ulMemClk;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clock Frequency */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCHAR&nbsp; ucVddInd;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SOC_VDD index */<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b=
/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c<br>
index 2b892e4..1623644 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptable=
s.c<br>
@@ -585,6 &#43;585,7 @@ static int get_gfxclk_voltage_dependency_table(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_size, i;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_vo=
ltage_dependency_table<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *clk_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATOM_Vega10_GFXCLK_Dependency_Rec=
ord_V2 *patom_record_v2;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((clk_d=
ep_table-&gt;ucNumEntries !=3D 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Invalid PowerPlay Table!&quot;, return -1);<br>
@@ -601,18 &#43;602,41 @@ static int get_gfxclk_voltage_dependency_table(<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&gt;count =3D cl=
k_dep_table-&gt;ucNumEntries;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clk_table-&gt;co=
unt; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_table-&gt;entries[i].vddInd =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clk_dep_table-&gt;ucRevId =3D=
=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; clk_table-&gt;count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].vddInd =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_dep_table-&gt;entries[i].ucV=
ddInd;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_table-&gt;entries[i].clk =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].clk =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(clk_dep_table-&gt;en=
tries[i].ulClk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_table-&gt;entries[i].cks_enable =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((clk_dep_table-&gt;entries[i].usCKSVOffse=
tandDisable &amp; 0x8000)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].cks_enable =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((le16_to_cpu(clk_dep_table-&gt;entrie=
s[i].usCKSVOffsetandDisable) &amp; 0x8000)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; 15=
) =3D=3D 0) ? 1 : 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_table-&gt;entries[i].cks_voffset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clk_dep_table-&gt;entries[i].usCKSVOffseta=
ndDisable &amp; 0x7F);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_table-&gt;entries[i].sclk_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_dep_table-&gt;entries[i].usAVFSOffset;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].cks_voffset =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(clk_dep_table-&gt;entries[i=
].usCKSVOffsetandDisable) &amp; 0x7F;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].sclk_offset =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(clk_dep_table-&gt;entries[i=
].usAVFSOffset);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (clk_dep_table-&gt;ucRe=
vId =3D=3D 1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; patom_record_v2 =3D (ATOM_Vega10_GFXCLK_Dependency_Record_V2=
 *)clk_dep_table-&gt;entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; clk_table-&gt;count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].vddInd =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; patom_record_v2-&gt;ucVddInd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].clk =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; le32_to_cpu(patom_record_v2-&gt;ulClk);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].cks_enable =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; (((le16_to_cpu(patom_record_v2-&gt;usCKSVOffsetandDisable) &amp; 0=
x8000)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; 15) =3D=3D 0) ? 1 : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].cks_voffset =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; le16_to_cpu(patom_record_v2-&gt;usCKSVOffsetandDisable) &amp; 0x7F=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_table-&g=
t;entries[i].sclk_offset =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; le16_to_cpu(patom_record_v2-&gt;usAVFSOffset);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; patom_record=
_v2&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfree(clk_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(false,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Unsupp=
orted GFXClockDependencyTable Revision!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINV=
AL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pp_vega10_clk_dep_table =
=3D clk_table;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY1PR12MB04745029F2EFA65CF8415FF88CC40CY1PR12MB0474namp_--

--===============0458527922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0458527922==--
