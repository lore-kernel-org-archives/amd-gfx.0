From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add a workaround for GDS ordered append hangs
 with compute queues
Date: Mon, 4 Feb 2019 13:42:15 +0100
Message-ID: <1b1294f7-1604-fe49-de7f-0e234656eecd@gmail.com>
References: <20190122200546.1575-1-maraeo@gmail.com>
 <CAAxE2A7xs40YZvCQpMmv9X0Z98Sc7+ZEbFJDJLfmkMuWHzuprw@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1939624493=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7xs40YZvCQpMmv9X0Z98Sc7+ZEbFJDJLfmkMuWHzuprw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1939624493==
Content-Type: multipart/alternative;
 boundary="------------0002019224E917E8496584A8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0002019224E917E8496584A8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

At least from coding style, backward compatibility etc.. this looks sane 
to me, so feel free to add an Acked-by.

But I absolutely can't judge if that is correct from the hardware point 
of view or not.

And I think that somebody else looking at this is mandatory for it to be 
committed.

Christian.

Am 28.01.19 um 18:25 schrieb Marek Olšák:
> Ping
>
> On Tue, Jan 22, 2019 at 3:05 PM Marek Olšák <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     From: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>
>     I'm not increasing the DRM version because GDS isn't totally
>     without bugs yet.
>
>     v2: update emit_ib_size
>
>     Signed-off-by: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org
>     <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h |  2 ++
>      drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 19 +++++++++++-
>      drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 21 +++++++++++--
>      drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 40
>     +++++++++++++++++++++++--
>      include/uapi/drm/amdgpu_drm.h           |  5 ++++
>      5 files changed, 82 insertions(+), 5 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     index ecbcefe49a98..f89f5734d985 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     @@ -30,20 +30,22 @@ struct amdgpu_bo;
>      struct amdgpu_gds_asic_info {
>             uint32_t        total_size;
>             uint32_t        gfx_partition_size;
>             uint32_t        cs_partition_size;
>      };
>
>      struct amdgpu_gds {
>             struct amdgpu_gds_asic_info     mem;
>             struct amdgpu_gds_asic_info     gws;
>             struct amdgpu_gds_asic_info     oa;
>     +       uint32_t gds_compute_max_wave_id;
>     +
>             /* At present, GDS, GWS and OA resources for gfx (graphics)
>              * is always pre-allocated and available for graphics
>     operation.
>              * Such resource is shared between all gfx clients.
>              * TODO: move this operation to user space
>              * */
>             struct amdgpu_bo*               gds_gfx_bo;
>             struct amdgpu_bo*               gws_gfx_bo;
>             struct amdgpu_bo*               oa_gfx_bo;
>      };
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>     index 7984292f9282..a59e0fdf5a97 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>     @@ -2257,20 +2257,36 @@ static void
>     gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>      }
>
>      static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>                                               struct amdgpu_job *job,
>                                               struct amdgpu_ib *ib,
>                                               uint32_t flags)
>      {
>             unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>             u32 control = INDIRECT_BUFFER_VALID | ib->length_dw |
>     (vmid << 24);
>
>     +       /* Currently, there is a high possibility to get wave ID
>     mismatch
>     +        * between ME and GDS, leading to a hw deadlock, because
>     ME generates
>     +        * different wave IDs than the GDS expects. This situation
>     happens
>     +        * randomly when at least 5 compute pipes use GDS ordered
>     append.
>     +        * The wave IDs generated by ME are also wrong after
>     suspend/resume.
>     +        * Those are probably bugs somewhere else in the kernel
>     driver.
>     +        *
>     +        * Writing GDS_COMPUTE_MAX_WAVE_ID resets wave ID counters
>     in ME and
>     +        * GDS to 0 for this ring (me/pipe).
>     +        */
>     +       if (ib->flags & AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {
>     +               amdgpu_ring_write(ring,
>     PACKET3(PACKET3_SET_CONFIG_REG, 1));
>     +               amdgpu_ring_write(ring, mmGDS_COMPUTE_MAX_WAVE_ID
>     - PACKET3_SET_CONFIG_REG_START);
>     +               amdgpu_ring_write(ring,
>     ring->adev->gds.gds_compute_max_wave_id);
>     +       }
>     +
>             amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
>             amdgpu_ring_write(ring,
>      #ifdef __BIG_ENDIAN
>                                               (2 << 0) |
>      #endif
>                                               (ib->gpu_addr &
>     0xFFFFFFFC));
>             amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr) & 0xFFFF);
>             amdgpu_ring_write(ring, control);
>      }
>
>     @@ -4993,21 +5009,21 @@ static const struct amdgpu_ring_funcs
>     gfx_v7_0_ring_funcs_compute = {
>             .get_rptr = gfx_v7_0_ring_get_rptr,
>             .get_wptr = gfx_v7_0_ring_get_wptr_compute,
>             .set_wptr = gfx_v7_0_ring_set_wptr_compute,
>             .emit_frame_size =
>                     20 + /* gfx_v7_0_ring_emit_gds_switch */
>                     7 + /* gfx_v7_0_ring_emit_hdp_flush */
>                     5 + /* hdp invalidate */
>                     7 + /* gfx_v7_0_ring_emit_pipeline_sync */
>                     CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
>     gfx_v7_0_ring_emit_vm_flush */
>                     7 + 7 + 7, /* gfx_v7_0_ring_emit_fence_compute x3
>     for user fence, vm fence */
>     -       .emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_compute */
>     +       .emit_ib_size = 7, /* gfx_v7_0_ring_emit_ib_compute */
>             .emit_ib = gfx_v7_0_ring_emit_ib_compute,
>             .emit_fence = gfx_v7_0_ring_emit_fence_compute,
>             .emit_pipeline_sync = gfx_v7_0_ring_emit_pipeline_sync,
>             .emit_vm_flush = gfx_v7_0_ring_emit_vm_flush,
>             .emit_gds_switch = gfx_v7_0_ring_emit_gds_switch,
>             .emit_hdp_flush = gfx_v7_0_ring_emit_hdp_flush,
>             .test_ring = gfx_v7_0_ring_test_ring,
>             .test_ib = gfx_v7_0_ring_test_ib,
>             .insert_nop = amdgpu_ring_insert_nop,
>             .pad_ib = amdgpu_ring_generic_pad_ib,
>     @@ -5050,20 +5066,21 @@ static void gfx_v7_0_set_irq_funcs(struct
>     amdgpu_device *adev)
>             adev->gfx.priv_inst_irq.num_types = 1;
>             adev->gfx.priv_inst_irq.funcs = &gfx_v7_0_priv_inst_irq_funcs;
>      }
>
>      static void gfx_v7_0_set_gds_init(struct amdgpu_device *adev)
>      {
>             /* init asci gds info */
>             adev->gds.mem.total_size = RREG32(mmGDS_VMID0_SIZE);
>             adev->gds.gws.total_size = 64;
>             adev->gds.oa.total_size = 16;
>     +       adev->gds.gds_compute_max_wave_id =
>     RREG32(mmGDS_COMPUTE_MAX_WAVE_ID);
>
>             if (adev->gds.mem.total_size == 64 * 1024) {
>                     adev->gds.mem.gfx_partition_size = 4096;
>                     adev->gds.mem.cs_partition_size = 4096;
>
>                     adev->gds.gws.gfx_partition_size = 4;
>                     adev->gds.gws.cs_partition_size = 4;
>
>                     adev->gds.oa.gfx_partition_size = 4;
>                     adev->gds.oa.cs_partition_size = 1;
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     index a26747681ed6..b8e50a34bdb3 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     @@ -6077,20 +6077,36 @@ static void
>     gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>      }
>
>      static void gfx_v8_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>                                               struct amdgpu_job *job,
>                                               struct amdgpu_ib *ib,
>                                               uint32_t flags)
>      {
>             unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>             u32 control = INDIRECT_BUFFER_VALID | ib->length_dw |
>     (vmid << 24);
>
>     +       /* Currently, there is a high possibility to get wave ID
>     mismatch
>     +        * between ME and GDS, leading to a hw deadlock, because
>     ME generates
>     +        * different wave IDs than the GDS expects. This situation
>     happens
>     +        * randomly when at least 5 compute pipes use GDS ordered
>     append.
>     +        * The wave IDs generated by ME are also wrong after
>     suspend/resume.
>     +        * Those are probably bugs somewhere else in the kernel
>     driver.
>     +        *
>     +        * Writing GDS_COMPUTE_MAX_WAVE_ID resets wave ID counters
>     in ME and
>     +        * GDS to 0 for this ring (me/pipe).
>     +        */
>     +       if (ib->flags & AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {
>     +               amdgpu_ring_write(ring,
>     PACKET3(PACKET3_SET_CONFIG_REG, 1));
>     +               amdgpu_ring_write(ring, mmGDS_COMPUTE_MAX_WAVE_ID
>     - PACKET3_SET_CONFIG_REG_START);
>     +               amdgpu_ring_write(ring,
>     ring->adev->gds.gds_compute_max_wave_id);
>     +       }
>     +
>             amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
>             amdgpu_ring_write(ring,
>      #ifdef __BIG_ENDIAN
>                                     (2 << 0) |
>      #endif
>                                     (ib->gpu_addr & 0xFFFFFFFC));
>             amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr) & 0xFFFF);
>             amdgpu_ring_write(ring, control);
>      }
>
>     @@ -6883,21 +6899,21 @@ static const struct amdgpu_ring_funcs
>     gfx_v8_0_ring_funcs_compute = {
>             .get_rptr = gfx_v8_0_ring_get_rptr,
>             .get_wptr = gfx_v8_0_ring_get_wptr_compute,
>             .set_wptr = gfx_v8_0_ring_set_wptr_compute,
>             .emit_frame_size =
>                     20 + /* gfx_v8_0_ring_emit_gds_switch */
>                     7 + /* gfx_v8_0_ring_emit_hdp_flush */
>                     5 + /* hdp_invalidate */
>                     7 + /* gfx_v8_0_ring_emit_pipeline_sync */
>                     VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
>     gfx_v8_0_ring_emit_vm_flush */
>                     7 + 7 + 7, /* gfx_v8_0_ring_emit_fence_compute x3
>     for user fence, vm fence */
>     -       .emit_ib_size = 4, /* gfx_v8_0_ring_emit_ib_compute */
>     +       .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */
>             .emit_ib = gfx_v8_0_ring_emit_ib_compute,
>             .emit_fence = gfx_v8_0_ring_emit_fence_compute,
>             .emit_pipeline_sync = gfx_v8_0_ring_emit_pipeline_sync,
>             .emit_vm_flush = gfx_v8_0_ring_emit_vm_flush,
>             .emit_gds_switch = gfx_v8_0_ring_emit_gds_switch,
>             .emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,
>             .test_ring = gfx_v8_0_ring_test_ring,
>             .test_ib = gfx_v8_0_ring_test_ib,
>             .insert_nop = amdgpu_ring_insert_nop,
>             .pad_ib = amdgpu_ring_generic_pad_ib,
>     @@ -6913,21 +6929,21 @@ static const struct amdgpu_ring_funcs
>     gfx_v8_0_ring_funcs_kiq = {
>             .get_rptr = gfx_v8_0_ring_get_rptr,
>             .get_wptr = gfx_v8_0_ring_get_wptr_compute,
>             .set_wptr = gfx_v8_0_ring_set_wptr_compute,
>             .emit_frame_size =
>                     20 + /* gfx_v8_0_ring_emit_gds_switch */
>                     7 + /* gfx_v8_0_ring_emit_hdp_flush */
>                     5 + /* hdp_invalidate */
>                     7 + /* gfx_v8_0_ring_emit_pipeline_sync */
>                     17 + /* gfx_v8_0_ring_emit_vm_flush */
>                     7 + 7 + 7, /* gfx_v8_0_ring_emit_fence_kiq x3 for
>     user fence, vm fence */
>     -       .emit_ib_size = 4, /* gfx_v8_0_ring_emit_ib_compute */
>     +       .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */
>             .emit_fence = gfx_v8_0_ring_emit_fence_kiq,
>             .test_ring = gfx_v8_0_ring_test_ring,
>             .insert_nop = amdgpu_ring_insert_nop,
>             .pad_ib = amdgpu_ring_generic_pad_ib,
>             .emit_rreg = gfx_v8_0_ring_emit_rreg,
>             .emit_wreg = gfx_v8_0_ring_emit_wreg,
>      };
>
>      static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
>      {
>     @@ -6989,20 +7005,21 @@ static void gfx_v8_0_set_rlc_funcs(struct
>     amdgpu_device *adev)
>      {
>             adev->gfx.rlc.funcs = &iceland_rlc_funcs;
>      }
>
>      static void gfx_v8_0_set_gds_init(struct amdgpu_device *adev)
>      {
>             /* init asci gds info */
>             adev->gds.mem.total_size = RREG32(mmGDS_VMID0_SIZE);
>             adev->gds.gws.total_size = 64;
>             adev->gds.oa.total_size = 16;
>     +       adev->gds.gds_compute_max_wave_id =
>     RREG32(mmGDS_COMPUTE_MAX_WAVE_ID);
>
>             if (adev->gds.mem.total_size == 64 * 1024) {
>                     adev->gds.mem.gfx_partition_size = 4096;
>                     adev->gds.mem.cs_partition_size = 4096;
>
>                     adev->gds.gws.gfx_partition_size = 4;
>                     adev->gds.gws.cs_partition_size = 4;
>
>                     adev->gds.oa.gfx_partition_size = 4;
>                     adev->gds.oa.cs_partition_size = 1;
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     index 262ee3cf6f1c..5533f6e4f4a4 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     @@ -4003,20 +4003,36 @@ static void
>     gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>      }
>
>      static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>                                               struct amdgpu_job *job,
>                                               struct amdgpu_ib *ib,
>                                               uint32_t flags)
>      {
>             unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>             u32 control = INDIRECT_BUFFER_VALID | ib->length_dw |
>     (vmid << 24);
>
>     +       /* Currently, there is a high possibility to get wave ID
>     mismatch
>     +        * between ME and GDS, leading to a hw deadlock, because
>     ME generates
>     +        * different wave IDs than the GDS expects. This situation
>     happens
>     +        * randomly when at least 5 compute pipes use GDS ordered
>     append.
>     +        * The wave IDs generated by ME are also wrong after
>     suspend/resume.
>     +        * Those are probably bugs somewhere else in the kernel
>     driver.
>     +        *
>     +        * Writing GDS_COMPUTE_MAX_WAVE_ID resets wave ID counters
>     in ME and
>     +        * GDS to 0 for this ring (me/pipe).
>     +        */
>     +       if (ib->flags & AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {
>     +               amdgpu_ring_write(ring,
>     PACKET3(PACKET3_SET_CONFIG_REG, 1));
>     +               amdgpu_ring_write(ring, mmGDS_COMPUTE_MAX_WAVE_ID);
>     +               amdgpu_ring_write(ring,
>     ring->adev->gds.gds_compute_max_wave_id);
>     +       }
>     +
>             amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
>             BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
>             amdgpu_ring_write(ring,
>      #ifdef __BIG_ENDIAN
>                                     (2 << 0) |
>      #endif
>     lower_32_bits(ib->gpu_addr));
>             amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
>             amdgpu_ring_write(ring, control);
>      }
>     @@ -4722,21 +4738,21 @@ static const struct amdgpu_ring_funcs
>     gfx_v9_0_ring_funcs_compute = {
>             .set_wptr = gfx_v9_0_ring_set_wptr_compute,
>             .emit_frame_size =
>                     20 + /* gfx_v9_0_ring_emit_gds_switch */
>                     7 + /* gfx_v9_0_ring_emit_hdp_flush */
>                     5 + /* hdp invalidate */
>                     7 + /* gfx_v9_0_ring_emit_pipeline_sync */
>                     SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                     SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                     2 + /* gfx_v9_0_ring_emit_vm_flush */
>                     8 + 8 + 8, /* gfx_v9_0_ring_emit_fence x3 for user
>     fence, vm fence */
>     -       .emit_ib_size = 4, /* gfx_v9_0_ring_emit_ib_compute */
>     +       .emit_ib_size = 7, /* gfx_v9_0_ring_emit_ib_compute */
>             .emit_ib = gfx_v9_0_ring_emit_ib_compute,
>             .emit_fence = gfx_v9_0_ring_emit_fence,
>             .emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
>             .emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
>             .emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
>             .emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
>             .test_ring = gfx_v9_0_ring_test_ring,
>             .test_ib = gfx_v9_0_ring_test_ib,
>             .insert_nop = amdgpu_ring_insert_nop,
>             .pad_ib = amdgpu_ring_generic_pad_ib,
>     @@ -4757,21 +4773,21 @@ static const struct amdgpu_ring_funcs
>     gfx_v9_0_ring_funcs_kiq = {
>             .set_wptr = gfx_v9_0_ring_set_wptr_compute,
>             .emit_frame_size =
>                     20 + /* gfx_v9_0_ring_emit_gds_switch */
>                     7 + /* gfx_v9_0_ring_emit_hdp_flush */
>                     5 + /* hdp invalidate */
>                     7 + /* gfx_v9_0_ring_emit_pipeline_sync */
>                     SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                     SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                     2 + /* gfx_v9_0_ring_emit_vm_flush */
>                     8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for
>     user fence, vm fence */
>     -       .emit_ib_size = 4, /* gfx_v9_0_ring_emit_ib_compute */
>     +       .emit_ib_size = 7, /* gfx_v9_0_ring_emit_ib_compute */
>             .emit_fence = gfx_v9_0_ring_emit_fence_kiq,
>             .test_ring = gfx_v9_0_ring_test_ring,
>             .insert_nop = amdgpu_ring_insert_nop,
>             .pad_ib = amdgpu_ring_generic_pad_ib,
>             .emit_rreg = gfx_v9_0_ring_emit_rreg,
>             .emit_wreg = gfx_v9_0_ring_emit_wreg,
>             .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>             .emit_reg_write_reg_wait =
>     gfx_v9_0_ring_emit_reg_write_reg_wait,
>      };
>
>     @@ -4839,20 +4855,40 @@ static void gfx_v9_0_set_gds_init(struct
>     amdgpu_device *adev)
>                     adev->gds.mem.total_size = 0x10000;
>                     break;
>             case CHIP_RAVEN:
>                     adev->gds.mem.total_size = 0x1000;
>                     break;
>             default:
>                     adev->gds.mem.total_size = 0x10000;
>                     break;
>             }
>
>     +       switch (adev->asic_type) {
>     +       case CHIP_VEGA10:
>     +       case CHIP_VEGA20:
>     +               adev->gds.gds_compute_max_wave_id = 0x7ff;
>     +               break;
>     +       case CHIP_VEGA12:
>     +               adev->gds.gds_compute_max_wave_id = 0x27f;
>     +               break;
>     +       case CHIP_RAVEN:
>     +               if (adev->rev_id >= 0x8)
>     +                       adev->gds.gds_compute_max_wave_id = 0x77;
>     /* raven2 */
>     +               else
>     +                       adev->gds.gds_compute_max_wave_id = 0x15f;
>     /* raven1 */
>     +               break;
>     +       default:
>     +               /* this really depends on the chip */
>     +               adev->gds.gds_compute_max_wave_id = 0x7ff;
>     +               break;
>     +       }
>     +
>             adev->gds.gws.total_size = 64;
>             adev->gds.oa.total_size = 16;
>
>             if (adev->gds.mem.total_size == 64 * 1024) {
>                     adev->gds.mem.gfx_partition_size = 4096;
>                     adev->gds.mem.cs_partition_size = 4096;
>
>                     adev->gds.gws.gfx_partition_size = 4;
>                     adev->gds.gws.cs_partition_size = 4;
>
>     diff --git a/include/uapi/drm/amdgpu_drm.h
>     b/include/uapi/drm/amdgpu_drm.h
>     index faaad04814e4..662d379ea624 100644
>     --- a/include/uapi/drm/amdgpu_drm.h
>     +++ b/include/uapi/drm/amdgpu_drm.h
>     @@ -561,20 +561,25 @@ union drm_amdgpu_cs {
>      /* Preamble flag, which means the IB could be dropped if no
>     context switch */
>      #define AMDGPU_IB_FLAG_PREAMBLE (1<<1)
>
>      /* Preempt flag, IB should set Pre_enb bit if PREEMPT flag
>     detected */
>      #define AMDGPU_IB_FLAG_PREEMPT (1<<2)
>
>      /* The IB fence should do the L2 writeback but not invalidate any
>     shader
>       * caches (L2/vL1/sL1/I$). */
>      #define AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE (1 << 3)
>
>     +/* Set GDS_COMPUTE_MAX_WAVE_ID = DEFAULT before
>     PACKET3_INDIRECT_BUFFER.
>     + * This will reset wave ID counters for the IB.
>     + */
>     +#define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
>     +
>      struct drm_amdgpu_cs_chunk_ib {
>             __u32 _pad;
>             /** AMDGPU_IB_FLAG_* */
>             __u32 flags;
>             /** Virtual address to begin IB execution */
>             __u64 va_start;
>             /** Size of submission */
>             __u32 ib_bytes;
>             /** HW IP to submit to */
>             __u32 ip_type;
>     -- 
>     2.17.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------0002019224E917E8496584A8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">At least from coding style, backward
      compatibility etc.. this looks sane to me, so feel free to add an
      Acked-by.<br>
      <br>
      But I absolutely can't judge if that is correct from the hardware
      point of view or not.<br>
      <br>
      And I think that somebody else looking at this is mandatory for it
      to be committed.<br>
      <br>
      Christian.<br>
      <br>
      Am 28.01.19 um 18:25 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7xs40YZvCQpMmv9X0Z98Sc7+ZEbFJDJLfmkMuWHzuprw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Ping<br>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, Jan 22, 2019 at 3:05
          PM Marek Olšák &lt;<a href="mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
            moz-do-not-send="true">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From:
          Marek Olšák &lt;<a href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"
            target="_blank" moz-do-not-send="true">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
          <br>
          I'm not increasing the DRM version because GDS isn't totally
          without bugs yet.<br>
          <br>
          v2: update emit_ib_size<br>
          <br>
          Signed-off-by: Marek Olšák &lt;<a
            href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target="_blank"
            moz-do-not-send="true">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
          ---<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h |  2 ++<br>
           drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 19 +++++++++++-<br>
           drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 21 +++++++++++--<br>
           drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 40
          +++++++++++++++++++++++--<br>
           include/uapi/drm/amdgpu_drm.h           |  5 ++++<br>
           5 files changed, 82 insertions(+), 5 deletions(-)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
          index ecbcefe49a98..f89f5734d985 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
          @@ -30,20 +30,22 @@ struct amdgpu_bo;<br>
           struct amdgpu_gds_asic_info {<br>
                  uint32_t        total_size;<br>
                  uint32_t        gfx_partition_size;<br>
                  uint32_t        cs_partition_size;<br>
           };<br>
          <br>
           struct amdgpu_gds {<br>
                  struct amdgpu_gds_asic_info     mem;<br>
                  struct amdgpu_gds_asic_info     gws;<br>
                  struct amdgpu_gds_asic_info     oa;<br>
          +       uint32_t                       
          gds_compute_max_wave_id;<br>
          +<br>
                  /* At present, GDS, GWS and OA resources for gfx
          (graphics)<br>
                   * is always pre-allocated and available for graphics
          operation.<br>
                   * Such resource is shared between all gfx clients.<br>
                   * TODO: move this operation to user space<br>
                   * */<br>
                  struct amdgpu_bo*               gds_gfx_bo;<br>
                  struct amdgpu_bo*               gws_gfx_bo;<br>
                  struct amdgpu_bo*               oa_gfx_bo;<br>
           };<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
          b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
          index 7984292f9282..a59e0fdf5a97 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
          @@ -2257,20 +2257,36 @@ static void
          gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,<br>
           }<br>
          <br>
           static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring
          *ring,<br>
                                                    struct amdgpu_job
          *job,<br>
                                                    struct amdgpu_ib
          *ib,<br>
                                                    uint32_t flags)<br>
           {<br>
                  unsigned vmid = AMDGPU_JOB_GET_VMID(job);<br>
                  u32 control = INDIRECT_BUFFER_VALID | ib-&gt;length_dw
          | (vmid &lt;&lt; 24);<br>
          <br>
          +       /* Currently, there is a high possibility to get wave
          ID mismatch<br>
          +        * between ME and GDS, leading to a hw deadlock,
          because ME generates<br>
          +        * different wave IDs than the GDS expects. This
          situation happens<br>
          +        * randomly when at least 5 compute pipes use GDS
          ordered append.<br>
          +        * The wave IDs generated by ME are also wrong after
          suspend/resume.<br>
          +        * Those are probably bugs somewhere else in the
          kernel driver.<br>
          +        *<br>
          +        * Writing GDS_COMPUTE_MAX_WAVE_ID resets wave ID
          counters in ME and<br>
          +        * GDS to 0 for this ring (me/pipe).<br>
          +        */<br>
          +       if (ib-&gt;flags &amp;
          AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {<br>
          +               amdgpu_ring_write(ring,
          PACKET3(PACKET3_SET_CONFIG_REG, 1));<br>
          +               amdgpu_ring_write(ring,
          mmGDS_COMPUTE_MAX_WAVE_ID - PACKET3_SET_CONFIG_REG_START);<br>
          +               amdgpu_ring_write(ring,
          ring-&gt;adev-&gt;gds.gds_compute_max_wave_id);<br>
          +       }<br>
          +<br>
                  amdgpu_ring_write(ring,
          PACKET3(PACKET3_INDIRECT_BUFFER, 2));<br>
                  amdgpu_ring_write(ring,<br>
           #ifdef __BIG_ENDIAN<br>
                                                    (2 &lt;&lt; 0) |<br>
           #endif<br>
                                                    (ib-&gt;gpu_addr
          &amp; 0xFFFFFFFC));<br>
                  amdgpu_ring_write(ring, upper_32_bits(ib-&gt;gpu_addr)
          &amp; 0xFFFF);<br>
                  amdgpu_ring_write(ring, control);<br>
           }<br>
          <br>
          @@ -4993,21 +5009,21 @@ static const struct amdgpu_ring_funcs
          gfx_v7_0_ring_funcs_compute = {<br>
                  .get_rptr = gfx_v7_0_ring_get_rptr,<br>
                  .get_wptr = gfx_v7_0_ring_get_wptr_compute,<br>
                  .set_wptr = gfx_v7_0_ring_set_wptr_compute,<br>
                  .emit_frame_size =<br>
                          20 + /* gfx_v7_0_ring_emit_gds_switch */<br>
                          7 + /* gfx_v7_0_ring_emit_hdp_flush */<br>
                          5 + /* hdp invalidate */<br>
                          7 + /* gfx_v7_0_ring_emit_pipeline_sync */<br>
                          CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
          gfx_v7_0_ring_emit_vm_flush */<br>
                          7 + 7 + 7, /* gfx_v7_0_ring_emit_fence_compute
          x3 for user fence, vm fence */<br>
          -       .emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_compute */<br>
          +       .emit_ib_size = 7, /* gfx_v7_0_ring_emit_ib_compute */<br>
                  .emit_ib = gfx_v7_0_ring_emit_ib_compute,<br>
                  .emit_fence = gfx_v7_0_ring_emit_fence_compute,<br>
                  .emit_pipeline_sync =
          gfx_v7_0_ring_emit_pipeline_sync,<br>
                  .emit_vm_flush = gfx_v7_0_ring_emit_vm_flush,<br>
                  .emit_gds_switch = gfx_v7_0_ring_emit_gds_switch,<br>
                  .emit_hdp_flush = gfx_v7_0_ring_emit_hdp_flush,<br>
                  .test_ring = gfx_v7_0_ring_test_ring,<br>
                  .test_ib = gfx_v7_0_ring_test_ib,<br>
                  .insert_nop = amdgpu_ring_insert_nop,<br>
                  .pad_ib = amdgpu_ring_generic_pad_ib,<br>
          @@ -5050,20 +5066,21 @@ static void
          gfx_v7_0_set_irq_funcs(struct amdgpu_device *adev)<br>
                  adev-&gt;gfx.priv_inst_irq.num_types = 1;<br>
                  adev-&gt;gfx.priv_inst_irq.funcs =
          &amp;gfx_v7_0_priv_inst_irq_funcs;<br>
           }<br>
          <br>
           static void gfx_v7_0_set_gds_init(struct amdgpu_device *adev)<br>
           {<br>
                  /* init asci gds info */<br>
                  adev-&gt;gds.mem.total_size =
          RREG32(mmGDS_VMID0_SIZE);<br>
                  adev-&gt;gds.gws.total_size = 64;<br>
                  adev-&gt;gds.oa.total_size = 16;<br>
          +       adev-&gt;gds.gds_compute_max_wave_id =
          RREG32(mmGDS_COMPUTE_MAX_WAVE_ID);<br>
          <br>
                  if (adev-&gt;gds.mem.total_size == 64 * 1024) {<br>
                          adev-&gt;gds.mem.gfx_partition_size = 4096;<br>
                          adev-&gt;gds.mem.cs_partition_size = 4096;<br>
          <br>
                          adev-&gt;gds.gws.gfx_partition_size = 4;<br>
                          adev-&gt;gds.gws.cs_partition_size = 4;<br>
          <br>
                          adev-&gt;gds.oa.gfx_partition_size = 4;<br>
                          adev-&gt;gds.oa.cs_partition_size = 1;<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
          b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          index a26747681ed6..b8e50a34bdb3 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          @@ -6077,20 +6077,36 @@ static void
          gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,<br>
           }<br>
          <br>
           static void gfx_v8_0_ring_emit_ib_compute(struct amdgpu_ring
          *ring,<br>
                                                    struct amdgpu_job
          *job,<br>
                                                    struct amdgpu_ib
          *ib,<br>
                                                    uint32_t flags)<br>
           {<br>
                  unsigned vmid = AMDGPU_JOB_GET_VMID(job);<br>
                  u32 control = INDIRECT_BUFFER_VALID | ib-&gt;length_dw
          | (vmid &lt;&lt; 24);<br>
          <br>
          +       /* Currently, there is a high possibility to get wave
          ID mismatch<br>
          +        * between ME and GDS, leading to a hw deadlock,
          because ME generates<br>
          +        * different wave IDs than the GDS expects. This
          situation happens<br>
          +        * randomly when at least 5 compute pipes use GDS
          ordered append.<br>
          +        * The wave IDs generated by ME are also wrong after
          suspend/resume.<br>
          +        * Those are probably bugs somewhere else in the
          kernel driver.<br>
          +        *<br>
          +        * Writing GDS_COMPUTE_MAX_WAVE_ID resets wave ID
          counters in ME and<br>
          +        * GDS to 0 for this ring (me/pipe).<br>
          +        */<br>
          +       if (ib-&gt;flags &amp;
          AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {<br>
          +               amdgpu_ring_write(ring,
          PACKET3(PACKET3_SET_CONFIG_REG, 1));<br>
          +               amdgpu_ring_write(ring,
          mmGDS_COMPUTE_MAX_WAVE_ID - PACKET3_SET_CONFIG_REG_START);<br>
          +               amdgpu_ring_write(ring,
          ring-&gt;adev-&gt;gds.gds_compute_max_wave_id);<br>
          +       }<br>
          +<br>
                  amdgpu_ring_write(ring,
          PACKET3(PACKET3_INDIRECT_BUFFER, 2));<br>
                  amdgpu_ring_write(ring,<br>
           #ifdef __BIG_ENDIAN<br>
                                          (2 &lt;&lt; 0) |<br>
           #endif<br>
                                          (ib-&gt;gpu_addr &amp;
          0xFFFFFFFC));<br>
                  amdgpu_ring_write(ring, upper_32_bits(ib-&gt;gpu_addr)
          &amp; 0xFFFF);<br>
                  amdgpu_ring_write(ring, control);<br>
           }<br>
          <br>
          @@ -6883,21 +6899,21 @@ static const struct amdgpu_ring_funcs
          gfx_v8_0_ring_funcs_compute = {<br>
                  .get_rptr = gfx_v8_0_ring_get_rptr,<br>
                  .get_wptr = gfx_v8_0_ring_get_wptr_compute,<br>
                  .set_wptr = gfx_v8_0_ring_set_wptr_compute,<br>
                  .emit_frame_size =<br>
                          20 + /* gfx_v8_0_ring_emit_gds_switch */<br>
                          7 + /* gfx_v8_0_ring_emit_hdp_flush */<br>
                          5 + /* hdp_invalidate */<br>
                          7 + /* gfx_v8_0_ring_emit_pipeline_sync */<br>
                          VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
          gfx_v8_0_ring_emit_vm_flush */<br>
                          7 + 7 + 7, /* gfx_v8_0_ring_emit_fence_compute
          x3 for user fence, vm fence */<br>
          -       .emit_ib_size = 4, /* gfx_v8_0_ring_emit_ib_compute */<br>
          +       .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */<br>
                  .emit_ib = gfx_v8_0_ring_emit_ib_compute,<br>
                  .emit_fence = gfx_v8_0_ring_emit_fence_compute,<br>
                  .emit_pipeline_sync =
          gfx_v8_0_ring_emit_pipeline_sync,<br>
                  .emit_vm_flush = gfx_v8_0_ring_emit_vm_flush,<br>
                  .emit_gds_switch = gfx_v8_0_ring_emit_gds_switch,<br>
                  .emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,<br>
                  .test_ring = gfx_v8_0_ring_test_ring,<br>
                  .test_ib = gfx_v8_0_ring_test_ib,<br>
                  .insert_nop = amdgpu_ring_insert_nop,<br>
                  .pad_ib = amdgpu_ring_generic_pad_ib,<br>
          @@ -6913,21 +6929,21 @@ static const struct amdgpu_ring_funcs
          gfx_v8_0_ring_funcs_kiq = {<br>
                  .get_rptr = gfx_v8_0_ring_get_rptr,<br>
                  .get_wptr = gfx_v8_0_ring_get_wptr_compute,<br>
                  .set_wptr = gfx_v8_0_ring_set_wptr_compute,<br>
                  .emit_frame_size =<br>
                          20 + /* gfx_v8_0_ring_emit_gds_switch */<br>
                          7 + /* gfx_v8_0_ring_emit_hdp_flush */<br>
                          5 + /* hdp_invalidate */<br>
                          7 + /* gfx_v8_0_ring_emit_pipeline_sync */<br>
                          17 + /* gfx_v8_0_ring_emit_vm_flush */<br>
                          7 + 7 + 7, /* gfx_v8_0_ring_emit_fence_kiq x3
          for user fence, vm fence */<br>
          -       .emit_ib_size = 4, /* gfx_v8_0_ring_emit_ib_compute */<br>
          +       .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */<br>
                  .emit_fence = gfx_v8_0_ring_emit_fence_kiq,<br>
                  .test_ring = gfx_v8_0_ring_test_ring,<br>
                  .insert_nop = amdgpu_ring_insert_nop,<br>
                  .pad_ib = amdgpu_ring_generic_pad_ib,<br>
                  .emit_rreg = gfx_v8_0_ring_emit_rreg,<br>
                  .emit_wreg = gfx_v8_0_ring_emit_wreg,<br>
           };<br>
          <br>
           static void gfx_v8_0_set_ring_funcs(struct amdgpu_device
          *adev)<br>
           {<br>
          @@ -6989,20 +7005,21 @@ static void
          gfx_v8_0_set_rlc_funcs(struct amdgpu_device *adev)<br>
           {<br>
                  adev-&gt;gfx.rlc.funcs = &amp;iceland_rlc_funcs;<br>
           }<br>
          <br>
           static void gfx_v8_0_set_gds_init(struct amdgpu_device *adev)<br>
           {<br>
                  /* init asci gds info */<br>
                  adev-&gt;gds.mem.total_size =
          RREG32(mmGDS_VMID0_SIZE);<br>
                  adev-&gt;gds.gws.total_size = 64;<br>
                  adev-&gt;gds.oa.total_size = 16;<br>
          +       adev-&gt;gds.gds_compute_max_wave_id =
          RREG32(mmGDS_COMPUTE_MAX_WAVE_ID);<br>
          <br>
                  if (adev-&gt;gds.mem.total_size == 64 * 1024) {<br>
                          adev-&gt;gds.mem.gfx_partition_size = 4096;<br>
                          adev-&gt;gds.mem.cs_partition_size = 4096;<br>
          <br>
                          adev-&gt;gds.gws.gfx_partition_size = 4;<br>
                          adev-&gt;gds.gws.cs_partition_size = 4;<br>
          <br>
                          adev-&gt;gds.oa.gfx_partition_size = 4;<br>
                          adev-&gt;gds.oa.cs_partition_size = 1;<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
          b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          index 262ee3cf6f1c..5533f6e4f4a4 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          @@ -4003,20 +4003,36 @@ static void
          gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,<br>
           }<br>
          <br>
           static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring
          *ring,<br>
                                                    struct amdgpu_job
          *job,<br>
                                                    struct amdgpu_ib
          *ib,<br>
                                                    uint32_t flags)<br>
           {<br>
                  unsigned vmid = AMDGPU_JOB_GET_VMID(job);<br>
                  u32 control = INDIRECT_BUFFER_VALID | ib-&gt;length_dw
          | (vmid &lt;&lt; 24);<br>
          <br>
          +       /* Currently, there is a high possibility to get wave
          ID mismatch<br>
          +        * between ME and GDS, leading to a hw deadlock,
          because ME generates<br>
          +        * different wave IDs than the GDS expects. This
          situation happens<br>
          +        * randomly when at least 5 compute pipes use GDS
          ordered append.<br>
          +        * The wave IDs generated by ME are also wrong after
          suspend/resume.<br>
          +        * Those are probably bugs somewhere else in the
          kernel driver.<br>
          +        *<br>
          +        * Writing GDS_COMPUTE_MAX_WAVE_ID resets wave ID
          counters in ME and<br>
          +        * GDS to 0 for this ring (me/pipe).<br>
          +        */<br>
          +       if (ib-&gt;flags &amp;
          AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {<br>
          +               amdgpu_ring_write(ring,
          PACKET3(PACKET3_SET_CONFIG_REG, 1));<br>
          +               amdgpu_ring_write(ring,
          mmGDS_COMPUTE_MAX_WAVE_ID);<br>
          +               amdgpu_ring_write(ring,
          ring-&gt;adev-&gt;gds.gds_compute_max_wave_id);<br>
          +       }<br>
          +<br>
                  amdgpu_ring_write(ring,
          PACKET3(PACKET3_INDIRECT_BUFFER, 2));<br>
                  BUG_ON(ib-&gt;gpu_addr &amp; 0x3); /* Dword align */<br>
                  amdgpu_ring_write(ring,<br>
           #ifdef __BIG_ENDIAN<br>
                                          (2 &lt;&lt; 0) |<br>
           #endif<br>
                                         
          lower_32_bits(ib-&gt;gpu_addr));<br>
                  amdgpu_ring_write(ring,
          upper_32_bits(ib-&gt;gpu_addr));<br>
                  amdgpu_ring_write(ring, control);<br>
           }<br>
          @@ -4722,21 +4738,21 @@ static const struct amdgpu_ring_funcs
          gfx_v9_0_ring_funcs_compute = {<br>
                  .set_wptr = gfx_v9_0_ring_set_wptr_compute,<br>
                  .emit_frame_size =<br>
                          20 + /* gfx_v9_0_ring_emit_gds_switch */<br>
                          7 + /* gfx_v9_0_ring_emit_hdp_flush */<br>
                          5 + /* hdp invalidate */<br>
                          7 + /* gfx_v9_0_ring_emit_pipeline_sync */<br>
                          SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +<br>
                          SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +<br>
                          2 + /* gfx_v9_0_ring_emit_vm_flush */<br>
                          8 + 8 + 8, /* gfx_v9_0_ring_emit_fence x3 for
          user fence, vm fence */<br>
          -       .emit_ib_size = 4, /* gfx_v9_0_ring_emit_ib_compute */<br>
          +       .emit_ib_size = 7, /* gfx_v9_0_ring_emit_ib_compute */<br>
                  .emit_ib = gfx_v9_0_ring_emit_ib_compute,<br>
                  .emit_fence = gfx_v9_0_ring_emit_fence,<br>
                  .emit_pipeline_sync =
          gfx_v9_0_ring_emit_pipeline_sync,<br>
                  .emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,<br>
                  .emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,<br>
                  .emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,<br>
                  .test_ring = gfx_v9_0_ring_test_ring,<br>
                  .test_ib = gfx_v9_0_ring_test_ib,<br>
                  .insert_nop = amdgpu_ring_insert_nop,<br>
                  .pad_ib = amdgpu_ring_generic_pad_ib,<br>
          @@ -4757,21 +4773,21 @@ static const struct amdgpu_ring_funcs
          gfx_v9_0_ring_funcs_kiq = {<br>
                  .set_wptr = gfx_v9_0_ring_set_wptr_compute,<br>
                  .emit_frame_size =<br>
                          20 + /* gfx_v9_0_ring_emit_gds_switch */<br>
                          7 + /* gfx_v9_0_ring_emit_hdp_flush */<br>
                          5 + /* hdp invalidate */<br>
                          7 + /* gfx_v9_0_ring_emit_pipeline_sync */<br>
                          SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +<br>
                          SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +<br>
                          2 + /* gfx_v9_0_ring_emit_vm_flush */<br>
                          8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3
          for user fence, vm fence */<br>
          -       .emit_ib_size = 4, /* gfx_v9_0_ring_emit_ib_compute */<br>
          +       .emit_ib_size = 7, /* gfx_v9_0_ring_emit_ib_compute */<br>
                  .emit_fence = gfx_v9_0_ring_emit_fence_kiq,<br>
                  .test_ring = gfx_v9_0_ring_test_ring,<br>
                  .insert_nop = amdgpu_ring_insert_nop,<br>
                  .pad_ib = amdgpu_ring_generic_pad_ib,<br>
                  .emit_rreg = gfx_v9_0_ring_emit_rreg,<br>
                  .emit_wreg = gfx_v9_0_ring_emit_wreg,<br>
                  .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,<br>
                  .emit_reg_write_reg_wait =
          gfx_v9_0_ring_emit_reg_write_reg_wait,<br>
           };<br>
          <br>
          @@ -4839,20 +4855,40 @@ static void
          gfx_v9_0_set_gds_init(struct amdgpu_device *adev)<br>
                          adev-&gt;gds.mem.total_size = 0x10000;<br>
                          break;<br>
                  case CHIP_RAVEN:<br>
                          adev-&gt;gds.mem.total_size = 0x1000;<br>
                          break;<br>
                  default:<br>
                          adev-&gt;gds.mem.total_size = 0x10000;<br>
                          break;<br>
                  }<br>
          <br>
          +       switch (adev-&gt;asic_type) {<br>
          +       case CHIP_VEGA10:<br>
          +       case CHIP_VEGA20:<br>
          +               adev-&gt;gds.gds_compute_max_wave_id = 0x7ff;<br>
          +               break;<br>
          +       case CHIP_VEGA12:<br>
          +               adev-&gt;gds.gds_compute_max_wave_id = 0x27f;<br>
          +               break;<br>
          +       case CHIP_RAVEN:<br>
          +               if (adev-&gt;rev_id &gt;= 0x8)<br>
          +                       adev-&gt;gds.gds_compute_max_wave_id =
          0x77; /* raven2 */<br>
          +               else<br>
          +                       adev-&gt;gds.gds_compute_max_wave_id =
          0x15f; /* raven1 */<br>
          +               break;<br>
          +       default:<br>
          +               /* this really depends on the chip */<br>
          +               adev-&gt;gds.gds_compute_max_wave_id = 0x7ff;<br>
          +               break;<br>
          +       }<br>
          +<br>
                  adev-&gt;gds.gws.total_size = 64;<br>
                  adev-&gt;gds.oa.total_size = 16;<br>
          <br>
                  if (adev-&gt;gds.mem.total_size == 64 * 1024) {<br>
                          adev-&gt;gds.mem.gfx_partition_size = 4096;<br>
                          adev-&gt;gds.mem.cs_partition_size = 4096;<br>
          <br>
                          adev-&gt;gds.gws.gfx_partition_size = 4;<br>
                          adev-&gt;gds.gws.cs_partition_size = 4;<br>
          <br>
          diff --git a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h<br>
          index faaad04814e4..662d379ea624 100644<br>
          --- a/include/uapi/drm/amdgpu_drm.h<br>
          +++ b/include/uapi/drm/amdgpu_drm.h<br>
          @@ -561,20 +561,25 @@ union drm_amdgpu_cs {<br>
           /* Preamble flag, which means the IB could be dropped if no
          context switch */<br>
           #define AMDGPU_IB_FLAG_PREAMBLE (1&lt;&lt;1)<br>
          <br>
           /* Preempt flag, IB should set Pre_enb bit if PREEMPT flag
          detected */<br>
           #define AMDGPU_IB_FLAG_PREEMPT (1&lt;&lt;2)<br>
          <br>
           /* The IB fence should do the L2 writeback but not invalidate
          any shader<br>
            * caches (L2/vL1/sL1/I$). */<br>
           #define AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE (1 &lt;&lt; 3)<br>
          <br>
          +/* Set GDS_COMPUTE_MAX_WAVE_ID = DEFAULT before
          PACKET3_INDIRECT_BUFFER.<br>
          + * This will reset wave ID counters for the IB.<br>
          + */<br>
          +#define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 &lt;&lt; 4)<br>
          +<br>
           struct drm_amdgpu_cs_chunk_ib {<br>
                  __u32 _pad;<br>
                  /** AMDGPU_IB_FLAG_* */<br>
                  __u32 flags;<br>
                  /** Virtual address to begin IB execution */<br>
                  __u64 va_start;<br>
                  /** Size of submission */<br>
                  __u32 ib_bytes;<br>
                  /** HW IP to submit to */<br>
                  __u32 ip_type;<br>
          -- <br>
          2.17.1<br>
          <br>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0002019224E917E8496584A8--

--===============1939624493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1939624493==--
