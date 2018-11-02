From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd: Update atom_smu_info_v3_3 structure
Date: Fri, 2 Nov 2018 15:06:09 +0000
Message-ID: <BN6PR12MB1809F359CE832143227BBF8FF7CF0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1541165364-6819-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1807747311=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1541165364-6819-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============1807747311==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F359CE832143227BBF8FF7CF0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F359CE832143227BBF8FF7CF0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of sunpeng.=
li-5C7GfCeVMHo@public.gmane.org <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 2, 2018 9:29:24 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Li, Sun peng (Leo); Wentland, Harry
Subject: [PATCH] drm/amd: Update atom_smu_info_v3_3 structure

From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>

Mainly adding the WAFL spread spectrum info, for adjusting display
clocks when XGMI is enabled.

Signed-off-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/a=
md/include/atomfirmware.h
index d2e7c0f..8eb0bb2 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1325,7 +1325,7 @@ struct atom_smu_info_v3_3 {
   struct   atom_common_table_header  table_header;
   uint8_t  smuip_min_ver;
   uint8_t  smuip_max_ver;
-  uint8_t  smu_rsd1;
+  uint8_t  waflclk_ss_mode;
   uint8_t  gpuclk_ss_mode;
   uint16_t sclk_ss_percentage;
   uint16_t sclk_ss_rate_10hz;
@@ -1355,7 +1355,10 @@ struct atom_smu_info_v3_3 {
   uint32_t syspll3_1_vco_freq_10khz;
   uint32_t bootup_fclk_10khz;
   uint32_t bootup_waflclk_10khz;
-  uint32_t reserved[3];
+  uint32_t smu_info_caps;
+  uint16_t waflclk_ss_percentage;    // in unit of 0.001%
+  uint16_t smuinitoffset;
+  uint32_t reserved;
 };

 /*
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809F359CE832143227BBF8FF7CF0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of sunpeng.li-5C7GfCeVMHo@public.gmane.org &lt;sunpen=
g.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 2, 2018 9:29:24 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Li, Sun peng (Leo); Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd: Update atom_smu_info_v3_3 structure</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Mainly adding the WAFL spread spectrum info, for adjusting display<br>
clocks when XGMI is enabled.<br>
<br>
Signed-off-by: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/atomfirmware.h | 7 &#43;&#43;&#43;&#43;&#=
43;--<br>
&nbsp;1 file changed, 5 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/a=
md/include/atomfirmware.h<br>
index d2e7c0f..8eb0bb2 100644<br>
--- a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
@@ -1325,7 &#43;1325,7 @@ struct atom_smu_info_v3_3 {<br>
&nbsp;&nbsp; struct&nbsp;&nbsp; atom_common_table_header&nbsp; table_header=
;<br>
&nbsp;&nbsp; uint8_t&nbsp; smuip_min_ver;<br>
&nbsp;&nbsp; uint8_t&nbsp; smuip_max_ver;<br>
-&nbsp; uint8_t&nbsp; smu_rsd1;<br>
&#43;&nbsp; uint8_t&nbsp; waflclk_ss_mode;<br>
&nbsp;&nbsp; uint8_t&nbsp; gpuclk_ss_mode;<br>
&nbsp;&nbsp; uint16_t sclk_ss_percentage;<br>
&nbsp;&nbsp; uint16_t sclk_ss_rate_10hz;<br>
@@ -1355,7 &#43;1355,10 @@ struct atom_smu_info_v3_3 {<br>
&nbsp;&nbsp; uint32_t syspll3_1_vco_freq_10khz;<br>
&nbsp;&nbsp; uint32_t bootup_fclk_10khz;<br>
&nbsp;&nbsp; uint32_t bootup_waflclk_10khz;<br>
-&nbsp; uint32_t reserved[3];<br>
&#43;&nbsp; uint32_t smu_info_caps;<br>
&#43;&nbsp; uint16_t waflclk_ss_percentage;&nbsp;&nbsp;&nbsp; // in unit of=
 0.001%<br>
&#43;&nbsp; uint16_t smuinitoffset;<br>
&#43;&nbsp; uint32_t reserved;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/*<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F359CE832143227BBF8FF7CF0BN6PR12MB1809namp_--

--===============1807747311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1807747311==--
