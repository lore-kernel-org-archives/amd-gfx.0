From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: add more feature bits
Date: Thu, 10 Oct 2019 02:25:54 +0000
Message-ID: <BN8PR12MB3602BB4F482647F07C325E3A89940@BN8PR12MB3602.namprd12.prod.outlook.com>
References: <20191009110757.30995-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0916468140=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191009110757.30995-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0916468140==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3602BB4F482647F07C325E3A89940BN8PR12MB3602namp_"

--_000_BN8PR12MB3602BB4F482647F07C325E3A89940BN8PR12MB3602namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping ...

BR,
Xiaojie
________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 9, 2019 7:08 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>;=
 Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Wang=
, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: add more feature bits

Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 5a34d01f7f7c..44152c1f01c7 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -337,19 +337,22 @@ navi10_get_allowed_feature_mask(struct smu_context *s=
mu,
                                 | FEATURE_MASK(FEATURE_PPT_BIT)
                                 | FEATURE_MASK(FEATURE_TDC_BIT)
                                 | FEATURE_MASK(FEATURE_GFX_EDC_BIT)
+                               | FEATURE_MASK(FEATURE_APCC_PLUS_BIT)
                                 | FEATURE_MASK(FEATURE_VR0HOT_BIT)
                                 | FEATURE_MASK(FEATURE_FAN_CONTROL_BIT)
                                 | FEATURE_MASK(FEATURE_THERMAL_BIT)
                                 | FEATURE_MASK(FEATURE_LED_DISPLAY_BIT)
                                 | FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT)
                                 | FEATURE_MASK(FEATURE_DS_GFXCLK_BIT)
+                               | FEATURE_MASK(FEATURE_DS_LCLK_BIT)
                                 | FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
                                 | FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
                                 | FEATURE_MASK(FEATURE_BACO_BIT)
                                 | FEATURE_MASK(FEATURE_ACDC_BIT)
                                 | FEATURE_MASK(FEATURE_GFX_SS_BIT)
                                 | FEATURE_MASK(FEATURE_APCC_DFLL_BIT)
-                               | FEATURE_MASK(FEATURE_FW_CTF_BIT);
+                               | FEATURE_MASK(FEATURE_FW_CTF_BIT)
+                               | FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_=
BIT);

         if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_UC=
LK_BIT)
--
2.20.1


--_000_BN8PR12MB3602BB4F482647F07C325E3A89940BN8PR12MB3602namp_
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
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Ping ...</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
BR,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Xiaojie<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yuan, Xiaojie &lt;Xia=
ojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 9, 2019 7:08 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Xiao, Jack &lt;Jac=
k.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan =
&lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Y=
uan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: add more feature bits</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan@amd.c=
om&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 5 &#43;&#43;&#43;&#43;-<=
br>
&nbsp;1 file changed, 4 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 5a34d01f7f7c..44152c1f01c7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -337,19 &#43;337,22 @@ navi10_get_allowed_feature_mask(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_PPT_BIT)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_TDC_BIT)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_GFX_EDC_B=
IT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_APCC_PLUS_BIT)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_VR0HOT_BI=
T)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_FAN_CONTR=
OL_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_THERMAL_B=
IT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_LED_DISPL=
AY_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_DPM_DCEFC=
LK_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_DS_GFXCLK=
_BIT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_DS_LCLK_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_DS_DCEFCL=
K_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_FW_DSTATE=
_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_BACO_BIT)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_ACDC_BIT)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_GFX_SS_BI=
T)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_APCC_DFLL=
_BIT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_FW_CTF_BIT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_FW_CTF_BIT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_OUT_OF_BAND_MONI=
TOR_BIT);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature=
 &amp; PP_MCLK_DPM_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_D=
PM_UCLK_BIT)<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB3602BB4F482647F07C325E3A89940BN8PR12MB3602namp_--

--===============0916468140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0916468140==--
