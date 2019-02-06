From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Improve doorbell variable names
Date: Wed, 6 Feb 2019 15:55:52 +0000
Message-ID: <SN1PR12MB2365312DF1DC8162D69C44C5F06F0@SN1PR12MB2365.namprd12.prod.outlook.com>
References: <20190206154921.14463-1-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0698174539=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190206154921.14463-1-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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

--===============0698174539==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2365312DF1DC8162D69C44C5F06F0SN1PR12MB2365namp_"

--_000_SN1PR12MB2365312DF1DC8162D69C44C5F06F0SN1PR12MB2365namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I only add the corresponding changes for IH, but not for GFX as GFX does no=
t use the similar range functions.

Regards,
Yong
________________________________
From: Zhao, Yong
Sent: Wednesday, February 6, 2019 10:49 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhao, Yong
Subject: [PATCH 1/3] drm/amdgpu: Improve doorbell variable names

Indicate that the doorbell offset and range is in dwords.

Change-Id: Ib0f2564ffa7b1940ffb8725cdc03f662184f5436
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c       | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/soc15.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c        |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c |  6 +++++-
 12 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index d67f8b1dfe80..88b3bbcea756 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -642,13 +642,13 @@ struct amdgpu_nbio_funcs {
         void (*hdp_flush)(struct amdgpu_device *adev, struct amdgpu_ring *=
ring);
         u32 (*get_memsize)(struct amdgpu_device *adev);
         void (*sdma_doorbell_range)(struct amdgpu_device *adev, int instan=
ce,
-                       bool use_doorbell, int doorbell_index, int doorbell=
_size);
+                       bool use_doorbell, int index_in_dw, int range_dw_si=
ze);
         void (*enable_doorbell_aperture)(struct amdgpu_device *adev,
                                          bool enable);
         void (*enable_doorbell_selfring_aperture)(struct amdgpu_device *ad=
ev,
                                                   bool enable);
         void (*ih_doorbell_range)(struct amdgpu_device *adev,
-                                 bool use_doorbell, int doorbell_index);
+                                 bool use_doorbell, int index_in_dw);
         void (*update_medium_grain_clock_gating)(struct amdgpu_device *ade=
v,
                                                  bool enable);
         void (*update_medium_grain_light_sleep)(struct amdgpu_device *adev=
,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_doorbell.h
index 1cfec06f81d4..5c8d04c353d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -39,6 +39,7 @@ struct amdgpu_doorbell {
  * can be 64-bit, so the index defined is in qword.
  */
 struct amdgpu_doorbell_index {
+       uint32_t entry_dw_size;
         uint32_t kiq;
         uint32_t mec_ring0;
         uint32_t mec_ring1;
@@ -73,7 +74,7 @@ struct amdgpu_doorbell_index {
         };
         uint32_t max_assignment;
         /* Per engine SDMA doorbell size in dword */
-       uint32_t sdma_doorbell_range;
+       uint32_t dw_range_per_sdma_eng;
 };

 typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ih.h
index 1ccb1831382a..2572191b394a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -33,7 +33,7 @@ struct amdgpu_iv_entry;
 struct amdgpu_ih_ring {
         unsigned                ring_size;
         uint32_t                ptr_mask;
-       u32                     doorbell_index;
+       u32                     doorbell_idx_in_dw;
         bool                    use_doorbell;
         bool                    use_bus_addr;

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v6_1.c
index cc967dbfd631..bcc41c957b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -68,7 +68,7 @@ static u32 nbio_v6_1_get_memsize(struct amdgpu_device *ad=
ev)
 }

 static void nbio_v6_1_sdma_doorbell_range(struct amdgpu_device *adev, int =
instance,
-                       bool use_doorbell, int doorbell_index, int doorbell=
_size)
+                       bool use_doorbell, int index_in_dw, int range_dw_si=
ze)
 {
         u32 reg =3D instance =3D=3D 0 ? SOC15_REG_OFFSET(NBIO, 0, mmBIF_SD=
MA0_DOORBELL_RANGE) :
                         SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA1_DOORBELL_RAN=
GE);
@@ -76,8 +76,8 @@ static void nbio_v6_1_sdma_doorbell_range(struct amdgpu_d=
evice *adev, int instan
         u32 doorbell_range =3D RREG32(reg);

         if (use_doorbell) {
-               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, OFFSET, doorbell_index);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, doorbell_size);
+               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, OFFSET, index_in_dw);
+               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, range_dw_size);
         } else
                 doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0=
_DOORBELL_RANGE, SIZE, 0);

@@ -112,12 +112,12 @@ static void nbio_v6_1_enable_doorbell_selfring_apertu=
re(struct amdgpu_device *ad


 static void nbio_v6_1_ih_doorbell_range(struct amdgpu_device *adev,
-                                       bool use_doorbell, int doorbell_ind=
ex)
+                                       bool use_doorbell, int index_in_dw)
 {
         u32 ih_doorbell_range =3D RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL=
_RANGE);

         if (use_doorbell) {
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_=
IH_DOORBELL_RANGE, OFFSET, doorbell_index);
+               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_=
IH_DOORBELL_RANGE, OFFSET, index_in_dw);
                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF=
_IH_DOORBELL_RANGE, SIZE, 2);
         } else
                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF=
_IH_DOORBELL_RANGE, SIZE, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_0.c
index 1cdb98ad2db3..02a9093b464a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -67,7 +67,7 @@ static u32 nbio_v7_0_get_memsize(struct amdgpu_device *ad=
ev)
 }

 static void nbio_v7_0_sdma_doorbell_range(struct amdgpu_device *adev, int =
instance,
-                       bool use_doorbell, int doorbell_index, int doorbell=
_size)
+                       bool use_doorbell, int index_in_dw, int range_dw_si=
ze)
 {
         u32 reg =3D instance =3D=3D 0 ? SOC15_REG_OFFSET(NBIO, 0, mmBIF_SD=
MA0_DOORBELL_RANGE) :
                         SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA1_DOORBELL_RAN=
GE);
@@ -75,8 +75,8 @@ static void nbio_v7_0_sdma_doorbell_range(struct amdgpu_d=
evice *adev, int instan
         u32 doorbell_range =3D RREG32(reg);

         if (use_doorbell) {
-               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, OFFSET, doorbell_index);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, doorbell_size);
+               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, OFFSET, index_in_dw);
+               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, range_dw_size);
         } else
                 doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0=
_DOORBELL_RANGE, SIZE, 0);

@@ -96,12 +96,12 @@ static void nbio_v7_0_enable_doorbell_selfring_aperture=
(struct amdgpu_device *ad
 }

 static void nbio_v7_0_ih_doorbell_range(struct amdgpu_device *adev,
-                                       bool use_doorbell, int doorbell_ind=
ex)
+                                       bool use_doorbell, int index_in_dw)
 {
         u32 ih_doorbell_range =3D RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL=
_RANGE);

         if (use_doorbell) {
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_=
IH_DOORBELL_RANGE, OFFSET, doorbell_index);
+               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_=
IH_DOORBELL_RANGE, OFFSET, index_in_dw);
                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF=
_IH_DOORBELL_RANGE, SIZE, 2);
         } else
                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF=
_IH_DOORBELL_RANGE, SIZE, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 221f26e50322..c32a5bd055d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -65,7 +65,7 @@ static u32 nbio_v7_4_get_memsize(struct amdgpu_device *ad=
ev)
 }

 static void nbio_v7_4_sdma_doorbell_range(struct amdgpu_device *adev, int =
instance,
-                       bool use_doorbell, int doorbell_index, int doorbell=
_size)
+                       bool use_doorbell, int index_in_dw, int range_dw_si=
ze)
 {
         u32 reg =3D instance =3D=3D 0 ? SOC15_REG_OFFSET(NBIO, 0, mmBIF_SD=
MA0_DOORBELL_RANGE) :
                         SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA1_DOORBELL_RAN=
GE);
@@ -73,8 +73,8 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdgpu_d=
evice *adev, int instan
         u32 doorbell_range =3D RREG32(reg);

         if (use_doorbell) {
-               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, OFFSET, doorbell_index);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, doorbell_size);
+               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, OFFSET, index_in_dw);
+               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, range_dw_size);
         } else
                 doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0=
_DOORBELL_RANGE, SIZE, 0);

@@ -107,12 +107,12 @@ static void nbio_v7_4_enable_doorbell_selfring_apertu=
re(struct amdgpu_device *ad
 }

 static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
-                                       bool use_doorbell, int doorbell_ind=
ex)
+                                       bool use_doorbell, int index_in_dw)
 {
         u32 ih_doorbell_range =3D RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL=
_RANGE);

         if (use_doorbell) {
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_=
IH_DOORBELL_RANGE, OFFSET, doorbell_index);
+               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_=
IH_DOORBELL_RANGE, OFFSET, index_in_dw);
                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF=
_IH_DOORBELL_RANGE, SIZE, 2);
         } else
                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF=
_IH_DOORBELL_RANGE, SIZE, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 127b85983e8f..e65e9bc52bd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1520,7 +1520,8 @@ static int sdma_v4_0_sw_init(void *handle)
                                 ring->use_doorbell?"true":"false");

                 /* doorbell size is 2 dwords, get DWORD offset */
-               ring->doorbell_index =3D adev->doorbell_index.sdma_engine[i=
] << 1;
+               ring->doorbell_index =3D adev->doorbell_index.sdma_engine[i=
]
+                               * adev->doorbell_index.entry_dw_size;

                 sprintf(ring->name, "sdma%d", i);
                 r =3D amdgpu_ring_init(adev, ring, 1024,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 99ebcf29dcb0..fbf4dde22f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -980,11 +980,11 @@ static void soc15_doorbell_range_init(struct amdgpu_d=
evice *adev)
                 ring =3D &adev->sdma.instance[i].ring;
                 adev->nbio_funcs->sdma_doorbell_range(adev, i,
                         ring->use_doorbell, ring->doorbell_index,
-                       adev->doorbell_index.sdma_doorbell_range);
+                       adev->doorbell_index.dw_range_per_sdma_eng);
         }

         adev->nbio_funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbel=
l,
-                                               adev->irq.ih.doorbell_index=
);
+                                               adev->irq.ih.doorbell_idx_i=
n_dw);
 }

 static int soc15_common_hw_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/am=
dgpu/tonga_ih.c
index a20b711a6756..96403ec5c98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -143,7 +143,7 @@ static int tonga_ih_irq_init(struct amdgpu_device *adev=
)
         ih_doorbell_rtpr =3D RREG32(mmIH_DOORBELL_RPTR);
         if (adev->irq.ih.use_doorbell) {
                 ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr, IH_DO=
ORBELL_RPTR,
-                                                OFFSET, adev->irq.ih.doorb=
ell_index);
+                                                OFFSET, adev->irq.ih.doorb=
ell_idx_in_dw);
                 ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr, IH_DO=
ORBELL_RPTR,
                                                  ENABLE, 1);
         } else {
@@ -254,7 +254,7 @@ static void tonga_ih_set_rptr(struct amdgpu_device *ade=
v,
         if (ih->use_doorbell) {
                 /* XXX check if swapping is necessary on BE */
                 *ih->rptr_cpu =3D ih->rptr;
-               WDOORBELL32(ih->doorbell_index, ih->rptr);
+               WDOORBELL32(ih->doorbell_idx_in_dw, ih->rptr);
         } else {
                 WREG32(mmIH_RB_RPTR, ih->rptr);
         }
@@ -284,7 +284,7 @@ static int tonga_ih_sw_init(void *handle)
                 return r;

         adev->irq.ih.use_doorbell =3D true;
-       adev->irq.ih.doorbell_index =3D adev->doorbell_index.ih;
+       adev->irq.ih.doorbell_idx_in_dw =3D adev->doorbell_index.ih;

         r =3D amdgpu_irq_init(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c
index 6d1f804277f8..796004896661 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -184,7 +184,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *ade=
v)
         if (adev->irq.ih.use_doorbell) {
                 ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
                                                  IH_DOORBELL_RPTR, OFFSET,
-                                                adev->irq.ih.doorbell_inde=
x);
+                                                adev->irq.ih.doorbell_idx_=
in_dw);
                 ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
                                                  IH_DOORBELL_RPTR,
                                                  ENABLE, 1);
@@ -377,7 +377,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device *ad=
ev,
         if (ih->use_doorbell) {
                 /* XXX check if swapping is necessary on BE */
                 *ih->rptr_cpu =3D ih->rptr;
-               WDOORBELL32(ih->doorbell_index, ih->rptr);
+               WDOORBELL32(ih->doorbell_idx_in_dw, ih->rptr);
         } else if (ih =3D=3D &adev->irq.ih) {
                 WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
         } else if (ih =3D=3D &adev->irq.ih1) {
@@ -461,7 +461,7 @@ static int vega10_ih_sw_init(void *handle)

         /* TODO add doorbell for IH1 & IH2 as well */
         adev->irq.ih.use_doorbell =3D true;
-       adev->irq.ih.doorbell_index =3D adev->doorbell_index.ih << 1;
+       adev->irq.ih.doorbell_idx_in_dw =3D adev->doorbell_index.ih << 1;

         r =3D amdgpu_irq_init(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega10_reg_init.c
index 4b5d60ea3e78..d2409df2dde9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
@@ -58,6 +58,7 @@ int vega10_reg_base_init(struct amdgpu_device *adev)

 void vega10_doorbell_index_init(struct amdgpu_device *adev)
 {
+       adev->doorbell_index.entry_dw_size =3D 2;
         adev->doorbell_index.kiq =3D AMDGPU_DOORBELL64_KIQ;
         adev->doorbell_index.mec_ring0 =3D AMDGPU_DOORBELL64_MEC_RING0;
         adev->doorbell_index.mec_ring1 =3D AMDGPU_DOORBELL64_MEC_RING1;
@@ -83,6 +84,9 @@ void vega10_doorbell_index_init(struct amdgpu_device *ade=
v)
         adev->doorbell_index.uvd_vce.vce_ring6_7 =3D AMDGPU_DOORBELL64_VCE=
_RING6_7;
         /* In unit of dword doorbell */
         adev->doorbell_index.max_assignment =3D AMDGPU_DOORBELL64_MAX_ASSI=
GNMENT << 1;
-       adev->doorbell_index.sdma_doorbell_range =3D 4;
+       adev->doorbell_index.dw_range_per_sdma_eng =3D
+                       (adev->doorbell_index.sdma_engine[1]
+                       - adev->doorbell_index.sdma_engine[0])
+                       * adev->doorbell_index.entry_dw_size;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega20_reg_init.c
index 53716c593b2b..b28c5999d8f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
@@ -56,6 +56,7 @@ int vega20_reg_base_init(struct amdgpu_device *adev)

 void vega20_doorbell_index_init(struct amdgpu_device *adev)
 {
+       adev->doorbell_index.entry_dw_size =3D 2;
         adev->doorbell_index.kiq =3D AMDGPU_VEGA20_DOORBELL_KIQ;
         adev->doorbell_index.mec_ring0 =3D AMDGPU_VEGA20_DOORBELL_MEC_RING=
0;
         adev->doorbell_index.mec_ring1 =3D AMDGPU_VEGA20_DOORBELL_MEC_RING=
1;
@@ -86,6 +87,9 @@ void vega20_doorbell_index_init(struct amdgpu_device *ade=
v)
         adev->doorbell_index.uvd_vce.vce_ring4_5 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING4_5;
         adev->doorbell_index.uvd_vce.vce_ring6_7 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING6_7;
         adev->doorbell_index.max_assignment =3D AMDGPU_VEGA20_DOORBELL_MAX=
_ASSIGNMENT << 1;
-       adev->doorbell_index.sdma_doorbell_range =3D 20;
+       adev->doorbell_index.dw_range_per_sdma_eng =3D
+                       (adev->doorbell_index.sdma_engine[1]
+                       - adev->doorbell_index.sdma_engine[0])
+                       * adev->doorbell_index.entry_dw_size;
 }

--
2.17.1


--_000_SN1PR12MB2365312DF1DC8162D69C44C5F06F0SN1PR12MB2365namp_
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
Hi Alex,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I only add the corresponding changes for IH, but not for GFX as GFX does no=
t use the similar range functions.</div>
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
<b>Sent:</b> Wednesday, February 6, 2019 10:49 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhao, Yong<br>
<b>Subject:</b> [PATCH 1/3] drm/amdgpu: Improve doorbell variable names</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Indicate that the doorbell offset and range is in =
dwords.<br>
<br>
Change-Id: Ib0f2564ffa7b1940ffb8725cdc03f662184f5436<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |&nbsp; 3 &#43;&#43;-<br=
>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/tonga_ih.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega10_ih.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c |&nbsp; 6 &#43;&#43;&#43=
;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c |&nbsp; 6 &#43;&#43;&#43=
;&#43;&#43;-<br>
&nbsp;12 files changed, 40 insertions(&#43;), 30 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index d67f8b1dfe80..88b3bbcea756 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -642,13 &#43;642,13 @@ struct amdgpu_nbio_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*hdp_flush)(struct a=
mdgpu_device *adev, struct amdgpu_ring *ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_memsize)(struct =
amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*sdma_doorbell_range=
)(struct amdgpu_device *adev, int instance,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbel=
l, int doorbell_index, int doorbell_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doo=
rbell, int index_in_dw, int range_dw_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*enable_doorbell_ape=
rture)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool enable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*enable_doorbell_sel=
fring_aperture)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 bool enable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*ih_doorbell_range)(=
struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbell, int doorbell=
_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbell, int inde=
x_in_dw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_medium_grain=
_clock_gating)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool =
enable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_medium_grain=
_light_sleep)(struct amdgpu_device *adev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_doorbell.h<br>
index 1cfec06f81d4..5c8d04c353d0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
@@ -39,6 &#43;39,7 @@ struct amdgpu_doorbell {<br>
&nbsp; * can be 64-bit, so the index defined is in qword.<br>
&nbsp; */<br>
&nbsp;struct amdgpu_doorbell_index {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t entry_dw_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t kiq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mec_ring1;<br>
@@ -73,7 &#43;74,7 @@ struct amdgpu_doorbell_index {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_assignment;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Per engine SDMA doorbel=
l size in dword */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_doorbell_range;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t dw_range_per_sdma_eng;<b=
r>
&nbsp;};<br>
&nbsp;<br>
&nbsp;typedef enum _AMDGPU_DOORBELL_ASSIGNMENT<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ih.h<br>
index 1ccb1831382a..2572191b394a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<br>
@@ -33,7 &#43;33,7 @@ struct amdgpu_iv_entry;<br>
&nbsp;struct amdgpu_ih_ring {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pt=
r_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; doorbell_index;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; doorbell_idx_in_dw;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; use_doorbell;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; use_bus_addr;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v6_1.c<br>
index cc967dbfd631..bcc41c957b24 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
@@ -68,7 &#43;68,7 @@ static u32 nbio_v6_1_get_memsize(struct amdgpu_device=
 *adev)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void nbio_v6_1_sdma_doorbell_range(struct amdgpu_device *adev,=
 int instance,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbel=
l, int doorbell_index, int doorbell_size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doo=
rbell, int index_in_dw, int range_dw_size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg =3D instance =3D=
=3D 0 ? SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA0_DOORBELL_RANGE) :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(NBIO, 0, mmBIF_SDMA1_DOORBELL_RANGE);<br>
@@ -76,8 &#43;76,8 @@ static void nbio_v6_1_sdma_doorbell_range(struct amdg=
pu_device *adev, int instan<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 doorbell_range =3D RRE=
G32(reg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORB=
ELL_RANGE, OFFSET, doorbell_index);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORB=
ELL_RANGE, SIZE, doorbell_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_D=
OORBELL_RANGE, OFFSET, index_in_dw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_D=
OORBELL_RANGE, SIZE, range_dw_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_=
SDMA0_DOORBELL_RANGE, SIZE, 0);<br>
&nbsp;<br>
@@ -112,12 &#43;112,12 @@ static void nbio_v6_1_enable_doorbell_selfring_ap=
erture(struct amdgpu_device *ad<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;static void nbio_v6_1_ih_doorbell_range(struct amdgpu_device *adev,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool use_doorbell, int doorbell_index)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool use_doorbell, int index_in_dw)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_doorbell_range =3D =
RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL_RANGE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_IH_DO=
ORBELL_RANGE, OFFSET, doorbell_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_I=
H_DOORBELL_RANGE, OFFSET, index_in_dw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range=
, BIF_IH_DOORBELL_RANGE, SIZE, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range=
, BIF_IH_DOORBELL_RANGE, SIZE, 0);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_0.c<br>
index 1cdb98ad2db3..02a9093b464a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
@@ -67,7 &#43;67,7 @@ static u32 nbio_v7_0_get_memsize(struct amdgpu_device=
 *adev)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void nbio_v7_0_sdma_doorbell_range(struct amdgpu_device *adev,=
 int instance,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbel=
l, int doorbell_index, int doorbell_size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doo=
rbell, int index_in_dw, int range_dw_size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg =3D instance =3D=
=3D 0 ? SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA0_DOORBELL_RANGE) :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(NBIO, 0, mmBIF_SDMA1_DOORBELL_RANGE);<br>
@@ -75,8 &#43;75,8 @@ static void nbio_v7_0_sdma_doorbell_range(struct amdg=
pu_device *adev, int instan<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 doorbell_range =3D RRE=
G32(reg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORB=
ELL_RANGE, OFFSET, doorbell_index);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORB=
ELL_RANGE, SIZE, doorbell_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_D=
OORBELL_RANGE, OFFSET, index_in_dw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_D=
OORBELL_RANGE, SIZE, range_dw_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_=
SDMA0_DOORBELL_RANGE, SIZE, 0);<br>
&nbsp;<br>
@@ -96,12 &#43;96,12 @@ static void nbio_v7_0_enable_doorbell_selfring_aper=
ture(struct amdgpu_device *ad<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void nbio_v7_0_ih_doorbell_range(struct amdgpu_device *adev,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool use_doorbell, int doorbell_index)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool use_doorbell, int index_in_dw)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_doorbell_range =3D =
RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL_RANGE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_IH_DO=
ORBELL_RANGE, OFFSET, doorbell_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_I=
H_DOORBELL_RANGE, OFFSET, index_in_dw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range=
, BIF_IH_DOORBELL_RANGE, SIZE, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range=
, BIF_IH_DOORBELL_RANGE, SIZE, 0);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index 221f26e50322..c32a5bd055d9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -65,7 &#43;65,7 @@ static u32 nbio_v7_4_get_memsize(struct amdgpu_device=
 *adev)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void nbio_v7_4_sdma_doorbell_range(struct amdgpu_device *adev,=
 int instance,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbel=
l, int doorbell_index, int doorbell_size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doo=
rbell, int index_in_dw, int range_dw_size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg =3D instance =3D=
=3D 0 ? SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA0_DOORBELL_RANGE) :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(NBIO, 0, mmBIF_SDMA1_DOORBELL_RANGE);<br>
@@ -73,8 &#43;73,8 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdg=
pu_device *adev, int instan<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 doorbell_range =3D RRE=
G32(reg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORB=
ELL_RANGE, OFFSET, doorbell_index);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORB=
ELL_RANGE, SIZE, doorbell_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_D=
OORBELL_RANGE, OFFSET, index_in_dw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_D=
OORBELL_RANGE, SIZE, range_dw_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_=
SDMA0_DOORBELL_RANGE, SIZE, 0);<br>
&nbsp;<br>
@@ -107,12 &#43;107,12 @@ static void nbio_v7_4_enable_doorbell_selfring_ap=
erture(struct amdgpu_device *ad<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool use_doorbell, int doorbell_index)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool use_doorbell, int index_in_dw)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_doorbell_range =3D =
RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL_RANGE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_IH_DO=
ORBELL_RANGE, OFFSET, doorbell_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range, BIF_I=
H_DOORBELL_RANGE, OFFSET, index_in_dw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range=
, BIF_IH_DOORBELL_RANGE, SIZE, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range=
, BIF_IH_DOORBELL_RANGE, SIZE, 0);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 127b85983e8f..e65e9bc52bd4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -1520,7 &#43;1520,8 @@ static int sdma_v4_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;use_doorbell?&quot;true=
&quot;:&quot;false&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* doorbell size is 2 dwords, get DWORD offset */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;doorbell_index =3D adev-&gt;doorbell_index.sdma_engine[=
i] &lt;&lt; 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ring-&gt;doorbell_index =3D adev-&gt;doorbell_index.sdma_eng=
ine[i]<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * adev-&gt;doorbell_index.entry_dw_size=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sprintf(ring-&gt;name, &quot;sdma%d&quot;, i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_init(adev, ring, 1024,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 99ebcf29dcb0..fbf4dde22f6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -980,11 &#43;980,11 @@ static void soc15_doorbell_range_init(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;sdma.instance[i].ring;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio_funcs-&gt;sdma_doorbell_range(adev, i,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;use_doorbell, ring-&gt;doorbell_index,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbel=
l_index.sdma_doorbell_range);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doo=
rbell_index.dw_range_per_sdma_eng);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio_funcs-&gt;ih=
_doorbell_range(adev, adev-&gt;irq.ih.use_doorbell,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.doorbe=
ll_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.do=
orbell_idx_in_dw);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int soc15_common_hw_init(void *handle)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/am=
dgpu/tonga_ih.c<br>
index a20b711a6756..96403ec5c98f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c<br>
@@ -143,7 &#43;143,7 @@ static int tonga_ih_irq_init(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_doorbell_rtpr =3D RREG3=
2(mmIH_DOORBELL_RPTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih.use_do=
orbell) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr, =
IH_DOORBELL_RPTR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET, adev-&gt=
;irq.ih.doorbell_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET, adev=
-&gt;irq.ih.doorbell_idx_in_dw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr, =
IH_DOORBELL_RPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENABL=
E, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -254,7 &#43;254,7 @@ static void tonga_ih_set_rptr(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;use_doorbell) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* XXX check if swapping is necessary on BE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *ih-&gt;rptr_cpu =3D ih-&gt;rptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WDOORBELL32(ih-&gt;doorbell_index, ih-&gt;rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WDOORBELL32(ih-&gt;doorbell_idx_in_dw, ih-&gt;rptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32(mmIH_RB_RPTR, ih-&gt;rptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -284,7 &#43;284,7 @@ static int tonga_ih_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.use_doorbe=
ll =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.doorbell_index =3D ad=
ev-&gt;doorbell_index.ih;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.doorbell_idx_in_d=
w =3D adev-&gt;doorbell_index.ih;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_init(adev=
);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c<br>
index 6d1f804277f8..796004896661 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
@@ -184,7 &#43;184,7 @@ static int vega10_ih_irq_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih.use_do=
orbell) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_DO=
ORBELL_RPTR, OFFSET,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.=
doorbell_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq=
.ih.doorbell_idx_in_dw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_DO=
ORBELL_RPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENABL=
E, 1);<br>
@@ -377,7 &#43;377,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;use_doorbell) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* XXX check if swapping is necessary on BE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *ih-&gt;rptr_cpu =3D ih-&gt;rptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WDOORBELL32(ih-&gt;doorbell_index, ih-&gt;rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WDOORBELL32(ih-&gt;doorbell_idx_in_dw, ih-&gt;rptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ih =3D=3D &amp;=
adev-&gt;irq.ih) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih-&gt;rptr);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ih =3D=3D &amp;=
adev-&gt;irq.ih1) {<br>
@@ -461,7 &#43;461,7 @@ static int vega10_ih_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO add doorbell for I=
H1 &amp; IH2 as well */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.use_doorbe=
ll =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.doorbell_index =3D ad=
ev-&gt;doorbell_index.ih &lt;&lt; 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.doorbell_idx_in_d=
w =3D adev-&gt;doorbell_index.ih &lt;&lt; 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_init(adev=
);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega10_reg_init.c<br>
index 4b5d60ea3e78..d2409df2dde9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
@@ -58,6 &#43;58,7 @@ int vega10_reg_base_init(struct amdgpu_device *adev)<=
br>
&nbsp;<br>
&nbsp;void vega10_doorbell_index_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.entry_dw_=
size =3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ki=
q =3D AMDGPU_DOORBELL64_KIQ;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.me=
c_ring0 =3D AMDGPU_DOORBELL64_MEC_RING0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.me=
c_ring1 =3D AMDGPU_DOORBELL64_MEC_RING1;<br>
@@ -83,6 &#43;84,9 @@ void vega10_doorbell_index_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring6_7 =3D AMDGPU_DOORBELL64_VCE_RING6_7;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In unit of dword doorbe=
ll */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ma=
x_assignment =3D AMDGPU_DOORBELL64_MAX_ASSIGNMENT &lt;&lt; 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma_doorbell=
_range =3D 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.dw_range_=
per_sdma_eng =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;do=
orbell_index.sdma_engine[1]<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - adev-&gt;d=
oorbell_index.sdma_engine[0])<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * adev-&gt;d=
oorbell_index.entry_dw_size;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gpu/drm=
/amd/amdgpu/vega20_reg_init.c<br>
index 53716c593b2b..b28c5999d8f0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
@@ -56,6 &#43;56,7 @@ int vega20_reg_base_init(struct amdgpu_device *adev)<=
br>
&nbsp;<br>
&nbsp;void vega20_doorbell_index_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.entry_dw_=
size =3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ki=
q =3D AMDGPU_VEGA20_DOORBELL_KIQ;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.me=
c_ring0 =3D AMDGPU_VEGA20_DOORBELL_MEC_RING0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.me=
c_ring1 =3D AMDGPU_VEGA20_DOORBELL_MEC_RING1;<br>
@@ -86,6 &#43;87,9 @@ void vega20_doorbell_index_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring4_5 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uv=
d_vce.vce_ring6_7 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ma=
x_assignment =3D AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT &lt;&lt; 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma_doorbell=
_range =3D 20;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.dw_range_=
per_sdma_eng =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;do=
orbell_index.sdma_engine[1]<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - adev-&gt;d=
oorbell_index.sdma_engine[0])<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * adev-&gt;d=
oorbell_index.entry_dw_size;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB2365312DF1DC8162D69C44C5F06F0SN1PR12MB2365namp_--

--===============0698174539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0698174539==--
