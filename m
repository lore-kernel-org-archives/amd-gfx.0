From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Moved doorbell structures to seperate file
Date: Fri, 23 Nov 2018 20:20:23 +0000
Message-ID: <BN6PR12MB18098BA4A45681AF186F961EF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1543003277-18487-1-git-send-email-ozeng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1223489315=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543003277-18487-1-git-send-email-ozeng-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

--===============1223489315==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18098BA4A45681AF186F961EF7D40BN6PR12MB1809namp_"

--_000_BN6PR12MB18098BA4A45681AF186F961EF7D40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Did you see my other comments about consolidating vega10, raven, and vega12=
?


Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Oak Zeng=
 <ozeng-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 23, 2018 3:01:23 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zeng, Oak
Subject: [PATCH] drm/amdgpu: Moved doorbell structures to seperate file

Move doorbell structures, enum definitions and helper functions
from amdgpu.h to amdgpu_doorbell.h. No functional change

Change-Id: I09f7b84869b6d3c688b7a2506ff78d62b3de23f5
Signed-off-by: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 227 +----------------------=
-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 249 +++++++++++++++++++++++=
++++
 2 files changed, 250 insertions(+), 226 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index e4101b1..7fc32c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -81,6 +81,7 @@
 #include "amdgpu_job.h"
 #include "amdgpu_bo_list.h"
 #include "amdgpu_gem.h"
+#include "amdgpu_doorbell.h"

 #define MAX_GPU_INSTANCE                16

@@ -361,173 +362,6 @@ int amdgpu_fence_slab_init(void);
 void amdgpu_fence_slab_fini(void);

 /*
- * GPU doorbell structures, functions & helpers
- */
-typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
-{
-       AMDGPU_DOORBELL_KIQ                     =3D 0x000,
-       AMDGPU_DOORBELL_HIQ                     =3D 0x001,
-       AMDGPU_DOORBELL_DIQ                     =3D 0x002,
-       AMDGPU_DOORBELL_MEC_RING0               =3D 0x010,
-       AMDGPU_DOORBELL_MEC_RING1               =3D 0x011,
-       AMDGPU_DOORBELL_MEC_RING2               =3D 0x012,
-       AMDGPU_DOORBELL_MEC_RING3               =3D 0x013,
-       AMDGPU_DOORBELL_MEC_RING4               =3D 0x014,
-       AMDGPU_DOORBELL_MEC_RING5               =3D 0x015,
-       AMDGPU_DOORBELL_MEC_RING6               =3D 0x016,
-       AMDGPU_DOORBELL_MEC_RING7               =3D 0x017,
-       AMDGPU_DOORBELL_GFX_RING0               =3D 0x020,
-       AMDGPU_DOORBELL_sDMA_ENGINE0            =3D 0x1E0,
-       AMDGPU_DOORBELL_sDMA_ENGINE1            =3D 0x1E1,
-       AMDGPU_DOORBELL_IH                      =3D 0x1E8,
-       AMDGPU_DOORBELL_MAX_ASSIGNMENT          =3D 0x3FF,
-       AMDGPU_DOORBELL_INVALID                 =3D 0xFFFF
-} AMDGPU_DOORBELL_ASSIGNMENT;
-
-struct amdgpu_doorbell {
-       /* doorbell mmio */
-       resource_size_t         base;
-       resource_size_t         size;
-       u32 __iomem             *ptr;
-       u32                     num_doorbells;  /* Number of doorbells actu=
ally reserved for amdgpu. */
-};
-
-typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
-{
-       /* Compute + GFX: 0~255 */
-       AMDGPU_VEGA20_DOORBELL_KIQ                     =3D 0x000,
-       AMDGPU_VEGA20_DOORBELL_HIQ                     =3D 0x001,
-       AMDGPU_VEGA20_DOORBELL_DIQ                     =3D 0x002,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING0               =3D 0x003,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING1               =3D 0x004,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING2               =3D 0x005,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING3               =3D 0x006,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING4               =3D 0x007,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING5               =3D 0x008,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING6               =3D 0x009,
-       AMDGPU_VEGA20_DOORBELL_MEC_RING7               =3D 0x00A,
-       AMDGPU_VEGA20_DOORBELL_USERQUEUE_START         =3D 0x00B,
-       AMDGPU_VEGA20_DOORBELL_USERQUEUE_END           =3D 0x08A,
-       AMDGPU_VEGA20_DOORBELL_GFX_RING0               =3D 0x08B,
-       /* SDMA:256~335*/
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE0            =3D 0x100,
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE1            =3D 0x10A,
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE2            =3D 0x114,
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE3            =3D 0x11E,
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE4            =3D 0x128,
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE5            =3D 0x132,
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE6            =3D 0x13C,
-       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE7            =3D 0x146,
-       /* IH: 376~391 */
-       AMDGPU_VEGA20_DOORBELL_IH                      =3D 0x178,
-       /* MMSCH: 392~407
-        * overlap the doorbell assignment with VCN as they are  mutually e=
xclusive
-        * VCE engine's doorbell is 32 bit and two VCE ring share one QWORD
-        */
-       AMDGPU_VEGA20_DOORBELL64_VCN0_1                  =3D 0x188, /* lowe=
r 32 bits for VNC0 and upper 32 bits for VNC1 */
-       AMDGPU_VEGA20_DOORBELL64_VCN2_3                  =3D 0x189,
-       AMDGPU_VEGA20_DOORBELL64_VCN4_5                  =3D 0x18A,
-       AMDGPU_VEGA20_DOORBELL64_VCN6_7                  =3D 0x18B,
-
-       AMDGPU_VEGA20_DOORBELL64_UVD_RING0_1             =3D 0x188,
-       AMDGPU_VEGA20_DOORBELL64_UVD_RING2_3             =3D 0x189,
-       AMDGPU_VEGA20_DOORBELL64_UVD_RING4_5             =3D 0x18A,
-       AMDGPU_VEGA20_DOORBELL64_UVD_RING6_7             =3D 0x18B,
-
-       AMDGPU_VEGA20_DOORBELL64_VCE_RING0_1             =3D 0x18C,
-       AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3             =3D 0x18D,
-       AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5             =3D 0x18E,
-       AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7             =3D 0x18F,
-       AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            =3D 0x18F,
-       AMDGPU_VEGA20_DOORBELL_INVALID                   =3D 0xFFFF
-} AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
-
-/*
- * 64bit doorbell, offset are in QWORD, occupy 2KB doorbell space
- */
-typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
-{
-       /*
-        * All compute related doorbells: kiq, hiq, diq, traditional comput=
e queue, user queue, should locate in
-        * a continues range so that programming CP_MEC_DOORBELL_RANGE_LOWE=
R/UPPER can cover this range.
-        *  Compute related doorbells are allocated from 0x00 to 0x8a
-        */
-
-
-       /* kernel scheduling */
-       AMDGPU_DOORBELL64_KIQ                     =3D 0x00,
-
-       /* HSA interface queue and debug queue */
-       AMDGPU_DOORBELL64_HIQ                     =3D 0x01,
-       AMDGPU_DOORBELL64_DIQ                     =3D 0x02,
-
-       /* Compute engines */
-       AMDGPU_DOORBELL64_MEC_RING0               =3D 0x03,
-       AMDGPU_DOORBELL64_MEC_RING1               =3D 0x04,
-       AMDGPU_DOORBELL64_MEC_RING2               =3D 0x05,
-       AMDGPU_DOORBELL64_MEC_RING3               =3D 0x06,
-       AMDGPU_DOORBELL64_MEC_RING4               =3D 0x07,
-       AMDGPU_DOORBELL64_MEC_RING5               =3D 0x08,
-       AMDGPU_DOORBELL64_MEC_RING6               =3D 0x09,
-       AMDGPU_DOORBELL64_MEC_RING7               =3D 0x0a,
-
-       /* User queue doorbell range (128 doorbells) */
-       AMDGPU_DOORBELL64_USERQUEUE_START         =3D 0x0b,
-       AMDGPU_DOORBELL64_USERQUEUE_END           =3D 0x8a,
-
-       /* Graphics engine */
-       AMDGPU_DOORBELL64_GFX_RING0               =3D 0x8b,
-
-       /*
-        * Other graphics doorbells can be allocated here: from 0x8c to 0xd=
f
-        * Graphics voltage island aperture 1
-        * default non-graphics QWORD index is 0xe0 - 0xFF inclusive
-        */
-
-       /* sDMA engines  reserved from 0xe0 -0xef  */
-       AMDGPU_DOORBELL64_sDMA_ENGINE0            =3D 0xE0,
-       AMDGPU_DOORBELL64_sDMA_HI_PRI_ENGINE0     =3D 0xE1,
-       AMDGPU_DOORBELL64_sDMA_ENGINE1            =3D 0xE8,
-       AMDGPU_DOORBELL64_sDMA_HI_PRI_ENGINE1     =3D 0xE9,
-
-       /* For vega10 sriov, the sdma doorbell must be fixed as follow
-        * to keep the same setting with host driver, or it will
-        * happen conflicts
-        */
-       AMDGPU_VEGA10_DOORBELL64_sDMA_ENGINE0            =3D 0xF0,
-       AMDGPU_VEGA10_DOORBELL64_sDMA_HI_PRI_ENGINE0     =3D 0xF1,
-       AMDGPU_VEGA10_DOORBELL64_sDMA_ENGINE1            =3D 0xF2,
-       AMDGPU_VEGA10_DOORBELL64_sDMA_HI_PRI_ENGINE1     =3D 0xF3,
-
-       /* Interrupt handler */
-       AMDGPU_DOORBELL64_IH                      =3D 0xF4,  /* For legacy =
interrupt ring buffer */
-       AMDGPU_DOORBELL64_IH_RING1                =3D 0xF5,  /* For page mi=
gration request log */
-       AMDGPU_DOORBELL64_IH_RING2                =3D 0xF6,  /* For page mi=
gration translation/invalidation log */
-
-       /* VCN engine use 32 bits doorbell  */
-       AMDGPU_DOORBELL64_VCN0_1                  =3D 0xF8, /* lower 32 bit=
s for VNC0 and upper 32 bits for VNC1 */
-       AMDGPU_DOORBELL64_VCN2_3                  =3D 0xF9,
-       AMDGPU_DOORBELL64_VCN4_5                  =3D 0xFA,
-       AMDGPU_DOORBELL64_VCN6_7                  =3D 0xFB,
-
-       /* overlap the doorbell assignment with VCN as they are  mutually e=
xclusive
-        * VCE engine's doorbell is 32 bit and two VCE ring share one QWORD
-        */
-       AMDGPU_DOORBELL64_UVD_RING0_1             =3D 0xF8,
-       AMDGPU_DOORBELL64_UVD_RING2_3             =3D 0xF9,
-       AMDGPU_DOORBELL64_UVD_RING4_5             =3D 0xFA,
-       AMDGPU_DOORBELL64_UVD_RING6_7             =3D 0xFB,
-
-       AMDGPU_DOORBELL64_VCE_RING0_1             =3D 0xFC,
-       AMDGPU_DOORBELL64_VCE_RING2_3             =3D 0xFD,
-       AMDGPU_DOORBELL64_VCE_RING4_5             =3D 0xFE,
-       AMDGPU_DOORBELL64_VCE_RING6_7             =3D 0xFF,
-
-       AMDGPU_DOORBELL64_MAX_ASSIGNMENT          =3D 0xFF,
-       AMDGPU_DOORBELL64_INVALID                 =3D 0xFFFF
-} AMDGPU_DOORBELL64_ASSIGNMENT;
-
-/*
  * IRQS.
  */

@@ -863,55 +697,6 @@ struct amd_powerplay {
         uint32_t pp_feature;
 };

-/* Reserved doorbells for amdgpu (including multimedia).
- * KFD can use all the rest in the 2M doorbell bar.
- * For asic before vega10, doorbell is 32-bit, so the
- * index/offset is in dword. For vega10 and after, doorbell
- * can be 64-bit, so the index defined is in qword.
- */
-struct amdgpu_doorbell_index {
-       uint32_t kiq;
-       uint32_t mec_ring0;
-       uint32_t mec_ring1;
-       uint32_t mec_ring2;
-       uint32_t mec_ring3;
-       uint32_t mec_ring4;
-       uint32_t mec_ring5;
-       uint32_t mec_ring6;
-       uint32_t mec_ring7;
-       uint32_t userqueue_start;
-       uint32_t userqueue_end;
-       uint32_t gfx_ring0;
-       uint32_t sdma_engine0;
-       uint32_t sdma_engine1;
-       uint32_t sdma_engine2;
-       uint32_t sdma_engine3;
-       uint32_t sdma_engine4;
-       uint32_t sdma_engine5;
-       uint32_t sdma_engine6;
-       uint32_t sdma_engine7;
-       uint32_t ih;
-       union {
-               struct {
-                       uint32_t vcn_ring0_1;
-                       uint32_t vcn_ring2_3;
-                       uint32_t vcn_ring4_5;
-                       uint32_t vcn_ring6_7;
-               } vcn;
-               struct {
-                       uint32_t uvd_ring0_1;
-                       uint32_t uvd_ring2_3;
-                       uint32_t uvd_ring4_5;
-                       uint32_t uvd_ring6_7;
-                       uint32_t vce_ring0_1;
-                       uint32_t vce_ring2_3;
-                       uint32_t vce_ring4_5;
-                       uint32_t vce_ring6_7;
-               } uvd_vce;
-       };
-       uint32_t max_assignment;
-};
-
 #define AMDGPU_RESET_MAGIC_NUM 64
 struct amdgpu_device {
         struct device                   *dev;
@@ -1150,11 +935,6 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, u=
int32_t offset);
 u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg);
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v);

-u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);
-void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
-u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
-void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
-
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);

@@ -1216,11 +996,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
 #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))

-#define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
-#define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
-#define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
-#define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), (v))
-
 #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
 #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_doorbell.h
new file mode 100644
index 0000000..708ac73
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -0,0 +1,249 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+/*
+ * GPU doorbell structures, functions & helpers
+ */
+struct amdgpu_doorbell {
+       /* doorbell mmio */
+       resource_size_t         base;
+       resource_size_t         size;
+       u32 __iomem             *ptr;
+       u32                     num_doorbells;  /* Number of doorbells actu=
ally reserved for amdgpu. */
+};
+
+/* Reserved doorbells for amdgpu (including multimedia).
+ * KFD can use all the rest in the 2M doorbell bar.
+ * For asic before vega10, doorbell is 32-bit, so the
+ * index/offset is in dword. For vega10 and after, doorbell
+ * can be 64-bit, so the index defined is in qword.
+ */
+struct amdgpu_doorbell_index {
+       uint32_t kiq;
+       uint32_t mec_ring0;
+       uint32_t mec_ring1;
+       uint32_t mec_ring2;
+       uint32_t mec_ring3;
+       uint32_t mec_ring4;
+       uint32_t mec_ring5;
+       uint32_t mec_ring6;
+       uint32_t mec_ring7;
+       uint32_t userqueue_start;
+       uint32_t userqueue_end;
+       uint32_t gfx_ring0;
+       uint32_t sdma_engine0;
+       uint32_t sdma_engine1;
+       uint32_t sdma_engine2;
+       uint32_t sdma_engine3;
+       uint32_t sdma_engine4;
+       uint32_t sdma_engine5;
+       uint32_t sdma_engine6;
+       uint32_t sdma_engine7;
+       uint32_t ih;
+       union {
+               struct {
+                       uint32_t vcn_ring0_1;
+                       uint32_t vcn_ring2_3;
+                       uint32_t vcn_ring4_5;
+                       uint32_t vcn_ring6_7;
+               } vcn;
+               struct {
+                       uint32_t uvd_ring0_1;
+                       uint32_t uvd_ring2_3;
+                       uint32_t uvd_ring4_5;
+                       uint32_t uvd_ring6_7;
+                       uint32_t vce_ring0_1;
+                       uint32_t vce_ring2_3;
+                       uint32_t vce_ring4_5;
+                       uint32_t vce_ring6_7;
+               } uvd_vce;
+       };
+       uint32_t max_assignment;
+};
+
+typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
+{
+       AMDGPU_DOORBELL_KIQ                     =3D 0x000,
+       AMDGPU_DOORBELL_HIQ                     =3D 0x001,
+       AMDGPU_DOORBELL_DIQ                     =3D 0x002,
+       AMDGPU_DOORBELL_MEC_RING0               =3D 0x010,
+       AMDGPU_DOORBELL_MEC_RING1               =3D 0x011,
+       AMDGPU_DOORBELL_MEC_RING2               =3D 0x012,
+       AMDGPU_DOORBELL_MEC_RING3               =3D 0x013,
+       AMDGPU_DOORBELL_MEC_RING4               =3D 0x014,
+       AMDGPU_DOORBELL_MEC_RING5               =3D 0x015,
+       AMDGPU_DOORBELL_MEC_RING6               =3D 0x016,
+       AMDGPU_DOORBELL_MEC_RING7               =3D 0x017,
+       AMDGPU_DOORBELL_GFX_RING0               =3D 0x020,
+       AMDGPU_DOORBELL_sDMA_ENGINE0            =3D 0x1E0,
+       AMDGPU_DOORBELL_sDMA_ENGINE1            =3D 0x1E1,
+       AMDGPU_DOORBELL_IH                      =3D 0x1E8,
+       AMDGPU_DOORBELL_MAX_ASSIGNMENT          =3D 0x3FF,
+       AMDGPU_DOORBELL_INVALID                 =3D 0xFFFF
+} AMDGPU_DOORBELL_ASSIGNMENT;
+
+typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
+{
+       /* Compute + GFX: 0~255 */
+       AMDGPU_VEGA20_DOORBELL_KIQ                     =3D 0x000,
+       AMDGPU_VEGA20_DOORBELL_HIQ                     =3D 0x001,
+       AMDGPU_VEGA20_DOORBELL_DIQ                     =3D 0x002,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING0               =3D 0x003,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING1               =3D 0x004,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING2               =3D 0x005,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING3               =3D 0x006,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING4               =3D 0x007,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING5               =3D 0x008,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING6               =3D 0x009,
+       AMDGPU_VEGA20_DOORBELL_MEC_RING7               =3D 0x00A,
+       AMDGPU_VEGA20_DOORBELL_USERQUEUE_START         =3D 0x00B,
+       AMDGPU_VEGA20_DOORBELL_USERQUEUE_END           =3D 0x08A,
+       AMDGPU_VEGA20_DOORBELL_GFX_RING0               =3D 0x08B,
+       /* SDMA:256~335*/
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE0            =3D 0x100,
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE1            =3D 0x10A,
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE2            =3D 0x114,
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE3            =3D 0x11E,
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE4            =3D 0x128,
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE5            =3D 0x132,
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE6            =3D 0x13C,
+       AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE7            =3D 0x146,
+       /* IH: 376~391 */
+       AMDGPU_VEGA20_DOORBELL_IH                      =3D 0x178,
+       /* MMSCH: 392~407
+        * overlap the doorbell assignment with VCN as they are  mutually e=
xclusive
+        * VCE engine's doorbell is 32 bit and two VCE ring share one QWORD
+        */
+       AMDGPU_VEGA20_DOORBELL64_VCN0_1                  =3D 0x188, /* lowe=
r 32 bits for VNC0 and upper 32 bits for VNC1 */
+       AMDGPU_VEGA20_DOORBELL64_VCN2_3                  =3D 0x189,
+       AMDGPU_VEGA20_DOORBELL64_VCN4_5                  =3D 0x18A,
+       AMDGPU_VEGA20_DOORBELL64_VCN6_7                  =3D 0x18B,
+
+       AMDGPU_VEGA20_DOORBELL64_UVD_RING0_1             =3D 0x188,
+       AMDGPU_VEGA20_DOORBELL64_UVD_RING2_3             =3D 0x189,
+       AMDGPU_VEGA20_DOORBELL64_UVD_RING4_5             =3D 0x18A,
+       AMDGPU_VEGA20_DOORBELL64_UVD_RING6_7             =3D 0x18B,
+
+       AMDGPU_VEGA20_DOORBELL64_VCE_RING0_1             =3D 0x18C,
+       AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3             =3D 0x18D,
+       AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5             =3D 0x18E,
+       AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7             =3D 0x18F,
+       AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            =3D 0x18F,
+       AMDGPU_VEGA20_DOORBELL_INVALID                   =3D 0xFFFF
+} AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
+
+/*
+ * 64bit doorbell, offset are in QWORD, occupy 2KB doorbell space
+ */
+typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
+{
+       /*
+        * All compute related doorbells: kiq, hiq, diq, traditional comput=
e queue, user queue, should locate in
+        * a continues range so that programming CP_MEC_DOORBELL_RANGE_LOWE=
R/UPPER can cover this range.
+        *  Compute related doorbells are allocated from 0x00 to 0x8a
+        */
+
+
+       /* kernel scheduling */
+       AMDGPU_DOORBELL64_KIQ                     =3D 0x00,
+
+       /* HSA interface queue and debug queue */
+       AMDGPU_DOORBELL64_HIQ                     =3D 0x01,
+       AMDGPU_DOORBELL64_DIQ                     =3D 0x02,
+
+       /* Compute engines */
+       AMDGPU_DOORBELL64_MEC_RING0               =3D 0x03,
+       AMDGPU_DOORBELL64_MEC_RING1               =3D 0x04,
+       AMDGPU_DOORBELL64_MEC_RING2               =3D 0x05,
+       AMDGPU_DOORBELL64_MEC_RING3               =3D 0x06,
+       AMDGPU_DOORBELL64_MEC_RING4               =3D 0x07,
+       AMDGPU_DOORBELL64_MEC_RING5               =3D 0x08,
+       AMDGPU_DOORBELL64_MEC_RING6               =3D 0x09,
+       AMDGPU_DOORBELL64_MEC_RING7               =3D 0x0a,
+
+       /* User queue doorbell range (128 doorbells) */
+       AMDGPU_DOORBELL64_USERQUEUE_START         =3D 0x0b,
+       AMDGPU_DOORBELL64_USERQUEUE_END           =3D 0x8a,
+
+       /* Graphics engine */
+       AMDGPU_DOORBELL64_GFX_RING0               =3D 0x8b,
+
+       /*
+        * Other graphics doorbells can be allocated here: from 0x8c to 0xd=
f
+        * Graphics voltage island aperture 1
+        * default non-graphics QWORD index is 0xe0 - 0xFF inclusive
+        */
+
+       /* sDMA engines  reserved from 0xe0 -0xef  */
+       AMDGPU_DOORBELL64_sDMA_ENGINE0            =3D 0xE0,
+       AMDGPU_DOORBELL64_sDMA_HI_PRI_ENGINE0     =3D 0xE1,
+       AMDGPU_DOORBELL64_sDMA_ENGINE1            =3D 0xE8,
+       AMDGPU_DOORBELL64_sDMA_HI_PRI_ENGINE1     =3D 0xE9,
+
+       /* For vega10 sriov, the sdma doorbell must be fixed as follow
+        * to keep the same setting with host driver, or it will
+        * happen conflicts
+        */
+       AMDGPU_VEGA10_DOORBELL64_sDMA_ENGINE0            =3D 0xF0,
+       AMDGPU_VEGA10_DOORBELL64_sDMA_HI_PRI_ENGINE0     =3D 0xF1,
+       AMDGPU_VEGA10_DOORBELL64_sDMA_ENGINE1            =3D 0xF2,
+       AMDGPU_VEGA10_DOORBELL64_sDMA_HI_PRI_ENGINE1     =3D 0xF3,
+
+       /* Interrupt handler */
+       AMDGPU_DOORBELL64_IH                      =3D 0xF4,  /* For legacy =
interrupt ring buffer */
+       AMDGPU_DOORBELL64_IH_RING1                =3D 0xF5,  /* For page mi=
gration request log */
+       AMDGPU_DOORBELL64_IH_RING2                =3D 0xF6,  /* For page mi=
gration translation/invalidation log */
+
+       /* VCN engine use 32 bits doorbell  */
+       AMDGPU_DOORBELL64_VCN0_1                  =3D 0xF8, /* lower 32 bit=
s for VNC0 and upper 32 bits for VNC1 */
+       AMDGPU_DOORBELL64_VCN2_3                  =3D 0xF9,
+       AMDGPU_DOORBELL64_VCN4_5                  =3D 0xFA,
+       AMDGPU_DOORBELL64_VCN6_7                  =3D 0xFB,
+
+       /* overlap the doorbell assignment with VCN as they are  mutually e=
xclusive
+        * VCE engine's doorbell is 32 bit and two VCE ring share one QWORD
+        */
+       AMDGPU_DOORBELL64_UVD_RING0_1             =3D 0xF8,
+       AMDGPU_DOORBELL64_UVD_RING2_3             =3D 0xF9,
+       AMDGPU_DOORBELL64_UVD_RING4_5             =3D 0xFA,
+       AMDGPU_DOORBELL64_UVD_RING6_7             =3D 0xFB,
+
+       AMDGPU_DOORBELL64_VCE_RING0_1             =3D 0xFC,
+       AMDGPU_DOORBELL64_VCE_RING2_3             =3D 0xFD,
+       AMDGPU_DOORBELL64_VCE_RING4_5             =3D 0xFE,
+       AMDGPU_DOORBELL64_VCE_RING6_7             =3D 0xFF,
+
+       AMDGPU_DOORBELL64_MAX_ASSIGNMENT          =3D 0xFF,
+       AMDGPU_DOORBELL64_INVALID                 =3D 0xFFFF
+} AMDGPU_DOORBELL64_ASSIGNMENT;
+
+u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);
+void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
+u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
+void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
+
+#define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
+#define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
+#define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
+#define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), (v))
+
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18098BA4A45681AF186F961EF7D40BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Did you see my other comments abo=
ut consolidating vega10, raven, and vega12?<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt=
;<br>
<b>Sent:</b> Friday, November 23, 2018 3:01:23 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zeng, Oak<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Moved doorbell structures to seperate f=
ile</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Move doorbell structures, enum definitions and hel=
per functions<br>
from amdgpu.h to amdgpu_doorbell.h. No functional change<br>
<br>
Change-Id: I09f7b84869b6d3c688b7a2506ff78d62b3de23f5<br>
Signed-off-by: Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; | 227 &#43;-----------------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 249 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 250 insertions(&#43;), 226 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index e4101b1..7fc32c7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -81,6 &#43;81,7 @@<br>
&nbsp;#include &quot;amdgpu_job.h&quot;<br>
&nbsp;#include &quot;amdgpu_bo_list.h&quot;<br>
&nbsp;#include &quot;amdgpu_gem.h&quot;<br>
&#43;#include &quot;amdgpu_doorbell.h&quot;<br>
&nbsp;<br>
&nbsp;#define MAX_GPU_INSTANCE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16<br>
&nbsp;<br>
@@ -361,173 &#43;362,6 @@ int amdgpu_fence_slab_init(void);<br>
&nbsp;void amdgpu_fence_slab_fini(void);<br>
&nbsp;<br>
&nbsp;/*<br>
- * GPU doorbell structures, functions &amp; helpers<br>
- */<br>
-typedef enum _AMDGPU_DOORBELL_ASSIGNMENT<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_KIQ&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_HIQ&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x001,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_DIQ&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x002,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING0&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x010,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING1&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x011,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING2&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x012,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING3&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x013,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING4&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x014,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING5&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x015,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING6&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x016,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING7&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x017,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_GFX_RING0&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x020,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_sDMA_ENGINE0&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1E0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_sDMA_ENGINE1&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1E1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_IH&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1E8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MAX_ASSIGNMENT&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x3FF,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_INVALID&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 0xFFFF<br>
-} AMDGPU_DOORBELL_ASSIGNMENT;<br>
-<br>
-struct amdgpu_doorbell {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* doorbell mmio */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; base;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 __iomem&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; num_doorbells;&nbsp; /* Number of doorbells actually reserved f=
or amdgpu. */<br>
-};<br>
-<br>
-typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Compute &#43; GFX: 0~255 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_KIQ&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_HIQ&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x001,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_DIQ&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x002,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x003,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING1&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x004,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING2&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x005,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING3&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x006,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING4&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x007,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING5&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x008,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING6&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x009,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING7&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x00A,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_USERQUEUE_STAR=
T&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00B,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_USERQUEUE_END&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x08A,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_GFX_RING0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0x08B,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SDMA:256~335*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE0&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x100,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE1&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x10A,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE2&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x114,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE3&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x11E,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE4&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x128,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE5&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x132,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE6&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x13C,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE7&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x146,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IH: 376~391 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_IH&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x178,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MMSCH: 392~407<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * overlap the doorbell assignme=
nt with VCN as they are&nbsp; mutually exclusive<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VCE engine's doorbell is 32 b=
it and two VCE ring share one QWORD<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN0_1&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 0x188, /* lower 32 bits for VNC0 and upper 32 bit=
s for VNC1 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN2_3&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 0x189,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN4_5&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 0x18A,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN6_7&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 0x18B,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING0_1&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x188,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING2_3&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x189,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING4_5&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x18A,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING6_7&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x18B,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING0_1&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x18C,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x18D,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x18E,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x18F,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18=
F,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_INVALID&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFFFF<br>
-} AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;<br>
-<br>
-/*<br>
- * 64bit doorbell, offset are in QWORD, occupy 2KB doorbell space<br>
- */<br>
-typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * All compute related doorbells=
: kiq, hiq, diq, traditional compute queue, user queue, should locate in<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * a continues range so that pro=
gramming CP_MEC_DOORBELL_RANGE_LOWER/UPPER can cover this range.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; Compute related doorbel=
ls are allocated from 0x00 to 0x8a<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* kernel scheduling */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_KIQ&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HSA interface queue and debug queu=
e */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_HIQ&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x01,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_DIQ&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x02,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Compute engines */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING0&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x03,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING1&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x04,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING2&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x05,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING3&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x06,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING4&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x07,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING5&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x08,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING6&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x09,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING7&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x0a,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* User queue doorbell range (128 doo=
rbells) */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_USERQUEUE_START&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0b,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_USERQUEUE_END&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x8a,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Graphics engine */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_GFX_RING0&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x8b,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Other graphics doorbells can =
be allocated here: from 0x8c to 0xdf<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Graphics voltage island apert=
ure 1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * default non-graphics QWORD in=
dex is 0xe0 - 0xFF inclusive<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sDMA engines&nbsp; reserved from 0=
xe0 -0xef&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_ENGINE0&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_HI_PRI_ENGINE0=
&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_ENGINE1&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_HI_PRI_ENGINE1=
&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE9,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For vega10 sriov, the sdma doorbel=
l must be fixed as follow<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to keep the same setting with=
 host driver, or it will<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * happen conflicts<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_ENGINE0=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF0=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_HI_PRI_=
ENGINE0&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_ENGINE1=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF2=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_HI_PRI_=
ENGINE1&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF3,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Interrupt handler */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_IH&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF4,&nbsp; /* For legacy interrupt =
ring buffer */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_IH_RING1&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0xF5,&nbsp; /* For page migration request log */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_IH_RING2&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0xF6,&nbsp; /* For page migration translation/invalidation log */<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VCN engine use 32 bits doorbell&nb=
sp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN0_1&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 0xF8, /* lower 32 bits for VNC0 and upper 32 bits for VN=
C1 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN2_3&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 0xF9,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN4_5&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 0xFA,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN6_7&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 0xFB,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* overlap the doorbell assignment wi=
th VCN as they are&nbsp; mutually exclusive<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VCE engine's doorbell is 32 b=
it and two VCE ring share one QWORD<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING0_1&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF8,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING2_3&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF9,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING4_5&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFA,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING6_7&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFB,<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING0_1&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFC,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING2_3&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFD,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING4_5&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFE,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING6_7&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFF,<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MAX_ASSIGNMENT&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFF,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_INVALID&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =3D 0xFFFF<br>
-} AMDGPU_DOORBELL64_ASSIGNMENT;<br>
-<br>
-/*<br>
&nbsp; * IRQS.<br>
&nbsp; */<br>
&nbsp;<br>
@@ -863,55 &#43;697,6 @@ struct amd_powerplay {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pp_feature;<br>
&nbsp;};<br>
&nbsp;<br>
-/* Reserved doorbells for amdgpu (including multimedia).<br>
- * KFD can use all the rest in the 2M doorbell bar.<br>
- * For asic before vega10, doorbell is 32-bit, so the<br>
- * index/offset is in dword. For vega10 and after, doorbell<br>
- * can be 64-bit, so the index defined is in qword.<br>
- */<br>
-struct amdgpu_doorbell_index {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t kiq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring5;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring6;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring7;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t userqueue_start;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t userqueue_end;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_ring0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine5;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine6;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine7;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ih;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn_rin=
g0_1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn_rin=
g2_3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn_rin=
g4_5;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn_rin=
g6_7;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } vcn;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd_rin=
g0_1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd_rin=
g2_3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd_rin=
g4_5;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd_rin=
g6_7;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce_rin=
g0_1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce_rin=
g2_3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce_rin=
g4_5;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce_rin=
g6_7;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } uvd_vce;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_assignment;<br>
-};<br>
-<br>
&nbsp;#define AMDGPU_RESET_MAGIC_NUM 64<br>
&nbsp;struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *dev;<br>
@@ -1150,11 &#43;935,6 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *ade=
v, uint32_t offset);<br>
&nbsp;u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg);<br>
&nbsp;void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v);<br>
&nbsp;<br>
-u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);<br>
-void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);<br=
>
-u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);<br>
-void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);<=
br>
-<br>
&nbsp;bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);=
<br>
&nbsp;bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);<br>
&nbsp;<br>
@@ -1216,11 &#43;996,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev)=
;<br>
&nbsp;#define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))<br>
&nbsp;#define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))<br>
&nbsp;<br>
-#define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))<br>
-#define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))<br>
-#define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))<br>
-#define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), (v))<br=
>
-<br>
&nbsp;#define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT<br>
&nbsp;#define REG_FIELD_MASK(reg, field) reg##__##field##_MASK<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_doorbell.h<br>
new file mode 100644<br>
index 0000000..708ac73<br>
--- /dev/null<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
@@ -0,0 &#43;1,249 @@<br>
&#43;/*<br>
&#43; * Copyright 2018 Advanced Micro Devices, Inc.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded in<br>
&#43; * all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS OR<br>
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR<br>
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,<br>
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR<br>
&#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&#43; *<br>
&#43; */<br>
&#43;<br>
&#43;/*<br>
&#43; * GPU doorbell structures, functions &amp; helpers<br>
&#43; */<br>
&#43;struct amdgpu_doorbell {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* doorbell mmio */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 __iomem&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; num_doorbells;&nbsp; /* Number of doorbells actually reserv=
ed for amdgpu. */<br>
&#43;};<br>
&#43;<br>
&#43;/* Reserved doorbells for amdgpu (including multimedia).<br>
&#43; * KFD can use all the rest in the 2M doorbell bar.<br>
&#43; * For asic before vega10, doorbell is 32-bit, so the<br>
&#43; * index/offset is in dword. For vega10 and after, doorbell<br>
&#43; * can be 64-bit, so the index defined is in qword.<br>
&#43; */<br>
&#43;struct amdgpu_doorbell_index {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t kiq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring6;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring7;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t userqueue_start;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t userqueue_end;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_ring0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine6;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine7;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ih;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn=
_ring0_1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn=
_ring2_3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn=
_ring4_5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vcn=
_ring6_7;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } vcn;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd=
_ring0_1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd=
_ring2_3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd=
_ring4_5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd=
_ring6_7;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce=
_ring0_1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce=
_ring2_3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce=
_ring4_5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce=
_ring6_7;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } uvd_vce;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_assignment;<br>
&#43;};<br>
&#43;<br>
&#43;typedef enum _AMDGPU_DOORBELL_ASSIGNMENT<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_KIQ&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x000,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_HIQ&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x001,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_DIQ&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x002,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING0&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x010,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING1&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x011,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING2&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x012,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING3&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x013,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING4&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x014,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING5&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x015,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING6&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x016,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RING7&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x017,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_GFX_RING0&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x020,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_sDMA_ENGINE0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1E0,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_sDMA_ENGINE1&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1E1,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_IH&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1E8,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MAX_ASSIGNMENT&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x3FF,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_INVALID&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D 0xFFFF<br>
&#43;} AMDGPU_DOORBELL_ASSIGNMENT;<br>
&#43;<br>
&#43;typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Compute &#43; GFX: 0~255 */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_KIQ&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x000,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_HIQ&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x001,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_DIQ&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x002,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING0&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x003,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING1&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x004,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING2&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x005,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING3&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x006,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING4&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x007,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING5&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x008,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING6&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x009,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MEC_RING7&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x00A,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_USERQUEUE_=
START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00B,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_USERQUEUE_=
END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x08A,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_GFX_RING0&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x08B,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SDMA:256~335*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
100,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
10A,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
114,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
11E,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
128,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
132,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
13C,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_sDMA_ENGIN=
E7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
146,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IH: 376~391 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_IH&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x178,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MMSCH: 392~407<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * overlap the doorbell assi=
gnment with VCN as they are&nbsp; mutually exclusive<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VCE engine's doorbell is =
32 bit and two VCE ring share one QWORD<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN0_1&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x188, /* lower 32 bits for VNC0 and upper 32=
 bits for VNC1 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN2_3&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x189,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN4_5&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18A,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCN6_7&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18B,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING=
0_1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x188,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING=
2_3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x189,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING=
4_5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x18A,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_UVD_RING=
6_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x18B,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING=
0_1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x18C,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING=
2_3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x18D,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING=
4_5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x18E,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE_RING=
6_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x18F,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MAX_ASSIGN=
MENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x18F,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_INVALID&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFFFF<br>
&#43;} AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;<br>
&#43;<br>
&#43;/*<br>
&#43; * 64bit doorbell, offset are in QWORD, occupy 2KB doorbell space<br>
&#43; */<br>
&#43;typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * All compute related doorb=
ells: kiq, hiq, diq, traditional compute queue, user queue, should locate i=
n<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * a continues range so that=
 programming CP_MEC_DOORBELL_RANGE_LOWER/UPPER can cover this range.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; Compute related doo=
rbells are allocated from 0x00 to 0x8a<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* kernel scheduling */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_KIQ&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HSA interface queue and debug =
queue */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_HIQ&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x01,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_DIQ&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x02,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Compute engines */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING0&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x03,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING1&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x04,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING2&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x05,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING3&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x06,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING4&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x07,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING5&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x08,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING6&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x09,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MEC_RING7&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x0a,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* User queue doorbell range (128=
 doorbells) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_USERQUEUE_START=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0b,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_USERQUEUE_END&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x8a,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Graphics engine */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_GFX_RING0&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x8b,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Other graphics doorbells =
can be allocated here: from 0x8c to 0xdf<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Graphics voltage island a=
perture 1<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * default non-graphics QWOR=
D index is 0xe0 - 0xFF inclusive<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sDMA engines&nbsp; reserved fr=
om 0xe0 -0xef&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_ENGINE0&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE0,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_HI_PRI_ENG=
INE0&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE1,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_ENGINE1&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE8,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_sDMA_HI_PRI_ENG=
INE1&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xE9,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For vega10 sriov, the sdma doo=
rbell must be fixed as follow<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to keep the same setting =
with host driver, or it will<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * happen conflicts<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_ENG=
INE0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0xF0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_HI_=
PRI_ENGINE0&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF1,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_ENG=
INE1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0xF2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA10_DOORBELL64_sDMA_HI_=
PRI_ENGINE1&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF3,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Interrupt handler */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_IH&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF4,&nbsp; /* For legacy interr=
upt ring buffer */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_IH_RING1&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0xF5,&nbsp; /* For page migration request log */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_IH_RING2&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0xF6,&nbsp; /* For page migration translation/invalidation log=
 */<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VCN engine use 32 bits doorbel=
l&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN0_1&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 0xF8, /* lower 32 bits for VNC0 and upper 32 bits fo=
r VNC1 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN2_3&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 0xF9,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN4_5&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 0xFA,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCN6_7&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 0xFB,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* overlap the doorbell assignmen=
t with VCN as they are&nbsp; mutually exclusive<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VCE engine's doorbell is =
32 bit and two VCE ring share one QWORD<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING0_1&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
F8,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING2_3&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
F9,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING4_5&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
FA,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_UVD_RING6_7&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
FB,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING0_1&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
FC,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING2_3&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
FD,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING4_5&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
FE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING6_7&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x=
FF,<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MAX_ASSIGNMENT&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFF,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_INVALID&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 0xFFFF<br>
&#43;} AMDGPU_DOORBELL64_ASSIGNMENT;<br>
&#43;<br>
&#43;u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);<br>
&#43;void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)=
;<br>
&#43;u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);<br>
&#43;void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 =
v);<br>
&#43;<br>
&#43;#define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))<br>
&#43;#define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))<=
br>
&#43;#define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))<br>
&#43;#define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), (v)=
)<br>
&#43;<br>
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

--_000_BN6PR12MB18098BA4A45681AF186F961EF7D40BN6PR12MB1809namp_--

--===============1223489315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1223489315==--
