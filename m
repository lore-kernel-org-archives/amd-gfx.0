From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/display: check if ppfuncs exists before using
 it
Date: Wed, 30 May 2018 16:32:55 +0000
Message-ID: <CY4PR12MB168730492F4206E689759F37FB6C0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180530143712.32269-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1773372173=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180530143712.32269-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

--===============1773372173==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168730492F4206E689759F37FB6C0CY4PR12MB1687namp_"

--_000_CY4PR12MB168730492F4206E689759F37FB6C0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, May 30, 2018 10:37 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/display: check if ppfuncs exists before using i=
t

Fixes a crash on asics without powerplay yet (e.g., vega20).

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index d5e6b45fd6e6..5a3346124a01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -343,7 +343,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
         struct pp_clock_levels_with_latency pp_clks =3D { 0 };
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;

-       if (!pp_funcs->get_clock_by_type_with_latency)
+       if (!pp_funcs || !pp_funcs->get_clock_by_type_with_latency)
                 return false;

         if (pp_funcs->get_clock_by_type_with_latency(pp_handle,
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




--_000_CY4PR12MB168730492F4206E689759F37FB6C0CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span>Reviewed-by: Rex Zhu&lt;rez=
hu-5C7GfCeVMHo@public.gmane.org&gt; &nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Best Regards&nbsp;</span></=
p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Rex</span><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Wednesday, May 30, 2018 10:37 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu/display: check if ppfuncs exists before =
using it</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes a crash on asics without powerplay yet (e.g.=
, vega20).<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 2 &#43;-=
<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
index d5e6b45fd6e6..5a3346124a01 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.=
c<br>
@@ -343,7 &#43;343,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_clock_levels_wit=
h_latency pp_clks =3D { 0 };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pp_funcs-&gt;get_clock_by_type_w=
ith_latency)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pp_funcs || !pp_funcs-&gt;ge=
t_clock_by_type_with_latency)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;get_clock=
_by_type_with_latency(pp_handle,<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk671284" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15276979449630.160472346261602" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15276979449600.36444457568079036" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15276979449610.0640851903284907" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15276979449610.9546222375892015"></div>
<div id=3D"LPTitle_15276979449620.9489138183768109" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15276979449620.8939398329651733" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15276979449620.9421895681139674" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15276979449630.24660085742545101" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
 hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB168730492F4206E689759F37FB6C0CY4PR12MB1687namp_--

--===============1773372173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1773372173==--
