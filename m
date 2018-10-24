From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Fix pp_sclk/mclk_od not work on smu7
Date: Wed, 24 Oct 2018 15:29:19 +0000
Message-ID: <BN6PR12MB1809669295A8549F684A178EF7F60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1540392908-29814-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0466299137=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540392908-29814-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

--===============0466299137==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809669295A8549F684A178EF7F60BN6PR12MB1809namp_"

--_000_BN6PR12MB1809669295A8549F684A178EF7F60BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 24, 2018 10:55:08 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Russell, Kent
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Fix pp_sclk/mclk_od not work on smu7

not update the dpm table with user's setting

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 6c99cbf..71cfbd4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3588,9 +3588,10 @@ static int smu7_find_dpm_states_clocks_in_dpm_table(=
struct pp_hwmgr *hwmgr, cons
                         break;
         }

-       if (i >=3D sclk_table->count)
+       if (i >=3D sclk_table->count) {
                 data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_S=
CLK;
-       else {
+               sclk_table->dpm_levels[i].value =3D sclk;
+       } else {
         /* TODO: Check SCLK in DAL's minimum clocks
          * in case DeepSleep divider update is required.
          */
@@ -3605,9 +3606,10 @@ static int smu7_find_dpm_states_clocks_in_dpm_table(=
struct pp_hwmgr *hwmgr, cons
                         break;
         }

-       if (i >=3D mclk_table->count)
+       if (i >=3D mclk_table->count) {
                 data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_M=
CLK;
-
+               mclk_table->dpm_levels[i-1].value =3D mclk;
+       }

         if (data->display_timing.num_existing_displays !=3D hwmgr->display=
_config->num_display)
                 data->need_update_smu7_dpm_table |=3D DPMTABLE_UPDATE_MCLK=
;
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809669295A8549F684A178EF7F60BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Wednesday, October 24, 2018 10:55:08 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Russell, Kent<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Fix pp_sclk/mclk_od not work on smu7</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">not update the dpm table with user's setting<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 10 &#43;&#43;&#43;=
&#43;&#43;&#43;----<br>
&nbsp;1 file changed, 6 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 6c99cbf..71cfbd4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -3588,9 &#43;3588,10 @@ static int smu7_find_dpm_states_clocks_in_dpm_ta=
ble(struct pp_hwmgr *hwmgr, cons<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D sclk_table-&gt;count)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D sclk_table-&gt;coun=
t) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;need_update_smu7_dpm_table |=3D DPMTABLE_OD_=
UPDATE_SCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sclk_table-&gt;dpm_levels[i].value =3D sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Check SCLK in DAL=
's minimum clocks<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in case DeepSleep =
divider update is required.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
@@ -3605,9 &#43;3606,10 @@ static int smu7_find_dpm_states_clocks_in_dpm_ta=
ble(struct pp_hwmgr *hwmgr, cons<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D mclk_table-&gt;count)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D mclk_table-&gt;coun=
t) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;need_update_smu7_dpm_table |=3D DPMTABLE_OD_=
UPDATE_MCLK;<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mclk_table-&gt;dpm_levels[i-1].value =3D mclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;display_timin=
g.num_existing_displays !=3D hwmgr-&gt;display_config-&gt;num_display)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;need_update_smu7_dpm_table |=3D DPMTABLE_UPD=
ATE_MCLK;<br>
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

--_000_BN6PR12MB1809669295A8549F684A178EF7F60BN6PR12MB1809namp_--

--===============0466299137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0466299137==--
