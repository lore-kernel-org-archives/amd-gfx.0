From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Use better name for sdma queue non HWS
 path
Date: Mon, 23 Sep 2019 17:37:53 +0000
Message-ID: <DM6PR12MB27784ED82D2680435D20248FF0850@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20190923035634.13152-1-Yong.Zhao@amd.com>
 <20190923035634.13152-2-Yong.Zhao@amd.com>,
 <e4c54eb2-0ee0-8b74-d1d5-5a2680f891e9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1082155872=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e4c54eb2-0ee0-8b74-d1d5-5a2680f891e9-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1082155872==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB27784ED82D2680435D20248FF0850DM6PR12MB2778namp_"

--_000_DM6PR12MB27784ED82D2680435D20248FF0850DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Okay, I will incorporate Shaoyun's input.

Yong
________________________________
From: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 23, 2019 10:27 AM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Use better name for sdma queue non HWS=
 path

Probably rename to sdma_rlc to avoid the  confusion of  rlc used in
other amdgpu driver .

Regards

shaoyun.liu

On 2019-09-22 11:56 p.m., Zhao, Yong wrote:
> The old name is prone to confusion. The register offset is for a RLC queu=
e
> rather than a SDMA engine. The value is not a base address, but a
> register offset.
>
> Change-Id: I55fb835f2105392344b1c17323bb55c03f927836
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 85 +++++++++---------
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 90 +++++++++----------
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 10 +--
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 10 +--
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 86 +++++++++---------
>   5 files changed, 137 insertions(+), 144 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index c9ce1516956e..d2c0666c2798 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -70,11 +70,11 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *=
mqd)
>        return (struct v9_sdma_mqd *)mqd;
>   }
>
> -static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,
> +static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,
>                                unsigned int engine_id,
>                                unsigned int queue_id)
>   {
> -     uint32_t base[8] =3D {
> +     uint32_t sdma_engine_reg_base[8] =3D {
>                SOC15_REG_OFFSET(SDMA0, 0,
>                                 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL,
>                SOC15_REG_OFFSET(SDMA1, 0,
> @@ -92,12 +92,11 @@ static uint32_t get_sdma_base_addr(struct amdgpu_devi=
ce *adev,
>                SOC15_REG_OFFSET(SDMA7, 0,
>                                 mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_C=
NTL
>        };
> -     uint32_t retval;
>
> -     retval =3D base[engine_id] + queue_id * (mmSDMA0_RLC1_RB_CNTL -
> -                                            mmSDMA0_RLC0_RB_CNTL);
> +     uint32_t retval =3D sdma_engine_reg_base[engine_id]
> +             + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
>
> -     pr_debug("sdma base address: 0x%x\n", retval);
> +     pr_debug("RLC register offset: 0x%x\n", retval);
>
>        return retval;
>   }
> @@ -107,22 +106,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v9_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        unsigned long end_jiffies;
>        uint32_t data;
>        uint64_t data64;
>        uint64_t __user *wptr64 =3D (uint64_t __user *)wptr;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
>                m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));
>
>        end_jiffies =3D msecs_to_jiffies(2000) + jiffies;
>        while (true) {
> -             data =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
> +             data =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
>                if (data & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
>                        break;
>                if (time_after(jiffies, end_jiffies))
> @@ -130,41 +129,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,
>                usleep_range(500, 1000);
>        }
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL_OFFSET,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL_OFFSET,
>               m->sdmax_rlcx_doorbell_offset);
>
>        data =3D REG_SET_FIELD(m->sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL=
,
>                             ENABLE, 1);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, data);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, data);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI,
>                                m->sdmax_rlcx_rb_rptr_hi);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
>        if (read_user_wptr(mm, wptr64, data64)) {
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
>                       lower_32_bits(data64));
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
>                       upper_32_bits(data64));
>        } else {
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
>                       m->sdmax_rlcx_rb_rptr);
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
>                       m->sdmax_rlcx_rb_rptr_hi);
>        }
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE_HI,
>                        m->sdmax_rlcx_rb_base_hi);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
>                        m->sdmax_rlcx_rb_rptr_addr_lo);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
>                        m->sdmax_rlcx_rb_rptr_addr_hi);
>
>        data =3D REG_SET_FIELD(m->sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,
>                             RB_ENABLE, 1);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, data);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, data);
>
>        return 0;
>   }
> @@ -174,7 +173,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
>                             uint32_t (**dump)[2], uint32_t *n_regs)
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> -     uint32_t sdma_base_addr =3D get_sdma_base_addr(adev, engine_id, que=
ue_id);
> +     uint32_t rlc_reg_offset =3D get_rlc_reg_offset(adev, engine_id, que=
ue_id);
>        uint32_t i =3D 0, reg;
>   #undef HQD_N_REGS
>   #define HQD_N_REGS (19+6+7+10)
> @@ -184,15 +183,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
>                return -ENOMEM;
>
>        for (reg =3D mmSDMA0_RLC0_RB_CNTL; reg <=3D mmSDMA0_RLC0_DOORBELL;=
 reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_STATUS; reg <=3D mmSDMA0_RLC0_CSA_ADDR_H=
I; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_IB_SUB_REMAIN;
>             reg <=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_MIDCMD_DATA0;
>             reg <=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>
>        WARN_ON_ONCE(i !=3D HQD_N_REGS);
>        *n_regs =3D i;
> @@ -204,14 +203,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev=
 *kgd, void *mqd)
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v9_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        uint32_t sdma_rlc_rb_cntl;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
> +     sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
>
>        if (sdma_rlc_rb_cntl & SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)
>                return true;
> @@ -224,20 +223,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v9_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        uint32_t temp;
>        unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
> +     temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
>        temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, temp);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, temp);
>
>        while (true) {
> -             temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
> +             temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
>                if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
>                        break;
>                if (time_after(jiffies, end_jiffies))
> @@ -245,14 +244,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,
>                usleep_range(500, 1000);
>        }
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, 0);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
> -             RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL) |
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, 0);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
> +             RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL) |
>                SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);
>
> -     m->sdmax_rlcx_rb_rptr =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_R=
PTR);
> +     m->sdmax_rlcx_rb_rptr =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_R=
PTR);
>        m->sdmax_rlcx_rb_rptr_hi =3D
> -             RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI);
> +             RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI);
>
>        return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index a4325db8d093..ee520ad90717 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -307,11 +307,11 @@ static int kgd_init_interrupts(struct kgd_dev *kgd,=
 uint32_t pipe_id)
>        return 0;
>   }
>
> -static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,
> +static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,
>                                unsigned int engine_id,
>                                unsigned int queue_id)
>   {
> -     uint32_t base[2] =3D {
> +     uint32_t sdma_engine_reg_base[2] =3D {
>                SOC15_REG_OFFSET(SDMA0, 0,
>                                 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL,
>                /* On gfx10, mmSDMA1_xxx registers are defined NOT based
> @@ -323,12 +323,11 @@ static uint32_t get_sdma_base_addr(struct amdgpu_de=
vice *adev,
>                SOC15_REG_OFFSET(SDMA1, 0,
>                                 mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL
>        };
> -     uint32_t retval;
>
> -     retval =3D base[engine_id] + queue_id * (mmSDMA0_RLC1_RB_CNTL -
> -                                            mmSDMA0_RLC0_RB_CNTL);
> +     uint32_t retval =3D sdma_engine_reg_base[engine_id]
> +             + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
>
> -     pr_debug("sdma base address: 0x%x\n", retval);
> +     pr_debug("RLC register offset: 0x%x\n", retval);
>
>        return retval;
>   }
> @@ -489,23 +488,23 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v10_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        unsigned long end_jiffies;
>        uint32_t data;
>        uint64_t data64;
>        uint64_t __user *wptr64 =3D (uint64_t __user *)wptr;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
> -     pr_debug("sdma load base addr %x for engine %d, queue %d\n", sdma_b=
ase_addr, m->sdma_engine_id, m->sdma_queue_id);
> +     pr_debug("sdma load base addr 0x%x for engine %d, queue %d\n", rlc_=
reg_offset, m->sdma_engine_id, m->sdma_queue_id);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
>                m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));
>
>        end_jiffies =3D msecs_to_jiffies(2000) + jiffies;
>        while (true) {
> -             data =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
> +             data =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
>                if (data & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
>                        break;
>                if (time_after(jiffies, end_jiffies))
> @@ -513,41 +512,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,
>                usleep_range(500, 1000);
>        }
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL_OFFSET,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL_OFFSET,
>               m->sdmax_rlcx_doorbell_offset);
>
>        data =3D REG_SET_FIELD(m->sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL=
,
>                             ENABLE, 1);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, data);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, data);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI,
>                                m->sdmax_rlcx_rb_rptr_hi);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
>        if (read_user_wptr(mm, wptr64, data64)) {
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
>                       lower_32_bits(data64));
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
>                       upper_32_bits(data64));
>        } else {
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
>                       m->sdmax_rlcx_rb_rptr);
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
>                       m->sdmax_rlcx_rb_rptr_hi);
>        }
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE_HI,
>                        m->sdmax_rlcx_rb_base_hi);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
>                        m->sdmax_rlcx_rb_rptr_addr_lo);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
>                        m->sdmax_rlcx_rb_rptr_addr_hi);
>
>        data =3D REG_SET_FIELD(m->sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,
>                             RB_ENABLE, 1);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, data);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, data);
>
>        return 0;
>   }
> @@ -557,28 +556,25 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
>                             uint32_t (**dump)[2], uint32_t *n_regs)
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> -     uint32_t sdma_base_addr =3D get_sdma_base_addr(adev, engine_id, que=
ue_id);
> +     uint32_t rlc_reg_offset =3D get_rlc_reg_offset(adev, engine_id, que=
ue_id);
>        uint32_t i =3D 0, reg;
>   #undef HQD_N_REGS
>   #define HQD_N_REGS (19+6+7+10)
>
> -     pr_debug("sdma dump engine id %d queue_id %d\n", engine_id, queue_i=
d);
> -     pr_debug("sdma base addr %x\n", sdma_base_addr);
> -
>        *dump =3D kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
>        if (*dump =3D=3D NULL)
>                return -ENOMEM;
>
>        for (reg =3D mmSDMA0_RLC0_RB_CNTL; reg <=3D mmSDMA0_RLC0_DOORBELL;=
 reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_STATUS; reg <=3D mmSDMA0_RLC0_CSA_ADDR_H=
I; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_IB_SUB_REMAIN;
>             reg <=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_MIDCMD_DATA0;
>             reg <=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>
>        WARN_ON_ONCE(i !=3D HQD_N_REGS);
>        *n_regs =3D i;
> @@ -612,14 +608,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev=
 *kgd, void *mqd)
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v10_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        uint32_t sdma_rlc_rb_cntl;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
> +     sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
>
>        if (sdma_rlc_rb_cntl & SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)
>                return true;
> @@ -740,20 +736,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v10_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        uint32_t temp;
>        unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
> +     temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
>        temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, temp);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, temp);
>
>        while (true) {
> -             temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
> +             temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
>                if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
>                        break;
>                if (time_after(jiffies, end_jiffies))
> @@ -761,14 +757,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,
>                usleep_range(500, 1000);
>        }
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, 0);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
> -             RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL) |
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, 0);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
> +             RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL) |
>                SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);
>
> -     m->sdmax_rlcx_rb_rptr =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_R=
PTR);
> +     m->sdmax_rlcx_rb_rptr =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_R=
PTR);
>        m->sdmax_rlcx_rb_rptr_hi =3D
> -             RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI);
> +             RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI);
>
>        return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index c6abcf72e822..d0517b7ae089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -303,14 +303,14 @@ static int kgd_init_interrupts(struct kgd_dev *kgd,=
 uint32_t pipe_id)
>        return 0;
>   }
>
> -static inline uint32_t get_sdma_base_addr(struct cik_sdma_rlc_registers =
*m)
> +static inline uint32_t get_rlc_reg_offset(struct cik_sdma_rlc_registers =
*m)
>   {
>        uint32_t retval;
>
>        retval =3D m->sdma_engine_id * SDMA1_REGISTER_OFFSET +
>                        m->sdma_queue_id * KFD_CIK_SDMA_QUEUE_OFFSET;
>
> -     pr_debug("sdma base address: 0x%x\n", retval);
> +     pr_debug("RLC register offset: 0x%x\n", retval);
>
>        return retval;
>   }
> @@ -417,7 +417,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
>        uint32_t data;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(m);
> +     sdma_base_addr =3D get_rlc_reg_offset(m);
>
>        WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
>                m->sdma_rlc_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK=
));
> @@ -528,7 +528,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *=
kgd, void *mqd)
>        uint32_t sdma_rlc_rb_cntl;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(m);
> +     sdma_base_addr =3D get_rlc_reg_offset(m);
>
>        sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL)=
;
>
> @@ -650,7 +650,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
>        unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(m);
> +     sdma_base_addr =3D get_rlc_reg_offset(m);
>
>        temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
>        temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index 4e8b4e949926..373501abdb6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -260,13 +260,13 @@ static int kgd_init_interrupts(struct kgd_dev *kgd,=
 uint32_t pipe_id)
>        return 0;
>   }
>
> -static inline uint32_t get_sdma_base_addr(struct vi_sdma_mqd *m)
> +static inline uint32_t get_rlc_reg_offset(struct vi_sdma_mqd *m)
>   {
>        uint32_t retval;
>
>        retval =3D m->sdma_engine_id * SDMA1_REGISTER_OFFSET +
>                m->sdma_queue_id * KFD_VI_SDMA_QUEUE_OFFSET;
> -     pr_debug("sdma base address: 0x%x\n", retval);
> +     pr_debug("RLC register offset: 0x%x\n", retval);
>
>        return retval;
>   }
> @@ -402,7 +402,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, voi=
d *mqd,
>        uint32_t data;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(m);
> +     sdma_base_addr =3D get_rlc_reg_offset(m);
>        WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
>                m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));
>
> @@ -521,7 +521,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *=
kgd, void *mqd)
>        uint32_t sdma_rlc_rb_cntl;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(m);
> +     sdma_base_addr =3D get_rlc_reg_offset(m);
>
>        sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL)=
;
>
> @@ -646,7 +646,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
>        unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(m);
> +     sdma_base_addr =3D get_rlc_reg_offset(m);
>
>        temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
>        temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 55437f160a72..2dd5bc676029 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -226,22 +226,20 @@ int kgd_gfx_v9_init_interrupts(struct kgd_dev *kgd,=
 uint32_t pipe_id)
>        return 0;
>   }
>
> -static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,
> +static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,
>                                unsigned int engine_id,
>                                unsigned int queue_id)
>   {
> -     uint32_t base[2] =3D {
> +     uint32_t sdma_engine_reg_base[2] =3D {
>                SOC15_REG_OFFSET(SDMA0, 0,
>                                 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_C=
NTL,
>                SOC15_REG_OFFSET(SDMA1, 0,
>                                 mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_C=
NTL
>        };
> -     uint32_t retval;
> +     uint32_t retval =3D sdma_engine_reg_base[engine_id]
> +             + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
>
> -     retval =3D base[engine_id] + queue_id * (mmSDMA0_RLC1_RB_CNTL -
> -                                            mmSDMA0_RLC0_RB_CNTL);
> -
> -     pr_debug("sdma base address: 0x%x\n", retval);
> +     pr_debug("RLC register offset: 0x%x\n", retval);
>
>        return retval;
>   }
> @@ -388,22 +386,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v9_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        unsigned long end_jiffies;
>        uint32_t data;
>        uint64_t data64;
>        uint64_t __user *wptr64 =3D (uint64_t __user *)wptr;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
>                m->sdmax_rlcx_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MA=
SK));
>
>        end_jiffies =3D msecs_to_jiffies(2000) + jiffies;
>        while (true) {
> -             data =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
> +             data =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
>                if (data & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
>                        break;
>                if (time_after(jiffies, end_jiffies))
> @@ -411,41 +409,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, v=
oid *mqd,
>                usleep_range(500, 1000);
>        }
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL_OFFSET,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL_OFFSET,
>               m->sdmax_rlcx_doorbell_offset);
>
>        data =3D REG_SET_FIELD(m->sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL=
,
>                             ENABLE, 1);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, data);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, data);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR, m->sdmax_rlcx_rb_rptr=
);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI,
>                                m->sdmax_rlcx_rb_rptr_hi);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 1);
>        if (read_user_wptr(mm, wptr64, data64)) {
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
>                       lower_32_bits(data64));
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
>                       upper_32_bits(data64));
>        } else {
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR,
>                       m->sdmax_rlcx_rb_rptr);
> -             WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR_HI,
> +             WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_WPTR_HI,
>                       m->sdmax_rlcx_rb_rptr_hi);
>        }
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_MINOR_PTR_UPDATE, 0);
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE, m->sdmax_rlcx_rb_base=
);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_BASE_HI,
>                        m->sdmax_rlcx_rb_base_hi);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
>                        m->sdmax_rlcx_rb_rptr_addr_lo);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
>                        m->sdmax_rlcx_rb_rptr_addr_hi);
>
>        data =3D REG_SET_FIELD(m->sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,
>                             RB_ENABLE, 1);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, data);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, data);
>
>        return 0;
>   }
> @@ -455,7 +453,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
>                             uint32_t (**dump)[2], uint32_t *n_regs)
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> -     uint32_t sdma_base_addr =3D get_sdma_base_addr(adev, engine_id, que=
ue_id);
> +     uint32_t rlc_reg_offset =3D get_rlc_reg_offset(adev, engine_id, que=
ue_id);
>        uint32_t i =3D 0, reg;
>   #undef HQD_N_REGS
>   #define HQD_N_REGS (19+6+7+10)
> @@ -465,15 +463,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
>                return -ENOMEM;
>
>        for (reg =3D mmSDMA0_RLC0_RB_CNTL; reg <=3D mmSDMA0_RLC0_DOORBELL;=
 reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_STATUS; reg <=3D mmSDMA0_RLC0_CSA_ADDR_H=
I; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_IB_SUB_REMAIN;
>             reg <=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>        for (reg =3D mmSDMA0_RLC0_MIDCMD_DATA0;
>             reg <=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg++)
> -             DUMP_REG(sdma_base_addr + reg);
> +             DUMP_REG(rlc_reg_offset + reg);
>
>        WARN_ON_ONCE(i !=3D HQD_N_REGS);
>        *n_regs =3D i;
> @@ -507,14 +505,14 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev=
 *kgd, void *mqd)
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v9_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        uint32_t sdma_rlc_rb_cntl;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
> +     sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
>
>        if (sdma_rlc_rb_cntl & SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)
>                return true;
> @@ -577,20 +575,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,
>   {
>        struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
>        struct v9_sdma_mqd *m;
> -     uint32_t sdma_base_addr;
> +     uint32_t rlc_reg_offset;
>        uint32_t temp;
>        unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
>
>        m =3D get_sdma_mqd(mqd);
> -     sdma_base_addr =3D get_sdma_base_addr(adev, m->sdma_engine_id,
> +     rlc_reg_offset =3D get_rlc_reg_offset(adev, m->sdma_engine_id,
>                                            m->sdma_queue_id);
>
> -     temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL);
> +     temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL);
>        temp =3D temp & ~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK;
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL, temp);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL, temp);
>
>        while (true) {
> -             temp =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATU=
S);
> +             temp =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_CONTEXT_STATU=
S);
>                if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
>                        break;
>                if (time_after(jiffies, end_jiffies))
> @@ -598,14 +596,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd=
, void *mqd,
>                usleep_range(500, 1000);
>        }
>
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, 0);
> -     WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
> -             RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL) |
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_DOORBELL, 0);
> +     WREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL,
> +             RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_CNTL) |
>                SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);
>
> -     m->sdmax_rlcx_rb_rptr =3D RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_R=
PTR);
> +     m->sdmax_rlcx_rb_rptr =3D RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_R=
PTR);
>        m->sdmax_rlcx_rb_rptr_hi =3D
> -             RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_HI);
> +             RREG32(rlc_reg_offset + mmSDMA0_RLC0_RB_RPTR_HI);
>
>        return 0;
>   }

--_000_DM6PR12MB27784ED82D2680435D20248FF0850DM6PR12MB2778namp_
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
Okay, I will incorporate Shaoyun's input.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun &lt;Shao=
yun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, September 23, 2019 10:27 AM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdkfd: Use better name for sdma queue =
non HWS path</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Probably rename to sdma_rlc to avoid the&nbsp; con=
fusion of&nbsp; rlc used in
<br>
other amdgpu driver .<br>
<br>
Regards<br>
<br>
shaoyun.liu<br>
<br>
On 2019-09-22 11:56 p.m., Zhao, Yong wrote:<br>
&gt; The old name is prone to confusion. The register offset is for a RLC q=
ueue<br>
&gt; rather than a SDMA engine. The value is not a base address, but a<br>
&gt; register offset.<br>
&gt;<br>
&gt; Change-Id: I55fb835f2105392344b1c17323bb55c03f927836<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c&nbsp;&nbsp; | =
85 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp;&nbsp;&nbs=
p; | 90 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 10 &#43;--=
<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 10 &#43;--=
<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 86 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&gt;&nbsp;&nbsp; 5 files changed, 137 insertions(&#43;), 144 deletions(-)<b=
r>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; index c9ce1516956e..d2c0666c2798 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<=
br>
&gt; @@ -70,11 &#43;70,11 @@ static inline struct v9_sdma_mqd *get_sdma_mqd=
(void *mqd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct v9_sdma_mqd *=
)mqd;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,<br>
&gt; &#43;static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t base[8] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[8] =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA0, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mmSD=
MA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA1, 0,<br>
&gt; @@ -92,12 &#43;92,11 @@ static uint32_t get_sdma_base_addr(struct amdg=
pu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA7, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA7_RLC0_RB_CNTL) - mmSD=
MA7_RLC0_RB_CNTL<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; retval =3D base[engine_id] &#43; queue_id * =
(mmSDMA0_RLC1_RB_CNTL -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_reg_base=
[engine_id]<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &#43; queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%x\n&quo=
t;, retval);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offset: 0x%x=
\n&quot;, retval);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -107,22 &#43;106,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev =
*kgd, void *mqd,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t data64;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *wptr64 =3D =
(uint64_t __user *)wptr;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__RB=
_ENABLE_MASK));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D msecs_to_jif=
fies(2000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (data &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
&gt; @@ -130,41 &#43;129,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev =
*kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL_OFFSET,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&gt=
;sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL, data);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_MIN=
OR_PTR_UPDATE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_MINOR_PTR_UPDATE, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_user_wptr(mm, wptr6=
4, data64)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits=
(data64));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits=
(data64));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_r=
lcx_rb_rptr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_r=
lcx_rb_rptr_hi);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_MIN=
OR_PTR_UPDATE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_MINOR_PTR_UPDATE, 0);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
BASE_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_BASE_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_base_hi);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_ADDR_LO,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_ADDR_LO,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_rptr_addr_lo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_ADDR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_ADDR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_rptr_addr_hi);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&gt=
;sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL, data);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -174,7 &#43;173,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *k=
gd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; uint32_t (**dump)[2], uint32_t *n_regs)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr =3D get_sdma_base_ad=
dr(adev, engine_id, queue_id);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset =3D get_rlc_reg_=
offset(adev, engine_id, queue_id);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0, reg;<br>
&gt;&nbsp;&nbsp; #undef HQD_N_REGS<br>
&gt;&nbsp;&nbsp; #define HQD_N_REGS (19&#43;6&#43;7&#43;10)<br>
&gt; @@ -184,15 &#43;183,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev =
*kgd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_RB=
_CNTL; reg &lt;=3D mmSDMA0_RLC0_DOORBELL; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_ST=
ATUS; reg &lt;=3D mmSDMA0_RLC0_CSA_ADDR_HI; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_IB=
_SUB_REMAIN;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg &lt;=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_MI=
DCMD_DATA0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg &lt;=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(i !=3D HQD_N_RE=
GS);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n_regs =3D i;<br>
&gt; @@ -204,14 &#43;203,14 @@ static bool kgd_hqd_sdma_is_occupied(struct =
kgd_dev *kgd, void *mqd)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr &=
#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offs=
et &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdma_rlc_rb_cntl &amp; S=
DMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; @@ -224,20 &#43;223,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_d=
ev *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0=
_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmS=
DMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0_R=
LC0_RB_CNTL__RB_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL, temp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL, temp);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (temp &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
&gt; @@ -245,14 &#43;244,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_d=
ev *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(sdma_bas=
e_addr &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(rlc_=
reg_offset &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi =
=3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; index a4325db8d093..ee520ad90717 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<b=
r>
&gt; @@ -307,11 &#43;307,11 @@ static int kgd_init_interrupts(struct kgd_de=
v *kgd, uint32_t pipe_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,<br>
&gt; &#43;static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t base[2] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[2] =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA0, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mmSD=
MA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* On gfx10, mmSDMA1_xxx registers are defined NOT base=
d<br>
&gt; @@ -323,12 &#43;323,11 @@ static uint32_t get_sdma_base_addr(struct am=
dgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA1, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mmSD=
MA0_RLC0_RB_CNTL<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; retval =3D base[engine_id] &#43; queue_id * =
(mmSDMA0_RLC1_RB_CNTL -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_reg_base=
[engine_id]<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &#43; queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%x\n&quo=
t;, retval);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offset: 0x%x=
\n&quot;, retval);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -489,23 &#43;488,23 @@ static int kgd_hqd_sdma_load(struct kgd_dev =
*kgd, void *mqd,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v10_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t data64;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *wptr64 =3D =
(uint64_t __user *)wptr;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma load base addr %x for en=
gine %d, queue %d\n&quot;, sdma_base_addr, m-&gt;sdma_engine_id, m-&gt;sdma=
_queue_id);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma load base addr 0x%x =
for engine %d, queue %d\n&quot;, rlc_reg_offset, m-&gt;sdma_engine_id, m-&g=
t;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__RB=
_ENABLE_MASK));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D msecs_to_jif=
fies(2000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (data &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
&gt; @@ -513,41 &#43;512,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev =
*kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL_OFFSET,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&gt=
;sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL, data);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_MIN=
OR_PTR_UPDATE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_MINOR_PTR_UPDATE, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_user_wptr(mm, wptr6=
4, data64)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits=
(data64));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits=
(data64));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_r=
lcx_rb_rptr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_r=
lcx_rb_rptr_hi);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_MIN=
OR_PTR_UPDATE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_MINOR_PTR_UPDATE, 0);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
BASE_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_BASE_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_base_hi);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_ADDR_LO,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_ADDR_LO,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_rptr_addr_lo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_ADDR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_ADDR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_rptr_addr_hi);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&gt=
;sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL, data);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -557,28 &#43;556,25 @@ static int kgd_hqd_sdma_dump(struct kgd_dev =
*kgd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; uint32_t (**dump)[2], uint32_t *n_regs)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr =3D get_sdma_base_ad=
dr(adev, engine_id, queue_id);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset =3D get_rlc_reg_=
offset(adev, engine_id, queue_id);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0, reg;<br>
&gt;&nbsp;&nbsp; #undef HQD_N_REGS<br>
&gt;&nbsp;&nbsp; #define HQD_N_REGS (19&#43;6&#43;7&#43;10)<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma dump engine id %d queue_=
id %d\n&quot;, engine_id, queue_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base addr %x\n&quot;, sd=
ma_base_addr);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dump =3D kmalloc(HQD_N_REGS=
*2*sizeof(uint32_t), GFP_KERNEL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*dump =3D=3D NULL)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_RB=
_CNTL; reg &lt;=3D mmSDMA0_RLC0_DOORBELL; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_ST=
ATUS; reg &lt;=3D mmSDMA0_RLC0_CSA_ADDR_HI; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_IB=
_SUB_REMAIN;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg &lt;=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_MI=
DCMD_DATA0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg &lt;=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(i !=3D HQD_N_RE=
GS);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n_regs =3D i;<br>
&gt; @@ -612,14 &#43;608,14 @@ static bool kgd_hqd_sdma_is_occupied(struct =
kgd_dev *kgd, void *mqd)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v10_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr &=
#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offs=
et &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdma_rlc_rb_cntl &amp; S=
DMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; @@ -740,20 &#43;736,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_d=
ev *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v10_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0=
_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmS=
DMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0_R=
LC0_RB_CNTL__RB_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL, temp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL, temp);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (temp &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
&gt; @@ -761,14 &#43;757,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_d=
ev *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(sdma_bas=
e_addr &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(rlc_=
reg_offset &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi =
=3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; index c6abcf72e822..d0517b7ae089 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br=
>
&gt; @@ -303,14 &#43;303,14 @@ static int kgd_init_interrupts(struct kgd_de=
v *kgd, uint32_t pipe_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static inline uint32_t get_sdma_base_addr(struct cik_sdma_rlc_registe=
rs *m)<br>
&gt; &#43;static inline uint32_t get_rlc_reg_offset(struct cik_sdma_rlc_reg=
isters *m)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D m-&gt;sdma_engine=
_id * SDMA1_REGISTER_OFFSET &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dma_queue_id * KFD_CIK_SDMA_QUEUE_OFFSET;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%x\n&quo=
t;, retval);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offset: 0x%x=
\n&quot;, retval);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -417,7 &#43;417,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *k=
gd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(m);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_offset(m)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; =
mmSDMA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; m-&gt;sdma_rlc_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__RB_E=
NABLE_MASK));<br>
&gt; @@ -528,7 &#43;528,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kg=
d_dev *kgd, void *mqd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(m);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_offset(m)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(=
sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -650,7 &#43;650,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev=
 *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(m);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_offset(m)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_ad=
dr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0_R=
LC0_RB_CNTL__RB_ENABLE_MASK;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; index 4e8b4e949926..373501abdb6b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br=
>
&gt; @@ -260,13 &#43;260,13 @@ static int kgd_init_interrupts(struct kgd_de=
v *kgd, uint32_t pipe_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static inline uint32_t get_sdma_base_addr(struct vi_sdma_mqd *m)<br>
&gt; &#43;static inline uint32_t get_rlc_reg_offset(struct vi_sdma_mqd *m)<=
br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D m-&gt;sdma_engine=
_id * SDMA1_REGISTER_OFFSET &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id * KFD_VI_SDMA_QUEUE_OFFSET;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%x\n&quo=
t;, retval);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offset: 0x%x=
\n&quot;, retval);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -402,7 &#43;402,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *k=
gd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(m);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_offset(m)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; =
mmSDMA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__RB=
_ENABLE_MASK));<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -521,7 &#43;521,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kg=
d_dev *kgd, void *mqd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(m);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_offset(m)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(=
sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -646,7 &#43;646,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev=
 *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(m);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_rlc_reg_offset(m)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_ad=
dr &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0_R=
LC0_RB_CNTL__RB_ENABLE_MASK;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; index 55437f160a72..2dd5bc676029 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br=
>
&gt; @@ -226,22 &#43;226,20 @@ int kgd_gfx_v9_init_interrupts(struct kgd_de=
v *kgd, uint32_t pipe_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static uint32_t get_sdma_base_addr(struct amdgpu_device *adev,<br>
&gt; &#43;static uint32_t get_rlc_reg_offset(struct amdgpu_device *adev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t base[2] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[2] =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA0, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mmSD=
MA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(SDMA1, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mmSD=
MA1_RLC0_RB_CNTL<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_reg_base=
[engine_id]<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &#43; queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; retval =3D base[engine_id] &#43; queue_id * =
(mmSDMA0_RLC1_RB_CNTL -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;sdma base address: 0x%x\n&quo=
t;, retval);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register offset: 0x%x=
\n&quot;, retval);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -388,22 &#43;386,22 @@ static int kgd_hqd_sdma_load(struct kgd_dev =
*kgd, void *mqd,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t data64;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *wptr64 =3D =
(uint64_t __user *)wptr;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_cntl &amp; (~SDMA0_RLC0_RB_CNTL__RB=
_ENABLE_MASK));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D msecs_to_jif=
fies(2000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (data &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
&gt; @@ -411,41 &#43;409,41 @@ static int kgd_hqd_sdma_load(struct kgd_dev =
*kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL_OFFSET,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&gt=
;sdmax_rlcx_doorbell, SDMA0_RLC0_DOORBELL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL, data);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR, m-&gt;sdmax_rlcx_rb_rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_MIN=
OR_PTR_UPDATE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_MINOR_PTR_UPDATE, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_user_wptr(mm, wptr6=
4, data64)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits=
(data64));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits=
(data64));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_r=
lcx_rb_rptr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_WPTR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_r=
lcx_rb_rptr_hi);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_MIN=
OR_PTR_UPDATE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_MINOR_PTR_UPDATE, 0);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
BASE_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_BASE, m-&gt;sdmax_rlcx_rb_base);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_BASE_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_base_hi);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_ADDR_LO,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_ADDR_LO,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_rptr_addr_lo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
RPTR_ADDR_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_RPTR_ADDR_HI,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;s=
dmax_rlcx_rb_rptr_addr_hi);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&gt=
;sdmax_rlcx_rb_cntl, SDMA0_RLC0_RB_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL, data);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -455,7 &#43;453,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *k=
gd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; uint32_t (**dump)[2], uint32_t *n_regs)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr =3D get_sdma_base_ad=
dr(adev, engine_id, queue_id);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset =3D get_rlc_reg_=
offset(adev, engine_id, queue_id);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0, reg;<br>
&gt;&nbsp;&nbsp; #undef HQD_N_REGS<br>
&gt;&nbsp;&nbsp; #define HQD_N_REGS (19&#43;6&#43;7&#43;10)<br>
&gt; @@ -465,15 &#43;463,15 @@ static int kgd_hqd_sdma_dump(struct kgd_dev =
*kgd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_RB=
_CNTL; reg &lt;=3D mmSDMA0_RLC0_DOORBELL; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_ST=
ATUS; reg &lt;=3D mmSDMA0_RLC0_CSA_ADDR_HI; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_IB=
_SUB_REMAIN;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg &lt;=3D mmSDMA0_RLC0_MINOR_PTR_UPDATE; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D mmSDMA0_RLC0_MI=
DCMD_DATA0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg &lt;=3D mmSDMA0_RLC0_MIDCMD_CNTL; reg&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DUMP_REG(sdma_base_addr &#43; reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DUMP_REG(rlc_reg_offset &#43; reg);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(i !=3D HQD_N_RE=
GS);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n_regs =3D i;<br>
&gt; @@ -507,14 &#43;505,14 @@ static bool kgd_hqd_sdma_is_occupied(struct =
kgd_dev *kgd, void *mqd)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(sdma_base_addr &=
#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(rlc_reg_offs=
et &#43; mmSDMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdma_rlc_rb_cntl &amp; S=
DMA0_RLC0_RB_CNTL__RB_ENABLE_MASK)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; @@ -577,20 &#43;575,20 @@ static int kgd_hqd_sdma_destroy(struct kgd_d=
ev *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D get_amdgpu_device(kgd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_base_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rlc_reg_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies =
=3D (utimeout * HZ / 1000) &#43; jiffies;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; sdma_base_addr =3D get_sdma_base_addr(adev, =
m-&gt;sdma_engine_id,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; rlc_reg_offset =3D get_rlc_reg_offset(ad=
ev, m-&gt;sdma_engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdma_queue_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0=
_RLC0_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmS=
DMA0_RLC0_RB_CNTL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D temp &amp; ~SDMA0_R=
LC0_RB_CNTL__RB_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL, temp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL, temp);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; temp =3D RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; temp =3D RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_CONTEXT_STATUS);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (temp &amp; SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies))<br>
&gt; @@ -598,14 &#43;596,14 @@ static int kgd_hqd_sdma_destroy(struct kgd_d=
ev *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_DOO=
RBELL, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_=
CNTL,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_DOORBELL, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rlc_reg_offset &#43; mmSDMA0_RLC0=
_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_CNTL) |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(sdma_bas=
e_addr &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr =3D RREG32(rlc_=
reg_offset &#43; mmSDMA0_RLC0_RB_RPTR);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_hi =
=3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RREG32(sdma_base_addr &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RREG32(rlc_reg_offset &#43; mmSDMA0_RLC0_RB_RPTR_HI);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB27784ED82D2680435D20248FF0850DM6PR12MB2778namp_--

--===============1082155872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1082155872==--
