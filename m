From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdkfd: Fix bugs regarding CP user queue
 doorbells mask on SOC15
Date: Thu, 7 Feb 2019 22:28:21 +0000
Message-ID: <SN1PR12MB23652876BD3F2301E0BE6473F0680@SN1PR12MB2365.namprd12.prod.outlook.com>
References: <20190205203047.22586-1-Yong.Zhao@amd.com>,
 <20190205203047.22586-4-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0768767224=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190205203047.22586-4-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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

--===============0768767224==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB23652876BD3F2301E0BE6473F0680SN1PR12MB2365namp_"

--_000_SN1PR12MB23652876BD3F2301E0BE6473F0680SN1PR12MB2365namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Felix,

Can you review the 4th and 5th patch? They were kept unchanged.

Regards,
Yong
________________________________
From: Zhao, Yong
Sent: Tuesday, February 5, 2019 3:31 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhao, Yong
Subject: [PATCH 4/5] drm/amdkfd: Fix bugs regarding CP user queue doorbells=
 mask on SOC15

Reserved doorbells for SDMA IH and VCN were not properly masked out
when allocating doorbells for CP user queues. This patch fixed that.

Change-Id: I670adfc3fd7725d2ed0bd9665cb7f69f8b9023c2
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 17 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 21 ++++++++++++++-----
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 19 ++++++-----------
 7 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index e957e42c539a..ee8527701731 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -196,11 +196,20 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *=
adev)
                         gpu_resources.sdma_doorbell[1][i+1] =3D
                                 adev->doorbell_index.sdma_engine[1] + 0x20=
0 + (i >> 1);
                 }
-               /* Doorbells 0x0e0-0ff and 0x2e0-2ff are reserved for
-                * SDMA, IH and VCN. So don't use them for the CP.
+
+               /* Because of the setting in registers like
+                * SDMA0_DOORBELL_RANGE etc., BIF statically uses the
+                * lower 12 bits of doorbell address for routing. In
+                * order to route the CP queue doorbells to CP engine,
+                * the doorbells allocated to CP queues have to be
+                * outside the range set for SDMA, VCN, and IH blocks
+                * Prior to SOC15, all queues use queue ID to
+                * determine doorbells.
                  */
-               gpu_resources.reserved_doorbell_mask =3D 0x1e0;
-               gpu_resources.reserved_doorbell_val  =3D 0x0e0;
+               gpu_resources.reserved_doorbells_start =3D
+                               adev->doorbell_index.sdma_engine[0];
+               gpu_resources.reserved_doorbells_end =3D
+                               adev->doorbell_index.last_non_cp;

                 kgd2kfd_device_init(adev->kfd.dev, &gpu_resources);
         }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_doorbell.h
index 59c41841cbce..74b8e2bfabd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -70,6 +70,7 @@ struct amdgpu_doorbell_index {
                         uint32_t vce_ring6_7;
                 } uvd_vce;
         };
+       uint32_t last_non_cp;
         uint32_t max_assignment;
         uint32_t last_idx;
         /* Per engine SDMA doorbell size in dword */
@@ -141,6 +142,7 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
         AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3             =3D 0x18D,
         AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5             =3D 0x18E,
         AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7             =3D 0x18F,
+       AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP             =3D AMDGPU_VEGA20_=
DOORBELL64_VCE_RING6_7,
         AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            =3D 0x18F,
         AMDGPU_VEGA20_DOORBELL_INVALID                   =3D 0xFFFF
 } AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
@@ -216,6 +218,8 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
         AMDGPU_DOORBELL64_VCE_RING4_5             =3D 0xFE,
         AMDGPU_DOORBELL64_VCE_RING6_7             =3D 0xFF,

+       AMDGPU_DOORBELL64_LAST_NON_CP             =3D AMDGPU_DOORBELL64_VCE=
_RING6_7,
+
         AMDGPU_DOORBELL64_MAX_ASSIGNMENT          =3D 0xFF,
         AMDGPU_DOORBELL64_INVALID                 =3D 0xFFFF
 } AMDGPU_DOORBELL64_ASSIGNMENT;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega10_reg_init.c
index 65214c7b0b20..76166c0ec509 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
@@ -80,6 +80,9 @@ void vega10_doorbell_index_init(struct amdgpu_device *ade=
v)
         adev->doorbell_index.uvd_vce.vce_ring2_3 =3D AMDGPU_DOORBELL64_VCE=
_RING2_3;
         adev->doorbell_index.uvd_vce.vce_ring4_5 =3D AMDGPU_DOORBELL64_VCE=
_RING4_5;
         adev->doorbell_index.uvd_vce.vce_ring6_7 =3D AMDGPU_DOORBELL64_VCE=
_RING6_7;
+
+       adev->doorbell_index.last_non_cp =3D AMDGPU_DOORBELL64_LAST_NON_CP;
+
         /* In unit of dword doorbell */
         adev->doorbell_index.max_assignment =3D AMDGPU_DOORBELL64_MAX_ASSI=
GNMENT << 1;
         adev->doorbell_index.dw_range_per_sdma_eng =3D
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega20_reg_init.c
index a388d306391a..10df2fed5a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
@@ -84,6 +84,9 @@ void vega20_doorbell_index_init(struct amdgpu_device *ade=
v)
         adev->doorbell_index.uvd_vce.vce_ring2_3 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING2_3;
         adev->doorbell_index.uvd_vce.vce_ring4_5 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING4_5;
         adev->doorbell_index.uvd_vce.vce_ring6_7 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING6_7;
+
+       adev->doorbell_index.last_non_cp =3D AMDGPU_VEGA20_DOORBELL64_LAST_=
NON_CP;
+
         adev->doorbell_index.max_assignment =3D AMDGPU_VEGA20_DOORBELL_MAX=
_ASSIGNMENT << 1;
         adev->doorbell_index.dw_range_per_sdma_eng =3D
                         (adev->doorbell_index.sdma_engine[1]
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index e5ebcca7f031..6b8459f852cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -103,6 +103,15 @@

 #define KFD_KERNEL_QUEUE_SIZE 2048

+/* 512 =3D 0x200
+ * On SOC15, the doorbell index distance for SDMA RLC i and (i + 1) in the
+ * same SDMA engine, where i is a even number.
+ * For 8-bytes doorbells, it ensures that the mirror doorbell range (in te=
rms
+ * of low 12 bit address for each HW engine) on the second doorbell page i=
s
+ * the same as the range of the first doorbell page.*/
+#define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
+
+
 /*
  * Kernel module parameter to specify maximum number of supported queues p=
er
  * device
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 80b36e860a0a..e904d6036b3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -607,13 +607,24 @@ static int init_doorbell_bitmap(struct qcm_process_de=
vice *qpd,
         if (!qpd->doorbell_bitmap)
                 return -ENOMEM;

-       /* Mask out any reserved doorbells */
-       for (i =3D 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS; i++)
-               if ((dev->shared_resources.reserved_doorbell_mask & i) =3D=
=3D
-                   dev->shared_resources.reserved_doorbell_val) {
+       /* Mask out all reserved doorbells for SDMA, IH, and VCN on SOC15.
+        * Because of the setting in registers like SDMA0_DOORBELL_RANGE et=
c.,
+        * BIF statically uses the lower 12 bits of doorbell address for
+        * routing. In order to route the CP queue doorbells to CP engine,
+        * the doorbells allocated to CP queues have to be outside the rang=
e
+        * set for SDMA, VCN, and IH blocks.
+        * Prior to SOC15, all queues use queue ID to
+        * determine doorbells. */
+       for (i =3D 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
+               if (i >=3D dev->shared_resources.reserved_doorbells_start
+                       && i <=3D dev->shared_resources.reserved_doorbells_=
end) {
                         set_bit(i, qpd->doorbell_bitmap);
-                       pr_debug("reserved doorbell 0x%03x\n", i);
+                       set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
+                               qpd->doorbell_bitmap);
+                       pr_debug("reserved doorbell 0x%03x and 0x%03x\n", i=
,
+                               i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET);
                 }
+       }

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index 83d960110d23..b1bf45419d93 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -137,20 +137,13 @@ struct kgd2kfd_shared_resources {
         /* Bit n =3D=3D 1 means Queue n is available for KFD */
         DECLARE_BITMAP(queue_bitmap, KGD_MAX_QUEUES);

-       /* Doorbell assignments (SOC15 and later chips only). Only
-        * specific doorbells are routed to each SDMA engine. Others
-        * are routed to IH and VCN. They are not usable by the CP.
-        *
-        * Any doorbell number D that satisfies the following condition
-        * is reserved: (D & reserved_doorbell_mask) =3D=3D reserved_doorbe=
ll_val
-        *
-        * KFD currently uses 1024 (=3D 0x3ff) doorbells per process. If
-        * doorbells 0x0e0-0x0ff and 0x2e0-0x2ff are reserved, that means
-        * mask would be set to 0x1e0 and val set to 0x0e0.
-        */
         unsigned int sdma_doorbell[2][8];
-       unsigned int reserved_doorbell_mask;
-       unsigned int reserved_doorbell_val;
+
+       /* From SOC15 onwards, the doorbell indexes reserved for SDMA, IH,
+        * and VCN
+        */
+       unsigned int reserved_doorbells_start;
+       unsigned int reserved_doorbells_end;

         /* Base address of doorbell aperture. */
         phys_addr_t doorbell_physical_address;
--
2.17.1


--_000_SN1PR12MB23652876BD3F2301E0BE6473F0680SN1PR12MB2365namp_
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
Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Can you review the 4th and 5th patch? They were kept unchanged.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Yong<br>
<b>Sent:</b> Tuesday, February 5, 2019 3:31 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhao, Yong<br>
<b>Subject:</b> [PATCH 4/5] drm/amdkfd: Fix bugs regarding CP user queue do=
orbells mask on SOC15</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reserved doorbells for SDMA IH and VCN were not pr=
operly masked out<br>
when allocating doorbells for CP user queues. This patch fixed that.<br>
<br>
Change-Id: I670adfc3fd7725d2ed0bd9665cb7f69f8b9023c2<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp; | 17 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h&nbsp; |&nbsp; 4 &#43;&#4=
3;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c&nbsp; |&nbsp; 3 &#43;&#4=
3;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c&nbsp; |&nbsp; 3 &#43;&#4=
3;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 21 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;-----<br>
&nbsp;.../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp; | 19 &#43;&#4=
3;&#43;&#43;&#43;&#43;-----------<br>
&nbsp;7 files changed, 54 insertions(&#43;), 22 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index e957e42c539a..ee8527701731 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -196,11 &#43;196,20 @@ void amdgpu_amdkfd_device_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_r=
esources.sdma_doorbell[1][i&#43;1] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma_eng=
ine[1] &#43; 0x200 &#43; (i &gt;&gt; 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Doorbells 0x0e0-0ff and 0x2e0-2ff are reserved for<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SDMA, IH and VCN. So don't use them for the CP.<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Because of the setting in registers like<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * SDMA0_DOORBELL_RANGE etc., BIF statically uses the<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * lower 12 bits of doorbell address for routing. In<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * order to route the CP queue doorbells to CP engine,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * the doorbells allocated to CP queues have to be<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * outside the range set for SDMA, VCN, and IH blocks<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Prior to SOC15, all queues use queue ID to<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * determine doorbells.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_resources.reserved_doorbell_mask =3D 0x1e0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_resources.reserved_doorbell_val&nbsp; =3D 0x0e0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gpu_resources.reserved_doorbells_start =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma_engine[0];=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gpu_resources.reserved_doorbells_end =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_cp;<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kgd2kfd_device_init(adev-&gt;kfd.dev, &amp;gpu_resour=
ces);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_doorbell.h<br>
index 59c41841cbce..74b8e2bfabd3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
@@ -70,6 &#43;70,7 @@ struct amdgpu_doorbell_index {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t vce_ring6_7;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } uvd_vce;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t last_non_cp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_assignment;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t last_idx;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Per engine SDMA doorbel=
l size in dword */<br>
@@ -141,6 &#43;142,7 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_V=
CE_RING2_3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 0x18D,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_V=
CE_RING4_5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 0x18E,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_V=
CE_RING6_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 0x18F,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_LAST_NON=
_CP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MAX=
_ASSIGNMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 0x18F,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_INV=
ALID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFFFF<br>
&nbsp;} AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;<br>
@@ -216,6 &#43;218,8 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING=
4_5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0xFE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING=
6_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0xFF,<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_LAST_NON_CP&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D AM=
DGPU_DOORBELL64_VCE_RING6_7,<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MAX_ASSI=
GNMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFF,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_INVALID&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =3D 0xFFFF<br>
&nbsp;} AMDGPU_DOORBELL64_ASSIGNMENT;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega10_reg_init.c<br>
index 65214c7b0b20..76166c0ec509 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
@@ -80,6 &#43;80,9 @@ void vega10_doorbell_index_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring2_3 =3D AMDGPU_DOORBELL64_VCE_RING2_3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring4_5 =3D AMDGPU_DOORBELL64_VCE_RING4_5;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring6_7 =3D AMDGPU_DOORBELL64_VCE_RING6_7;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_=
cp =3D AMDGPU_DOORBELL64_LAST_NON_CP;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In unit of dword doorbe=
ll */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ma=
x_assignment =3D AMDGPU_DOORBELL64_MAX_ASSIGNMENT &lt;&lt; 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.dw=
_range_per_sdma_eng =3D<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega20_reg_init.c<br>
index a388d306391a..10df2fed5a99 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
@@ -84,6 &#43;84,9 @@ void vega20_doorbell_index_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring2_3 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring4_5 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring6_7 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_=
cp =3D AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ma=
x_assignment =3D AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT &lt;&lt; 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.dw=
_range_per_sdma_eng =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev=
-&gt;doorbell_index.sdma_engine[1]<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index e5ebcca7f031..6b8459f852cc 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -103,6 &#43;103,15 @@<br>
&nbsp;<br>
&nbsp;#define KFD_KERNEL_QUEUE_SIZE 2048<br>
&nbsp;<br>
&#43;/* 512 =3D 0x200<br>
&#43; * On SOC15, the doorbell index distance for SDMA RLC i and (i &#43; 1=
) in the<br>
&#43; * same SDMA engine, where i is a even number.<br>
&#43; * For 8-bytes doorbells, it ensures that the mirror doorbell range (i=
n terms<br>
&#43; * of low 12 bit address for each HW engine) on the second doorbell pa=
ge is<br>
&#43; * the same as the range of the first doorbell page.*/<br>
&#43;#define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512<br>
&#43;<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * Kernel module parameter to specify maximum number of supported que=
ues per<br>
&nbsp; * device<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 80b36e860a0a..e904d6036b3d 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -607,13 &#43;607,24 @@ static int init_doorbell_bitmap(struct qcm_proces=
s_device *qpd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!qpd-&gt;doorbell_bitm=
ap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Mask out any reserved doorbells */=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; KFD_MAX_NUM_OF_Q=
UEUES_PER_PROCESS; i&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((dev-&gt;shared_resources.reserved_doorbell_mask &amp; i) =
=3D=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;shared_resources.reserved_doorbe=
ll_val) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Mask out all reserved doorbell=
s for SDMA, IH, and VCN on SOC15.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Because of the setting in=
 registers like SDMA0_DOORBELL_RANGE etc.,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * BIF statically uses the l=
ower 12 bits of doorbell address for<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * routing. In order to rout=
e the CP queue doorbells to CP engine,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the doorbells allocated t=
o CP queues have to be outside the range<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set for SDMA, VCN, and IH=
 blocks.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Prior to SOC15, all queue=
s use queue ID to<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * determine doorbells. */<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; KFD_MAX_NUM_=
OF_QUEUES_PER_PROCESS / 2; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (i &gt;=3D dev-&gt;shared_resources.reserved_doorbells_st=
art<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; i=
 &lt;=3D dev-&gt;shared_resources.reserved_doorbells_end) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_b=
it(i, qpd-&gt;doorbell_bitmap);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;r=
eserved doorbell 0x%03x\n&quot;, i);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(i &#=
43; KFD_QUEUE_DOORBELL_MIRROR_OFFSET,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;doorbell_bitmap);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&qu=
ot;reserved doorbell 0x%03x and 0x%03x\n&quot;, i,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &#43; KFD_QUEUE_DOORBELL_MIRROR_OFFSE=
T);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h<br>
index 83d960110d23..b1bf45419d93 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
@@ -137,20 &#43;137,13 @@ struct kgd2kfd_shared_resources {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit n =3D=3D 1 means Qu=
eue n is available for KFD */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(queue_bitma=
p, KGD_MAX_QUEUES);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Doorbell assignments (SOC15 and la=
ter chips only). Only<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * specific doorbells are routed=
 to each SDMA engine. Others<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * are routed to IH and VCN. The=
y are not usable by the CP.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Any doorbell number D that sa=
tisfies the following condition<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is reserved: (D &amp; reserve=
d_doorbell_mask) =3D=3D reserved_doorbell_val<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * KFD currently uses 1024 (=3D =
0x3ff) doorbells per process. If<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * doorbells 0x0e0-0x0ff and 0x2=
e0-0x2ff are reserved, that means<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mask would be set to 0x1e0 an=
d val set to 0x0e0.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int sdma_doorbell=
[2][8];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbell_mask;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbell_val;<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* From SOC15 onwards, the doorbe=
ll indexes reserved for SDMA, IH,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and VCN<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbells_s=
tart;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbells_e=
nd;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Base address of doorbel=
l aperture. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t doorbell_physi=
cal_address;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB23652876BD3F2301E0BE6473F0680SN1PR12MB2365namp_--

--===============0768767224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0768767224==--
