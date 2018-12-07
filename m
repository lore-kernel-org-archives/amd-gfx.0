From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu/powerplay: Apply avfs cks-off voltages on VI
Date: Fri, 7 Dec 2018 16:07:18 +0000
Message-ID: <BN6PR12MB1809B3E784D95744A3DCB955F7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1544163200-9543-1-git-send-email-kenneth.feng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968393762=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544163200-9543-1-git-send-email-kenneth.feng-5C7GfCeVMHo@public.gmane.org>
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
To: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0968393762==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809B3E784D95744A3DCB955F7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809B3E784D95744A3DCB955F7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kenneth =
Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, December 7, 2018 1:13:20 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Feng, Kenneth
Subject: [PATCH v2] drm/amdgpu/powerplay: Apply avfs cks-off voltages on VI

Instead of EVV cks-off voltages, avfs cks-off voltages can avoid
the overshoot voltages when switching sclk.

Signed-off-by: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h          | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h b/drivers/gpu/d=
rm/amd/powerplay/inc/smu7_ppsmc.h
index 62f36ba..c1a99df 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h
@@ -386,6 +386,8 @@ typedef uint16_t PPSMC_Result;
 #define PPSMC_MSG_AgmResetPsm                 ((uint16_t) 0x403)
 #define PPSMC_MSG_ReadVftCell                 ((uint16_t) 0x404)

+#define PPSMC_MSG_ApplyAvfsCksOffVoltage      ((uint16_t) 0x415)
+
 #define PPSMC_MSG_GFX_CU_PG_ENABLE            ((uint16_t) 0x280)
 #define PPSMC_MSG_GFX_CU_PG_DISABLE           ((uint16_t) 0x281)
 #define PPSMC_MSG_GetCurrPkgPwr               ((uint16_t) 0x282)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 94898b2..d2b97aa 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -1997,6 +1997,12 @@ int polaris10_thermal_avfs_enable(struct pp_hwmgr *h=
wmgr)

         smum_send_msg_to_smc(hwmgr, PPSMC_MSG_EnableAvfs);

+       /* Apply avfs cks-off voltages to avoid the overshoot
+        * when switching to the highest sclk frequency
+        */
+       if (data->apply_avfs_cks_off_voltage)
+               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ApplyAvfsCksOffVoltag=
e);
+
         return 0;
 }

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809B3E784D95744A3DCB955F7AA0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Friday, December 7, 2018 1:13:20 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Feng, Kenneth<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu/powerplay: Apply avfs cks-off voltage=
s on VI</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Instead of EVV cks-off voltages, avfs cks-off volt=
ages can avoid<br>
the overshoot voltages when switching sclk.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 6 &#43;&#43=
;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 8 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h b/drivers/gpu/d=
rm/amd/powerplay/inc/smu7_ppsmc.h<br>
index 62f36ba..c1a99df 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h<br>
@@ -386,6 &#43;386,8 @@ typedef uint16_t PPSMC_Result;<br>
&nbsp;#define PPSMC_MSG_AgmResetPsm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint16_t) 0x403)=
<br>
&nbsp;#define PPSMC_MSG_ReadVftCell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint16_t) 0x404)=
<br>
&nbsp;<br>
&#43;#define PPSMC_MSG_ApplyAvfsCksOffVoltage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ((uint16_t) 0x415)<br>
&#43;<br>
&nbsp;#define PPSMC_MSG_GFX_CU_PG_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint16_t) 0x280)<br>
&nbsp;#define PPSMC_MSG_GFX_CU_PG_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ((uint16_t) 0x281)<br>
&nbsp;#define PPSMC_MSG_GetCurrPkgPwr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint16_t) 0x282)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
index 94898b2..d2b97aa 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<b=
r>
@@ -1997,6 &#43;1997,12 @@ int polaris10_thermal_avfs_enable(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr=
, PPSMC_MSG_EnableAvfs);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Apply avfs cks-off voltages to=
 avoid the overshoot<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * when switching to the hig=
hest sclk frequency<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;apply_avfs_cks_off_v=
oltage)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ApplyAvfsCksOffVoltage=
);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
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

--_000_BN6PR12MB1809B3E784D95744A3DCB955F7AA0BN6PR12MB1809namp_--

--===============0968393762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0968393762==--
