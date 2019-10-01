From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Export setup_vm_pt_regs() logic for mmhub 2.0
Date: Tue, 1 Oct 2019 17:58:49 +0000
Message-ID: <BN6PR12MB18094FAAA3A261BF9DFD1C22F79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190928034012.28228-1-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1695083167=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190928034012.28228-1-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1695083167==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18094FAAA3A261BF9DFD1C22F79D0BN6PR12MB1809namp_"

--_000_BN6PR12MB18094FAAA3A261BF9DFD1C22F79D0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhao, Yo=
ng <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, September 27, 2019 11:40 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Export setup_vm_pt_regs() logic for mmhub 2.0

The KFD code will call this function later.

Change-Id: I5993323603799963e9eb473852b6c72de2172ed6
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 19 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c
index 86ed8cb915a8..2eea702de8ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -31,20 +31,25 @@

 #include "soc15_common.h"

-static void mmhub_v2_0_init_gart_pt_regs(struct amdgpu_device *adev)
+void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid=
,
+                               uint64_t page_table_base)
 {
-       uint64_t value =3D amdgpu_gmc_pd_addr(adev->gart.bo);
+       /* two registers distance between mmMMVM_CONTEXT0_* to mmMMVM_CONTE=
XT1_* */
+       int offset =3D mmMMVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
+                       - mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;

-       WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-                    lower_32_bits(value));
+       WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_=
LO32,
+                       offset * vmid, lower_32_bits(page_table_base));

-       WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-                    upper_32_bits(value));
+       WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_=
HI32,
+                       offset * vmid, upper_32_bits(page_table_base));
 }

 static void mmhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
-       mmhub_v2_0_init_gart_pt_regs(adev);
+       uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
+
+       mmhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);

         WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
                      (u32)(adev->gmc.gart_start >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.h
index db16f3ece218..3ea4344f0315 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h
@@ -31,5 +31,7 @@ void mmhub_v2_0_init(struct amdgpu_device *adev);
 int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
                                enum amd_clockgating_state state);
 void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags);
+void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid=
,
+                               uint64_t page_table_base);

 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18094FAAA3A261BF9DFD1C22F79D0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhao, Yong &lt;Yong.Zhao@amd.=
com&gt;<br>
<b>Sent:</b> Friday, September 27, 2019 11:40 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Export setup_vm_pt_regs() logic for mmh=
ub 2.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The KFD code will call this function later.<br>
<br>
Change-Id: I5993323603799963e9eb473852b6c72de2172ed6<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 19 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h |&nbsp; 2 &#43;&#43;<br>
&nbsp;2 files changed, 14 insertions(&#43;), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c<br>
index 86ed8cb915a8..2eea702de8ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
@@ -31,20 &#43;31,25 @@<br>
&nbsp;<br>
&nbsp;#include &quot;soc15_common.h&quot;<br>
&nbsp;<br>
-static void mmhub_v2_0_init_gart_pt_regs(struct amdgpu_device *adev)<br>
&#43;void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t =
vmid,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value =3D amdgpu_gmc_pd_addr=
(adev-&gt;gart.bo);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* two registers distance between=
 mmMMVM_CONTEXT0_* to mmMMVM_CONTEXT1_* */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int offset =3D mmMMVM_CONTEXT1_PA=
GE_TABLE_BASE_ADDR_LO32<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - mmMMVM_CON=
TEXT0_PAGE_TABLE_BASE_ADDR_LO32;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT=
0_PAGE_TABLE_BASE_ADDR_LO32,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(value));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmM=
MVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmi=
d, lower_32_bits(page_table_base));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT=
0_PAGE_TABLE_BASE_ADDR_HI32,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(value));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmM=
MVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmi=
d, upper_32_bits(page_table_base));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void mmhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *=
adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v2_0_init_gart_pt_regs(adev);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_p=
d_addr(adev-&gt;gart.bo);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v2_0_setup_vm_pt_regs(adev,=
 0, pt_base);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmM=
MVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart=
_start &gt;&gt; 12));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.h<br>
index db16f3ece218..3ea4344f0315 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h<br>
@@ -31,5 &#43;31,7 @@ void mmhub_v2_0_init(struct amdgpu_device *adev);<br>
&nbsp;int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state);<br>
&nbsp;void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flag=
s);<br>
&#43;void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t =
vmid,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base);<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18094FAAA3A261BF9DFD1C22F79D0BN6PR12MB1809namp_--

--===============1695083167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1695083167==--
