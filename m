From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Modify the argument of emit_ib interface
Date: Tue, 23 Oct 2018 12:43:06 +0000
Message-ID: <BYAPR12MB2775CA38B33B516CF35C61B5FBF50@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1540296077-9971-1-git-send-email-Rex.Zhu@amd.com>,
 <331a74c1-2dac-52e4-363f-eaed2b1c9aa3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0988574871=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <331a74c1-2dac-52e4-363f-eaed2b1c9aa3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0988574871==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775CA38B33B516CF35C61B5FBF50BYAPR12MB2775namp_"

--_000_BYAPR12MB2775CA38B33B516CF35C61B5FBF50BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>Maybe indeed provide the CSA address as parameter instead. It doesn't
>really matter that it is unused by most IP block implementations.

>Alternative is to use a wrapper function to get the VMID from the job.


I preferred to use a wrapper function to get vmid.


Because if use CSA address as parameter, we need to check which ring it is.

The csa address is different between sdma/gfx/compute.


Best Regards

Rex






________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, October 23, 2018 8:09 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Modify the argument of emit_ib interface

Am 23.10.18 um 14:01 schrieb Rex Zhu:
> use the point of struct amdgpu_job as the function
> argument instand of vmid, so the other members of
> struct amdgpu_job can be visit in emit_ib function.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  6 ++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  6 ++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 24 +++++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/si_dma.c      |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  7 +++++--
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 10 +++++++---
>   20 files changed, 66 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index b8963b7..0b227ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -221,8 +221,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned num_ibs,
>                        !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, P=
reamble CE ib must be inserted anyway */
>                        continue;
>
> -             amdgpu_ring_emit_ib(ring, ib, job ? job->vmid : 0,
> -                                 need_ctx_switch);
> +             amdgpu_ring_emit_ib(ring, ib, job, need_ctx_switch);
>                need_ctx_switch =3D false;
>        }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 3cb7fb8..0f0f8fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -229,7 +229,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_get_rptr(r) (r)->funcs->get_rptr((r))
>   #define amdgpu_ring_get_wptr(r) (r)->funcs->get_wptr((r))
>   #define amdgpu_ring_set_wptr(r) (r)->funcs->set_wptr((r))
> -#define amdgpu_ring_emit_ib(r, ib, vmid, c) (r)->funcs->emit_ib((r), (ib=
), (vmid), (c))
> +#define amdgpu_ring_emit_ib(r, ib, job, c) ((r)->funcs->emit_ib((r), (ib=
), (job), (c)))
>   #define amdgpu_ring_emit_pipeline_sync(r) (r)->funcs->emit_pipeline_syn=
c((r))
>   #define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)->funcs->emit_vm_fl=
ush((r), (vmid), (addr))
>   #define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)->funcs->emit_fe=
nce((r), (addr), (seq), (flags))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 84dd550..8f98641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -1032,7 +1032,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_pa=
rser *p, uint32_t ib_idx)
>    *
>    */
>   void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_ib=
 *ib,
> -                          unsigned vmid, bool ctx_switch)
> +                                     struct amdgpu_job *job, bool ctx_sw=
itch)

The indentation here looks wrong on first glance.

Additional to that I would put the job before the IB in the parameter
list because it is the containing object.

>   {
>        amdgpu_ring_write(ring, VCE_CMD_IB);
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.h
> index a1f209e..06d6d87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -66,7 +66,7 @@ int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring=
, uint32_t handle,
>   int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_id=
x);
>   int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p, uint32_t ib=
_idx);
>   void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_ib=
 *ib,
> -                          unsigned vmid, bool ctx_switch);
> +                             struct amdgpu_job *job, bool ctx_switch);
>   void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64=
 seq,
>                                unsigned flags);
>   int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/=
amdgpu/cik_sdma.c
> index 32eb43d..70d4419 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -219,8 +219,9 @@ static void cik_sdma_ring_insert_nop(struct amdgpu_ri=
ng *ring, uint32_t count)
>    */
>   static void cik_sdma_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;

I'm not 100% sure if duplicating this logic over and over again is such
a good idea.

Maybe indeed provide the CSA address as parameter instead. It doesn't
really matter that it is unused by most IP block implementations.

Alternative is to use a wrapper function to get the VMID from the job.

Regards,
Christian.

>        u32 extra_bits =3D vmid & 0xf;
>
>        /* IB packet must end on a 8 DW boundary */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 622dd70..266482f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1846,8 +1846,9 @@ static void gfx_v6_0_ring_emit_fence(struct amdgpu_=
ring *ring, u64 addr,
>
>   static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
>        u32 header, control =3D 0;
>
>        /* insert SWITCH_BUFFER packet before first IB in the ring frame *=
/
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index cfa45d9..dbcd9cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2234,8 +2234,9 @@ static void gfx_v7_0_ring_emit_fence_compute(struct=
 amdgpu_ring *ring,
>    */
>   static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>                                      struct amdgpu_ib *ib,
> -                                   unsigned vmid, bool ctx_switch)
> +                                   struct amdgpu_job *job, bool ctx_swit=
ch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
>        u32 header, control =3D 0;
>
>        /* insert SWITCH_BUFFER packet before first IB in the ring frame *=
/
> @@ -2263,8 +2264,9 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu=
_ring *ring,
>
>   static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>                                          struct amdgpu_ib *ib,
> -                                       unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
>        u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 2=
4);
>
>        amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index f6cc0d3..355679a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6130,8 +6130,9 @@ static void gfx_v8_0_ring_emit_vgt_flush(struct amd=
gpu_ring *ring)
>
>   static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>                                      struct amdgpu_ib *ib,
> -                                   unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
>        u32 header, control =3D 0;
>
>        if (ib->flags & AMDGPU_IB_FLAG_CE)
> @@ -6160,8 +6161,9 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu=
_ring *ring,
>
>   static void gfx_v8_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>                                          struct amdgpu_ib *ib,
> -                                       unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
>        u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 2=
4);
>
>        amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index f1bf0b7..34bf45c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4072,9 +4072,10 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct am=
dgpu_ring *ring)
>   }
>
>   static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
> -                                      struct amdgpu_ib *ib,
> -                                      unsigned vmid, bool ctx_switch)
> +                                     struct amdgpu_ib *ib,
> +                                     struct amdgpu_job *job, bool ctx_sw=
itch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
>        u32 header, control =3D 0;
>
>        if (ib->flags & AMDGPU_IB_FLAG_CE)
> @@ -4103,20 +4104,21 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdg=
pu_ring *ring,
>   }
>
>   static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
> -                                          struct amdgpu_ib *ib,
> -                                          unsigned vmid, bool ctx_switch=
)
> +                                     struct amdgpu_ib *ib,
> +                                     struct amdgpu_job *job, bool ctx_sw=
itch)
>   {
> -        u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid <<=
 24);
> +     unsigned vmid =3D job ? job->vmid : 0;
> +     u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24=
);
>
> -        amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
> +     amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
>        BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> -        amdgpu_ring_write(ring,
> +     amdgpu_ring_write(ring,
>   #ifdef __BIG_ENDIAN
> -                                (2 << 0) |
> +                             (2 << 0) |
>   #endif
> -                                lower_32_bits(ib->gpu_addr));
> -        amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> -        amdgpu_ring_write(ring, control);
> +                             lower_32_bits(ib->gpu_addr));
> +     amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> +     amdgpu_ring_write(ring, control);
>   }
>
>   static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr=
,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index bedbd5f..d29f126 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -246,8 +246,10 @@ static void sdma_v2_4_ring_insert_nop(struct amdgpu_=
ring *ring, uint32_t count)
>    */
>   static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *ring,
>                                   struct amdgpu_ib *ib,
> -                                unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        /* IB packet must end on a 8 DW boundary */
>        sdma_v2_4_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &=
 7)) % 8);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index 6d039b6..061ef5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -420,8 +420,10 @@ static void sdma_v3_0_ring_insert_nop(struct amdgpu_=
ring *ring, uint32_t count)
>    */
>   static void sdma_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
>                                   struct amdgpu_ib *ib,
> -                                unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        /* IB packet must end on a 8 DW boundary */
>        sdma_v3_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &=
 7)) % 8);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 2b97224..452fef3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -503,8 +503,10 @@ static void sdma_v4_0_ring_insert_nop(struct amdgpu_=
ring *ring, uint32_t count)
>    */
>   static void sdma_v4_0_ring_emit_ib(struct amdgpu_ring *ring,
>                                        struct amdgpu_ib *ib,
> -                                     unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        /* IB packet must end on a 8 DW boundary */
>        sdma_v4_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &=
 7)) % 8);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/am=
dgpu/si_dma.c
> index d9b27d7..1bf54b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -62,8 +62,9 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ri=
ng)
>
>   static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
>                                struct amdgpu_ib *ib,
> -                             unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
>        /* The indirect buffer packet must end on an 8 DW boundary in the =
DMA ring.
>         * Pad as necessary with NOPs.
>         */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index 1fc17bf..4706c91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -520,7 +520,7 @@ static int uvd_v4_2_ring_test_ring(struct amdgpu_ring=
 *ring)
>    */
>   static void uvd_v4_2_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
>        amdgpu_ring_write(ring, PACKET0(mmUVD_RBC_IB_BASE, 0));
>        amdgpu_ring_write(ring, ib->gpu_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index fde6ad5..b69c2ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -536,7 +536,7 @@ static int uvd_v5_0_ring_test_ring(struct amdgpu_ring=
 *ring)
>    */
>   static void uvd_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
>        amdgpu_ring_write(ring, PACKET0(mmUVD_LMI_RBC_IB_64BIT_BAR_LOW, 0)=
);
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index 7a5b402..36f6b96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -1005,8 +1005,10 @@ static int uvd_v6_0_ring_test_ring(struct amdgpu_r=
ing *ring)
>    */
>   static void uvd_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        amdgpu_ring_write(ring, PACKET0(mmUVD_LMI_RBC_IB_VMID, 0));
>        amdgpu_ring_write(ring, vmid);
>
> @@ -1027,8 +1029,10 @@ static void uvd_v6_0_ring_emit_ib(struct amdgpu_ri=
ng *ring,
>    * Write enc ring commands to execute the indirect buffer
>    */
>   static void uvd_v6_0_enc_ring_emit_ib(struct amdgpu_ring *ring,
> -             struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)
> +             struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_swit=
ch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        amdgpu_ring_write(ring, HEVC_ENC_CMD_IB_VM);
>        amdgpu_ring_write(ring, vmid);
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index 58b39af..beda492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -1301,9 +1301,10 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct =
amdgpu_cs_parser *p,
>    */
>   static void uvd_v7_0_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
>        struct amdgpu_device *adev =3D ring->adev;
> +     unsigned vmid =3D job ? job->vmid : 0;
>
>        amdgpu_ring_write(ring,
>                PACKET0(SOC15_REG_OFFSET(UVD, ring->me, mmUVD_LMI_RBC_IB_V=
MID), 0));
> @@ -1329,8 +1330,10 @@ static void uvd_v7_0_ring_emit_ib(struct amdgpu_ri=
ng *ring,
>    * Write enc ring commands to execute the indirect buffer
>    */
>   static void uvd_v7_0_enc_ring_emit_ib(struct amdgpu_ring *ring,
> -             struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)
> +             struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_swit=
ch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        amdgpu_ring_write(ring, HEVC_ENC_CMD_IB_VM);
>        amdgpu_ring_write(ring, vmid);
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index a1feea0..26661bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -849,8 +849,10 @@ static void vce_v3_0_get_clockgating_state(void *han=
dle, u32 *flags)
>   }
>
>   static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
> -             struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)
> +             struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_swit=
ch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        amdgpu_ring_write(ring, VCE_CMD_IB_VM);
>        amdgpu_ring_write(ring, vmid);
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v4_0.c
> index 1c94718..e531cfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -952,8 +952,10 @@ static int vce_v4_0_set_powergating_state(void *hand=
le,
>   #endif
>
>   static void vce_v4_0_ring_emit_ib(struct amdgpu_ring *ring,
> -             struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)
> +             struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_swit=
ch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        amdgpu_ring_write(ring, VCE_CMD_IB_VM);
>        amdgpu_ring_write(ring, vmid);
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index eae9092..f7abf5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1367,9 +1367,10 @@ static void vcn_v1_0_dec_ring_emit_fence(struct am=
dgpu_ring *ring, u64 addr, u64
>    */
>   static void vcn_v1_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
>        struct amdgpu_device *adev =3D ring->adev;
> +     unsigned vmid =3D job ? job->vmid : 0;
>
>        amdgpu_ring_write(ring,
>                PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_LMI_RBC_IB_VMID), 0=
));
> @@ -1524,8 +1525,10 @@ static void vcn_v1_0_enc_ring_insert_end(struct am=
dgpu_ring *ring)
>    * Write enc ring commands to execute the indirect buffer
>    */
>   static void vcn_v1_0_enc_ring_emit_ib(struct amdgpu_ring *ring,
> -             struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)
> +             struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_swit=
ch)
>   {
> +     unsigned vmid =3D job ? job->vmid : 0;
> +
>        amdgpu_ring_write(ring, VCN_ENC_CMD_IB);
>        amdgpu_ring_write(ring, vmid);
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> @@ -1726,9 +1729,10 @@ static void vcn_v1_0_jpeg_ring_emit_fence(struct a=
mdgpu_ring *ring, u64 addr, u6
>    */
>   static void vcn_v1_0_jpeg_ring_emit_ib(struct amdgpu_ring *ring,
>                                  struct amdgpu_ib *ib,
> -                               unsigned vmid, bool ctx_switch)
> +                               struct amdgpu_job *job, bool ctx_switch)
>   {
>        struct amdgpu_device *adev =3D ring->adev;
> +     unsigned vmid =3D job ? job->vmid : 0;
>
>        amdgpu_ring_write(ring,
>                PACKETJ(SOC15_REG_OFFSET(UVD, 0, mmUVD_LMI_JRBC_IB_VMID), =
0, 0, PACKETJ_TYPE0));


--_000_BYAPR12MB2775CA38B33B516CF35C61B5FBF50BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">&gt;Maybe indeed provide the CSA address as parameter inste=
ad. It doesn't
<br>
&gt;really matter that it is unused by most IP block implementations.&nbsp;=
&nbsp; <br>
</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">&gt;Alternative is to use a wrapper function to get the VMI=
D from the job.</span></font><br>
</p>
<br>
<p style=3D"margin-top:0;margin-bottom:0">I preferred to use a wrapper func=
tion to get vmid.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Because if use CSA address as par=
ameter, we need to check which ring it is.</p>
<p style=3D"margin-top:0;margin-bottom:0">The csa address is different betw=
een sdma/gfx/compute.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &l=
t;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 23, 2018 8:09 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Modify the argument of emit_ib inte=
rface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 23.10.18 um 14:01 schrieb Rex Zhu:<br>
&gt; use the point of struct amdgpu_job as the function<br>
&gt; argument instand of vmid, so the other members of<br>
&gt; struct amdgpu_job can be visit in emit_ib function.<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp;&nbsp; |&nbsp;=
 3 &#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |&nbsp; 2 &#43;-<=
br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp; |&nbsp; 2 &#=
43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h&nbsp; |&nbsp; 2 &#=
43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 6 &#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 6 &#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp; | =
24 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------=
----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c&nbsp;&nbsp; |&nbsp;=
 4 &#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp; |&nbsp;=
 4 &#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp; |&nbsp;=
 4 &#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/si_dma.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 8 &#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 7 &#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 4 &#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v4_0.c&nbsp;&nbsp;&nbsp; |&=
nbsp; 4 &#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c&nbsp;&nbsp;&nbsp; | =
10 &#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; 20 files changed, 66 insertions(&#43;), 37 deletions(-)<br=
>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ib.c<br>
&gt; index b8963b7..0b227ca 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; @@ -221,8 &#43;221,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *rin=
g, unsigned num_ibs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu=
_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted a=
nyway */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ring_emit_ib(ring, ib, job ? job-&gt;vmid : 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_ctx_switch);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_ring_emit_ib(ring, ib, job, need_ctx_switch);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; need_ctx_switch =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.h<br>
&gt; index 3cb7fb8..0f0f8fb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; @@ -229,7 &#43;229,7 @@ struct amdgpu_ring {<br>
&gt;&nbsp;&nbsp; #define amdgpu_ring_get_rptr(r) (r)-&gt;funcs-&gt;get_rptr=
((r))<br>
&gt;&nbsp;&nbsp; #define amdgpu_ring_get_wptr(r) (r)-&gt;funcs-&gt;get_wptr=
((r))<br>
&gt;&nbsp;&nbsp; #define amdgpu_ring_set_wptr(r) (r)-&gt;funcs-&gt;set_wptr=
((r))<br>
&gt; -#define amdgpu_ring_emit_ib(r, ib, vmid, c) (r)-&gt;funcs-&gt;emit_ib=
((r), (ib), (vmid), (c))<br>
&gt; &#43;#define amdgpu_ring_emit_ib(r, ib, job, c) ((r)-&gt;funcs-&gt;emi=
t_ib((r), (ib), (job), (c)))<br>
&gt;&nbsp;&nbsp; #define amdgpu_ring_emit_pipeline_sync(r) (r)-&gt;funcs-&g=
t;emit_pipeline_sync((r))<br>
&gt;&nbsp;&nbsp; #define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)-&gt;f=
uncs-&gt;emit_vm_flush((r), (vmid), (addr))<br>
&gt;&nbsp;&nbsp; #define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)-&g=
t;funcs-&gt;emit_fence((r), (addr), (seq), (flags))<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vce.c<br>
&gt; index 84dd550..8f98641 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
&gt; @@ -1032,7 &#43;1032,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgp=
u_cs_parser *p, uint32_t ib_idx)<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring, str=
uct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_job *job, bool ctx_switch)<br>
<br>
The indentation here looks wrong on first glance.<br>
<br>
Additional to that I would put the job before the IB in the parameter <br>
list because it is the containing object.<br>
<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCE_=
CMD_IB);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vce.h<br>
&gt; index a1f209e..06d6d87 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
&gt; @@ -66,7 &#43;66,7 @@ int amdgpu_vce_get_destroy_msg(struct amdgpu_rin=
g *ring, uint32_t handle,<br>
&gt;&nbsp;&nbsp; int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, u=
int32_t ib_idx);<br>
&gt;&nbsp;&nbsp; int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p=
, uint32_t ib_idx);<br>
&gt;&nbsp;&nbsp; void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring, str=
uct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; unsigned vmid, bool ctx_switch);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_switch);<br>
&gt;&nbsp;&nbsp; void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, =
u64 addr, u64 seq,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned flags);<br>
&gt;&nbsp;&nbsp; int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring);<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/cik_sdma.c<br>
&gt; index 32eb43d..70d4419 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&gt; @@ -219,8 &#43;219,9 @@ static void cik_sdma_ring_insert_nop(struct am=
dgpu_ring *ring, uint32_t count)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void cik_sdma_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
<br>
I'm not 100% sure if duplicating this logic over and over again is such <br=
>
a good idea.<br>
<br>
Maybe indeed provide the CSA address as parameter instead. It doesn't <br>
really matter that it is unused by most IP block implementations.<br>
<br>
Alternative is to use a wrapper function to get the VMID from the job.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 extra_bits =3D vmid &amp=
; 0xf;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IB packet must end on a 8=
 DW boundary */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v6_0.c<br>
&gt; index 622dd70..266482f6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; @@ -1846,8 &#43;1846,9 @@ static void gfx_v6_0_ring_emit_fence(struct =
amdgpu_ring *ring, u64 addr,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* insert SWITCH_BUFFER pack=
et before first IB in the ring frame */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v7_0.c<br>
&gt; index cfa45d9..dbcd9cc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; @@ -2234,8 &#43;2234,9 @@ static void gfx_v7_0_ring_emit_fence_compute=
(struct amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *=
ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid,=
 bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd=
gpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* insert SWITCH_BUFFER pack=
et before first IB in the ring frame */<br>
&gt; @@ -2263,8 &#43;2264,9 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct=
 amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ri=
ng *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_BUF=
FER_VALID | ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET3(PACKET3_INDIRECT_BUFFER, 2));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index f6cc0d3..355679a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -6130,8 &#43;6130,9 @@ static void gfx_v8_0_ring_emit_vgt_flush(str=
uct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *=
ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid,=
 bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ib-&gt;flags &amp; AMDGP=
U_IB_FLAG_CE)<br>
&gt; @@ -6160,8 &#43;6161,9 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct=
 amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_ring_emit_ib_compute(struct amdgpu_ri=
ng *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_BUF=
FER_VALID | ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET3(PACKET3_INDIRECT_BUFFER, 2));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index f1bf0b7..34bf45c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -4072,9 &#43;4072,10 @@ static void gfx_v9_0_ring_emit_hdp_flush(st=
ruct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *=
ring,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_ib *ib,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ib-&gt;flags &amp; AMDGP=
U_IB_FLAG_CE)<br>
&gt; @@ -4103,20 &#43;4104,21 @@ static void gfx_v9_0_ring_emit_ib_gfx(stru=
ct amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ri=
ng *ring,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_ib *ib,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_B=
UFFER_VALID | ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_BUFFER_VALID | =
ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_INDIRECT_BUFFER, 2));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(PACKET3_=
INDIRECT_BUFFER, 2));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ib-&gt;gpu_addr &amp;=
 0x3); /* Dword align */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br>
&gt;&nbsp;&nbsp; #ifdef __BIG_ENDIAN<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2 &lt;&lt; 0) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (2 &lt;&lt; 0) |<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(ib-&gt;gpu_addr));=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, up=
per_32_bits(ib-&gt;gpu_addr));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, co=
ntrol);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(ib-&gt;gpu_addr));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, upper_32_bits(ib=
-&gt;gpu_addr));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, control);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *r=
ing, u64 addr,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v2_4.c<br>
&gt; index bedbd5f..d29f126 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&gt; @@ -246,8 &#43;246,10 @@ static void sdma_v2_4_ring_insert_nop(struct =
amdgpu_ring *ring, uint32_t count)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *rin=
g,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib=
 *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IB packet must end on a 8=
 DW boundary */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v2_4_ring_insert_nop(ri=
ng, (10 - (lower_32_bits(ring-&gt;wptr) &amp; 7)) % 8);<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v3_0.c<br>
&gt; index 6d039b6..061ef5f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; @@ -420,8 &#43;420,10 @@ static void sdma_v3_0_ring_insert_nop(struct =
amdgpu_ring *ring, uint32_t count)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void sdma_v3_0_ring_emit_ib(struct amdgpu_ring *rin=
g,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib=
 *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IB packet must end on a 8=
 DW boundary */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v3_0_ring_insert_nop(ri=
ng, (10 - (lower_32_bits(ring-&gt;wptr) &amp; 7)) % 8);<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v4_0.c<br>
&gt; index 2b97224..452fef3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; @@ -503,8 &#43;503,10 @@ static void sdma_v4_0_ring_insert_nop(struct =
amdgpu_ring *ring, uint32_t count)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void sdma_v4_0_ring_emit_ib(struct amdgpu_ring *rin=
g,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; un=
signed vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IB packet must end on a 8=
 DW boundary */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v4_0_ring_insert_nop(ri=
ng, (10 - (lower_32_bits(ring-&gt;wptr) &amp; 7)) % 8);<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd=
/amdgpu/si_dma.c<br>
&gt; index d9b27d7..1bf54b2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&gt; @@ -62,8 &#43;62,9 @@ static void si_dma_ring_set_wptr(struct amdgpu_r=
ing *ring)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The indirect buffer packe=
t must end on an 8 DW boundary in the DMA ring.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Pad as necessary wit=
h NOPs.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v4_2.c<br>
&gt; index 1fc17bf..4706c91 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt; @@ -520,7 &#43;520,7 @@ static int uvd_v4_2_ring_test_ring(struct amdg=
pu_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void uvd_v4_2_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_RBC_IB_BASE, 0));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ib-&=
gt;gpu_addr);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v5_0.c<br>
&gt; index fde6ad5..b69c2ac 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt; @@ -536,7 &#43;536,7 @@ static int uvd_v5_0_ring_test_ring(struct amdg=
pu_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void uvd_v5_0_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_LMI_RBC_IB_64BIT_BAR_LOW, 0));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v6_0.c<br>
&gt; index 7a5b402..36f6b96 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; @@ -1005,8 &#43;1005,10 @@ static int uvd_v6_0_ring_test_ring(struct a=
mdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void uvd_v6_0_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_LMI_RBC_IB_VMID, 0));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, vmid=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -1027,8 &#43;1029,10 @@ static void uvd_v6_0_ring_emit_ib(struct am=
dgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp; * Write enc ring commands to execute the indirect bu=
ffer<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void uvd_v6_0_enc_ring_emit_ib(struct amdgpu_ring *=
ring,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, HEVC=
_ENC_CMD_IB_VM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, vmid=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v7_0.c<br>
&gt; index 58b39af..beda492 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt; @@ -1301,9 &#43;1301,10 @@ static int uvd_v7_0_ring_patch_cs_in_place(=
struct amdgpu_cs_parser *p,<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void uvd_v7_0_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ring-&gt;adev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PACKET0(SOC15_REG_OFFSET(UVD, ring-&gt;me, mmUVD_LMI_RB=
C_IB_VMID), 0));<br>
&gt; @@ -1329,8 &#43;1330,10 @@ static void uvd_v7_0_ring_emit_ib(struct am=
dgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp; * Write enc ring commands to execute the indirect bu=
ffer<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void uvd_v7_0_enc_ring_emit_ib(struct amdgpu_ring *=
ring,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, HEVC=
_ENC_CMD_IB_VM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, vmid=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v3_0.c<br>
&gt; index a1feea0..26661bf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; @@ -849,8 &#43;849,10 @@ static void vce_v3_0_get_clockgating_state(vo=
id *handle, u32 *flags)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCE_=
CMD_IB_VM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, vmid=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v4_0.c<br>
&gt; index 1c94718..e531cfe 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt; @@ -952,8 &#43;952,10 @@ static int vce_v4_0_set_powergating_state(voi=
d *handle,<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void vce_v4_0_ring_emit_ib(struct amdgpu_ring *ring=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCE_=
CMD_IB_VM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, vmid=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v1_0.c<br>
&gt; index eae9092..f7abf5b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; @@ -1367,9 &#43;1367,10 @@ static void vcn_v1_0_dec_ring_emit_fence(st=
ruct amdgpu_ring *ring, u64 addr, u64<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void vcn_v1_0_dec_ring_emit_ib(struct amdgpu_ring *=
ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ring-&gt;adev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_LMI_RBC_IB_VMID)=
, 0));<br>
&gt; @@ -1524,8 &#43;1525,10 @@ static void vcn_v1_0_enc_ring_insert_end(st=
ruct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp; * Write enc ring commands to execute the indirect bu=
ffer<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void vcn_v1_0_enc_ring_emit_ib(struct amdgpu_ring *=
ring,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct amdgpu_ib *ib, unsigned int vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_ib *ib, struct amdgpu_job *job, bool ctx_switch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_=
ENC_CMD_IB);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, vmid=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt; @@ -1726,9 &#43;1729,10 @@ static void vcn_v1_0_jpeg_ring_emit_fence(s=
truct amdgpu_ring *ring, u64 addr, u6<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static void vcn_v1_0_jpeg_ring_emit_ib(struct amdgpu_ring =
*ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool ctx_s=
witch)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ring-&gt;adev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D job ? job-&gt;vmid : 0=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PACKETJ(SOC15_REG_OFFSET(UVD, 0, mmUVD_LMI_JRBC_IB_VMID=
), 0, 0, PACKETJ_TYPE0));<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2775CA38B33B516CF35C61B5FBF50BYAPR12MB2775namp_--

--===============0988574871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0988574871==--
