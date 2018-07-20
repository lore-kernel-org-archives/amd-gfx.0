From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: disallow slow switch if NBPState
 is disabled
Date: Fri, 20 Jul 2018 10:08:04 +0000
Message-ID: <CY4PR12MB16876A0FBFDBF6FC8EA5C8C2FB510@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180720023505.25239-1-evan.quan@amd.com>,
 <20180720023505.25239-3-evan.quan@amd.com>,
 <CY4PR12MB168739D42A1638743A55AF34FB510@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0076433750=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB168739D42A1638743A55AF34FB510-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0076433750==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16876A0FBFDBF6FC8EA5C8C2FB510CY4PR12MB1687namp_"

--_000_CY4PR12MB16876A0FBFDBF6FC8EA5C8C2FB510CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Evan=1B$B!$=1B(B


Changing the title to "Only allow slow switch if NB pstate switch is enable=
d"   can make patch more

understandable.



Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, July 20, 2018 4:43 PM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 3/3] drm/amd/powerplay: disallow slow switch if NBPStat=
e is disabled


+       bool uclk_switching_disabled =3D
+(bool)hwmgr->display_config->nb_pstate_switch_disable;


Don't need type convert.


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, July 20, 2018 10:35 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan; Zhu, Rex
Subject: [PATCH 3/3] drm/amd/powerplay: disallow slow switch if NBPState is=
 disabled

Otherwise there may be potential SMU performance issues.

Change-Id: I05a09bb05407f7b3705d79a1d2c6628385c80461
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 5 ++++-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 002ed77a5268..ccb587607b03 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3779,9 +3779,12 @@ static int vega10_notify_smc_display_config_after_ps=
_adjustment(
         struct PP_Clocks min_clocks =3D {0};
         uint32_t i;
         struct pp_display_clock_request clock_req;
+       bool uclk_switching_disabled =3D
+                       (bool)hwmgr->display_config->nb_pstate_switch_disab=
le;

         if ((hwmgr->display_config->num_display > 1) &&
-            !hwmgr->display_config->multi_monitor_in_sync)
+            !hwmgr->display_config->multi_monitor_in_sync &&
+            !uclk_switching_disabled)
                 vega10_notify_smc_display_change(hwmgr, false);
         else
                 vega10_notify_smc_display_change(hwmgr, true);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 35f96dacb50a..e3b11ae8fdb8 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1387,9 +1387,12 @@ static int vega12_notify_smc_display_config_after_ps=
_adjustment(
                         (struct vega12_hwmgr *)(hwmgr->backend);
         struct PP_Clocks min_clocks =3D {0};
         struct pp_display_clock_request clock_req;
+       bool uclk_switching_disabled =3D
+                       (bool)hwmgr->display_config->nb_pstate_switch_disab=
le;

         if ((hwmgr->display_config->num_display > 1) &&
-               !hwmgr->display_config->multi_monitor_in_sync)
+            !hwmgr->display_config->multi_monitor_in_sync &&
+            !uclk_switching_disabled)
                 vega12_notify_smc_display_change(hwmgr, false);
         else
                 vega12_notify_smc_display_change(hwmgr, true);
--
2.18.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.



--_000_CY4PR12MB16876A0FBFDBF6FC8EA5C8C2FB510CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Evan=1B$B!$=1B(B</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
<font size=3D"2"><span style=3D"font-size:11pt"></span></font></p>
<p style=3D"margin-top:0;margin-bottom:0">Changing the title to <font style=
=3D"font-size:11pt" color=3D"#000000" face=3D"Calibri, sans-serif">
&quot;Only allow slow switch</font> if NB pstate switch is enabled&quot;&nb=
sp;&nbsp; can make patch more</p>
<p style=3D"margin-top:0;margin-bottom:0"><span id=3D"w_126" class=3D"">und=
erstandable.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span id=3D"w_126" class=3D""><br=
>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span id=3D"w_126" class=3D""></s=
pan><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Friday, July 20, 2018 4:43 PM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/powerplay: disallow slow switch if =
NBPState is disabled</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Diso-8859-1">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; co=
lor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;Emoji=
Font&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, Noto=
ColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSy=
mbols;">
<p style=3D"margin-top:0; margin-bottom:0"><font size=3D"2"><span style=3D"=
font-size:11pt">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool uclk_switchi=
ng_disabled =3D<br>
&#43;(bool)hwmgr-&gt;display_config-&gt;nb_pstate_switch_disable;</span></f=
ont><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Don't need type convert.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd=
.com&gt;<br>
<b>Sent:</b> Friday, July 20, 2018 10:35 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan; Zhu, Rex<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/powerplay: disallow slow switch if NBPS=
tate is disabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Otherwise there may be potential SMU performance=
 issues.<br>
<br>
Change-Id: I05a09bb05407f7b3705d79a1d2c6628385c80461<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 5 &#43;&#43;&#43=
;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 5 &#43;&#43;&#43=
;&#43;-<br>
&nbsp;2 files changed, 8 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 002ed77a5268..ccb587607b03 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -3779,9 &#43;3779,12 @@ static int vega10_notify_smc_display_config_afte=
r_ps_adjustment(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks min_clock=
s =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_display_clock_re=
quest clock_req;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool uclk_switching_disabled =3D<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bool)hwmgr-=
&gt;display_config-&gt;nb_pstate_switch_disable;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hwmgr-&gt;display_con=
fig-&gt;num_display &gt; 1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hwmgr-=
&gt;display_config-&gt;multi_monitor_in_sync)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hw=
mgr-&gt;display_config-&gt;multi_monitor_in_sync &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !uc=
lk_switching_disabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega10_notify_smc_display_change(hwmgr, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega10_notify_smc_display_change(hwmgr, true);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
index 35f96dacb50a..e3b11ae8fdb8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -1387,9 &#43;1387,12 @@ static int vega12_notify_smc_display_config_afte=
r_ps_adjustment(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (stru=
ct vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks min_clock=
s =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_display_clock_re=
quest clock_req;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool uclk_switching_disabled =3D<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bool)hwmgr-=
&gt;display_config-&gt;nb_pstate_switch_disable;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hwmgr-&gt;display_con=
fig-&gt;num_display &gt; 1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !hwmgr-&gt;display_config-&gt;multi_monitor_in_sync)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hw=
mgr-&gt;display_config-&gt;multi_monitor_in_sync &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !uc=
lk_switching_disabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega12_notify_smc_display_change(hwmgr, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega12_notify_smc_display_change(hwmgr, true);<br>
-- <br>
2.18.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk652857" class=3D"x_OWAAutoLink" previewremoved=3D"true">https://lists.fr=
eedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15320760932520.07807509508203059" style=3D"margin-bo=
ttom:20px; overflow:auto; width:100%; text-indent:0px">
<table id=3D"LPContainer_15320760932240.4325743911662876" style=3D"width:90=
%; background-color:rgb(255,255,255); overflow:auto; padding-top:20px; padd=
ing-bottom:20px; margin-top:20px; border-top:1px dotted rgb(200,200,200); b=
order-bottom:1px dotted rgb(200,200,200)" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"x_TextCell_15320760932460.7623274709465312" colspan=3D"2" style=
=3D"vertical-align: top; padding: 0px; display: table-cell; position: relat=
ive;">
<div id=3D"LPRemovePreviewContainer_15320760932460.33509911256038116"></div=
>
<div id=3D"LPTitle_15320760932460.8893094785459864" style=3D"top:0px; color=
:rgb(0,120,215); font-weight:400; font-size:21px; font-family:&quot;wf_sego=
e-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quo=
t;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-height:=
21px">
<a id=3D"LPUrlAnchor_15320760932520.7056631923527743" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration:none">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15320760932520.4922178239396222" style=3D"margin:10px=
 0px 16px; color:rgb(102,102,102); font-weight:400; font-family:&quot;wf_se=
goe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,=
sans-serif; font-size:14px; line-height:14px">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15320760932520.6953170574068477" style=3D"display:=
block; color:rgb(102,102,102); font-weight:400; font-family:&quot;wf_segoe-=
ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans=
-serif; font-size:14px; line-height:20px; max-height:100px; overflow:hidden=
">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16876A0FBFDBF6FC8EA5C8C2FB510CY4PR12MB1687namp_--

--===============0076433750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0076433750==--
