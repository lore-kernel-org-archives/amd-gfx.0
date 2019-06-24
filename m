From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: update infoframe after dig fe is
 turned on (v2)
Date: Mon, 24 Jun 2019 20:50:19 +0000
Message-ID: <7aee30c2-f90d-8bc4-3fe3-10c0ff2d8b12@amd.com>
References: <20190624175847.26253-1-nicholas.kazlauskas@amd.com>
 <BN6PR12MB18091CE5FB4DD0A59853D849F7E00@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0922563419=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18091CE5FB4DD0A59853D849F7E00-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0922563419==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7aee30c2f90d8bc43fe310c0ff2d8b12amdcom_"

--_000_7aee30c2f90d8bc43fe310c0ff2d8b12amdcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org><mailto:Bhawanpre=
et.Lakha-5C7GfCeVMHo@public.gmane.org>



On 2019-06-24 2:00 p.m., Deucher, Alexander wrote:
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.deucher=
@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Nicholas Kazlauskas <nicholas.kazlaus=
kas-5C7GfCeVMHo@public.gmane.org><mailto:nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, June 24, 2019 1:58 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org><mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Roman Li <roman.li-5C7GfCeVMHo@public.gmane.org><mailto:roman.li-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org><mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org><mailto:nic=
holas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_7aee30c2f90d8bc43fe310c0ff2d8b12amdcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <E120798005CE384294B9CCC5380A05F3-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<p>Reviewed-by: Bhawanpreet Lakha <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org">
&lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
<p><br>
</p>
<p><br>
</p>
<div class=3D"moz-cite-prefix">On 2019-06-24 2:00 p.m., Deucher, Alexander =
wrote:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:BN6PR12MB18091CE5FB4DD0A59853D849F7E0=
0@BN6PR12MB1809.namprd12.prod.outlook.com">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:al=
exander.deucher-5C7GfCeVMHo@public.gmane.org">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
        font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Nicholas Kaz=
lauskas <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:nicholas.kazlausk=
as-5C7GfCeVMHo@public.gmane.org">
&lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Monday, June 24, 2019 1:58 PM<br>
<b>To:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
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
Cc: Harry Wentland <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:harry.=
wentland-5C7GfCeVMHo@public.gmane.org">
&lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
Cc: Roman Li <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:roman.li@amd=
.com">&lt;roman.li-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
Cc: Leo Li <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:sunpeng.li@amd=
.com">&lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
Signed-off-by: Nicholas Kazlauskas <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org">
&lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
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
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-n=
ot-send=3D"true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>=
</div>
</span></font></div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
<pre class=3D"moz-quote-pre" wrap=3D"">____________________________________=
___________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a></pre>
</blockquote>
</body>
</html>

--_000_7aee30c2f90d8bc43fe310c0ff2d8b12amdcom_--

--===============0922563419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0922563419==--
