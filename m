From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdkfd: Use functions from amdgpu for setting up
 page table base
Date: Thu, 18 Oct 2018 21:59:32 +0000
Message-ID: <BN6PR12MB180905403FA46D7791ADE9E2F7F80@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1539897169-23047-1-git-send-email-Yong.Zhao@amd.com>,
 <1539897169-23047-3-git-send-email-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1174137544=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539897169-23047-3-git-send-email-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--===============1174137544==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180905403FA46D7791ADE9E2F7F80BN6PR12MB1809namp_"

--_000_BN6PR12MB180905403FA46D7791ADE9E2F7F80BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please include a patch description on 2 and 3, with that fixed, series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Zhao, Yong
Sent: Thursday, October 18, 2018 5:13:04 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev
Cc: Zhao, Yong
Subject: [PATCH 3/3] drm/amdkfd: Use functions from amdgpu for setting up p=
age table base

Change-Id: I42eb2e41ce21b4a6ea0c8394dcc762ee92b2ca5e
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 4b79639..223bbc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -46,6 +46,7 @@
 #include "v9_structs.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "gmc_v9_0.h"

 /* HACK: MMHUB and GC both have VM-related register with the same
  * names but different offsets. Define the MMHUB register we need here
@@ -59,11 +60,6 @@
 #define mmMMHUB_VM_INVALIDATE_ENG16_ACK                         0x0705
 #define mmMMHUB_VM_INVALIDATE_ENG16_ACK_BASE_IDX                0

-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32          0x072b
-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32_BASE_IDX 0
-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32          0x072c
-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32_BASE_IDX 0
-
 #define mmMMHUB_VM_INVALIDATE_ENG16_ADDR_RANGE_LO32             0x0727
 #define mmMMHUB_VM_INVALIDATE_ENG16_ADDR_RANGE_LO32_BASE_IDX    0
 #define mmMMHUB_VM_INVALIDATE_ENG16_ADDR_RANGE_HI32             0x0728
@@ -1018,9 +1014,7 @@ static void set_vm_context_page_table_base(struct kgd=
_dev *kgd, uint32_t vmid,
          * now, all processes share the same address space size, like
          * on GFX8 and older.
          */
-       WREG32(SOC15_REG_OFFSET(MMHUB, 0, mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BA=
SE_ADDR_LO32) + (vmid*2), lower_32_bits(base));
-       WREG32(SOC15_REG_OFFSET(MMHUB, 0, mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BA=
SE_ADDR_HI32) + (vmid*2), upper_32_bits(base));
+       mmhub_v1_0_setup_vm_pt_regs(adev, vmid, base);

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_L=
O32) + (vmid*2), lower_32_bits(base));
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_H=
I32) + (vmid*2), upper_32_bits(base));
+       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, base);
 }
--
2.7.4


--_000_BN6PR12MB180905403FA46D7791ADE9E2F7F80BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFo=
nt&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols;">
<p style=3D"margin-top:0; margin-bottom:0">Please include a patch descripti=
on on 2 and 3, with that fixed, series is:</p>
<p style=3D"margin-top:0; margin-bottom:0">Reviewed-by: Alex Deucher &lt;al=
exander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhao, Yong<br>
<b>Sent:</b> Thursday, October 18, 2018 5:13:04 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev<br>
<b>Cc:</b> Zhao, Yong<br>
<b>Subject:</b> [PATCH 3/3] drm/amdkfd: Use functions from amdgpu for setti=
ng up page table base</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Change-Id: I42eb2e41ce21b4a6ea0c8394dcc762ee92b2ca=
5e<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 12 &#43;&#43;&#43=
;---------<br>
&nbsp;1 file changed, 3 insertions(&#43;), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 4b79639..223bbc1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -46,6 &#43;46,7 @@<br>
&nbsp;#include &quot;v9_structs.h&quot;<br>
&nbsp;#include &quot;soc15.h&quot;<br>
&nbsp;#include &quot;soc15d.h&quot;<br>
&#43;#include &quot;gmc_v9_0.h&quot;<br>
&nbsp;<br>
&nbsp;/* HACK: MMHUB and GC both have VM-related register with the same<br>
&nbsp; * names but different offsets. Define the MMHUB register we need her=
e<br>
@@ -59,11 &#43;60,6 @@<br>
&nbsp;#define mmMMHUB_VM_INVALIDATE_ENG16_ACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0705<br>
&nbsp;#define mmMMHUB_VM_INVALIDATE_ENG16_ACK_BASE_IDX&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x072b<br>
-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32_BASE_IDX 0<br>
-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x072c<br>
-#define mmMMHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32_BASE_IDX 0<br>
-<br>
&nbsp;#define mmMMHUB_VM_INVALIDATE_ENG16_ADDR_RANGE_LO32&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0727<br>
&nbsp;#define mmMMHUB_VM_INVALIDATE_ENG16_ADDR_RANGE_LO32_BASE_IDX&nbsp;&nb=
sp;&nbsp; 0<br>
&nbsp;#define mmMMHUB_VM_INVALIDATE_ENG16_ADDR_RANGE_HI32&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0728<br>
@@ -1018,9 &#43;1014,7 @@ static void set_vm_context_page_table_base(struct=
 kgd_dev *kgd, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * now, all processes=
 share the same address space size, like<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on GFX8 and older.=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(MMHUB, 0, mmM=
MHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32) &#43; (vmid*2), lower_32_bits(b=
ase));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(MMHUB, 0, mmM=
MHUB_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32) &#43; (vmid*2), upper_32_bits(b=
ase));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_setup_vm_pt_regs(adev,=
 vmid, base);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmVM_C=
ONTEXT0_PAGE_TABLE_BASE_ADDR_LO32) &#43; (vmid*2), lower_32_bits(base));<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmVM_C=
ONTEXT0_PAGE_TABLE_BASE_ADDR_HI32) &#43; (vmid*2), upper_32_bits(base));<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_setup_vm_pt_regs(adev=
, vmid, base);<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB180905403FA46D7791ADE9E2F7F80BN6PR12MB1809namp_--

--===============1174137544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1174137544==--
