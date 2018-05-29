From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix wrong latency assignment for VEGA
 clock levels
Date: Tue, 29 May 2018 14:55:58 +0000
Message-ID: <BN6PR12MB1809B7203AA35BC520D0833AF76D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180529140314.15950-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0477113384=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180529140314.15950-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0477113384==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809B7203AA35BC520D0833AF76D0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809B7203AA35BC520D0833AF76D0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, May 29, 2018 10:03 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wentland, Harry
Subject: [PATCH] drm/amd/display: Fix wrong latency assignment for VEGA clo=
ck levels

Also drop wrong 10kHz comment

Fixes: drm/amd/display: Implement dm_pp_get_clock_levels_by_type_with_laten=
cy
Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index ead3d21545b1..d5e6b45fd6e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -256,9 +256,8 @@ static void pp_to_dc_clock_levels_with_latency(

         for (i =3D 0; i < clk_level_info->num_levels; i++) {
                 DRM_DEBUG("DM_PPLIB:\t %d\n", pp_clks->data[i].clocks_in_k=
hz);
-               /* translate 10kHz to kHz */
                 clk_level_info->data[i].clocks_in_khz =3D pp_clks->data[i]=
.clocks_in_khz;
-               clk_level_info->data[i].latency_in_us =3D pp_clks->data[i].=
clocks_in_khz;
+               clk_level_info->data[i].latency_in_us =3D pp_clks->data[i].=
latency_in_us;
         }
 }

--
2.17.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809B7203AA35BC520D0833AF76D0BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.we=
ntland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, May 29, 2018 10:03 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix wrong latency assignment for V=
EGA clock levels</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Also drop wrong 10kHz comment<br>
<br>
Fixes: drm/amd/display: Implement dm_pp_get_clock_levels_by_type_with_laten=
cy<br>
Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 3 &#43;-=
-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
index ead3d21545b1..d5e6b45fd6e6 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.=
c<br>
@@ -256,9 &#43;256,8 @@ static void pp_to_dc_clock_levels_with_latency(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clk_l=
evel_info-&gt;num_levels; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;DM_PPLIB:\t %d\n&quot;, pp_clks-&gt;d=
ata[i].clocks_in_khz);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* translate 10kHz to kHz */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; clk_level_info-&gt;data[i].clocks_in_khz =3D pp_clks-=
&gt;data[i].clocks_in_khz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_level_info-&gt;data[i].latency_in_us =3D pp_clks-&gt;data[i]=
.clocks_in_khz;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clk_level_info-&gt;data[i].latency_in_us =3D pp_clks-&gt;dat=
a[i].latency_in_us;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk146839" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1809B7203AA35BC520D0833AF76D0BN6PR12MB1809namp_--

--===============0477113384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0477113384==--
