From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: update infoframe after dig fe is
 turned on (v2)
Date: Mon, 24 Jun 2019 18:00:21 +0000
Message-ID: <BN6PR12MB18091CE5FB4DD0A59853D849F7E00@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190624175847.26253-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0507749674=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190624175847.26253-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>

--===============0507749674==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18091CE5FB4DD0A59853D849F7E00BN6PR12MB1809namp_"

--_000_BN6PR12MB18091CE5FB4DD0A59853D849F7E00BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Nicholas=
 Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, June 24, 2019 1:58 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Li, Sun peng (Leo); Wentland, Harry; Kazlauskas, Nicholas; Li, Roman
Subject: [PATCH v2] drm/amd/display: update infoframe after dig fe is turne=
d on (v2)

[Why]
The AVI infoframe is incorrectly programmed on DCN1/2 when enabling a
stream - causing the wrong pixel encoding to be used for display.

This is because the AVI infoframe is programmed before the DIG BE is
connected to the FE and turned on, so enabling the AFMT block doesn't
actually work and the registers subsequently can't be written to.

[How]
Program the infoframe *after* turning on the DIG FE. This was the
behavior previously used but it was incorrectly reverted
when adding the DCN2 HW sequencer code.

v2: Don't call update_info_frame twice

Fixes: 54ff35915948 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")

Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Roman Li <roman.li-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 940e74b7d2c6..84d90b475e2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -686,6 +686,7 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
                                                         dmdata_dp : dmdata=
_hdmi);
         }
 #endif
+       dce110_update_info_frame(pipe_ctx);

         /* enable early control to avoid corruption on DP monitor*/
         active_total_with_borders =3D
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18091CE5FB4DD0A59853D849F7E00BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Nicholas Kazlauskas &lt;nic=
holas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, June 24, 2019 1:58 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Li, Sun peng (Leo); Wentland, Harry; Kazlauskas, Nicholas; Li, R=
oman<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: update infoframe after dig fe i=
s turned on (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[Why]<br>
The AVI infoframe is incorrectly programmed on DCN1/2 when enabling a<br>
stream - causing the wrong pixel encoding to be used for display.<br>
<br>
This is because the AVI infoframe is programmed before the DIG BE is<br>
connected to the FE and turned on, so enabling the AFMT block doesn't<br>
actually work and the registers subsequently can't be written to.<br>
<br>
[How]<br>
Program the infoframe *after* turning on the DIG FE. This was the<br>
behavior previously used but it was incorrectly reverted<br>
when adding the DCN2 HW sequencer code.<br>
<br>
v2: Don't call update_info_frame twice<br>
<br>
Fixes: 54ff35915948 (&quot;drm/amd/display: Add DCN2 HW Sequencer and Resou=
rce&quot;)<br>
<br>
Cc: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: Roman Li &lt;roman.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 &#43;=
<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
index 940e74b7d2c6..84d90b475e2a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer=
.c<br>
@@ -686,6 &#43;686,7 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmdata_dp : dmdata_hdmi);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_update_info_frame(pipe_ctx=
);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable early control to=
 avoid corruption on DP monitor*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_total_with_borders =
=3D<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18091CE5FB4DD0A59853D849F7E00BN6PR12MB1809namp_--

--===============0507749674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0507749674==--
