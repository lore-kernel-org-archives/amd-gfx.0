From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: enable ppfeaturemask module parameter
 support on Vega20
Date: Mon, 29 Apr 2019 13:58:12 +0000
Message-ID: <BN6PR12MB180930F6C8AB56ED967CD9A4F7390@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190429085603.15659-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1587447981=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190429085603.15659-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============1587447981==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180930F6C8AB56ED967CD9A4F7390BN6PR12MB1809namp_"

--_000_BN6PR12MB180930F6C8AB56ED967CD9A4F7390BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, April 29, 2019 4:56 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Quan, Evan
Subject: [PATCH] drm/amd/powerplay: enable ppfeaturemask module parameter s=
upport on Vega20

Support DPM/DS/ULV related bitmasks of ppfeaturemask module parameter.

Change-Id: I6b75becf8d39105189b30be41b58ec7d4425f356
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 91e26f8b3758..d7873df484a4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -97,6 +97,27 @@ static void vega20_set_default_registry_data(struct pp_h=
wmgr *hwmgr)
         if (hwmgr->smu_version < 0x282100)
                 data->registry_data.disallowed_features |=3D FEATURE_ECC_M=
ASK;

+       if (!(hwmgr->feature_mask & PP_PCIE_DPM_MASK))
+               data->registry_data.disallowed_features |=3D FEATURE_DPM_LI=
NK_MASK;
+
+       if (!(hwmgr->feature_mask & PP_SCLK_DPM_MASK))
+               data->registry_data.disallowed_features |=3D FEATURE_DPM_GF=
XCLK_MASK;
+
+       if (!(hwmgr->feature_mask & PP_SOCCLK_DPM_MASK))
+               data->registry_data.disallowed_features |=3D FEATURE_DPM_SO=
CCLK_MASK;
+
+       if (!(hwmgr->feature_mask & PP_MCLK_DPM_MASK))
+               data->registry_data.disallowed_features |=3D FEATURE_DPM_UC=
LK_MASK;
+
+       if (!(hwmgr->feature_mask & PP_DCEFCLK_DPM_MASK))
+               data->registry_data.disallowed_features |=3D FEATURE_DPM_DC=
EFCLK_MASK;
+
+       if (!(hwmgr->feature_mask & PP_ULV_MASK))
+               data->registry_data.disallowed_features |=3D FEATURE_ULV_MA=
SK;
+
+       if (!(hwmgr->feature_mask & PP_SCLK_DEEP_SLEEP_MASK))
+               data->registry_data.disallowed_features |=3D FEATURE_DS_GFX=
CLK_MASK;
+
         data->registry_data.od_state_in_dc_support =3D 0;
         data->registry_data.thermal_support =3D 1;
         data->registry_data.skip_baco_hardware =3D 0;
--
2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180930F6C8AB56ED967CD9A4F7390BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, April 29, 2019 4:56 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: enable ppfeaturemask module para=
meter support on Vega20</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Support DPM/DS/ULV related bitmasks of ppfeaturema=
sk module parameter.<br>
<br>
Change-Id: I6b75becf8d39105189b30be41b58ec7d4425f356<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; | 21 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 21 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 91e26f8b3758..d7873df484a4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -97,6 &#43;97,27 @@ static void vega20_set_default_registry_data(struct =
pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smu_version =
&lt; 0x282100)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATU=
RE_ECC_MASK;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;feature_mask &amp=
; PP_PCIE_DPM_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATURE_DPM_=
LINK_MASK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;feature_mask &amp=
; PP_SCLK_DPM_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATURE_DPM_=
GFXCLK_MASK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;feature_mask &amp=
; PP_SOCCLK_DPM_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATURE_DPM_=
SOCCLK_MASK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;feature_mask &amp=
; PP_MCLK_DPM_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATURE_DPM_=
UCLK_MASK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;feature_mask &amp=
; PP_DCEFCLK_DPM_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATURE_DPM_=
DCEFCLK_MASK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;feature_mask &amp=
; PP_ULV_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATURE_ULV_=
MASK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hwmgr-&gt;feature_mask &amp=
; PP_SCLK_DEEP_SLEEP_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;registry_data.disallowed_features |=3D FEATURE_DS_G=
FXCLK_MASK;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.od_=
state_in_dc_support =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.the=
rmal_support =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.ski=
p_baco_hardware =3D 0;<br>
-- <br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180930F6C8AB56ED967CD9A4F7390BN6PR12MB1809namp_--

--===============1587447981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1587447981==--
