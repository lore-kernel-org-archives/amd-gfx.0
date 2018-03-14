From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay/vega10: fix memory leak in error path
Date: Wed, 14 Mar 2018 08:07:13 +0000
Message-ID: <CY4PR12MB1687C08ADA71A514BB56CBD5FBD10@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180314014613.14695-1-alexander.deucher@amd.com>,
 <DM5PR1201MB248901BA08487897F5F1A3FBE4D10@DM5PR1201MB2489.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0330223626=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR1201MB248901BA08487897F5F1A3FBE4D10-grEf7a3NxMAAZHT/xKzwlGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0330223626==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687C08ADA71A514BB56CBD5FBD10CY4PR12MB1687namp_"

--_000_CY4PR12MB1687C08ADA71A514BB56CBD5FBD10CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, March 14, 2018 11:20 AM
To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: RE: [PATCH] drm/amdgpu/powerplay/vega10: fix memory leak in error =
path

Reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

-----Original Message-----
From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of A=
lex Deucher
Sent: Wednesday, March 14, 2018 9:46 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/powerplay/vega10: fix memory leak in error path

Free the backend structure if we fail to allocate device memory.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
index 15e1afa28018..219950882be9 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
@@ -406,9 +406,8 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
                         &handle,
                         &mc_addr,
                         &kaddr);
-
         if (ret)
-               return -EINVAL;
+               goto free_backend;

         priv->smu_tables.entry[PPTABLE].version =3D 0x01;
         priv->smu_tables.entry[PPTABLE].size =3D sizeof(PPTable_t); @@ -51=
1,6 +510,9 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
         amdgpu_bo_free_kernel(&priv->smu_tables.entry[PPTABLE].handle,
                         &priv->smu_tables.entry[PPTABLE].mc_addr,
                         &priv->smu_tables.entry[PPTABLE].table);
+free_backend:
+       kfree(hwmgr->smu_backend);
+
         return -EINVAL;
 }

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
orm. Use of all freedesktop.org lists is subject to our Code of ...


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



--_000_CY4PR12MB1687C08ADA71A514BB56CBD5FBD10CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: <span>Rex Zhu &lt;Re=
x.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, March 14, 2018 11:20 AM<br>
<b>To:</b> Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/powerplay/vega10: fix memory leak in=
 error path</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reviewed-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<br>
-----Original Message-----<br>
From: amd-gfx [<a previewremoved=3D"true" id=3D"LPlnk315882" href=3D"mailto=
:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org</a>] On Behalf Of Alex Deucher<br>
Sent: Wednesday, March 14, 2018 9:46 AM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu/powerplay/vega10: fix memory leak in error path=
<br>
<br>
Free the backend structure if we fail to allocate device memory.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c | 6 &#43;&#43;&#=
43;&#43;--<br>
&nbsp;1 file changed, 4 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
index 15e1afa28018..219950882be9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
@@ -406,9 &#43;406,8 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
mc_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
kaddr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto free_backend;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[=
PPTABLE].version =3D 0x01;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[=
PPTABLE].size =3D sizeof(PPTable_t); @@ -511,6 &#43;510,9 @@ static int veg=
a10_smu_init(struct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;priv-&gt;smu_tables.entry[PPTABLE].handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
priv-&gt;smu_tables.entry[PPTABLE].mc_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
priv-&gt;smu_tables.entry[PPTABLE].table);<br>
&#43;free_backend:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;smu_backend);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;<br>
--<br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a previewremoved=3D"true" id=3D"LPlnk648036" href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_15210137495790.2404838779031666">
<table role=3D"presentation" style=3D"width: 90%; background-color: rgb(255=
, 255, 255); position: relative; overflow: auto; padding-top: 20px; padding=
-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200);=
 border-bottom: 1px dotted rgb(200, 200, 200);" id=3D"LPContainer_152101374=
95730.3663124356348335" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_15210137495760.0906023900396830=
7">
<div id=3D"LPRemovePreviewContainer_15210137495770.9886665195800116"></div>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_15210137495770.497=
3053232809411">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_15210137495780=
.29606840336844686">amd-gfx Info Page - freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_15210137495780.9997151861386632">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_15210137495790.12239=
088429978973">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a previewremoved=3D"true" id=3D"LPlnk351937" href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_15210137494090.5120423675447435">
<table role=3D"presentation" style=3D"width: 90%; background-color: rgb(255=
, 255, 255); position: relative; overflow: auto; padding-top: 20px; padding=
-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200);=
 border-bottom: 1px dotted rgb(200, 200, 200);" id=3D"LPContainer_152101374=
93850.8523090467859297" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_15210137494060.2489754754787789=
6">
<div id=3D"LPRemovePreviewContainer_15210137494070.7364408730716526"></div>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_15210137494070.627=
5733314661497">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_15210137494070=
.7052113502568403">amd-gfx Info Page - freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_15210137494080.8576899392938786">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_15210137494080.61285=
84996376812">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
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
</body>
</html>

--_000_CY4PR12MB1687C08ADA71A514BB56CBD5FBD10CY4PR12MB1687namp_--

--===============0330223626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0330223626==--
