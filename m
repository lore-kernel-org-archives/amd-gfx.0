From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Allow underclocking when od table is empty in
 vbios
Date: Wed, 30 May 2018 13:01:11 +0000
Message-ID: <BN6PR12MB180908E279C8F8E55562B8DFF76C0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1527670808-27140-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1372833138=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527670808-27140-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============1372833138==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180908E279C8F8E55562B8DFF76C0BN6PR12MB1809namp_"

--_000_BN6PR12MB180908E279C8F8E55562B8DFF76C0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, May 30, 2018 5:00:08 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Allow underclocking when od table is empty in =
vbios

if the max od engine clock limit and memory clock limit are not set
in vbios. driver will allow underclocking instand of disable od feature
completely.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c  | 6 ------
 drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c        | 6 ------
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c             | 5 ++++-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c           | 6 ++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c | 6 ------
 5 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
index f0d48b1..35bd987 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
@@ -870,12 +870,6 @@ static int init_over_drive_limits(
         hwmgr->platform_descriptor.maxOverdriveVDDC =3D 0;
         hwmgr->platform_descriptor.overdriveVDDCStep =3D 0;

-       if (hwmgr->platform_descriptor.overdriveLimit.engineClock =3D=3D 0 =
\
-               || hwmgr->platform_descriptor.overdriveLimit.memoryClock =
=3D=3D 0) {
-               hwmgr->od_enabled =3D false;
-               pr_debug("OverDrive feature not support by VBIOS\n");
-       }
-
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/processpptables.c
index ce64dfa..925e171 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
@@ -1074,12 +1074,6 @@ static int init_overdrive_limits(struct pp_hwmgr *hw=
mgr,
                                 powerplay_table,
                                 (const ATOM_FIRMWARE_INFO_V2_1 *)fw_info);

-       if (hwmgr->platform_descriptor.overdriveLimit.engineClock =3D=3D 0
-               && hwmgr->platform_descriptor.overdriveLimit.memoryClock =
=3D=3D 0) {
-               hwmgr->od_enabled =3D false;
-               pr_debug("OverDrive feature not support by VBIOS\n");
-       }
-
         return result;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index d142008..2b4b911 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -791,7 +791,8 @@ static int smu7_setup_dpm_tables_v1(struct pp_hwmgr *hw=
mgr)
                         data->dpm_table.sclk_table.count++;
                 }
         }
-
+       if (hwmgr->platform_descriptor.overdriveLimit.engineClock =3D=3D 0)
+               hwmgr->platform_descriptor.overdriveLimit.engineClock =3D d=
ep_sclk_table->entries[i-1].clk;
         /* Initialize Mclk DPM table based on allow Mclk values */
         data->dpm_table.mclk_table.count =3D 0;
         for (i =3D 0; i < dep_mclk_table->count; i++) {
@@ -806,6 +807,8 @@ static int smu7_setup_dpm_tables_v1(struct pp_hwmgr *hw=
mgr)
                 }
         }

+       if (hwmgr->platform_descriptor.overdriveLimit.memoryClock =3D=3D 0)
+               hwmgr->platform_descriptor.overdriveLimit.memoryClock =3D d=
ep_mclk_table->entries[i-1].clk;
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 97864c7..dd52d7e 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -1311,6 +1311,9 @@ static int vega10_setup_default_dpm_tables(struct pp_=
hwmgr *hwmgr)
         vega10_setup_default_single_dpm_table(hwmgr,
                         dpm_table,
                         dep_gfx_table);
+       if (hwmgr->platform_descriptor.overdriveLimit.engineClock =3D=3D 0)
+               hwmgr->platform_descriptor.overdriveLimit.engineClock =3D
+                                       dpm_table->dpm_levels[dpm_table->co=
unt-1].value;
         vega10_init_dpm_state(&(dpm_table->dpm_state));

         /* Initialize Mclk DPM table based on allow Mclk values */
@@ -1319,6 +1322,9 @@ static int vega10_setup_default_dpm_tables(struct pp_=
hwmgr *hwmgr)
         vega10_setup_default_single_dpm_table(hwmgr,
                         dpm_table,
                         dep_mclk_table);
+       if (hwmgr->platform_descriptor.overdriveLimit.memoryClock =3D=3D 0)
+               hwmgr->platform_descriptor.overdriveLimit.memoryClock =3D
+                                       dpm_table->dpm_levels[dpm_table->co=
unt-1].value;
         vega10_init_dpm_state(&(dpm_table->dpm_state));

         data->dpm_table.eclk_table.count =3D 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b=
/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
index 0768d25..16b1a9c 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
@@ -267,12 +267,6 @@ static int init_over_drive_limits(
         hwmgr->platform_descriptor.maxOverdriveVDDC =3D 0;
         hwmgr->platform_descriptor.overdriveVDDCStep =3D 0;

-       if (hwmgr->platform_descriptor.overdriveLimit.engineClock =3D=3D 0 =
||
-               hwmgr->platform_descriptor.overdriveLimit.memoryClock =3D=
=3D 0) {
-               hwmgr->od_enabled =3D false;
-               pr_debug("OverDrive feature not support by VBIOS\n");
-       }
-
         return 0;
 }

--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180908E279C8F8E55562B8DFF76C0BN6PR12MB1809namp_
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
<b>Sent:</b> Wednesday, May 30, 2018 5:00:08 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Allow underclocking when od table is em=
pty in vbios</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">if the max od engine clock limit and memory clock =
limit are not set<br>
in vbios. driver will allow underclocking instand of disable od feature<br>
completely.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c&nbsp; | 6=
 ------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 6 ------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 5 &#43;&#43;&#43;&#43=
;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6 &#43;&#43;&#43;&#43;&#43;&#43=
;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c | 6 ----=
--<br>
&nbsp;5 files changed, 10 insertions(&#43;), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c<br>
index f0d48b1..35bd987 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0=
.c<br>
@@ -870,12 &#43;870,6 @@ static int init_over_drive_limits(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platform_descrip=
tor.maxOverdriveVDDC =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platform_descrip=
tor.overdriveVDDCStep =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;platform_descriptor.ove=
rdriveLimit.engineClock =3D=3D 0 \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || hwmgr-&gt;platform_descriptor.overdriveLimit.memoryClock =3D=
=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;od_enabled =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;OverDrive feature not support by VBIOS\n&quot;);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/processpptables.c<br>
index ce64dfa..925e171 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c<br>
@@ -1074,12 &#43;1074,6 @@ static int init_overdrive_limits(struct pp_hwmgr=
 *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const ATOM_FIRMWARE_INFO_V2_1 *=
)fw_info);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;platform_descriptor.ove=
rdriveLimit.engineClock =3D=3D 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;&amp; hwmgr-&gt;platform_descriptor.overdriveLimit.memoryCl=
ock =3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;od_enabled =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;OverDrive feature not support by VBIOS\n&quot;);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index d142008..2b4b911 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -791,7 &#43;791,8 @@ static int smu7_setup_dpm_tables_v1(struct pp_hwmgr=
 *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-=
&gt;dpm_table.sclk_table.count&#43;&#43;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;platform_descriptor=
.overdriveLimit.engineClock =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;platform_descriptor.overdriveLimit.engineClock =3D=
 dep_sclk_table-&gt;entries[i-1].clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize Mclk DPM tab=
le based on allow Mclk values */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.mclk_ta=
ble.count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dep_m=
clk_table-&gt;count; i&#43;&#43;) {<br>
@@ -806,6 &#43;807,8 @@ static int smu7_setup_dpm_tables_v1(struct pp_hwmgr=
 *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;platform_descriptor=
.overdriveLimit.memoryClock =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;platform_descriptor.overdriveLimit.memoryClock =3D=
 dep_mclk_table-&gt;entries[i-1].clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 97864c7..dd52d7e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -1311,6 &#43;1311,9 @@ static int vega10_setup_default_dpm_tables(struct=
 pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_setup_default_singl=
e_dpm_table(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_t=
able,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_g=
fx_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;platform_descriptor=
.overdriveLimit.engineClock =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;platform_descriptor.overdriveLimit.engineClock =3D=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dpm_table-&gt;dpm_levels[dpm_table-&gt;count-1].value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_init_dpm_state(&amp=
;(dpm_table-&gt;dpm_state));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize Mclk DPM tab=
le based on allow Mclk values */<br>
@@ -1319,6 &#43;1322,9 @@ static int vega10_setup_default_dpm_tables(struct=
 pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_setup_default_singl=
e_dpm_table(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_t=
able,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dep_m=
clk_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;platform_descriptor=
.overdriveLimit.memoryClock =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;platform_descriptor.overdriveLimit.memoryClock =3D=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dpm_table-&gt;dpm_levels[dpm_table-&gt;count-1].value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_init_dpm_state(&amp=
;(dpm_table-&gt;dpm_state));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.eclk_ta=
ble.count =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b=
/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c<br>
index 0768d25..16b1a9c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptable=
s.c<br>
@@ -267,12 &#43;267,6 @@ static int init_over_drive_limits(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platform_descrip=
tor.maxOverdriveVDDC =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platform_descrip=
tor.overdriveVDDCStep =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;platform_descriptor.ove=
rdriveLimit.engineClock =3D=3D 0 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;platform_descriptor.overdriveLimit.memoryClock =3D=3D =
0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;od_enabled =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;OverDrive feature not support by VBIOS\n&quot;);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
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

--_000_BN6PR12MB180908E279C8F8E55562B8DFF76C0BN6PR12MB1809namp_--

--===============1372833138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1372833138==--
