From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/26] drm/amdgpu: refactor MQD/HQD initialization v2
Date: Tue, 11 Apr 2017 18:18:55 -0400
Message-ID: <CADnq5_OdNy8hW8=WZouJBTtGjd261E9Boz6zL2L1o-GYegqP8Q@mail.gmail.com>
References: <20170406062139.3335-1-andresx7@gmail.com>
 <20170406062139.3335-2-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f403045c03224a4502054ceb7aef
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170406062139.3335-2-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--f403045c03224a4502054ceb7aef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 6, 2017 at 2:21 AM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> The MQD programming sequence currently exists in 3 different places.
> Refactor it to absorb all the duplicates.
>
> The success path remains mostly identical except for a slightly
> different order in the non-kiq case. This shouldn't matter if the HQD
> is disabled.
>
> The error handling paths have been updated to deal with the new code
> structure.
>
> v2: the non-kiq path for gfxv8 was dropped in the rebase
>
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
> Acked-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 447 ++++++++++++++++++----------=
------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 110 +++++----
>  2 files changed, 309 insertions(+), 248 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 185cb31..f67ef58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -42,20 +42,22 @@
>  #include "gca/gfx_7_2_sh_mask.h"
>
>  #include "gmc/gmc_7_0_d.h"
>  #include "gmc/gmc_7_0_sh_mask.h"
>
>  #include "oss/oss_2_0_d.h"
>  #include "oss/oss_2_0_sh_mask.h"
>
>  #define GFX7_NUM_GFX_RINGS     1
>  #define GFX7_NUM_COMPUTE_RINGS 8
> +#define GFX7_MEC_HPD_SIZE      2048
> +
>
>  static void gfx_v7_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void gfx_v7_0_set_irq_funcs(struct amdgpu_device *adev);
>  static void gfx_v7_0_set_gds_init(struct amdgpu_device *adev);
>
>  MODULE_FIRMWARE("radeon/bonaire_pfp.bin");
>  MODULE_FIRMWARE("radeon/bonaire_me.bin");
>  MODULE_FIRMWARE("radeon/bonaire_ce.bin");
>  MODULE_FIRMWARE("radeon/bonaire_rlc.bin");
>  MODULE_FIRMWARE("radeon/bonaire_mec.bin");
> @@ -2814,40 +2816,38 @@ static void gfx_v7_0_mec_fini(struct amdgpu_devic=
e *adev)
>                 if (unlikely(r !=3D 0))
>                         dev_warn(adev->dev, "(%d) reserve HPD EOP bo fail=
ed\n", r);
>                 amdgpu_bo_unpin(adev->gfx.mec.hpd_eop_obj);
>                 amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>
>                 amdgpu_bo_unref(&adev->gfx.mec.hpd_eop_obj);
>                 adev->gfx.mec.hpd_eop_obj =3D NULL;
>         }
>  }
>
> -#define MEC_HPD_SIZE 2048
> -
>  static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
>  {
>         int r;
>         u32 *hpd;
>
>         /*
>          * KV:    2 MEC, 4 Pipes/MEC, 8 Queues/Pipe - 64 Queues total
>          * CI/KB: 1 MEC, 4 Pipes/MEC, 8 Queues/Pipe - 32 Queues total
>          * Nonetheless, we assign only 1 pipe because all other pipes wil=
l
>          * be handled by KFD
>          */
>         adev->gfx.mec.num_mec =3D 1;
>         adev->gfx.mec.num_pipe =3D 1;
>         adev->gfx.mec.num_queue =3D adev->gfx.mec.num_mec * adev->gfx.mec=
.num_pipe * 8;
>
>         if (adev->gfx.mec.hpd_eop_obj =3D=3D NULL) {
>                 r =3D amdgpu_bo_create(adev,
> -                                    adev->gfx.mec.num_mec *adev->gfx.mec=
.num_pipe * MEC_HPD_SIZE * 2,
> +                                    adev->gfx.mec.num_mec * adev->gfx.me=
c.num_pipe * GFX7_MEC_HPD_SIZE * 2,
>                                      PAGE_SIZE, true,
>                                      AMDGPU_GEM_DOMAIN_GTT, 0, NULL, NULL=
,
>                                      &adev->gfx.mec.hpd_eop_obj);
>                 if (r) {
>                         dev_warn(adev->dev, "(%d) create HDP EOP bo faile=
d\n", r);
>                         return r;
>                 }
>         }
>
>         r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, false);
> @@ -2863,21 +2863,21 @@ static int gfx_v7_0_mec_init(struct amdgpu_device=
 *adev)
>                 return r;
>         }
>         r =3D amdgpu_bo_kmap(adev->gfx.mec.hpd_eop_obj, (void **)&hpd);
>         if (r) {
>                 dev_warn(adev->dev, "(%d) map HDP EOP bo failed\n", r);
>                 gfx_v7_0_mec_fini(adev);
>                 return r;
>         }
>
>         /* clear memory.  Not sure if this is required or not */
> -       memset(hpd, 0, adev->gfx.mec.num_mec *adev->gfx.mec.num_pipe * ME=
C_HPD_SIZE * 2);
> +       memset(hpd, 0, adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe * G=
FX7_MEC_HPD_SIZE * 2);
>
>         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>
>         return 0;
>  }
>
>  struct hqd_registers
>  {
>         u32 cp_mqd_base_addr;
> @@ -2938,261 +2938,296 @@ struct bonaire_mqd
>         u32 restart[3];
>         u32 thread_trace_enable;
>         u32 reserved1;
>         u32 user_data[16];
>         u32 vgtcs_invoke_count[2];
>         struct hqd_registers queue_state;
>         u32 dequeue_cntr;
>         u32 interrupt_queue[64];
>  };
>
> -/**
> - * gfx_v7_0_cp_compute_resume - setup the compute queue registers
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Program the compute queues and test them to make sure they
> - * are working.
> - * Returns 0 for success, error for failure.
> - */
> -static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
> +static void gfx_v7_0_compute_pipe_init(struct amdgpu_device *adev, int m=
e, int pipe)
>  {
> -       int r, i, j;
> -       u32 tmp;
> -       bool use_doorbell =3D true;
> -       u64 hqd_gpu_addr;
> -       u64 mqd_gpu_addr;
>         u64 eop_gpu_addr;
> -       u64 wb_gpu_addr;
> -       u32 *buf;
> -       struct bonaire_mqd *mqd;
> -       struct amdgpu_ring *ring;
> -
> -       /* fix up chicken bits */
> -       tmp =3D RREG32(mmCP_CPF_DEBUG);
> -       tmp |=3D (1 << 23);
> -       WREG32(mmCP_CPF_DEBUG, tmp);
> +       u32 tmp;
> +       size_t eop_offset =3D me * pipe * GFX7_MEC_HPD_SIZE * 2;
>
> -       /* init the pipes */
>         mutex_lock(&adev->srbm_mutex);
> -       for (i =3D 0; i < (adev->gfx.mec.num_pipe * adev->gfx.mec.num_mec=
); i++) {
> -               int me =3D (i < 4) ? 1 : 2;
> -               int pipe =3D (i < 4) ? i : (i - 4);
> +       eop_gpu_addr =3D adev->gfx.mec.hpd_eop_gpu_addr + eop_offset;
>
> -               eop_gpu_addr =3D adev->gfx.mec.hpd_eop_gpu_addr + (i * ME=
C_HPD_SIZE * 2);
> +       cik_srbm_select(adev, me, pipe, 0, 0);
>
> -               cik_srbm_select(adev, me, pipe, 0, 0);
> +       /* write the EOP addr */
> +       WREG32(mmCP_HPD_EOP_BASE_ADDR, eop_gpu_addr >> 8);
> +       WREG32(mmCP_HPD_EOP_BASE_ADDR_HI, upper_32_bits(eop_gpu_addr) >> =
8);
>
> -               /* write the EOP addr */
> -               WREG32(mmCP_HPD_EOP_BASE_ADDR, eop_gpu_addr >> 8);
> -               WREG32(mmCP_HPD_EOP_BASE_ADDR_HI, upper_32_bits(eop_gpu_a=
ddr) >> 8);
> +       /* set the VMID assigned */
> +       WREG32(mmCP_HPD_EOP_VMID, 0);
>
> -               /* set the VMID assigned */
> -               WREG32(mmCP_HPD_EOP_VMID, 0);
> +       /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
> +       tmp =3D RREG32(mmCP_HPD_EOP_CONTROL);
> +       tmp &=3D ~CP_HPD_EOP_CONTROL__EOP_SIZE_MASK;
> +       tmp |=3D order_base_2(GFX7_MEC_HPD_SIZE / 8);
> +       WREG32(mmCP_HPD_EOP_CONTROL, tmp);
>
> -               /* set the EOP size, register value is 2^(EOP_SIZE+1) dwo=
rds */
> -               tmp =3D RREG32(mmCP_HPD_EOP_CONTROL);
> -               tmp &=3D ~CP_HPD_EOP_CONTROL__EOP_SIZE_MASK;
> -               tmp |=3D order_base_2(MEC_HPD_SIZE / 8);
> -               WREG32(mmCP_HPD_EOP_CONTROL, tmp);
> -       }
>         cik_srbm_select(adev, 0, 0, 0, 0);
>         mutex_unlock(&adev->srbm_mutex);
> +}
>
> -       /* init the queues.  Just two for now. */
> -       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               ring =3D &adev->gfx.compute_ring[i];
> +static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
> +{
> +       int i;
>
> -               if (ring->mqd_obj =3D=3D NULL) {
> -                       r =3D amdgpu_bo_create(adev,
> -                                            sizeof(struct bonaire_mqd),
> -                                            PAGE_SIZE, true,
> -                                            AMDGPU_GEM_DOMAIN_GTT, 0, NU=
LL, NULL,
> -                                            &ring->mqd_obj);
> -                       if (r) {
> -                               dev_warn(adev->dev, "(%d) create MQD bo f=
ailed\n", r);
> -                               return r;
> -                       }
> +       /* disable the queue if it's active */
> +       if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> +               WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> +               for (i =3D 0; i < adev->usec_timeout; i++) {
> +                       if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> +                               break;
> +                       udelay(1);
>                 }
>
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0)) {
> -                       gfx_v7_0_cp_compute_fini(adev);
> -                       return r;
> -               }
> -               r =3D amdgpu_bo_pin(ring->mqd_obj, AMDGPU_GEM_DOMAIN_GTT,
> -                                 &mqd_gpu_addr);
> -               if (r) {
> -                       dev_warn(adev->dev, "(%d) pin MQD bo failed\n", r=
);
> -                       gfx_v7_0_cp_compute_fini(adev);
> -                       return r;
> -               }
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&buf);
> -               if (r) {
> -                       dev_warn(adev->dev, "(%d) map MQD bo failed\n", r=
);
> -                       gfx_v7_0_cp_compute_fini(adev);
> -                       return r;
> -               }
> +               if (i =3D=3D adev->usec_timeout)
> +                       return -ETIMEDOUT;
>
> -               /* init the mqd struct */
> -               memset(buf, 0, sizeof(struct bonaire_mqd));
> +               WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> +               WREG32(mmCP_HQD_PQ_RPTR, 0);
> +               WREG32(mmCP_HQD_PQ_WPTR, 0);
> +       }
>
> -               mqd =3D (struct bonaire_mqd *)buf;
> -               mqd->header =3D 0xC0310800;
> -               mqd->static_thread_mgmt01[0] =3D 0xffffffff;
> -               mqd->static_thread_mgmt01[1] =3D 0xffffffff;
> -               mqd->static_thread_mgmt23[0] =3D 0xffffffff;
> -               mqd->static_thread_mgmt23[1] =3D 0xffffffff;
> +       return 0;
> +}
>
> -               mutex_lock(&adev->srbm_mutex);
> -               cik_srbm_select(adev, ring->me,
> -                               ring->pipe,
> -                               ring->queue, 0);
> +static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
> +                            struct bonaire_mqd *mqd,
> +                            uint64_t mqd_gpu_addr,
> +                            struct amdgpu_ring *ring)
> +{
> +       u64 hqd_gpu_addr;
> +       u64 wb_gpu_addr;
>
> -               /* disable wptr polling */
> -               tmp =3D RREG32(mmCP_PQ_WPTR_POLL_CNTL);
> -               tmp &=3D ~CP_PQ_WPTR_POLL_CNTL__EN_MASK;
> -               WREG32(mmCP_PQ_WPTR_POLL_CNTL, tmp);
> +       /* init the mqd struct */
> +       memset(mqd, 0, sizeof(struct bonaire_mqd));
>
> -               /* enable doorbell? */
> -               mqd->queue_state.cp_hqd_pq_doorbell_control =3D
> -                       RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
> -               if (use_doorbell)
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control |=3D =
CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
> -               else
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control &=3D =
~CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
> -               WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL,
> -                      mqd->queue_state.cp_hqd_pq_doorbell_control);
> -
> -               /* disable the queue if it's active */
> -               mqd->queue_state.cp_hqd_dequeue_request =3D 0;
> -               mqd->queue_state.cp_hqd_pq_rptr =3D 0;
> -               mqd->queue_state.cp_hqd_pq_wptr=3D 0;
> -               if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> -                       WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> -                       for (j =3D 0; j < adev->usec_timeout; j++) {
> -                               if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> -                                       break;
> -                               udelay(1);
> -                       }
> -                       WREG32(mmCP_HQD_DEQUEUE_REQUEST, mqd->queue_state=
.cp_hqd_dequeue_request);
> -                       WREG32(mmCP_HQD_PQ_RPTR, mqd->queue_state.cp_hqd_=
pq_rptr);
> -                       WREG32(mmCP_HQD_PQ_WPTR, mqd->queue_state.cp_hqd_=
pq_wptr);
> -               }
> +       mqd->header =3D 0xC0310800;
> +       mqd->static_thread_mgmt01[0] =3D 0xffffffff;
> +       mqd->static_thread_mgmt01[1] =3D 0xffffffff;
> +       mqd->static_thread_mgmt23[0] =3D 0xffffffff;
> +       mqd->static_thread_mgmt23[1] =3D 0xffffffff;
>
> -               /* set the pointer to the MQD */
> -               mqd->queue_state.cp_mqd_base_addr =3D mqd_gpu_addr & 0xff=
fffffc;
> -               mqd->queue_state.cp_mqd_base_addr_hi =3D upper_32_bits(mq=
d_gpu_addr);
> -               WREG32(mmCP_MQD_BASE_ADDR, mqd->queue_state.cp_mqd_base_a=
ddr);
> -               WREG32(mmCP_MQD_BASE_ADDR_HI, mqd->queue_state.cp_mqd_bas=
e_addr_hi);
> -               /* set MQD vmid to 0 */
> -               mqd->queue_state.cp_mqd_control =3D RREG32(mmCP_MQD_CONTR=
OL);
> -               mqd->queue_state.cp_mqd_control &=3D ~CP_MQD_CONTROL__VMI=
D_MASK;
> -               WREG32(mmCP_MQD_CONTROL, mqd->queue_state.cp_mqd_control)=
;
> -
> -               /* set the pointer to the HQD, this is similar CP_RB0_BAS=
E/_HI */
> -               hqd_gpu_addr =3D ring->gpu_addr >> 8;
> -               mqd->queue_state.cp_hqd_pq_base =3D hqd_gpu_addr;
> -               mqd->queue_state.cp_hqd_pq_base_hi =3D upper_32_bits(hqd_=
gpu_addr);
> -               WREG32(mmCP_HQD_PQ_BASE, mqd->queue_state.cp_hqd_pq_base)=
;
> -               WREG32(mmCP_HQD_PQ_BASE_HI, mqd->queue_state.cp_hqd_pq_ba=
se_hi);
> -
> -               /* set up the HQD, this is similar to CP_RB0_CNTL */
> -               mqd->queue_state.cp_hqd_pq_control =3D RREG32(mmCP_HQD_PQ=
_CONTROL);
> -               mqd->queue_state.cp_hqd_pq_control &=3D
> -                       ~(CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK |
> -                                       CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZ=
E_MASK);
> -
> -               mqd->queue_state.cp_hqd_pq_control |=3D
> -                       order_base_2(ring->ring_size / 8);
> -               mqd->queue_state.cp_hqd_pq_control |=3D
> -                       (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8);
> +       /* enable doorbell? */
> +       mqd->queue_state.cp_hqd_pq_doorbell_control =3D
> +               RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
> +       if (ring->use_doorbell)
> +               mqd->queue_state.cp_hqd_pq_doorbell_control |=3D CP_HQD_P=
Q_DOORBELL_CONTROL__DOORBELL_EN_MASK;
> +       else
> +               mqd->queue_state.cp_hqd_pq_doorbell_control &=3D ~CP_HQD_=
PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
> +
> +       /* set the pointer to the MQD */
> +       mqd->queue_state.cp_mqd_base_addr =3D mqd_gpu_addr & 0xfffffffc;
> +       mqd->queue_state.cp_mqd_base_addr_hi =3D upper_32_bits(mqd_gpu_ad=
dr);
> +
> +       /* set MQD vmid to 0 */
> +       mqd->queue_state.cp_mqd_control =3D RREG32(mmCP_MQD_CONTROL);
> +       mqd->queue_state.cp_mqd_control &=3D ~CP_MQD_CONTROL__VMID_MASK;
> +
> +       /* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
> +       hqd_gpu_addr =3D ring->gpu_addr >> 8;
> +       mqd->queue_state.cp_hqd_pq_base =3D hqd_gpu_addr;
> +       mqd->queue_state.cp_hqd_pq_base_hi =3D upper_32_bits(hqd_gpu_addr=
);
> +
> +       /* set up the HQD, this is similar to CP_RB0_CNTL */
> +       mqd->queue_state.cp_hqd_pq_control =3D RREG32(mmCP_HQD_PQ_CONTROL=
);
> +       mqd->queue_state.cp_hqd_pq_control &=3D
> +               ~(CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK |
> +                               CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK);
> +
> +       mqd->queue_state.cp_hqd_pq_control |=3D
> +               order_base_2(ring->ring_size / 8);
> +       mqd->queue_state.cp_hqd_pq_control |=3D
> +               (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8);
>  #ifdef __BIG_ENDIAN
> -               mqd->queue_state.cp_hqd_pq_control |=3D
> -                       2 << CP_HQD_PQ_CONTROL__ENDIAN_SWAP__SHIFT;
> +       mqd->queue_state.cp_hqd_pq_control |=3D
> +               2 << CP_HQD_PQ_CONTROL__ENDIAN_SWAP__SHIFT;
>  #endif
> -               mqd->queue_state.cp_hqd_pq_control &=3D
> -                       ~(CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK |
> +       mqd->queue_state.cp_hqd_pq_control &=3D
> +               ~(CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK |
>                                 CP_HQD_PQ_CONTROL__ROQ_PQ_IB_FLIP_MASK |
>                                 CP_HQD_PQ_CONTROL__PQ_VOLATILE_MASK);
> -               mqd->queue_state.cp_hqd_pq_control |=3D
> -                       CP_HQD_PQ_CONTROL__PRIV_STATE_MASK |
> -                       CP_HQD_PQ_CONTROL__KMD_QUEUE_MASK; /* assuming ke=
rnel queue control */
> -               WREG32(mmCP_HQD_PQ_CONTROL, mqd->queue_state.cp_hqd_pq_co=
ntrol);
> -
> -               /* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL=
__EN_MASK=3D1 */
> -               wb_gpu_addr =3D adev->wb.gpu_addr + (ring->wptr_offs * 4)=
;
> -               mqd->queue_state.cp_hqd_pq_wptr_poll_addr =3D wb_gpu_addr=
 & 0xfffffffc;
> -               mqd->queue_state.cp_hqd_pq_wptr_poll_addr_hi =3D upper_32=
_bits(wb_gpu_addr) & 0xffff;
> -               WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR, mqd->queue_state.cp_hq=
d_pq_wptr_poll_addr);
> -               WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
> -                      mqd->queue_state.cp_hqd_pq_wptr_poll_addr_hi);
> -
> -               /* set the wb address wether it's enabled or not */
> -               wb_gpu_addr =3D adev->wb.gpu_addr + (ring->rptr_offs * 4)=
;
> -               mqd->queue_state.cp_hqd_pq_rptr_report_addr =3D wb_gpu_ad=
dr & 0xfffffffc;
> -               mqd->queue_state.cp_hqd_pq_rptr_report_addr_hi =3D
> -                       upper_32_bits(wb_gpu_addr) & 0xffff;
> -               WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR,
> -                      mqd->queue_state.cp_hqd_pq_rptr_report_addr);
> -               WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
> -                      mqd->queue_state.cp_hqd_pq_rptr_report_addr_hi);
> -
> -               /* enable the doorbell if requested */
> -               if (use_doorbell) {
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control =3D
> -                               RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control &=3D
> -                               ~CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFF=
SET_MASK;
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control |=3D
> -                               (ring->doorbell_index <<
> -                                CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFF=
SET__SHIFT);
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control |=3D
> -                               CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_M=
ASK;
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control &=3D
> -                               ~(CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_SO=
URCE_MASK |
> -                               CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_HIT_=
MASK);
> +       mqd->queue_state.cp_hqd_pq_control |=3D
> +               CP_HQD_PQ_CONTROL__PRIV_STATE_MASK |
> +               CP_HQD_PQ_CONTROL__KMD_QUEUE_MASK; /* assuming kernel que=
ue control */
>
> -               } else {
> -                       mqd->queue_state.cp_hqd_pq_doorbell_control =3D 0=
;
> +       /* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MAS=
K=3D1 */
> +       wb_gpu_addr =3D adev->wb.gpu_addr + (ring->wptr_offs * 4);
> +       mqd->queue_state.cp_hqd_pq_wptr_poll_addr =3D wb_gpu_addr & 0xfff=
ffffc;
> +       mqd->queue_state.cp_hqd_pq_wptr_poll_addr_hi =3D upper_32_bits(wb=
_gpu_addr) & 0xffff;
> +
> +       /* set the wb address wether it's enabled or not */
> +       wb_gpu_addr =3D adev->wb.gpu_addr + (ring->rptr_offs * 4);
> +       mqd->queue_state.cp_hqd_pq_rptr_report_addr =3D wb_gpu_addr & 0xf=
ffffffc;
> +       mqd->queue_state.cp_hqd_pq_rptr_report_addr_hi =3D
> +               upper_32_bits(wb_gpu_addr) & 0xffff;
> +
> +       /* enable the doorbell if requested */
> +       if (ring->use_doorbell) {
> +               mqd->queue_state.cp_hqd_pq_doorbell_control =3D
> +                       RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
> +               mqd->queue_state.cp_hqd_pq_doorbell_control &=3D
> +                       ~CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK=
;
> +               mqd->queue_state.cp_hqd_pq_doorbell_control |=3D
> +                       (ring->doorbell_index <<
> +                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHI=
FT);
> +               mqd->queue_state.cp_hqd_pq_doorbell_control |=3D
> +                       CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
> +               mqd->queue_state.cp_hqd_pq_doorbell_control &=3D
> +                       ~(CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_SOURCE_MAS=
K |
> +                                       CP_HQD_PQ_DOORBELL_CONTROL__DOORB=
ELL_HIT_MASK);
> +
> +       } else {
> +               mqd->queue_state.cp_hqd_pq_doorbell_control =3D 0;
> +       }
> +
> +       /* read and write pointers, similar to CP_RB0_WPTR/_RPTR */
> +       ring->wptr =3D 0;
> +       mqd->queue_state.cp_hqd_pq_wptr =3D lower_32_bits(ring->wptr);
> +       mqd->queue_state.cp_hqd_pq_rptr =3D RREG32(mmCP_HQD_PQ_RPTR);
> +
> +       /* set the vmid for the queue */
> +       mqd->queue_state.cp_hqd_vmid =3D 0;
> +
> +       /* activate the queue */
> +       mqd->queue_state.cp_hqd_active =3D 1;
> +}
> +
> +static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev,
> +                              struct bonaire_mqd *mqd)
> +{
> +       u32 tmp;
> +
> +       /* disable wptr polling */
> +       tmp =3D RREG32(mmCP_PQ_WPTR_POLL_CNTL);
> +       tmp =3D REG_SET_FIELD(tmp, CP_PQ_WPTR_POLL_CNTL, EN, 0);
> +       WREG32(mmCP_PQ_WPTR_POLL_CNTL, tmp);
> +
> +       /* program MQD field to HW */
> +       WREG32(mmCP_MQD_BASE_ADDR, mqd->queue_state.cp_mqd_base_addr);
> +       WREG32(mmCP_MQD_BASE_ADDR_HI, mqd->queue_state.cp_mqd_base_addr_h=
i);
> +       WREG32(mmCP_MQD_CONTROL, mqd->queue_state.cp_mqd_control);
> +       WREG32(mmCP_HQD_PQ_BASE, mqd->queue_state.cp_hqd_pq_base);
> +       WREG32(mmCP_HQD_PQ_BASE_HI, mqd->queue_state.cp_hqd_pq_base_hi);
> +       WREG32(mmCP_HQD_PQ_CONTROL, mqd->queue_state.cp_hqd_pq_control);
> +       WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR, mqd->queue_state.cp_hqd_pq_wpt=
r_poll_addr);
> +       WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR_HI, mqd->queue_state.cp_hqd_pq_=
wptr_poll_addr_hi);
> +       WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR, mqd->queue_state.cp_hqd_pq_r=
ptr_report_addr);
> +       WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI, mqd->queue_state.cp_hqd_p=
q_rptr_report_addr_hi);
> +       WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, mqd->queue_state.cp_hqd_pq_d=
oorbell_control);
> +       WREG32(mmCP_HQD_PQ_WPTR, mqd->queue_state.cp_hqd_pq_wptr);
> +       WREG32(mmCP_HQD_VMID, mqd->queue_state.cp_hqd_vmid);
> +
> +       /* activate the HQD */
> +       WREG32(mmCP_HQD_ACTIVE, mqd->queue_state.cp_hqd_active);
> +
> +       return 0;
> +}
> +
> +static int gfx_v7_0_compute_queue_init(struct amdgpu_device *adev, int r=
ing_id)
> +{
> +       int r;
> +       u64 mqd_gpu_addr;
> +       struct bonaire_mqd *mqd;
> +       struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[ring_id];
> +
> +       if (ring->mqd_obj =3D=3D NULL) {
> +               r =3D amdgpu_bo_create(adev,
> +                               sizeof(struct bonaire_mqd),
> +                               PAGE_SIZE, true,
> +                               AMDGPU_GEM_DOMAIN_GTT, 0, NULL, NULL,
> +                               &ring->mqd_obj);
> +               if (r) {
> +                       dev_warn(adev->dev, "(%d) create MQD bo failed\n"=
, r);
> +                       return r;
>                 }
> -               WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL,
> -                      mqd->queue_state.cp_hqd_pq_doorbell_control);
> +       }
> +
> +       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> +       if (unlikely(r !=3D 0))
> +               goto out;
> +
> +       r =3D amdgpu_bo_pin(ring->mqd_obj, AMDGPU_GEM_DOMAIN_GTT,
> +                       &mqd_gpu_addr);
> +       if (r) {
> +               dev_warn(adev->dev, "(%d) pin MQD bo failed\n", r);
> +               goto out_unreserve;
> +       }
> +       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&mqd);
> +       if (r) {
> +               dev_warn(adev->dev, "(%d) map MQD bo failed\n", r);
> +               goto out_unreserve;
> +       }
> +
> +       mutex_lock(&adev->srbm_mutex);
> +       cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
>
> -               /* read and write pointers, similar to CP_RB0_WPTR/_RPTR =
*/
> -               ring->wptr =3D 0;
> -               mqd->queue_state.cp_hqd_pq_wptr =3D lower_32_bits(ring->w=
ptr);
> -               WREG32(mmCP_HQD_PQ_WPTR, mqd->queue_state.cp_hqd_pq_wptr)=
;
> -               mqd->queue_state.cp_hqd_pq_rptr =3D RREG32(mmCP_HQD_PQ_RP=
TR);
> +       gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
> +       gfx_v7_0_mqd_deactivate(adev);
> +       gfx_v7_0_mqd_commit(adev, mqd);
>
> -               /* set the vmid for the queue */
> -               mqd->queue_state.cp_hqd_vmid =3D 0;
> -               WREG32(mmCP_HQD_VMID, mqd->queue_state.cp_hqd_vmid);
> +       cik_srbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
>
> -               /* activate the queue */
> -               mqd->queue_state.cp_hqd_active =3D 1;
> -               WREG32(mmCP_HQD_ACTIVE, mqd->queue_state.cp_hqd_active);
> +       amdgpu_bo_kunmap(ring->mqd_obj);
> +out_unreserve:
> +       amdgpu_bo_unreserve(ring->mqd_obj);
> +out:
> +       return 0;
> +}
> +
> +/**
> + * gfx_v7_0_cp_compute_resume - setup the compute queue registers
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Program the compute queues and test them to make sure they
> + * are working.
> + * Returns 0 for success, error for failure.
> + */
> +static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
> +{
> +       int r, i, j;
> +       u32 tmp;
> +       struct amdgpu_ring *ring;
>
> -               cik_srbm_select(adev, 0, 0, 0, 0);
> -               mutex_unlock(&adev->srbm_mutex);
> +       /* fix up chicken bits */
> +       tmp =3D RREG32(mmCP_CPF_DEBUG);
> +       tmp |=3D (1 << 23);
> +       WREG32(mmCP_CPF_DEBUG, tmp);
>
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +       /* init the pipes */
> +       for (i =3D 0; i < adev->gfx.mec.num_mec; i++)
> +               for (j =3D 0; j < adev->gfx.mec.num_pipe; j++)
> +                       gfx_v7_0_compute_pipe_init(adev, i, j);
>
> -               ring->ready =3D true;
> +       /* init the queues */
> +       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +               r =3D gfx_v7_0_compute_queue_init(adev, i);
> +               if (r) {
> +                       gfx_v7_0_cp_compute_fini(adev);
> +                       return r;
> +               }
>         }
>
>         gfx_v7_0_cp_compute_enable(adev, true);
>
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 ring =3D &adev->gfx.compute_ring[i];
> -
> +               ring->ready =3D true;
>                 r =3D amdgpu_ring_test_ring(ring);
>                 if (r)
>                         ring->ready =3D false;
>         }
>
>         return 0;
>  }
>
>  static void gfx_v7_0_cp_enable(struct amdgpu_device *adev, bool enable)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 4e63e52..88b85f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -46,20 +46,22 @@
>  #include "gca/gfx_8_0_sh_mask.h"
>  #include "gca/gfx_8_0_enum.h"
>
>  #include "dce/dce_10_0_d.h"
>  #include "dce/dce_10_0_sh_mask.h"
>
>  #include "smu/smu_7_1_3_d.h"
>
>  #define GFX8_NUM_GFX_RINGS     1
>  #define GFX8_NUM_COMPUTE_RINGS 8
> +#define GFX8_MEC_HPD_SIZE 2048
> +
>
>  #define TOPAZ_GB_ADDR_CONFIG_GOLDEN 0x22010001
>  #define CARRIZO_GB_ADDR_CONFIG_GOLDEN 0x22010001
>  #define POLARIS11_GB_ADDR_CONFIG_GOLDEN 0x22011002
>  #define TONGA_GB_ADDR_CONFIG_GOLDEN 0x22011003
>
>  #define ARRAY_MODE(x)                                  ((x) << GB_TILE_M=
ODE0__ARRAY_MODE__SHIFT)
>  #define PIPE_CONFIG(x)                                 ((x) << GB_TILE_M=
ODE0__PIPE_CONFIG__SHIFT)
>  #define TILE_SPLIT(x)                                  ((x) << GB_TILE_M=
ODE0__TILE_SPLIT__SHIFT)
>  #define MICRO_TILE_MODE_NEW(x)                         ((x) << GB_TILE_M=
ODE0__MICRO_TILE_MODE_NEW__SHIFT)
> @@ -1406,38 +1408,38 @@ static int gfx_v8_0_kiq_init_ring(struct amdgpu_d=
evice *adev,
>
>         return r;
>  }
>  static void gfx_v8_0_kiq_free_ring(struct amdgpu_ring *ring,
>                                    struct amdgpu_irq_src *irq)
>  {
>         amdgpu_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
>         amdgpu_ring_fini(ring);
>  }
>
> -#define MEC_HPD_SIZE 2048
> +#define GFX8_MEC_HPD_SIZE 2048
>
>  static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>  {
>         int r;
>         u32 *hpd;
>
>         /*
>          * we assign only 1 pipe because all other pipes will
>          * be handled by KFD
>          */
>         adev->gfx.mec.num_mec =3D 1;
>         adev->gfx.mec.num_pipe =3D 1;
>         adev->gfx.mec.num_queue =3D adev->gfx.mec.num_mec * adev->gfx.mec=
.num_pipe * 8;
>
>         if (adev->gfx.mec.hpd_eop_obj =3D=3D NULL) {
>                 r =3D amdgpu_bo_create(adev,
> -                                    adev->gfx.mec.num_queue * MEC_HPD_SI=
ZE,
> +                                    adev->gfx.mec.num_queue * GFX8_MEC_H=
PD_SIZE,
>                                      PAGE_SIZE, true,
>                                      AMDGPU_GEM_DOMAIN_GTT, 0, NULL, NULL=
,
>                                      &adev->gfx.mec.hpd_eop_obj);
>                 if (r) {
>                         dev_warn(adev->dev, "(%d) create HDP EOP bo faile=
d\n", r);
>                         return r;
>                 }
>         }
>
>         r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, false);
> @@ -1452,50 +1454,50 @@ static int gfx_v8_0_mec_init(struct amdgpu_device=
 *adev)
>                 gfx_v8_0_mec_fini(adev);
>                 return r;
>         }
>         r =3D amdgpu_bo_kmap(adev->gfx.mec.hpd_eop_obj, (void **)&hpd);
>         if (r) {
>                 dev_warn(adev->dev, "(%d) map HDP EOP bo failed\n", r);
>                 gfx_v8_0_mec_fini(adev);
>                 return r;
>         }
>
> -       memset(hpd, 0, adev->gfx.mec.num_queue * MEC_HPD_SIZE);
> +       memset(hpd, 0, adev->gfx.mec.num_queue * GFX8_MEC_HPD_SIZE);
>
>         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
>         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
>
>         return 0;
>  }
>
>  static void gfx_v8_0_kiq_fini(struct amdgpu_device *adev)
>  {
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
>         amdgpu_bo_free_kernel(&kiq->eop_obj, &kiq->eop_gpu_addr, NULL);
>  }
>
>  static int gfx_v8_0_kiq_init(struct amdgpu_device *adev)
>  {
>         int r;
>         u32 *hpd;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
> -       r =3D amdgpu_bo_create_kernel(adev, MEC_HPD_SIZE, PAGE_SIZE,
> +       r =3D amdgpu_bo_create_kernel(adev, GFX8_MEC_HPD_SIZE, PAGE_SIZE,
>                                     AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
>                                     &kiq->eop_gpu_addr, (void **)&hpd);
>         if (r) {
>                 dev_warn(adev->dev, "failed to create KIQ bo (%d).\n", r)=
;
>                 return r;
>         }
>
> -       memset(hpd, 0, MEC_HPD_SIZE);
> +       memset(hpd, 0, GFX8_MEC_HPD_SIZE);
>
>         r =3D amdgpu_bo_reserve(kiq->eop_obj, false);
>         if (unlikely(r !=3D 0))
>                 dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r=
);
>         amdgpu_bo_kunmap(kiq->eop_obj);
>         amdgpu_bo_unreserve(kiq->eop_obj);
>
>         return 0;
>  }
>
> @@ -2148,21 +2150,21 @@ static int gfx_v8_0_sw_init(void *handle)
>                         DRM_ERROR("Too many (%d) compute rings!\n", i);
>                         break;
>                 }
>                 ring =3D &adev->gfx.compute_ring[i];
>                 ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>                 ring->doorbell_index =3D AMDGPU_DOORBELL_MEC_RING0 + i;
>                 ring->me =3D 1; /* first MEC */
>                 ring->pipe =3D i / 8;
>                 ring->queue =3D i % 8;
> -               ring->eop_gpu_addr =3D adev->gfx.mec.hpd_eop_gpu_addr + (=
i * MEC_HPD_SIZE);
> +               ring->eop_gpu_addr =3D adev->gfx.mec.hpd_eop_gpu_addr + (=
i * GFX8_MEC_HPD_SIZE);
>                 sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe=
, ring->queue);
>                 irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP + ring-=
>pipe;
>                 /* type-2 packets are deprecated on MEC, use type-3 inste=
ad */
>                 r =3D amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_i=
rq,
>                                      irq_type);
>                 if (r)
>                         return r;
>         }
>
>         r =3D gfx_v8_0_kiq_init(adev);
> @@ -4747,52 +4749,50 @@ static int gfx_v8_0_kiq_kcq_disable(struct amdgpu=
_device *adev)
>         return r;
>  }
>
>  static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct vi_mqd *mqd =3D ring->mqd_ptr;
>         uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
>         uint32_t tmp;
>
> +       /* init the mqd struct */
> +       memset(mqd, 0, sizeof(struct vi_mqd));
> +
>         mqd->header =3D 0xC0310800;
>         mqd->compute_pipelinestat_enable =3D 0x00000001;
>         mqd->compute_static_thread_mgmt_se0 =3D 0xffffffff;
>         mqd->compute_static_thread_mgmt_se1 =3D 0xffffffff;
>         mqd->compute_static_thread_mgmt_se2 =3D 0xffffffff;
>         mqd->compute_static_thread_mgmt_se3 =3D 0xffffffff;
>         mqd->compute_misc_reserved =3D 0x00000003;
>
>         eop_base_addr =3D ring->eop_gpu_addr >> 8;
>         mqd->cp_hqd_eop_base_addr_lo =3D eop_base_addr;
>         mqd->cp_hqd_eop_base_addr_hi =3D upper_32_bits(eop_base_addr);
>
>         /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
>         tmp =3D RREG32(mmCP_HQD_EOP_CONTROL);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
> -                       (order_base_2(MEC_HPD_SIZE / 4) - 1));
> +                       (order_base_2(GFX8_MEC_HPD_SIZE / 4) - 1));
>
>         mqd->cp_hqd_eop_control =3D tmp;
>
>         /* enable doorbell? */
>         tmp =3D REG_SET_FIELD(RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL),
>                             CP_HQD_PQ_DOORBELL_CONTROL,
>                             DOORBELL_EN,
>                             ring->use_doorbell ? 1 : 0);
>
>         mqd->cp_hqd_pq_doorbell_control =3D tmp;
>
> -       /* disable the queue if it's active */
> -       mqd->cp_hqd_dequeue_request =3D 0;
> -       mqd->cp_hqd_pq_rptr =3D 0;
> -       mqd->cp_hqd_pq_wptr =3D 0;
> -
>         /* set the pointer to the MQD */
>         mqd->cp_mqd_base_addr_lo =3D ring->mqd_gpu_addr & 0xfffffffc;
>         mqd->cp_mqd_base_addr_hi =3D upper_32_bits(ring->mqd_gpu_addr);
>
>         /* set MQD vmid to 0 */
>         tmp =3D RREG32(mmCP_MQD_CONTROL);
>         tmp =3D REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
>         mqd->cp_mqd_control =3D tmp;
>
>         /* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
> @@ -4854,50 +4854,86 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *=
ring)
>         tmp =3D RREG32(mmCP_HQD_PERSISTENT_STATE);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE,=
 0x53);
>         mqd->cp_hqd_persistent_state =3D tmp;
>
>         /* activate the queue */
>         mqd->cp_hqd_active =3D 1;
>
>         return 0;
>  }
>
> -static int gfx_v8_0_kiq_init_register(struct amdgpu_ring *ring)
> +static int gfx_v8_0_mqd_deactivate(struct amdgpu_device *adev)

I'd prefer to call this gfx_v8_0_deactivate_hqd() since it's operating
on an HQD rather than an MQD and generally we use the verb first in
the naming.


> +{
> +       int i;
> +
> +       /* disable the queue if it's active */
> +       if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> +               WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> +               for (i =3D 0; i < adev->usec_timeout; i++) {
> +                       if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> +                               break;
> +                       udelay(1);
> +               }
> +
> +               if (i =3D=3D adev->usec_timeout)
> +                       return -ETIMEDOUT;
> +
> +               WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> +               WREG32(mmCP_HQD_PQ_RPTR, 0);
> +               WREG32(mmCP_HQD_PQ_WPTR, 0);

Maybe move this hunk outside of the loop?  Then I think this function
could also replace gfx_v8_0_init_hqd() and gfx_v8_0_inactive_hqd().
Also, maybe the request type should be selectable?  How about the
attached patch?

Alex


> +       }
> +
> +       return 0;
> +}
> +
> +static void gfx_v8_0_enable_doorbell(struct amdgpu_device *adev, bool en=
able)
> +{
> +       uint32_t tmp;
> +
> +       if (!enable)
> +               return;
> +
> +       if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
> +                       (adev->asic_type =3D=3D CHIP_FIJI) ||
> +                       (adev->asic_type =3D=3D CHIP_STONEY) ||
> +                       (adev->asic_type =3D=3D CHIP_POLARIS11) ||
> +                       (adev->asic_type =3D=3D CHIP_POLARIS10)) {
> +               WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER, AMDGPU_DOORBELL_KIQ=
 << 2);
> +               WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER, AMDGPU_DOORBELL_MEC=
_RING7 << 2);
> +       }
> +
> +       tmp =3D RREG32(mmCP_PQ_STATUS);
> +       tmp =3D REG_SET_FIELD(tmp, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
> +       WREG32(mmCP_PQ_STATUS, tmp);
> +}
> +
> +static int gfx_v8_0_mqd_commit(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct vi_mqd *mqd =3D ring->mqd_ptr;
> -       int j;
>
>         /* disable wptr polling */
>         WREG32_FIELD(CP_PQ_WPTR_POLL_CNTL, EN, 0);
>
>         WREG32(mmCP_HQD_EOP_BASE_ADDR, mqd->cp_hqd_eop_base_addr_lo);
>         WREG32(mmCP_HQD_EOP_BASE_ADDR_HI, mqd->cp_hqd_eop_base_addr_hi);
>
>         /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
>         WREG32(mmCP_HQD_EOP_CONTROL, mqd->cp_hqd_eop_control);
>
>         /* enable doorbell? */
>         WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, mqd->cp_hqd_pq_doorbell_cont=
rol);
>
> -       /* disable the queue if it's active */
> -       if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
> -               WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> -               for (j =3D 0; j < adev->usec_timeout; j++) {
> -                       if (!(RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__AC=
TIVE_MASK))
> -                               break;
> -                       udelay(1);
> -               }
> -               WREG32(mmCP_HQD_DEQUEUE_REQUEST, mqd->cp_hqd_dequeue_requ=
est);
> -               WREG32(mmCP_HQD_PQ_RPTR, mqd->cp_hqd_pq_rptr);
> -               WREG32(mmCP_HQD_PQ_WPTR, mqd->cp_hqd_pq_wptr);
> -       }
> +       /* set pq read/write pointers */
> +       WREG32(mmCP_HQD_DEQUEUE_REQUEST, mqd->cp_hqd_dequeue_request);
> +       WREG32(mmCP_HQD_PQ_RPTR, mqd->cp_hqd_pq_rptr);
> +       WREG32(mmCP_HQD_PQ_WPTR, mqd->cp_hqd_pq_wptr);
>
>         /* set the pointer to the MQD */
>         WREG32(mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr_lo);
>         WREG32(mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
>
>         /* set MQD vmid to 0 */
>         WREG32(mmCP_MQD_CONTROL, mqd->cp_mqd_control);
>
>         /* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
>         WREG32(mmCP_HQD_PQ_BASE, mqd->cp_hqd_pq_base_lo);
> @@ -4910,46 +4946,33 @@ static int gfx_v8_0_kiq_init_register(struct amdg=
pu_ring *ring)
>         WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR,
>                                 mqd->cp_hqd_pq_rptr_report_addr_lo);
>         WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
>                                 mqd->cp_hqd_pq_rptr_report_addr_hi);
>
>         /* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MAS=
K=3D1 */
>         WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR, mqd->cp_hqd_pq_wptr_poll_addr_=
lo);
>         WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR_HI, mqd->cp_hqd_pq_wptr_poll_ad=
dr_hi);
>
>         /* enable the doorbell if requested */
> -       if (ring->use_doorbell) {
> -               if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
> -                               (adev->asic_type =3D=3D CHIP_FIJI) ||
> -                               (adev->asic_type =3D=3D CHIP_STONEY)) {
> -                       WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER,
> -                                               AMDGPU_DOORBELL_KIQ << 2)=
;
> -                       WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER,
> -                                               AMDGPU_DOORBELL_MEC_RING7=
 << 2);
> -               }
> -       }
>         WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, mqd->cp_hqd_pq_doorbell_cont=
rol);
>
>         /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>         WREG32(mmCP_HQD_PQ_WPTR, mqd->cp_hqd_pq_wptr);
>
>         /* set the vmid for the queue */
>         WREG32(mmCP_HQD_VMID, mqd->cp_hqd_vmid);
>
>         WREG32(mmCP_HQD_PERSISTENT_STATE, mqd->cp_hqd_persistent_state);
>
>         /* activate the queue */
>         WREG32(mmCP_HQD_ACTIVE, mqd->cp_hqd_active);
>
> -       if (ring->use_doorbell)
> -               WREG32_FIELD(CP_PQ_STATUS, DOORBELL_ENABLE, 1);
> -
>         return 0;
>  }
>
>  static int gfx_v8_0_kiq_init_queue(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct vi_mqd *mqd =3D ring->mqd_ptr;
>         int mqd_idx =3D AMDGPU_MAX_COMPUTE_RINGS;
>
>         gfx_v8_0_kiq_setting(ring);
> @@ -4958,29 +4981,32 @@ static int gfx_v8_0_kiq_init_queue(struct amdgpu_=
ring *ring)
>                 /* reset MQD to a clean status */
>                 if (adev->gfx.mec.mqd_backup[mqd_idx])
>                         memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], si=
zeof(*mqd));
>
>                 /* reset ring buffer */
>                 ring->wptr =3D 0;
>                 amdgpu_ring_clear_ring(ring);
>
>                 mutex_lock(&adev->srbm_mutex);
>                 vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0=
);
> -               gfx_v8_0_kiq_init_register(ring);
> +               gfx_v8_0_mqd_deactivate(adev);
> +               gfx_v8_0_enable_doorbell(adev, ring->use_doorbell);
> +               gfx_v8_0_mqd_commit(ring);
>                 vi_srbm_select(adev, 0, 0, 0, 0);
>                 mutex_unlock(&adev->srbm_mutex);
>         } else {
> -               memset((void *)mqd, 0, sizeof(*mqd));
>                 mutex_lock(&adev->srbm_mutex);
>                 vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0=
);
>                 gfx_v8_0_mqd_init(ring);
> -               gfx_v8_0_kiq_init_register(ring);
> +               gfx_v8_0_mqd_deactivate(adev);
> +               gfx_v8_0_enable_doorbell(adev, ring->use_doorbell);
> +               gfx_v8_0_mqd_commit(ring);
>                 vi_srbm_select(adev, 0, 0, 0, 0);
>                 mutex_unlock(&adev->srbm_mutex);
>
>                 if (adev->gfx.mec.mqd_backup[mqd_idx])
>                         memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, si=
zeof(*mqd));
>         }
>
>         return 0;
>  }
>
> --
> 2.9.3
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--f403045c03224a4502054ceb7aef
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-drm-amdgpu-gfx8-unify-the-HQD-deactivation-code.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-gfx8-unify-the-HQD-deactivation-code.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j1e3za1w0

RnJvbSA1MDQxZDRlMWJlYjY1OTk4ZjY2MGE5ODlkYjllMjNhNjYyYTU5NDA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMTEgQXByIDIwMTcgMTc6Mzc6MDEgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L2dmeDg6IHVuaWZ5IHRoZSBIUUQgZGVhY3RpdmF0aW9uIGNvZGUKClRoaXMg
Y291bGQgYmUgdXNlZCBpbiBBbmRyZXMnIHByaW9yaXR5IHNjaGVkdWxpbmcgcGF0Y2gKYXMgd2Vs
bC4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgNDIgKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCAyMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAu
YwppbmRleCA1Y2ZjYjFhLi40NjFhZDIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjhfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMKQEAgLTUyOTcsMjMgKzUyOTcsMjUgQEAgc3RhdGljIGJvb2wgZ2Z4X3Y4XzBfY2hlY2tf
c29mdF9yZXNldCh2b2lkICpoYW5kbGUpCiAJfQogfQogCi1zdGF0aWMgdm9pZCBnZnhfdjhfMF9p
bmFjdGl2ZV9ocWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0JCQkJICBzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcpCitzdGF0aWMgaW50IGdmeF92OF8wX2RlYWN0aXZhdGVfaHFkKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgcmVxKQogewotCWludCBpOworCWludCBpLCByID0g
MDsKIAotCW11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwotCXZpX3NyYm1fc2VsZWN0KGFk
ZXYsIHJpbmctPm1lLCByaW5nLT5waXBlLCByaW5nLT5xdWV1ZSwgMCk7CiAJaWYgKFJSRUczMiht
bUNQX0hRRF9BQ1RJVkUpICYgQ1BfSFFEX0FDVElWRV9fQUNUSVZFX01BU0spIHsKLQkJV1JFRzMy
X0ZJRUxEKENQX0hRRF9ERVFVRVVFX1JFUVVFU1QsIERFUVVFVUVfUkVRLCAyKTsKKwkJV1JFRzMy
X0ZJRUxEKENQX0hRRF9ERVFVRVVFX1JFUVVFU1QsIERFUVVFVUVfUkVRLCByZXEpOwogCQlmb3Ig
KGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsKIAkJCWlmICghKFJSRUczMiht
bUNQX0hRRF9BQ1RJVkUpICYgQ1BfSFFEX0FDVElWRV9fQUNUSVZFX01BU0spKQogCQkJCWJyZWFr
OwogCQkJdWRlbGF5KDEpOwogCQl9CisJCWlmIChpID09IGFkZXYtPnVzZWNfdGltZW91dCkKKwkJ
CXIgPSAtRVRJTUVET1VUOwogCX0KLQl2aV9zcmJtX3NlbGVjdChhZGV2LCAwLCAwLCAwLCAwKTsK
LQltdXRleF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOworCVdSRUczMihtbUNQX0hRRF9ERVFV
RVVFX1JFUVVFU1QsIDApOworCVdSRUczMihtbUNQX0hRRF9QUV9SUFRSLCAwKTsKKwlXUkVHMzIo
bW1DUF9IUURfUFFfV1BUUiwgMCk7CisKKwlyZXR1cm4gcjsKIH0KIAogc3RhdGljIGludCBnZnhf
djhfMF9wcmVfc29mdF9yZXNldCh2b2lkICpoYW5kbGUpCkBAIC01MzQ1LDcgKzUzNDcsMTEgQEAg
c3RhdGljIGludCBnZnhfdjhfMF9wcmVfc29mdF9yZXNldCh2b2lkICpoYW5kbGUpCiAJCWZvciAo
aSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmluZ3M7IGkrKykgewogCQkJc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nID0gJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV07CiAKLQkJCWdm
eF92OF8wX2luYWN0aXZlX2hxZChhZGV2LCByaW5nKTsKKwkJCW11dGV4X2xvY2soJmFkZXYtPnNy
Ym1fbXV0ZXgpOworCQkJdmlfc3JibV9zZWxlY3QoYWRldiwgcmluZy0+bWUsIHJpbmctPnBpcGUs
IHJpbmctPnF1ZXVlLCAwKTsKKwkJCWdmeF92OF8wX2RlYWN0aXZhdGVfaHFkKGFkZXYsIDIpOwor
CQkJdmlfc3JibV9zZWxlY3QoYWRldiwgMCwgMCwgMCwgMCk7CisJCQltdXRleF91bmxvY2soJmFk
ZXYtPnNyYm1fbXV0ZXgpOwogCQl9CiAJCS8qIERpc2FibGUgTUVDIHBhcnNpbmcvcHJlZmV0Y2hp
bmcgKi8KIAkJZ2Z4X3Y4XzBfY3BfY29tcHV0ZV9lbmFibGUoYWRldiwgZmFsc2UpOwpAQCAtNTQx
NiwxOCArNTQyMiw2IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y4XzBfc29mdF9yZXNldCh2b2lkICpoYW5k
bGUpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyB2b2lkIGdmeF92OF8wX2luaXRfaHFkKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAotCQkJICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
KQotewotCW11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwotCXZpX3NyYm1fc2VsZWN0KGFk
ZXYsIHJpbmctPm1lLCByaW5nLT5waXBlLCByaW5nLT5xdWV1ZSwgMCk7Ci0JV1JFRzMyKG1tQ1Bf
SFFEX0RFUVVFVUVfUkVRVUVTVCwgMCk7Ci0JV1JFRzMyKG1tQ1BfSFFEX1BRX1JQVFIsIDApOwot
CVdSRUczMihtbUNQX0hRRF9QUV9XUFRSLCAwKTsKLQl2aV9zcmJtX3NlbGVjdChhZGV2LCAwLCAw
LCAwLCAwKTsKLQltdXRleF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwotfQotCiBzdGF0aWMg
aW50IGdmeF92OF8wX3Bvc3Rfc29mdF9yZXNldCh2b2lkICpoYW5kbGUpCiB7CiAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CkBAIC01
NDUzLDcgKzU0NDcsMTEgQEAgc3RhdGljIGludCBnZnhfdjhfMF9wb3N0X3NvZnRfcmVzZXQodm9p
ZCAqaGFuZGxlKQogCQlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3Jpbmdz
OyBpKyspIHsKIAkJCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZhZGV2LT5nZnguY29tcHV0
ZV9yaW5nW2ldOwogCi0JCQlnZnhfdjhfMF9pbml0X2hxZChhZGV2LCByaW5nKTsKKwkJCW11dGV4
X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOworCQkJdmlfc3JibV9zZWxlY3QoYWRldiwgcmluZy0+
bWUsIHJpbmctPnBpcGUsIHJpbmctPnF1ZXVlLCAwKTsKKwkJCWdmeF92OF8wX2RlYWN0aXZhdGVf
aHFkKGFkZXYsIDIpOworCQkJdmlfc3JibV9zZWxlY3QoYWRldiwgMCwgMCwgMCwgMCk7CisJCQlt
dXRleF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwogCQl9CiAJCWdmeF92OF8wX2tpcV9yZXN1
bWUoYWRldik7CiAJfQotLSAKMi41LjUKCg==
--f403045c03224a4502054ceb7aef
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--f403045c03224a4502054ceb7aef--
