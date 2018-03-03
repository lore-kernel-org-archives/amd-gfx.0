From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: used cached pcie gen info for SI (v2)
Date: Sat, 3 Mar 2018 02:24:29 +0000
Message-ID: <CY4PR12MB16878291BB159AD22A703180FBC40@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180301020428.16953-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0353854261=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180301020428.16953-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============0353854261==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16878291BB159AD22A703180FBC40CY4PR12MB1687namp_"

--_000_CY4PR12MB16878291BB159AD22A703180FBC40CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org>

Best Regards
Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, March 1, 2018 10:04 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amdgpu: used cached pcie gen info for SI (v2)

Rather than querying it every time we need it.
Also fixes a crash in VM pass through if there is no
root bridge because the cached value fetch already checks
this properly.

v2: fix includes

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=3D105244
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/gpu/drm/amd/amdgpu/si.c     | 22 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 50 ++++++++++-----------------------=
----
 2 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/s=
i.c
index f20c4b7414e8..6e61b56bfbfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -31,6 +31,7 @@
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
 #include "atom.h"
+#include "amd_pcie.h"
 #include "amdgpu_powerplay.h"
 #include "sid.h"
 #include "si_ih.h"
@@ -1484,8 +1485,8 @@ static void si_pcie_gen3_enable(struct amdgpu_device =
*adev)
 {
         struct pci_dev *root =3D adev->pdev->bus->self;
         int bridge_pos, gpu_pos;
-       u32 speed_cntl, mask, current_data_rate;
-       int ret, i;
+       u32 speed_cntl, current_data_rate;
+       int i;
         u16 tmp16;

         if (pci_is_root_bus(adev->pdev->bus))
@@ -1497,23 +1498,20 @@ static void si_pcie_gen3_enable(struct amdgpu_devic=
e *adev)
         if (adev->flags & AMD_IS_APU)
                 return;

-       ret =3D drm_pcie_get_speed_cap_mask(adev->ddev, &mask);
-       if (ret !=3D 0)
-               return;
-
-       if (!(mask & (DRM_PCIE_SPEED_50 | DRM_PCIE_SPEED_80)))
+       if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
+                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3))=
)
                 return;

         speed_cntl =3D RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
         current_data_rate =3D (speed_cntl & LC_CURRENT_DATA_RATE_MASK) >>
                 LC_CURRENT_DATA_RATE_SHIFT;
-       if (mask & DRM_PCIE_SPEED_80) {
+       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
                 if (current_data_rate =3D=3D 2) {
                         DRM_INFO("PCIE gen 3 link speeds already enabled\n=
");
                         return;
                 }
                 DRM_INFO("enabling PCIE gen 3 link speeds, disable with am=
dgpu.pcie_gen2=3D0\n");
-       } else if (mask & DRM_PCIE_SPEED_50) {
+       } else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GE=
N2) {
                 if (current_data_rate =3D=3D 1) {
                         DRM_INFO("PCIE gen 2 link speeds already enabled\n=
");
                         return;
@@ -1529,7 +1527,7 @@ static void si_pcie_gen3_enable(struct amdgpu_device =
*adev)
         if (!gpu_pos)
                 return;

-       if (mask & DRM_PCIE_SPEED_80) {
+       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
                 if (current_data_rate !=3D 2) {
                         u16 bridge_cfg, gpu_cfg;
                         u16 bridge_cfg2, gpu_cfg2;
@@ -1612,9 +1610,9 @@ static void si_pcie_gen3_enable(struct amdgpu_device =
*adev)

         pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16=
);
         tmp16 &=3D ~0xf;
-       if (mask & DRM_PCIE_SPEED_80)
+       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
                 tmp16 |=3D 3;
-       else if (mask & DRM_PCIE_SPEED_50)
+       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2=
)
                 tmp16 |=3D 2;
         else
                 tmp16 |=3D 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/si_dpm.c
index 8138053fcef1..8137c02fd16a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -26,6 +26,7 @@
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
 #include "amdgpu_atombios.h"
+#include "amd_pcie.h"
 #include "sid.h"
 #include "r600_dpm.h"
 #include "si_dpm.h"
@@ -3331,29 +3332,6 @@ static void btc_apply_voltage_delta_rules(struct amd=
gpu_device *adev,
         }
 }

-static enum amdgpu_pcie_gen r600_get_pcie_gen_support(struct amdgpu_device=
 *adev,
-                                              u32 sys_mask,
-                                              enum amdgpu_pcie_gen asic_ge=
n,
-                                              enum amdgpu_pcie_gen default=
_gen)
-{
-       switch (asic_gen) {
-       case AMDGPU_PCIE_GEN1:
-               return AMDGPU_PCIE_GEN1;
-       case AMDGPU_PCIE_GEN2:
-               return AMDGPU_PCIE_GEN2;
-       case AMDGPU_PCIE_GEN3:
-               return AMDGPU_PCIE_GEN3;
-       default:
-               if ((sys_mask & DRM_PCIE_SPEED_80) && (default_gen =3D=3D A=
MDGPU_PCIE_GEN3))
-                       return AMDGPU_PCIE_GEN3;
-               else if ((sys_mask & DRM_PCIE_SPEED_50) && (default_gen =3D=
=3D AMDGPU_PCIE_GEN2))
-                       return AMDGPU_PCIE_GEN2;
-               else
-                       return AMDGPU_PCIE_GEN1;
-       }
-       return AMDGPU_PCIE_GEN1;
-}
-
 static void r600_calculate_u_and_p(u32 i, u32 r_c, u32 p_b,
                             u32 *p, u32 *u)
 {
@@ -5028,10 +5006,11 @@ static int si_populate_smc_acpi_state(struct amdgpu=
_device *adev,
                                                               table->ACPIS=
tate.levels[0].vddc.index,
                                                               &table->ACPI=
State.levels[0].std_vddc);
                 }
-               table->ACPIState.levels[0].gen2PCIE =3D (u8)r600_get_pcie_g=
en_support(adev,
-                                                                          =
         si_pi->sys_pcie_mask,
-                                                                          =
         si_pi->boot_pcie_gen,
-                                                                          =
         AMDGPU_PCIE_GEN1);
+               table->ACPIState.levels[0].gen2PCIE =3D
+                       (u8)amdgpu_get_pcie_gen_support(adev,
+                                                       si_pi->sys_pcie_mas=
k,
+                                                       si_pi->boot_pcie_ge=
n,
+                                                       AMDGPU_PCIE_GEN1);

                 if (si_pi->vddc_phase_shed_control)
                         si_populate_phase_shedding_value(adev,
@@ -7168,10 +7147,10 @@ static void si_parse_pplib_clock_info(struct amdgpu=
_device *adev,
         pl->vddc =3D le16_to_cpu(clock_info->si.usVDDC);
         pl->vddci =3D le16_to_cpu(clock_info->si.usVDDCI);
         pl->flags =3D le32_to_cpu(clock_info->si.ulFlags);
-       pl->pcie_gen =3D r600_get_pcie_gen_support(adev,
-                                                si_pi->sys_pcie_mask,
-                                                si_pi->boot_pcie_gen,
-                                                clock_info->si.ucPCIEGen);
+       pl->pcie_gen =3D amdgpu_get_pcie_gen_support(adev,
+                                                  si_pi->sys_pcie_mask,
+                                                  si_pi->boot_pcie_gen,
+                                                  clock_info->si.ucPCIEGen=
);

         /* patch up vddc if necessary */
         ret =3D si_get_leakage_voltage_from_leakage_index(adev, pl->vddc,
@@ -7326,7 +7305,6 @@ static int si_dpm_init(struct amdgpu_device *adev)
         struct si_power_info *si_pi;
         struct atom_clock_dividers dividers;
         int ret;
-       u32 mask;

         si_pi =3D kzalloc(sizeof(struct si_power_info), GFP_KERNEL);
         if (si_pi =3D=3D NULL)
@@ -7336,11 +7314,9 @@ static int si_dpm_init(struct amdgpu_device *adev)
         eg_pi =3D &ni_pi->eg;
         pi =3D &eg_pi->rv7xx;

-       ret =3D drm_pcie_get_speed_cap_mask(adev->ddev, &mask);
-       if (ret)
-               si_pi->sys_pcie_mask =3D 0;
-       else
-               si_pi->sys_pcie_mask =3D mask;
+       si_pi->sys_pcie_mask =3D
+               (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_MASK=
) >>
+               CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT;
         si_pi->force_pcie_gen =3D AMDGPU_PCIE_GEN_INVALID;
         si_pi->boot_pcie_gen =3D si_get_current_pcie_speed(adev);

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




--_000_CY4PR12MB16878291BB159AD22A703180FBC40CY4PR12MB1687namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; font-family: Cal=
ibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quo=
t;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;=
Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D"color: rgb=
(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;=
Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.=
6667px;">Reviewed-by: Rex Zhu&lt;rezhu-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br style=3D"color: rgb(3=
3, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Se=
goe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.66=
67px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">Best Regards</span><br style=3D"color: rg=
b(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot=
;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14=
.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">Rex</span><a class=3D"i_Wm6 jZtLg _19Y0R =
_81eaS _1EhqP " title=3D"rex.zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_self" tabindex=3D"0" a=
ria-label=3D"Email rex.zhu-5C7GfCeVMHo@public.gmane.org" style=3D"color: rgb(36, 136, 216) !impo=
rtant; box-sizing: content-box; background-color: rgb(255, 255, 255); font-=
family: &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif;" id=3D"LPlnk452588" previewremoved=3D"true"></a></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Thursday, March 1, 2018 10:04 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: used cached pcie gen info for SI (v2)</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Rather than querying it every time we need it.<br>
Also fixes a crash in VM pass through if there is no<br>
root bridge because the cached value fetch already checks<br>
this properly.<br>
<br>
v2: fix includes<br>
<br>
Fixes: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D105244" id=
=3D"LPlnk317240" previewremoved=3D"true">
https://bugs.freedesktop.org/show_bug.cgi?id=3D105244</a><br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/si.c&nbsp;&nbsp;&nbsp;&nbsp; | 22 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/si_dpm.c | 50 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;---------------------------<br>
&nbsp;2 files changed, 23 insertions(&#43;), 49 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/s=
i.c<br>
index f20c4b7414e8..6e61b56bfbfc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/si.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si.c<br>
@@ -31,6 &#43;31,7 @@<br>
&nbsp;#include &quot;amdgpu_uvd.h&quot;<br>
&nbsp;#include &quot;amdgpu_vce.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&#43;#include &quot;amd_pcie.h&quot;<br>
&nbsp;#include &quot;amdgpu_powerplay.h&quot;<br>
&nbsp;#include &quot;sid.h&quot;<br>
&nbsp;#include &quot;si_ih.h&quot;<br>
@@ -1484,8 &#43;1485,8 @@ static void si_pcie_gen3_enable(struct amdgpu_dev=
ice *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *root =3D a=
dev-&gt;pdev-&gt;bus-&gt;self;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int bridge_pos, gpu_pos;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 speed_cntl, mask, current_data_ra=
te;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 speed_cntl, current_data_rate=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 tmp16;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_is_root_bus(adev-&=
gt;pdev-&gt;bus))<br>
@@ -1497,23 &#43;1498,20 @@ static void si_pcie_gen3_enable(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; A=
MD_IS_APU)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_pcie_get_speed_cap_mask(a=
dev-&gt;ddev, &amp;mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(mask &amp; (DRM_PCIE_SPEED_50 |=
 DRM_PCIE_SPEED_80)))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pcie_gen_mask &=
amp; (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; speed_cntl =3D RREG32_PCIE=
_PORT(PCIE_LC_SPEED_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_data_rate =3D (spe=
ed_cntl &amp; LC_CURRENT_DATA_RATE_MASK) &gt;&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; LC_CURRENT_DATA_RATE_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mask &amp; DRM_PCIE_SPEED_80) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_gen_mask &am=
p; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (current_data_rate =3D=3D 2) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;PCIE gen 3 link speeds already enabled\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;enabling PCIE gen 3 link speeds, disab=
le with amdgpu.pcie_gen2=3D0\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (mask &amp; DRM_PCIE_SPEED_=
50) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;pm.pcie_gen_m=
ask &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (current_data_rate =3D=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;PCIE gen 2 link speeds already enabled\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n;<br>
@@ -1529,7 &#43;1527,7 @@ static void si_pcie_gen3_enable(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!gpu_pos)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mask &amp; DRM_PCIE_SPEED_80) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_gen_mask &am=
p; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (current_data_rate !=3D 2) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 b=
ridge_cfg, gpu_cfg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 b=
ridge_cfg2, gpu_cfg2;<br>
@@ -1612,9 &#43;1610,9 @@ static void si_pcie_gen3_enable(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_read_config_word(adev-=
&gt;pdev, gpu_pos &#43; PCI_EXP_LNKCTL2, &amp;tmp16);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp16 &amp;=3D ~0xf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mask &amp; DRM_PCIE_SPEED_80)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_gen_mask &am=
p; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp16 |=3D 3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (mask &amp; DRM_PCIE_SPEED_50=
)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_gen_mas=
k &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp16 |=3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp16 |=3D 1;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/si_dpm.c<br>
index 8138053fcef1..8137c02fd16a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
@@ -26,6 &#43;26,7 @@<br>
&nbsp;#include &quot;amdgpu_pm.h&quot;<br>
&nbsp;#include &quot;amdgpu_dpm.h&quot;<br>
&nbsp;#include &quot;amdgpu_atombios.h&quot;<br>
&#43;#include &quot;amd_pcie.h&quot;<br>
&nbsp;#include &quot;sid.h&quot;<br>
&nbsp;#include &quot;r600_dpm.h&quot;<br>
&nbsp;#include &quot;si_dpm.h&quot;<br>
@@ -3331,29 &#43;3332,6 @@ static void btc_apply_voltage_delta_rules(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-static enum amdgpu_pcie_gen r600_get_pcie_gen_support(struct amdgpu_device=
 *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sys_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_pcie_gen asic_ge=
n,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_pcie_gen default=
_gen)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_gen) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_GEN1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_PCIE_GEN1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_GEN2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_PCIE_GEN2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_GEN3:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_PCIE_GEN3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((sys_mask &amp; DRM_PCIE_SPEED_80) &amp;&amp; (default_gen =
=3D=3D AMDGPU_PCIE_GEN3))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_PC=
IE_GEN3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if ((sys_mask &amp; DRM_PCIE_SPEED_50) &amp;&amp; (default_=
gen =3D=3D AMDGPU_PCIE_GEN2))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_PC=
IE_GEN2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_PC=
IE_GEN1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_PCIE_GEN1;<br>
-}<br>
-<br>
&nbsp;static void r600_calculate_u_and_p(u32 i, u32 r_c, u32 p_b,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; u32 *p, u32 *u)<br>
&nbsp;{<br>
@@ -5028,10 &#43;5006,11 @@ static int si_populate_smc_acpi_state(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta=
ble-&gt;ACPIState.levels[0].vddc.index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;table-&gt;ACPIState.levels[0].std_vddc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;ACPIState.levels[0].gen2PCIE =3D (u8)r600_get_pcie_gen=
_support(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;sys_pcie_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;boot_pcie_gen,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PCIE_GEN1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;ACPIState.levels[0].gen2PCIE =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u8)amdgpu_g=
et_pcie_gen_support(adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;sys_pcie_mask,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;boot_pcie_gen,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PCIE_GEN1);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (si_pi-&gt;vddc_phase_shed_control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_po=
pulate_phase_shedding_value(adev,<br>
@@ -7168,10 &#43;7147,10 @@ static void si_parse_pplib_clock_info(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pl-&gt;vddc =3D le16_to_cp=
u(clock_info-&gt;si.usVDDC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pl-&gt;vddci =3D le16_to_c=
pu(clock_info-&gt;si.usVDDCI);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pl-&gt;flags =3D le32_to_c=
pu(clock_info-&gt;si.ulFlags);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pl-&gt;pcie_gen =3D r600_get_pcie_gen=
_support(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;sys_pc=
ie_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;boot_p=
cie_gen,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_info-&gt;s=
i.ucPCIEGen);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pl-&gt;pcie_gen =3D amdgpu_get_pc=
ie_gen_support(adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
si_pi-&gt;sys_pcie_mask,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
si_pi-&gt;boot_pcie_gen,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
clock_info-&gt;si.ucPCIEGen);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* patch up vddc if necess=
ary */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D si_get_leakage_vol=
tage_from_leakage_index(adev, pl-&gt;vddc,<br>
@@ -7326,7 &#43;7305,6 @@ static int si_dpm_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct si_power_info *si_p=
i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_clock_dividers=
 dividers;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mask;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi =3D kzalloc(sizeof(s=
truct si_power_info), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (si_pi =3D=3D NULL)<br>
@@ -7336,11 &#43;7314,9 @@ static int si_dpm_init(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eg_pi =3D &amp;ni_pi-&gt;e=
g;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi =3D &amp;eg_pi-&gt;rv7x=
x;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_pcie_get_speed_cap_mask(a=
dev-&gt;ddev, &amp;mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; si_pi-&gt;sys_pcie_mask =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; si_pi-&gt;sys_pcie_mask =3D mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;sys_pcie_mask =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (adev-&gt;pm.pcie_gen_mask &amp; CAIL_PCIE_LINK_SPEED_SUPPOR=
T_MASK) &gt;&gt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;force_pcie_gen =
=3D AMDGPU_PCIE_GEN_INVALID;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_pi-&gt;boot_pcie_gen =
=3D si_get_current_pcie_speed(adev);<br>
&nbsp;<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk569804" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15200389369860.8099112469914744" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15200389369770.07540873504833634" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15200389369810.15734688362710525" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15200389369820.9499041851208263"></div>
<div id=3D"LPTitle_15200389369820.031472893158088766" style=3D"top: 0px; co=
lor: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: w=
f_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &=
quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-=
height: 21px;">
<a id=3D"LPUrlAnchor_15200389369840.11259246378743137" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15200389369840.057204491134174695" style=3D"margin: 1=
0px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: =
wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Ari=
al, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15200389369850.3904603170324785" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
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

--_000_CY4PR12MB16878291BB159AD22A703180FBC40CY4PR12MB1687namp_--

--===============0353854261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0353854261==--
