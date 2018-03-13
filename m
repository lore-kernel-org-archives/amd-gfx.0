From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amd/pp: Delete dead code on cz_clockpowergating.c
Date: Tue, 13 Mar 2018 15:16:52 +0000
Message-ID: <BN6PR12MB1652B62FCCCCE5F6ACD34CF9F7D20@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1520935279-17471-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0417458406=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520935279-17471-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0417458406==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652B62FCCCCE5F6ACD34CF9F7D20BN6PR12MB1652namp_"

--_000_BN6PR12MB1652B62FCCCCE5F6ACD34CF9F7D20BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, March 13, 2018 6:01 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 1/5] drm/amd/pp: Delete dead code on cz_clockpowergating.c

Change-Id: Ia4a121435c4860b1703d3647ef7220ee97f52d03
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c  | 78 ------------------=
----
 .../drm/amd/powerplay/hwmgr/cz_clockpowergating.h  |  3 -
 2 files changed, 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
index 416abeb..01e5612 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
@@ -25,84 +25,6 @@
 #include "cz_clockpowergating.h"
 #include "cz_ppsmc.h"

-/* PhyID -> Status Mapping in DDI_PHY_GEN_STATUS
-    0    GFX0L (3:0),                  (27:24),
-    1    GFX0H (7:4),                  (31:28),
-    2    GFX1L (3:0),                  (19:16),
-    3    GFX1H (7:4),                  (23:20),
-    4    DDIL   (3:0),                   (11: 8),
-    5    DDIH  (7:4),                   (15:12),
-    6    DDI2L (3:0),                   ( 3: 0),
-    7    DDI2H (7:4),                   ( 7: 4),
-*/
-#define DDI_PHY_GEN_STATUS_VAL(phyID)   (1 << ((3 - ((phyID & 0x07)/2))*8 =
+ (phyID & 0x01)*4))
-#define IS_PHY_ID_USED_BY_PLL(PhyID)    (((0xF3 & (1 << PhyID)) & 0xFF) ? =
true : false)
-
-
-int cz_phm_set_asic_block_gating(struct pp_hwmgr *hwmgr, enum PHM_AsicBloc=
k block, enum PHM_ClockGateSetting gating)
-{
-       int ret =3D 0;
-
-       switch (block) {
-       case PHM_AsicBlock_UVD_MVC:
-       case PHM_AsicBlock_UVD:
-       case PHM_AsicBlock_UVD_HD:
-       case PHM_AsicBlock_UVD_SD:
-               if (gating =3D=3D PHM_ClockGateSetting_StaticOff)
-                       ret =3D cz_dpm_powerdown_uvd(hwmgr);
-               else
-                       ret =3D cz_dpm_powerup_uvd(hwmgr);
-               break;
-       case PHM_AsicBlock_GFX:
-       default:
-               break;
-       }
-
-       return ret;
-}
-
-
-bool cz_phm_is_safe_for_asic_block(struct pp_hwmgr *hwmgr, const struct pp=
_hw_power_state *state, enum PHM_AsicBlock block)
-{
-       return true;
-}
-
-
-int cz_phm_enable_disable_gfx_power_gating(struct pp_hwmgr *hwmgr, bool en=
able)
-{
-       return 0;
-}
-
-int cz_phm_smu_power_up_down_pcie(struct pp_hwmgr *hwmgr, uint32_t target,=
 bool up, uint32_t args)
-{
-       /* TODO */
-       return 0;
-}
-
-int cz_phm_initialize_display_phy_access(struct pp_hwmgr *hwmgr, bool init=
ialize, bool accesshw)
-{
-       /* TODO */
-       return 0;
-}
-
-int cz_phm_get_display_phy_access_info(struct pp_hwmgr *hwmgr)
-{
-       /* TODO */
-       return 0;
-}
-
-int cz_phm_gate_unused_display_phys(struct pp_hwmgr *hwmgr)
-{
-       /* TODO */
-       return 0;
-}
-
-int cz_phm_ungate_all_display_phys(struct pp_hwmgr *hwmgr)
-{
-       /* TODO */
-       return 0;
-}
-
 int cz_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
 {
         struct cz_hwmgr *cz_hwmgr =3D (struct cz_hwmgr *)(hwmgr->backend);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h
index 92f707b..08d393f 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h
@@ -25,10 +25,7 @@
 #define _CZ_CLOCK_POWER_GATING_H_

 #include "cz_hwmgr.h"
-#include "pp_asicblocks.h"

-extern int cz_phm_set_asic_block_gating(struct pp_hwmgr *hwmgr, enum PHM_A=
sicBlock block, enum PHM_ClockGateSetting gating);
-extern const struct phm_master_table_header cz_phm_enable_clock_power_gati=
ngs_master;
 extern void cz_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate);
 extern void cz_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate);
 extern int cz_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable);
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652B62FCCCCE5F6ACD34CF9F7D20BN6PR12MB1652namp_
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
Series is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Tuesday, March 13, 2018 6:01 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 1/5] drm/amd/pp: Delete dead code on cz_clockpowerga=
ting.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: Ia4a121435c4860b1703d3647ef7220ee97f52d=
03<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/cz_clockpowergating.c&nbsp; | 78 --------=
--------------<br>
&nbsp;.../drm/amd/powerplay/hwmgr/cz_clockpowergating.h&nbsp; |&nbsp; 3 -<b=
r>
&nbsp;2 files changed, 81 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c<br>
index 416abeb..01e5612 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c=
<br>
@@ -25,84 &#43;25,6 @@<br>
&nbsp;#include &quot;cz_clockpowergating.h&quot;<br>
&nbsp;#include &quot;cz_ppsmc.h&quot;<br>
&nbsp;<br>
-/* PhyID -&gt; Status Mapping in DDI_PHY_GEN_STATUS<br>
-&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; GFX0L (3:0),&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (27:24),<br>
-&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; GFX0H (7:4),&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (31:28),<br>
-&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; GFX1L (3:0),&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (19:16),<br>
-&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp; GFX1H (7:4),&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (23:20),<br>
-&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp; DDIL&nbsp;&nbsp; (3:0),&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (11: 8),<br>
-&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp; DDIH&nbsp; (7:4),&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (15:12),<br>
-&nbsp;&nbsp;&nbsp; 6&nbsp;&nbsp;&nbsp; DDI2L (3:0),&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ( 3: 0),<br>
-&nbsp;&nbsp;&nbsp; 7&nbsp;&nbsp;&nbsp; DDI2H (7:4),&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ( 7: 4),<br>
-*/<br>
-#define DDI_PHY_GEN_STATUS_VAL(phyID)&nbsp;&nbsp; (1 &lt;&lt; ((3 - ((phyI=
D &amp; 0x07)/2))*8 &#43; (phyID &amp; 0x01)*4))<br>
-#define IS_PHY_ID_USED_BY_PLL(PhyID)&nbsp;&nbsp;&nbsp; (((0xF3 &amp; (1 &l=
t;&lt; PhyID)) &amp; 0xFF) ? true : false)<br>
-<br>
-<br>
-int cz_phm_set_asic_block_gating(struct pp_hwmgr *hwmgr, enum PHM_AsicBloc=
k block, enum PHM_ClockGateSetting gating)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (block) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PHM_AsicBlock_UVD_MVC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PHM_AsicBlock_UVD:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PHM_AsicBlock_UVD_HD:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PHM_AsicBlock_UVD_SD:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gating =3D=3D PHM_ClockGateSetting_StaticOff)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_dpm_p=
owerdown_uvd(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_dpm_p=
owerup_uvd(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PHM_AsicBlock_GFX:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-<br>
-bool cz_phm_is_safe_for_asic_block(struct pp_hwmgr *hwmgr, const struct pp=
_hw_power_state *state, enum PHM_AsicBlock block)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
-<br>
-int cz_phm_enable_disable_gfx_power_gating(struct pp_hwmgr *hwmgr, bool en=
able)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int cz_phm_smu_power_up_down_pcie(struct pp_hwmgr *hwmgr, uint32_t target,=
 bool up, uint32_t args)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int cz_phm_initialize_display_phy_access(struct pp_hwmgr *hwmgr, bool init=
ialize, bool accesshw)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int cz_phm_get_display_phy_access_info(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int cz_phm_gate_unused_display_phys(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int cz_phm_ungate_all_display_phys(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;int cz_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cz_hwmgr *cz_hwmgr =
=3D (struct cz_hwmgr *)(hwmgr-&gt;backend);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h<br>
index 92f707b..08d393f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h=
<br>
@@ -25,10 &#43;25,7 @@<br>
&nbsp;#define _CZ_CLOCK_POWER_GATING_H_<br>
&nbsp;<br>
&nbsp;#include &quot;cz_hwmgr.h&quot;<br>
-#include &quot;pp_asicblocks.h&quot;<br>
&nbsp;<br>
-extern int cz_phm_set_asic_block_gating(struct pp_hwmgr *hwmgr, enum PHM_A=
sicBlock block, enum PHM_ClockGateSetting gating);<br>
-extern const struct phm_master_table_header cz_phm_enable_clock_power_gati=
ngs_master;<br>
&nbsp;extern void cz_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate);=
<br>
&nbsp;extern void cz_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate);=
<br>
&nbsp;extern int cz_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool ena=
ble);<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk570250" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652B62FCCCCE5F6ACD34CF9F7D20BN6PR12MB1652namp_--

--===============0417458406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0417458406==--
