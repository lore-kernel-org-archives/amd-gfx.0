From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Use functions from amdgpu to invalidate
 vmid in kfd
Date: Tue, 23 Oct 2018 19:20:06 +0000
Message-ID: <BN6PR12MB1809B4684E7E16A5F49C74F6F7F50@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1540318546-1468-1-git-send-email-Yong.Zhao@amd.com>,
 <1540318546-1468-2-git-send-email-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1459292704=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540318546-1468-2-git-send-email-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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

--===============1459292704==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809B4684E7E16A5F49C74F6F7F50BN6PR12MB1809namp_"

--_000_BN6PR12MB1809B4684E7E16A5F49C74F6F7F50BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Zhao, Yong
Sent: Tuesday, October 23, 2018 2:15:59 PM
To: brahma_sw_dev; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhao, Yong
Subject: [PATCH 2/2] drm/amdkfd: Use functions from amdgpu to invalidate vm=
id in kfd

As part of the change, we stop taking the srbm lock, and start to use
the same invalidation engine and software lock.

Change-Id: I306305e43d4b4032316909b3f4e3f9f5ca4520ae
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 37 +------------------=
----
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 3ade5d5..f4b4706 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -48,17 +48,6 @@
 #include "soc15d.h"
 #include "gmc_v9_0.h"

-/* HACK: MMHUB and GC both have VM-related register with the same
- * names but different offsets. Define the MMHUB register we need here
- * with a prefix. A proper solution would be to move the functions
- * programming these registers into gfx_v9_0.c and mmhub_v1_0.c
- * respectively.
- */
-#define mmMMHUB_VM_INVALIDATE_ENG16_REQ                                0x0=
6f3
-#define mmMMHUB_VM_INVALIDATE_ENG16_REQ_BASE_IDX               0
-
-#define mmMMHUB_VM_INVALIDATE_ENG16_ACK                                0x0=
705
-#define mmMMHUB_VM_INVALIDATE_ENG16_ACK_BASE_IDX               0

 #define V9_PIPE_PER_MEC         (4)
 #define V9_QUEUES_PER_PIPE_MEC  (8)
@@ -742,15 +731,6 @@ static uint16_t get_atc_vmid_pasid_mapping_pasid(struc=
t kgd_dev *kgd,
 static void write_vmid_invalidate_request(struct kgd_dev *kgd, uint8_t vmi=
d)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *) kgd;
-       uint32_t req =3D (1 << vmid) |
-               (0 << VM_INVALIDATE_ENG16_REQ__FLUSH_TYPE__SHIFT) | /* lega=
cy */
-               VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PTES_MASK |
-               VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PDE0_MASK |
-               VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PDE1_MASK |
-               VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PDE2_MASK |
-               VM_INVALIDATE_ENG16_REQ__INVALIDATE_L1_PTES_MASK;
-
-       mutex_lock(&adev->srbm_mutex);

         /* Use legacy mode tlb invalidation.
          *
@@ -767,22 +747,7 @@ static void write_vmid_invalidate_request(struct kgd_d=
ev *kgd, uint8_t vmid)
          * TODO 2: support range-based invalidation, requires kfg2kgd
          * interface change
          */
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmVM_INVALIDATE_ENG16_REQ), req);
-
-       WREG32(SOC15_REG_OFFSET(MMHUB, 0, mmMMHUB_VM_INVALIDATE_ENG16_REQ),
-                               req);
-
-       while (!(RREG32(SOC15_REG_OFFSET(GC, 0, mmVM_INVALIDATE_ENG16_ACK))=
 &
-                                       (1 << vmid)))
-               cpu_relax();
-
-       while (!(RREG32(SOC15_REG_OFFSET(MMHUB, 0,
-                                       mmMMHUB_VM_INVALIDATE_ENG16_ACK)) &
-                                       (1 << vmid)))
-               cpu_relax();
-
-       mutex_unlock(&adev->srbm_mutex);
-
+       amdgpu_gmc_flush_gpu_tlb(adev, vmid, 0);
 }

 static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint16_t p=
asid)
--
2.7.4


--_000_BN6PR12MB1809B4684E7E16A5F49C74F6F7F50BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Yong<br>
<b>Sent:</b> Tuesday, October 23, 2018 2:15:59 PM<br>
<b>To:</b> brahma_sw_dev; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhao, Yong<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: Use functions from amdgpu to invali=
date vmid in kfd</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As part of the change, we stop taking the srbm loc=
k, and start to use<br>
the same invalidation engine and software lock.<br>
<br>
Change-Id: I306305e43d4b4032316909b3f4e3f9f5ca4520ae<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 37 &#43;---------=
-------------<br>
&nbsp;1 file changed, 1 insertion(&#43;), 36 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 3ade5d5..f4b4706 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -48,17 &#43;48,6 @@<br>
&nbsp;#include &quot;soc15d.h&quot;<br>
&nbsp;#include &quot;gmc_v9_0.h&quot;<br>
&nbsp;<br>
-/* HACK: MMHUB and GC both have VM-related register with the same<br>
- * names but different offsets. Define the MMHUB register we need here<br>
- * with a prefix. A proper solution would be to move the functions<br>
- * programming these registers into gfx_v9_0.c and mmhub_v1_0.c<br>
- * respectively.<br>
- */<br>
-#define mmMMHUB_VM_INVALIDATE_ENG16_REQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0x06f3<br>
-#define mmMMHUB_VM_INVALIDATE_ENG16_REQ_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
-<br>
-#define mmMMHUB_VM_INVALIDATE_ENG16_ACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0x0705<br>
-#define mmMMHUB_VM_INVALIDATE_ENG16_ACK_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
&nbsp;#define V9_PIPE_PER_MEC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (4)<br>
&nbsp;#define V9_QUEUES_PER_PIPE_MEC&nbsp; (8)<br>
@@ -742,15 &#43;731,6 @@ static uint16_t get_atc_vmid_pasid_mapping_pasid(s=
truct kgd_dev *kgd,<br>
&nbsp;static void write_vmid_invalidate_request(struct kgd_dev *kgd, uint8_=
t vmid)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *) kgd;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t req =3D (1 &lt;&lt; vmid) |<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (0 &lt;&lt; VM_INVALIDATE_ENG16_REQ__FLUSH_TYPE__SHIFT) | /* leg=
acy */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PTES_MASK |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PDE0_MASK |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PDE1_MASK |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VM_INVALIDATE_ENG16_REQ__INVALIDATE_L2_PDE2_MASK |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VM_INVALIDATE_ENG16_REQ__INVALIDATE_L1_PTES_MASK;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use legacy mode tlb inv=
alidation.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
@@ -767,22 &#43;747,7 @@ static void write_vmid_invalidate_request(struct k=
gd_dev *kgd, uint8_t vmid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO 2: support ra=
nge-based invalidation, requires kfg2kgd<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * interface change<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmVM_I=
NVALIDATE_ENG16_REQ), req);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(MMHUB, 0, mmM=
MHUB_VM_INVALIDATE_ENG16_REQ),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (!(RREG32(SOC15_REG_OFFSET(GC, =
0, mmVM_INVALIDATE_ENG16_ACK)) &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (1 &lt;&lt; vmid)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cpu_relax();<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (!(RREG32(SOC15_REG_OFFSET(MMHU=
B, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mmMMHUB_VM_INVALIDATE_ENG16_ACK)) &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (1 &lt;&lt; vmid)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cpu_relax();<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex=
);<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush_gpu_tlb(adev, vm=
id, 0);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint1=
6_t pasid)<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809B4684E7E16A5F49C74F6F7F50BN6PR12MB1809namp_--

--===============1459292704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1459292704==--
