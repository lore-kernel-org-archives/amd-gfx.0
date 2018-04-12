From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: rename smu7_upload_mc_firmware
Date: Thu, 12 Apr 2018 03:25:51 +0000
Message-ID: <CY4PR12MB1687FB68A7C55094B7386F2DFBBC0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180411231100.31686-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0024246040=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180411231100.31686-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0024246040==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687FB68A7C55094B7386F2DFBBC0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687FB68A7C55094B7386F2DFBBC0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>



Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, April 12, 2018 7:11 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/powerplay: rename smu7_upload_mc_firmware

It doesn't actually upload any firmware is just
checks the version.  The actual upload happens in
the gmc modules.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 97b7c2333f19..ed43dd39b5d6 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4071,7 +4071,7 @@ static int smu7_check_states_equal(struct pp_hwmgr *h=
wmgr,
         return 0;
 }

-static int smu7_upload_mc_firmware(struct pp_hwmgr *hwmgr)
+static int smu7_check_mc_firmware(struct pp_hwmgr *hwmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);

@@ -4200,7 +4200,7 @@ static int smu7_setup_asic_task(struct pp_hwmgr *hwmg=
r)
 {
         int tmp_result, result =3D 0;

-       smu7_upload_mc_firmware(hwmgr);
+       smu7_check_mc_firmware(hwmgr);

         tmp_result =3D smu7_read_clock_registers(hwmgr);
         PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.




--_000_CY4PR12MB1687FB68A7C55094B7386F2DFBBC0CY4PR12MB1687namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Reviewed-by: Rex Zhu &lt;=
Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">&nbsp;</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Best Regards</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"width: 98%; display: inline-block;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Calib=
ri, sans-serif" style=3D"font-size: 11pt;"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Thursday, April 12, 2018 7:11 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu/powerplay: rename smu7_upload_mc_firmwar=
e</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size: 11pt=
;">
<div class=3D"PlainText">It doesn't actually upload any firmware is just<br=
>
checks the version.&nbsp; The actual upload happens in<br>
the gmc modules.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 4 &#43;&#43;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 97b7c2333f19..ed43dd39b5d6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -4071,7 &#43;4071,7 @@ static int smu7_check_states_equal(struct pp_hwmg=
r *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu7_upload_mc_firmware(struct pp_hwmgr *hwmgr)<br>
&#43;static int smu7_check_mc_firmware(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;<br>
@@ -4200,7 &#43;4200,7 @@ static int smu7_setup_asic_task(struct pp_hwmgr *=
hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tmp_result, result =3D=
 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_upload_mc_firmware(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_check_mc_firmware(hwmgr);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D smu7_read_c=
lock_registers(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((0 =3D=
=3D tmp_result),<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a id=3D"LPlnk742814" href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<p></p>
<div id=3D"LPBorder_GT_15235035507610.8864175340081135" style=3D"width: 100=
%; text-indent: 0px; overflow: auto; margin-bottom: 20px; display: inline-b=
lock;">
<table id=3D"LPContainer_15235035507450.7563721087499751" role=3D"presentat=
ion" style=3D"width: 90%; overflow: auto; padding-top: 20px; padding-bottom=
: 20px; margin-top: 20px; border-top-color: rgb(200, 200, 200); border-bott=
om-color: rgb(200, 200, 200); border-top-width: 1px; border-bottom-width: 1=
px; border-top-style: dotted; border-bottom-style: dotted; position: relati=
ve; background-color: rgb(255, 255, 255);" cellspacing=3D"0">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15235035507490.05238852005809225" style=3D"padding: 0px;=
 vertical-align: top; display: table-cell; position: relative;" colspan=3D"=
2">
<div id=3D"LPRemovePreviewContainer_15235035507490.5064380115241844" style=
=3D"float: right;">
</div>
<div id=3D"LPTitle_15235035507490.9189891582732629" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); line-height: 21px; font-family: &quot;wf_segoe-ui_ligh=
t&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &quot;Sego=
e UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; font-size: 21p=
x; font-weight: 400;">
<a id=3D"LPUrlAnchor_15235035507530.9518651314395661" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15235035507530.20486925298627484" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); line-height: 14px; font-family: &qu=
ot;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Ta=
homa, Arial, sans-serif; font-size: 14px; font-weight: 400;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15235035507570.3744978834834676" style=3D"color: r=
gb(102, 102, 102); line-height: 20px; overflow: hidden; font-family: &quot;=
wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahom=
a, Arial, sans-serif; font-size: 14px; font-weight: 400; display: block; ma=
x-height: 100px;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<p></p>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687FB68A7C55094B7386F2DFBBC0CY4PR12MB1687namp_--

--===============0024246040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0024246040==--
