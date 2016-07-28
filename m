From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 07/14] drm/amd/powerplay: remove
 enable_clock_power_gatings_tasks from initialize and resume events
Date: Thu, 28 Jul 2016 16:53:44 +0000
Message-ID: <SN1PR12MB06720C34C852F9F14DAD38BAFB000@SN1PR12MB0672.namprd12.prod.outlook.com>
References: <20160728141912.18140-1-tom.stdenis@amd.com>,
 <20160728141912.18140-8-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0315230831=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160728141912.18140-8-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

--===============0315230831==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB06720C34C852F9F14DAD38BAFB000SN1PR12MB0672namp_"

--_000_SN1PR12MB06720C34C852F9F14DAD38BAFB000SN1PR12MB0672namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


For the series:
Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tom St D=
enis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, July 28, 2016 10:19:05 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: [PATCH 07/14] drm/amd/powerplay: remove enable_clock_power_gatings=
_tasks from initialize and resume events

Setting PG state this early would cause lock ups in the IP block
initialized functions.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c b/d=
rivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
index d6635cc4b0fc..635fc4b48184 100644
--- a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
+++ b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
@@ -30,7 +30,6 @@ static const pem_event_action * const initialize_event[] =
=3D {
         system_config_tasks,
         setup_asic_tasks,
         enable_dynamic_state_management_tasks,
-       enable_clock_power_gatings_tasks,
         get_2d_performance_state_tasks,
         set_performance_state_tasks,
         initialize_thermal_controller_tasks,
@@ -140,7 +139,6 @@ static const pem_event_action * const resume_event[] =
=3D {
         setup_asic_tasks,
         enable_stutter_mode_tasks, /*must do this in boot state and before=
 SMC is started */
         enable_dynamic_state_management_tasks,
-       enable_clock_power_gatings_tasks,
         enable_disable_bapm_tasks,
         initialize_thermal_controller_tasks,
         get_2d_performance_state_tasks,
--
2.9.2

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...



--_000_SN1PR12MB06720C34C852F9F14DAD38BAFB000SN1PR12MB0672namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p><br>
</p>
<meta content=3D"text/html; charset=3DUTF-8">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; =
background-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><span id=3D"x_ms-rterangepaste-start"></span><font size=3D"2"><span styl=
e=3D"font-size:10pt">For the series:<br>
Reviewed-by: <font size=3D"2"><span style=3D"font-size:10pt;">Rex Zhu &lt;R=
ex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</span></font></span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><font size=3D"2"><span s=
tyle=3D"font-size:10pt;"><br>
</span></font></span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><font size=3D"2"><span s=
tyle=3D"font-size:10pt;">Best Regards</span></font></span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><font size=3D"2"><span s=
tyle=3D"font-size:10pt;">Rex</span></font></span></font><span id=3D"x_ms-rt=
erangepaste-end"></span><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Tom St Denis &lt;tstdenis82=
@gmail.com&gt;<br>
<b>Sent:</b> Thursday, July 28, 2016 10:19:05 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH 07/14] drm/amd/powerplay: remove enable_clock_power_=
gatings_tasks from initialize and resume events</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Setting PG state this early would cause lock ups i=
n the IP block<br>
initialized functions.<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c | 2 --<br>
&nbsp;1 file changed, 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c b/d=
rivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c<br>
index d6635cc4b0fc..635fc4b48184 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.=
c<br>
@@ -30,7 &#43;30,6 @@ static const pem_event_action * const initialize_even=
t[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_config_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_asic_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_dynamic_state_manag=
ement_tasks,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_clock_power_gatings_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_2d_performance_state_t=
asks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_performance_state_task=
s,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initialize_thermal_control=
ler_tasks,<br>
@@ -140,7 &#43;139,6 @@ static const pem_event_action * const resume_event[=
] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_asic_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_stutter_mode_tasks,=
 /*must do this in boot state and before SMC is started */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_dynamic_state_manag=
ement_tasks,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_clock_power_gatings_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_disable_bapm_tasks,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initialize_thermal_control=
ler_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_2d_performance_state_t=
asks,<br>
-- <br>
2.9.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a id=3D"LPlnk637276" href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_14697248013770.18668780624267978">
<table style=3D"width: 90%; background-color: rgb(255, 255, 255); position:=
 relative; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-=
top: 20px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px do=
tted rgb(200, 200, 200);" id=3D"LPContainer_14697248013740.4098503448476658=
" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_14697248013750.9079451709603679=
">
<div id=3D"LPRemovePreviewContainer_14697248013750.3663968305566656"></div>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_14697248013750.591=
6092549448757">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_14697248013760=
.13472699829525459">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_14697248013760.6158150059455259">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_14697248013760.49725=
280174609954">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB06720C34C852F9F14DAD38BAFB000SN1PR12MB0672namp_--

--===============0315230831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0315230831==--
