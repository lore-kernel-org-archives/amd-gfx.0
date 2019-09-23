From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Use better name for sdma queue non HWS
 path
Date: Mon, 23 Sep 2019 12:42:34 +0000
Message-ID: <BN6PR12MB1809E4E9AA68A11DD89D8992F7850@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190923035634.13152-1-Yong.Zhao@amd.com>,
 <20190923035634.13152-2-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1060505394=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190923035634.13152-2-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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

--===============1060505394==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809E4E9AA68A11DD89D8992F7850BN6PR12MB1809namp_"

--_000_BN6PR12MB1809E4E9AA68A11DD89D8992F7850BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhao, Yo=
ng <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Sent: Sunday, September 22, 2019 11:56 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdkfd: Use better name for sdma queue non HWS pat=
h

The old name is prone to confusion. The register offset is for a RLC queue
rather than a SDMA engine. The value is not a base address, but a
register offset.

Change-Id: I55fb835f2105392344b1c17323bb55c03f927836
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 85 +++++++++---------
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 90 +++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 10 +--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 10 +--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 86 +++++++++---------
 5 files changed, 137 insertions(+), 144 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index c9ce1516956e..d2c0666c2798 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -70,11 +70,11 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mq=
d)
         return (struct v9_sdma_mqd *)mqd;
 }

-static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,
+static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,
                                 unsigned int engine_id,
                                 unsigned int queue_id)
 {
-       uint32_t base[8] =3D {
+       uint32_t sdma_engine_reg_base[8] =3D {
                 SOC15_REG_OFFSET(SDMA0, 0,
                                  mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL,
                 SOC15_REG_OFFSET(SDMA1, 0,
@@ -92,12 +92,11 @@ static uint32_t get_sdma_base_addr(struct amdgpu_device=
 *adev,
                 SOC15_REG_OFFSET(SDMA7, 0,
                                  mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_C=
NTL
         };
-       uint32_t retval;

-       retval =3D base[engine_id] + queue_id * (mmSDMA0_RLC1_RB_CNTL -
-                                              mmSDMA0_RLC0_RB_CNTL);
+       uint32_t retval =3D sdma_engine_reg_base[engine_id]
+               + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);

-       pr_debug("sdma base address: 0x%x\n", retval);
+       pr_debug("RLC register offset: 0x%x\n", retval);

         return retval;
 }
@@ -107,22 +106,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v9_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         unsigned long end_jiffies;
         uint32_t data;
         uint64_t data64;
         uint64_t __user *wptr64 =3D (uint64_t __user *)wptr;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
                 m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));

         end_jiffies =3D msecs_to_jiffies(2000) + jiffies;
         while (true) {
-               data =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
+               data =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
                 if (data & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
                         break;
                 if (time_after(jiffies, end_jiffies))
@@ -130,41 +129,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
                 usleep_range(500, 1000);
         }

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL_OFFSET,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL_OFFSET,
                m->sdmax_rlcx_doorbell_offset);

         data =3D REG_SET_FIELD(m->sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL=
,
                              ENABLE, 1);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, data);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, data);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI,
                                 m->sdmax_rlcx_rb_rptr_hi);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
         if (read_user_wptr(mm, wptr64, data64)) {
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
                        lower_32_bits(data64));
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
                        upper_32_bits(data64));
         } else {
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
                        m->sdmax_rlcx_rb_rptr);
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
                        m->sdmax_rlcx_rb_rptr_hi);
         }
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE_HI,
                         m->sdmax_rlcx_rb_base_hi);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
                         m->sdmax_rlcx_rb_rptr_addr_lo);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
                         m->sdmax_rlcx_rb_rptr_addr_hi);

         data =3D REG_SET_FIELD(m->sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,
                              RB_ENABLE, 1);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, data);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, data);

         return 0;
 }
@@ -174,7 +173,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
                              uint32_t (**dump)[2], uint32_t *n_regs)
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
-       uint32_t sdma_base_addr =3D get_sdma_base_addr(adev, engine_id, que=
ue_id);
+       uint32_t rlc_reg_offset =3D get_rlc_reg_offset(adev, engine_id, que=
ue_id);
         uint32_t i =3D 0, reg;
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+10)
@@ -184,15 +183,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
                 return -ENOMEM;

         for (reg =3D mmSDMA0_RLC0_RB_CNTL; reg <=3D mmSDMA0_RLC0_DOORBELL;=
 reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_STATUS; reg <=3D mmSDMA0_RLC0_CSA_ADDR_H=
I; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_IB_SUB_REMAIN;
              reg <=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_MIDCMD_DATA0;
              reg <=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);

         WARN_ON_ONCE(i !=3D HQD_N_REGS);
         *n_regs =3D i;
@@ -204,14 +203,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *=
kgd, void *mqd)
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v9_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         uint32_t sdma_rlc_rb_cntl;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
+       sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);

         if (sdma_rlc_rb_cntl & SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)
                 return true;
@@ -224,20 +223,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v9_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         uint32_t temp;
         unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
+       temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
         temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, temp);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, temp);

         while (true) {
-               temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
+               temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
                 if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
                         break;
                 if (time_after(jiffies, end_jiffies))
@@ -245,14 +244,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
                 usleep_range(500, 1000);
         }

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, 0);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
-               RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL) |
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, 0);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
+               RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL) |
                 SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);

-       m->sdmax_rlcx_rb_rptr =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_R=
PTR);
+       m->sdmax_rlcx_rb_rptr =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_R=
PTR);
         m->sdmax_rlcx_rb_rptr_hi =3D
-               RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI);
+               RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI);

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index a4325db8d093..ee520ad90717 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -307,11 +307,11 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, u=
int32_t pipe_id)
         return 0;
 }

-static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,
+static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,
                                 unsigned int engine_id,
                                 unsigned int queue_id)
 {
-       uint32_t base[2] =3D {
+       uint32_t sdma_engine_reg_base[2] =3D {
                 SOC15_REG_OFFSET(SDMA0, 0,
                                  mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL,
                 /* On gfx10, mmSDMA1_xxx registers are defined NOT based
@@ -323,12 +323,11 @@ static uint32_t get_sdma_base_addr(struct amdgpu_devi=
ce *adev,
                 SOC15_REG_OFFSET(SDMA1, 0,
                                  mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL
         };
-       uint32_t retval;

-       retval =3D base[engine_id] + queue_id * (mmSDMA0_RLC1_RB_CNTL -
-                                              mmSDMA0_RLC0_RB_CNTL);
+       uint32_t retval =3D sdma_engine_reg_base[engine_id]
+               + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);

-       pr_debug("sdma base address: 0x%x\n", retval);
+       pr_debug("RLC register offset: 0x%x\n", retval);

         return retval;
 }
@@ -489,23 +488,23 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v10_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         unsigned long end_jiffies;
         uint32_t data;
         uint64_t data64;
         uint64_t __user *wptr64 =3D (uint64_t __user *)wptr;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);
-       pr_debug("sdma load base addr %x for engine %d, queue %d\n", sdma_b=
ase_addr, m->sdma_engine_id, m->sdma_queue_id);
+       pr_debug("sdma load base addr 0x%x for engine %d, queue %d\n", rlc_=
reg_offset, m->sdma_engine_id, m->sdma_queue_id);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
                 m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));

         end_jiffies =3D msecs_to_jiffies(2000) + jiffies;
         while (true) {
-               data =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
+               data =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
                 if (data & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
                         break;
                 if (time_after(jiffies, end_jiffies))
@@ -513,41 +512,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
                 usleep_range(500, 1000);
         }

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL_OFFSET,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL_OFFSET,
                m->sdmax_rlcx_doorbell_offset);

         data =3D REG_SET_FIELD(m->sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL=
,
                              ENABLE, 1);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, data);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, data);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI,
                                 m->sdmax_rlcx_rb_rptr_hi);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
         if (read_user_wptr(mm, wptr64, data64)) {
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
                        lower_32_bits(data64));
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
                        upper_32_bits(data64));
         } else {
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
                        m->sdmax_rlcx_rb_rptr);
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
                        m->sdmax_rlcx_rb_rptr_hi);
         }
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE_HI,
                         m->sdmax_rlcx_rb_base_hi);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
                         m->sdmax_rlcx_rb_rptr_addr_lo);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
                         m->sdmax_rlcx_rb_rptr_addr_hi);

         data =3D REG_SET_FIELD(m->sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,
                              RB_ENABLE, 1);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, data);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, data);

         return 0;
 }
@@ -557,28 +556,25 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
                              uint32_t (**dump)[2], uint32_t *n_regs)
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
-       uint32_t sdma_base_addr =3D get_sdma_base_addr(adev, engine_id, que=
ue_id);
+       uint32_t rlc_reg_offset =3D get_rlc_reg_offset(adev, engine_id, que=
ue_id);
         uint32_t i =3D 0, reg;
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+10)

-       pr_debug("sdma dump engine id %d queue_id %d\n", engine_id, queue_i=
d);
-       pr_debug("sdma base addr %x\n", sdma_base_addr);
-
         *dump =3D kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
         if (*dump =3D=3D NULL)
                 return -ENOMEM;

         for (reg =3D mmSDMA0_RLC0_RB_CNTL; reg <=3D mmSDMA0_RLC0_DOORBELL;=
 reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_STATUS; reg <=3D mmSDMA0_RLC0_CSA_ADDR_H=
I; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_IB_SUB_REMAIN;
              reg <=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_MIDCMD_DATA0;
              reg <=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);

         WARN_ON_ONCE(i !=3D HQD_N_REGS);
         *n_regs =3D i;
@@ -612,14 +608,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *=
kgd, void *mqd)
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v10_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         uint32_t sdma_rlc_rb_cntl;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
+       sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);

         if (sdma_rlc_rb_cntl & SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)
                 return true;
@@ -740,20 +736,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v10_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         uint32_t temp;
         unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
+       temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
         temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, temp);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, temp);

         while (true) {
-               temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
+               temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
                 if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
                         break;
                 if (time_after(jiffies, end_jiffies))
@@ -761,14 +757,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
                 usleep_range(500, 1000);
         }

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, 0);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
-               RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL) |
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, 0);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
+               RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL) |
                 SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);

-       m->sdmax_rlcx_rb_rptr =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_R=
PTR);
+       m->sdmax_rlcx_rb_rptr =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_R=
PTR);
         m->sdmax_rlcx_rb_rptr_hi =3D
-               RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI);
+               RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI);

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index c6abcf72e822..d0517b7ae089 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -303,14 +303,14 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, u=
int32_t pipe_id)
         return 0;
 }

-static inline uint32_t get_sdma_base_addr(struct cik_sdma_rlc_registers *m=
)
+static inline uint32_t get_rlc_reg_offset(struct cik_sdma_rlc_registers *m=
)
 {
         uint32_t retval;

         retval =3D m->sdma_engine_id * SDMA1_REGISTER_OFFSET +
                         m->sdma_queue_id * KFD_CIK_SDMA_QUEUE_OFFSET;

-       pr_debug("sdma base address: 0x%x\n", retval);
+       pr_debug("RLC register offset: 0x%x\n", retval);

         return retval;
 }
@@ -417,7 +417,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void =
*mqd,
         uint32_t data;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(m);
+       sdma_base_addr =3D get_rlc_reg_offset(m);

         WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
                 m->sdma_rlc_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK=
));
@@ -528,7 +528,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kg=
d, void *mqd)
         uint32_t sdma_rlc_rb_cntl;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(m);
+       sdma_base_addr =3D get_rlc_reg_offset(m);

         sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL)=
;

@@ -650,7 +650,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, vo=
id *mqd,
         unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(m);
+       sdma_base_addr =3D get_rlc_reg_offset(m);

         temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
         temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 4e8b4e949926..373501abdb6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -260,13 +260,13 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, u=
int32_t pipe_id)
         return 0;
 }

-static inline uint32_t get_sdma_base_addr(struct vi_sdma_mqd *m)
+static inline uint32_t get_rlc_reg_offset(struct vi_sdma_mqd *m)
 {
         uint32_t retval;

         retval =3D m->sdma_engine_id * SDMA1_REGISTER_OFFSET +
                 m->sdma_queue_id * KFD_VI_SDMA_QUEUE_OFFSET;
-       pr_debug("sdma base address: 0x%x\n", retval);
+       pr_debug("RLC register offset: 0x%x\n", retval);

         return retval;
 }
@@ -402,7 +402,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void =
*mqd,
         uint32_t data;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(m);
+       sdma_base_addr =3D get_rlc_reg_offset(m);
         WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
                 m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));

@@ -521,7 +521,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kg=
d, void *mqd)
         uint32_t sdma_rlc_rb_cntl;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(m);
+       sdma_base_addr =3D get_rlc_reg_offset(m);

         sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL)=
;

@@ -646,7 +646,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, vo=
id *mqd,
         unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(m);
+       sdma_base_addr =3D get_rlc_reg_offset(m);

         temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
         temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 55437f160a72..2dd5bc676029 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -226,22 +226,20 @@ int kgd_gfx_v9_init_interrupts(struct kgd_dev *kgd, u=
int32_t pipe_id)
         return 0;
 }

-static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,
+static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,
                                 unsigned int engine_id,
                                 unsigned int queue_id)
 {
-       uint32_t base[2] =3D {
+       uint32_t sdma_engine_reg_base[2] =3D {
                 SOC15_REG_OFFSET(SDMA0, 0,
                                  mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL,
                 SOC15_REG_OFFSET(SDMA1, 0,
                                  mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_C=
NTL
         };
-       uint32_t retval;
+       uint32_t retval =3D sdma_engine_reg_base[engine_id]
+               + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);

-       retval =3D base[engine_id] + queue_id * (mmSDMA0_RLC1_RB_CNTL -
-                                              mmSDMA0_RLC0_RB_CNTL);
-
-       pr_debug("sdma base address: 0x%x\n", retval);
+       pr_debug("RLC register offset: 0x%x\n", retval);

         return retval;
 }
@@ -388,22 +386,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v9_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         unsigned long end_jiffies;
         uint32_t data;
         uint64_t data64;
         uint64_t __user *wptr64 =3D (uint64_t __user *)wptr;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
                 m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));

         end_jiffies =3D msecs_to_jiffies(2000) + jiffies;
         while (true) {
-               data =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
+               data =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
                 if (data & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
                         break;
                 if (time_after(jiffies, end_jiffies))
@@ -411,41 +409,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
                 usleep_range(500, 1000);
         }

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL_OFFSET,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL_OFFSET,
                m->sdmax_rlcx_doorbell_offset);

         data =3D REG_SET_FIELD(m->sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL=
,
                              ENABLE, 1);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, data);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, data);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI,
                                 m->sdmax_rlcx_rb_rptr_hi);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
         if (read_user_wptr(mm, wptr64, data64)) {
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
                        lower_32_bits(data64));
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
                        upper_32_bits(data64));
         } else {
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
                        m->sdmax_rlcx_rb_rptr);
-               WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
+               WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
                        m->sdmax_rlcx_rb_rptr_hi);
         }
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE_HI,
                         m->sdmax_rlcx_rb_base_hi);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
                         m->sdmax_rlcx_rb_rptr_addr_lo);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
                         m->sdmax_rlcx_rb_rptr_addr_hi);

         data =3D REG_SET_FIELD(m->sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,
                              RB_ENABLE, 1);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, data);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, data);

         return 0;
 }
@@ -455,7 +453,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
                              uint32_t (**dump)[2], uint32_t *n_regs)
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
-       uint32_t sdma_base_addr =3D get_sdma_base_addr(adev, engine_id, que=
ue_id);
+       uint32_t rlc_reg_offset =3D get_rlc_reg_offset(adev, engine_id, que=
ue_id);
         uint32_t i =3D 0, reg;
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+10)
@@ -465,15 +463,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
                 return -ENOMEM;

         for (reg =3D mmSDMA0_RLC0_RB_CNTL; reg <=3D mmSDMA0_RLC0_DOORBELL;=
 reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_STATUS; reg <=3D mmSDMA0_RLC0_CSA_ADDR_H=
I; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_IB_SUB_REMAIN;
              reg <=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);
         for (reg =3D mmSDMA0_RLC0_MIDCMD_DATA0;
              reg <=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg++)
-               DUMP_REG(sdma_base_addr + reg);
+               DUMP_REG(rlc_reg_offset + reg);

         WARN_ON_ONCE(i !=3D HQD_N_REGS);
         *n_regs =3D i;
@@ -507,14 +505,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *=
kgd, void *mqd)
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v9_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         uint32_t sdma_rlc_rb_cntl;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
+       sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);

         if (sdma_rlc_rb_cntl & SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)
                 return true;
@@ -577,20 +575,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
         struct v9_sdma_mqd *m;
-       uint32_t sdma_base_addr;
+       uint32_t rlc_reg_offset;
         uint32_t temp;
         unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;

         m =3D get_sdma_mqd(mqd);
-       sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
+       rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
                                             m->sdma_queue_id);

-       temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
+       temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
         temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, temp);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, temp);

         while (true) {
-               temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
+               temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
                 if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
                         break;
                 if (time_after(jiffies, end_jiffies))
@@ -598,14 +596,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
                 usleep_range(500, 1000);
         }

-       WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, 0);
-       WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
-               RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL) |
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, 0);
+       WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
+               RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL) |
                 SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);

-       m->sdmax_rlcx_rb_rptr =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_R=
PTR);
+       m->sdmax_rlcx_rb_rptr =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_R=
PTR);
         m->sdmax_rlcx_rb_rptr_hi =3D
-               RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI);
+               RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI);

         return 0;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809E4E9AA68A11DD89D8992F7850BN6PR12MB1809namp_
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
Series is:</div>
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
<b>Sent:</b> Sunday, September 22, 2019 11:56 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: Use better name for sdma queue non =
HWS path</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The old name is prone to confusion. The register o=
ffset is for a RLC queue<br>
rather than a SDMA engine. The value is not a base address, but a<br>
register offset.<br>
<br>
Change-Id: I55fb835f2105392344b1c17323bb55c03f927836<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c&nbsp;&nbsp; | 85 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp;&nbsp;&nbsp; | 90 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 10 &#43;--<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 10 &#43;--<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 86 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;5 files changed, 137 insertions(&#43;), 144 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
index c9ce1516956e..d2c0666c2798 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
@@ -70,11 &#43;70,11 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void=
 *mqd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct v9_sdma_mqd=
 *)mqd;<br>
&nbsp;}<br>
&nbsp;<br>
-static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,<br>
&#43;static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t base[8] =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[8] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA0, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mm=
SDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA1, 0,<br>
@@ -92,12 &#43;92,11 @@ static uint32_t get_sdma_base_addr(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA7, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA7_RLC0_RB_CNTL) - mm=
SDMA7_RLC0_RB_CNTL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D base[engine_id] &#43; queu=
e_id * (mmSDMA0_RLC1_RB_CNTL -<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_r=
eg_base[engine_id]<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &#43; queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNT=
L);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%=
x\n&quot;, retval);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offse=
t: 0x%x\n&quot;, retval);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;}<br>
@@ -107,22 &#43;106,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd,=
 void *mqd,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t data64;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *wptr64 =
=3D (uint64_t __user *)wptr;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__=
RB_ENABLE_MASK));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D msecs_to_j=
iffies(2000) &#43; jiffies;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_ST=
ATUS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (data &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
@@ -130,41 &#43;129,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd,=
 void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL_OFFSET,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL_OFFSET,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL, data);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_MINOR_PTR_UPDATE, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_MINOR_PTR_UPDATE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_user_wptr(mm, wpt=
r64, data64)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bi=
ts(data64));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts(data64));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax=
_rlcx_rb_rptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax=
_rlcx_rb_rptr_hi);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_MINOR_PTR_UPDATE, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_MINOR_PTR_UPDATE, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_BASE_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_BASE_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_base_hi);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_ADDR_LO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_rptr_addr_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_ADDR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_rptr_addr_hi);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL, data);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -174,7 &#43;173,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (**dump)[2], uint32_t *n_regs)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr =3D get_sdma_=
base_addr(adev, engine_id, queue_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset =3D get_r=
lc_reg_offset(adev, engine_id, queue_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0, reg;<br>
&nbsp;#undef HQD_N_REGS<br>
&nbsp;#define HQD_N_REGS (19&#43;6&#43;7&#43;10)<br>
@@ -184,15 &#43;183,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
RB_CNTL; reg &lt;=3D mmSDMA0_RLC0_DOORBELL; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
STATUS; reg &lt;=3D mmSDMA0_RLC0_CSA_ADDR_HI; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
IB_SUB_REMAIN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg &lt;=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
MIDCMD_DATA0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg &lt;=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(i !=3D HQD_N_=
REGS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n_regs =3D i;<br>
@@ -204,14 &#43;203,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_d=
ev *kgd, void *mqd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(sdma_base=
_addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(rlc_r=
eg_offset &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdma_rlc_rb_cntl &amp;=
 SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -224,20 &#43;223,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *k=
gd, void *mqd,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; =
mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#=
43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0=
_RLC0_RB_CNTL__RB_ENABLE_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL, temp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL, temp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_ST=
ATUS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (temp &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
@@ -245,14 &#43;244,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *k=
gd, void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(s=
dma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG=
32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_h=
i =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
index a4325db8d093..ee520ad90717 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
@@ -307,11 &#43;307,11 @@ static int kgd_init_interrupts(struct kgd_dev *kg=
d, uint32_t pipe_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,<br>
&#43;static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t base[2] =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[2] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA0, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mm=
SDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* On gfx10, mmSDMA1_xxx registers are defined NOT ba=
sed<br>
@@ -323,12 &#43;323,11 @@ static uint32_t get_sdma_base_addr(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA1, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mm=
SDMA0_RLC0_RB_CNTL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D base[engine_id] &#43; queu=
e_id * (mmSDMA0_RLC1_RB_CNTL -<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_r=
eg_base[engine_id]<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &#43; queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNT=
L);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%=
x\n&quot;, retval);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offse=
t: 0x%x\n&quot;, retval);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;}<br>
@@ -489,23 &#43;488,23 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd,=
 void *mqd,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v10_sdma_mqd *m;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t data64;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *wptr64 =
=3D (uint64_t __user *)wptr;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma load base addr %x=
 for engine %d, queue %d\n&quot;, sdma_base_addr, m-&gt;sdma_engine_id, m-&=
gt;sdma_queue_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma load base add=
r 0x%x for engine %d, queue %d\n&quot;, rlc_reg_offset, m-&gt;sdma_engine_i=
d, m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__=
RB_ENABLE_MASK));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D msecs_to_j=
iffies(2000) &#43; jiffies;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_ST=
ATUS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (data &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
@@ -513,41 &#43;512,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd,=
 void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL_OFFSET,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL_OFFSET,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL, data);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_MINOR_PTR_UPDATE, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_MINOR_PTR_UPDATE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_user_wptr(mm, wpt=
r64, data64)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bi=
ts(data64));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts(data64));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax=
_rlcx_rb_rptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax=
_rlcx_rb_rptr_hi);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_MINOR_PTR_UPDATE, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_MINOR_PTR_UPDATE, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_BASE_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_BASE_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_base_hi);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_ADDR_LO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_rptr_addr_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_ADDR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_rptr_addr_hi);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL, data);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -557,28 &#43;556,25 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (**dump)[2], uint32_t *n_regs)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr =3D get_sdma_=
base_addr(adev, engine_id, queue_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset =3D get_r=
lc_reg_offset(adev, engine_id, queue_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0, reg;<br>
&nbsp;#undef HQD_N_REGS<br>
&nbsp;#define HQD_N_REGS (19&#43;6&#43;7&#43;10)<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma dump engine id %d=
 queue_id %d\n&quot;, engine_id, queue_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base addr %x\n&qu=
ot;, sdma_base_addr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dump =3D kmalloc(HQD_N_RE=
GS*2*sizeof(uint32_t), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*dump =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
RB_CNTL; reg &lt;=3D mmSDMA0_RLC0_DOORBELL; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
STATUS; reg &lt;=3D mmSDMA0_RLC0_CSA_ADDR_HI; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
IB_SUB_REMAIN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg &lt;=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
MIDCMD_DATA0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg &lt;=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(i !=3D HQD_N_=
REGS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n_regs =3D i;<br>
@@ -612,14 &#43;608,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_d=
ev *kgd, void *mqd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v10_sdma_mqd *m;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(sdma_base=
_addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(rlc_r=
eg_offset &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdma_rlc_rb_cntl &amp;=
 SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -740,20 &#43;736,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *k=
gd, void *mqd,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v10_sdma_mqd *m;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; =
mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#=
43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0=
_RLC0_RB_CNTL__RB_ENABLE_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL, temp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL, temp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_ST=
ATUS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (temp &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
@@ -761,14 &#43;757,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *k=
gd, void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(s=
dma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG=
32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_h=
i =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
index c6abcf72e822..d0517b7ae089 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
@@ -303,14 &#43;303,14 @@ static int kgd_init_interrupts(struct kgd_dev *kg=
d, uint32_t pipe_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static inline uint32_t get_sdma_base_addr(struct cik_sdma_rlc_registers *m=
)<br>
&#43;static inline uint32_t get_rlc_reg_offset(struct cik_sdma_rlc_register=
s *m)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D m-&gt;sdma_engi=
ne_id * SDMA1_REGISTER_OFFSET &#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdma_queue_id * KFD_CIK_SDMA_QUEUE_OFFSET;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%=
x\n&quot;, retval);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offse=
t: 0x%x\n&quot;, retval);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;}<br>
@@ -417,7 &#43;417,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(m);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_of=
fset(m);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43=
; mmSDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_rlc_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__RB=
_ENABLE_MASK));<br>
@@ -528,7 &#43;528,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev=
 *kgd, void *mqd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(m);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_of=
fset(m);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG3=
2(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;<br>
@@ -650,7 &#43;650,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(m);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_of=
fset(m);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_=
addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0=
_RLC0_RB_CNTL__RB_ENABLE_MASK;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
index 4e8b4e949926..373501abdb6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
@@ -260,13 &#43;260,13 @@ static int kgd_init_interrupts(struct kgd_dev *kg=
d, uint32_t pipe_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static inline uint32_t get_sdma_base_addr(struct vi_sdma_mqd *m)<br>
&#43;static inline uint32_t get_rlc_reg_offset(struct vi_sdma_mqd *m)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D m-&gt;sdma_engi=
ne_id * SDMA1_REGISTER_OFFSET &#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id * KFD_VI_SDMA_QUEUE_OFFSET;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%=
x\n&quot;, retval);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offse=
t: 0x%x\n&quot;, retval);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;}<br>
@@ -402,7 &#43;402,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(m);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_of=
fset(m);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43=
; mmSDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__=
RB_ENABLE_MASK));<br>
&nbsp;<br>
@@ -521,7 &#43;521,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev=
 *kgd, void *mqd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(m);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_of=
fset(m);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG3=
2(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;<br>
@@ -646,7 &#43;646,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(m);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_of=
fset(m);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_=
addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0=
_RLC0_RB_CNTL__RB_ENABLE_MASK;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 55437f160a72..2dd5bc676029 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -226,22 &#43;226,20 @@ int kgd_gfx_v9_init_interrupts(struct kgd_dev *kg=
d, uint32_t pipe_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,<br>
&#43;static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t base[2] =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[2] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA0, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mm=
SDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA1, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mm=
SDMA1_RLC0_RB_CNTL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_r=
eg_base[engine_id]<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &#43; queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNT=
L);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D base[engine_id] &#43; queu=
e_id * (mmSDMA0_RLC1_RB_CNTL -<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%=
x\n&quot;, retval);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offse=
t: 0x%x\n&quot;, retval);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;}<br>
@@ -388,22 &#43;386,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd,=
 void *mqd,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t data64;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *wptr64 =
=3D (uint64_t __user *)wptr;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__=
RB_ENABLE_MASK));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D msecs_to_j=
iffies(2000) &#43; jiffies;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_ST=
ATUS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (data &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
@@ -411,41 &#43;409,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd,=
 void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL_OFFSET,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL_OFFSET,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL, data);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_MINOR_PTR_UPDATE, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_MINOR_PTR_UPDATE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_user_wptr(mm, wpt=
r64, data64)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bi=
ts(data64));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts(data64));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax=
_rlcx_rb_rptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax=
_rlcx_rb_rptr_hi);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_MINOR_PTR_UPDATE, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_MINOR_PTR_UPDATE, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_BASE_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_BASE_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_base_hi);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_ADDR_LO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_rptr_addr_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_RPTR_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_RPTR_ADDR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_rptr_addr_hi);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL, data);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -455,7 &#43;453,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (**dump)[2], uint32_t *n_regs)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr =3D get_sdma_=
base_addr(adev, engine_id, queue_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset =3D get_r=
lc_reg_offset(adev, engine_id, queue_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0, reg;<br>
&nbsp;#undef HQD_N_REGS<br>
&nbsp;#define HQD_N_REGS (19&#43;6&#43;7&#43;10)<br>
@@ -465,15 &#43;463,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
RB_CNTL; reg &lt;=3D mmSDMA0_RLC0_DOORBELL; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
STATUS; reg &lt;=3D mmSDMA0_RLC0_CSA_ADDR_HI; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
IB_SUB_REMAIN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg &lt;=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_=
MIDCMD_DATA0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg &lt;=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(i !=3D HQD_N_=
REGS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n_regs =3D i;<br>
@@ -507,14 &#43;505,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_d=
ev *kgd, void *mqd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(sdma_base=
_addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(rlc_r=
eg_offset &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdma_rlc_rb_cntl &amp;=
 SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -577,20 &#43;575,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *k=
gd, void *mqd,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr=
(adev, m-&gt;sdma_engine_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_of=
fset(adev, m-&gt;sdma_engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; =
mmSDMA0_RLC0_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#=
43; mmSDMA0_RLC0_RB_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0=
_RLC0_RB_CNTL__RB_ENABLE_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL, temp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL, temp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_ST=
ATUS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (temp &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
@@ -598,14 &#43;596,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *k=
gd, void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_DOORBELL, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_R=
LC0_RB_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_DOORBELL, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDM=
A0_RLC0_RB_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(s=
dma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG=
32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_h=
i =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
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

--_000_BN6PR12MB1809E4E9AA68A11DD89D8992F7850BN6PR12MB1809namp_--

--===============1060505394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1060505394==--
