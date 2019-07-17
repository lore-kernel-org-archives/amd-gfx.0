From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: reserve GDS resources on the gfx ring for
 gfx10
Date: Wed, 17 Jul 2019 16:43:16 +0200
Message-ID: <57de127c-a6ac-c459-fc77-4da8578a41ae@gmail.com>
References: <20190717000606.7181-1-maraeo@gmail.com>
 <26330d7e-3cc0-f460-b7e0-b234597f382d@gmail.com>
 <CAAxE2A6s2SOhqhkZydtN7kzzFRzHKwRnSG-JgYGy_GceofHAsQ@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0383041703=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6s2SOhqhkZydtN7kzzFRzHKwRnSG-JgYGy_GceofHAsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0383041703==
Content-Type: multipart/alternative;
 boundary="------------E7C45430DCCF3D702BAA8703"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E7C45430DCCF3D702BAA8703
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.07.19 um 16:27 schrieb Marek Olšák:
>
>
> On Wed., Jul. 17, 2019, 03:15 Christian König, 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Am 17.07.19 um 02:06 schrieb Marek Olšák:
>     > From: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>     >
>     > Hopefully we'll only use 1 gfx ring, because otherwise we'd have
>     to have
>     > separate GDS buffers for each gfx ring.
>     >
>     > This is a workaround to ensure stability of transform feedback.
>     Shaders hang
>     > waiting for a GDS instruction (ds_sub, not ds_ordered_count).
>     >
>     > The disadvantage is that compute IBs might get a different VMID,
>     > because now gfx always has GDS and compute doesn't.
>
>     So far compute is only using GWS, but I don't think that those
>     reservations are a good idea in general.
>
>     How severe is the ENOMEM problem you see with using an explicit GWS
>     allocation?
>
>
> I guess you mean GDS or OA.

Yeah, just a typo. Compute is using GWS and we want to use GDS and OA here.

> There is no ENOMEM, it just hangs. I don't know why. The shader is 
> waiting for ds_sub and can't continue, but GDS is idle.

Well could it be because we don't correctly handle non zero offsets or 
stuff like that?

Does it work with this hack when you don't allocate GDS/OA from the 
start? (Just allocate it twice or something like this).

Christian.

>
> Marek
>
>
>     Regards,
>     Christian.
>
>     >
>     > Signed-off-by: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org
>     <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>     > ---
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 10 ++++++++++
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h |  6 ++++++
>     >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 20 ++++++++++++++++++++
>     >   4 files changed, 37 insertions(+)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     > index 4b514a44184c..cbd55d061b72 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     > @@ -456,20 +456,21 @@ struct amdgpu_cs_parser {
>     >       struct drm_file         *filp;
>     >       struct amdgpu_ctx       *ctx;
>     >
>     >       /* chunks */
>     >       unsigned                nchunks;
>     >       struct amdgpu_cs_chunk  *chunks;
>     >
>     >       /* scheduler job object */
>     >       struct amdgpu_job       *job;
>     >       struct drm_sched_entity *entity;
>     > +     unsigned                hw_ip;
>     >
>     >       /* buffer objects */
>     >       struct ww_acquire_ctx           ticket;
>     >       struct amdgpu_bo_list           *bo_list;
>     >       struct amdgpu_mn                *mn;
>     >       struct amdgpu_bo_list_entry     vm_pd;
>     >       struct list_head                validated;
>     >       struct dma_fence                *fence;
>     >       uint64_t bytes_moved_threshold;
>     >       uint64_t bytes_moved_vis_threshold;
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > index c691df6f7a57..9125cd69a124 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > @@ -678,20 +678,28 @@ static int amdgpu_cs_parser_bos(struct
>     amdgpu_cs_parser *p,
>     >       if (r)
>     >               goto error_validate;
>     >
>     >       amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>     > p->bytes_moved_vis);
>     >
>     >       gds = p->bo_list->gds_obj;
>     >       gws = p->bo_list->gws_obj;
>     >       oa = p->bo_list->oa_obj;
>     >
>     > +     if (p->hw_ip == AMDGPU_HW_IP_GFX) {
>     > +             /* Only gfx10 allocates these. */
>     > +             if (!gds)
>     > +                     gds = p->adev->gds.gds_gfx_bo;
>     > +             if (!oa)
>     > +                     oa = p->adev->gds.oa_gfx_bo;
>     > +     }
>     > +
>     >       amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>     >               struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo
>     <http://tv.bo>);
>     >
>     >               /* Make sure we use the exclusive slot for shared
>     BOs */
>     >               if (bo->prime_shared_count)
>     >                       e->tv.num_shared = 0;
>     >               e->bo_va = amdgpu_vm_bo_find(vm, bo);
>     >       }
>     >
>     >       if (gds) {
>     > @@ -954,20 +962,22 @@ static int amdgpu_cs_ib_fill(struct
>     amdgpu_device *adev,
>     >               struct drm_amdgpu_cs_chunk_ib *chunk_ib;
>     >               struct drm_sched_entity *entity;
>     >
>     >               chunk = &parser->chunks[i];
>     >               ib = &parser->job->ibs[j];
>     >               chunk_ib = (struct drm_amdgpu_cs_chunk_ib
>     *)chunk->kdata;
>     >
>     >               if (chunk->chunk_id != AMDGPU_CHUNK_ID_IB)
>     >                       continue;
>     >
>     > +             parser->hw_ip = chunk_ib->ip_type;
>     > +
>     >               if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
>     >                   (amdgpu_mcbp || amdgpu_sriov_vf(adev))) {
>     >                       if (chunk_ib->flags &
>     AMDGPU_IB_FLAG_PREEMPT) {
>     >                               if (chunk_ib->flags &
>     AMDGPU_IB_FLAG_CE)
>     >                                       ce_preempt++;
>     >                               else
>     >                                       de_preempt++;
>     >                       }
>     >
>     >                       /* each GFX command submit allows 0 or 1
>     IB preemptible for CE & DE */
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     > index df8a23554831..0943b8e1d97e 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>     > @@ -26,20 +26,26 @@
>     >
>     >   struct amdgpu_ring;
>     >   struct amdgpu_bo;
>     >
>     >   struct amdgpu_gds {
>     >       uint32_t gds_size;
>     >       uint32_t gws_size;
>     >       uint32_t oa_size;
>     >       uint32_t gds_compute_max_wave_id;
>     >       uint32_t vgt_gs_max_wave_id;
>     > +
>     > +     /* Reserved OA for the gfx ring. (gfx10) */
>     > +     uint32_t gds_gfx_reservation_size;
>     > +     uint32_t oa_gfx_reservation_size;
>     > +     struct amdgpu_bo *gds_gfx_bo;
>     > +     struct amdgpu_bo *oa_gfx_bo;
>     >   };
>     >
>     >   struct amdgpu_gds_reg_offset {
>     >       uint32_t        mem_base;
>     >       uint32_t        mem_size;
>     >       uint32_t        gws;
>     >       uint32_t        oa;
>     >   };
>     >
>     >   #endif /* __AMDGPU_GDS_H__ */
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     > index 618291df659b..3952754c04ff 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     > @@ -1314,20 +1314,33 @@ static int gfx_v10_0_sw_init(void *handle)
>     >
>     >       kiq = &adev->gfx.kiq;
>     >       r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
>     >       if (r)
>     >               return r;
>     >
>     >       r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct
>     v10_compute_mqd));
>     >       if (r)
>     >               return r;
>     >
>     > +     /* allocate reserved GDS resources for transform feedback */
>     > +     r = amdgpu_bo_create_kernel(adev,
>     adev->gds.gds_gfx_reservation_size,
>     > +                                 4, AMDGPU_GEM_DOMAIN_GDS,
>     > +  &adev->gds.gds_gfx_bo, NULL, NULL);
>     > +     if (r)
>     > +             return r;
>     > +
>     > +     r = amdgpu_bo_create_kernel(adev,
>     adev->gds.oa_gfx_reservation_size,
>     > +                                 1, AMDGPU_GEM_DOMAIN_OA,
>     > +  &adev->gds.oa_gfx_bo, NULL, NULL);
>     > +     if (r)
>     > +             return r;
>     > +
>     >       /* allocate visible FB for rlc auto-loading fw */
>     >       if (adev->firmware.load_type ==
>     AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
>     >               r = gfx_v10_0_rlc_backdoor_autoload_buffer_init(adev);
>     >               if (r)
>     >                       return r;
>     >       }
>     >
>     >       adev->gfx.ce_ram_size = F32_CE_PROGRAM_RAM_SIZE;
>     >
>     >       gfx_v10_0_gpu_early_init(adev);
>     > @@ -1354,20 +1367,23 @@ static void gfx_v10_0_me_fini(struct
>     amdgpu_device *adev)
>     >  amdgpu_bo_free_kernel(&adev->gfx.me.me_fw_obj,
>     >  &adev->gfx.me.me_fw_gpu_addr,
>     >                             (void **)&adev->gfx.me.me_fw_ptr);
>     >   }
>     >
>     >   static int gfx_v10_0_sw_fini(void *handle)
>     >   {
>     >       int i;
>     >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>     >
>     > +  amdgpu_bo_free_kernel(&adev->gds.gds_gfx_bo, NULL, NULL);
>     > +  amdgpu_bo_free_kernel(&adev->gds.oa_gfx_bo, NULL, NULL);
>     > +
>     >       for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>     >  amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>     >       for (i = 0; i < adev->gfx.num_compute_rings; i++)
>     >  amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>     >
>     >       amdgpu_gfx_mqd_sw_fini(adev);
>     >  amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
>     >       amdgpu_gfx_kiq_fini(adev);
>     >
>     >       gfx_v10_0_pfp_fini(adev);
>     > @@ -5181,20 +5197,24 @@ static void
>     gfx_v10_0_set_gds_init(struct amdgpu_device *adev)
>     >       case CHIP_NAVI10:
>     >       default:
>     >               adev->gds.gds_size = 0x10000;
>     >               adev->gds.gds_compute_max_wave_id = 0x4ff;
>     >               adev->gds.vgt_gs_max_wave_id = 0x3ff;
>     >               break;
>     >       }
>     >
>     >       adev->gds.gws_size = 64;
>     >       adev->gds.oa_size = 16;
>     > +
>     > +     /* Reserved for transform feedback. */
>     > +     adev->gds.gds_gfx_reservation_size = 256;
>     > +     adev->gds.oa_gfx_reservation_size = 4;
>     >   }
>     >
>     >   static void
>     gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device
>     *adev,
>     >    u32 bitmap)
>     >   {
>     >       u32 data;
>     >
>     >       if (!bitmap)
>     >               return;
>     >
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------E7C45430DCCF3D702BAA8703
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 17.07.19 um 16:27 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A6s2SOhqhkZydtN7kzzFRzHKwRnSG-JgYGy_GceofHAsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div><br>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">On Wed., Jul. 17, 2019,
              03:15 Christian König, &lt;<a
                href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Am
              17.07.19 um 02:06 schrieb Marek Olšák:<br>
              &gt; From: Marek Olšák &lt;<a
                href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target="_blank"
                rel="noreferrer" moz-do-not-send="true">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
              &gt;<br>
              &gt; Hopefully we'll only use 1 gfx ring, because
              otherwise we'd have to have<br>
              &gt; separate GDS buffers for each gfx ring.<br>
              &gt;<br>
              &gt; This is a workaround to ensure stability of transform
              feedback. Shaders hang<br>
              &gt; waiting for a GDS instruction (ds_sub, not
              ds_ordered_count).<br>
              &gt;<br>
              &gt; The disadvantage is that compute IBs might get a
              different VMID,<br>
              &gt; because now gfx always has GDS and compute doesn't.<br>
              <br>
              So far compute is only using GWS, but I don't think that
              those <br>
              reservations are a good idea in general.<br>
              <br>
              How severe is the ENOMEM problem you see with using an
              explicit GWS <br>
              allocation?<br>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">I guess you mean GDS or OA.</div>
      </div>
    </blockquote>
    <br>
    Yeah, just a typo. Compute is using GWS and we want to use GDS and
    OA here.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6s2SOhqhkZydtN7kzzFRzHKwRnSG-JgYGy_GceofHAsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="auto">
        <div dir="auto">There is no ENOMEM, it just hangs. I don't know
          why. The shader is waiting for ds_sub and can't continue, but
          GDS is idle.</div>
      </div>
    </blockquote>
    <br>
    Well could it be because we don't correctly handle non zero offsets
    or stuff like that?<br>
    <br>
    Does it work with this hack when you don't allocate GDS/OA from the
    start? (Just allocate it twice or something like this).<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6s2SOhqhkZydtN7kzzFRzHKwRnSG-JgYGy_GceofHAsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              &gt;<br>
              &gt; Signed-off-by: Marek Olšák &lt;<a
                href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target="_blank"
                rel="noreferrer" moz-do-not-send="true">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
              &gt; ---<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 10
              ++++++++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h |  6 ++++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 20
              ++++++++++++++++++++<br>
              &gt;   4 files changed, 37 insertions(+)<br>
              &gt;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; index 4b514a44184c..cbd55d061b72 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; @@ -456,20 +456,21 @@ struct amdgpu_cs_parser {<br>
              &gt;       struct drm_file         *filp;<br>
              &gt;       struct amdgpu_ctx       *ctx;<br>
              &gt;   <br>
              &gt;       /* chunks */<br>
              &gt;       unsigned                nchunks;<br>
              &gt;       struct amdgpu_cs_chunk  *chunks;<br>
              &gt;   <br>
              &gt;       /* scheduler job object */<br>
              &gt;       struct amdgpu_job       *job;<br>
              &gt;       struct drm_sched_entity *entity;<br>
              &gt; +     unsigned                hw_ip;<br>
              &gt;   <br>
              &gt;       /* buffer objects */<br>
              &gt;       struct ww_acquire_ctx           ticket;<br>
              &gt;       struct amdgpu_bo_list           *bo_list;<br>
              &gt;       struct amdgpu_mn                *mn;<br>
              &gt;       struct amdgpu_bo_list_entry     vm_pd;<br>
              &gt;       struct list_head                validated;<br>
              &gt;       struct dma_fence                *fence;<br>
              &gt;       uint64_t                       
              bytes_moved_threshold;<br>
              &gt;       uint64_t                       
              bytes_moved_vis_threshold;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; index c691df6f7a57..9125cd69a124 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; @@ -678,20 +678,28 @@ static int
              amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,<br>
              &gt;       if (r)<br>
              &gt;               goto error_validate;<br>
              &gt;   <br>
              &gt;       amdgpu_cs_report_moved_bytes(p-&gt;adev,
              p-&gt;bytes_moved,<br>
              &gt;                                   
              p-&gt;bytes_moved_vis);<br>
              &gt;   <br>
              &gt;       gds = p-&gt;bo_list-&gt;gds_obj;<br>
              &gt;       gws = p-&gt;bo_list-&gt;gws_obj;<br>
              &gt;       oa = p-&gt;bo_list-&gt;oa_obj;<br>
              &gt;   <br>
              &gt; +     if (p-&gt;hw_ip == AMDGPU_HW_IP_GFX) {<br>
              &gt; +             /* Only gfx10 allocates these. */<br>
              &gt; +             if (!gds)<br>
              &gt; +                     gds =
              p-&gt;adev-&gt;gds.gds_gfx_bo;<br>
              &gt; +             if (!oa)<br>
              &gt; +                     oa =
              p-&gt;adev-&gt;gds.oa_gfx_bo;<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt;       amdgpu_bo_list_for_each_entry(e, p-&gt;bo_list)
              {<br>
              &gt;               struct amdgpu_bo *bo =
              ttm_to_amdgpu_bo(e-&gt;<a href="http://tv.bo"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">tv.bo</a>);<br>
              &gt;   <br>
              &gt;               /* Make sure we use the exclusive slot
              for shared BOs */<br>
              &gt;               if (bo-&gt;prime_shared_count)<br>
              &gt;                       e-&gt;tv.num_shared = 0;<br>
              &gt;               e-&gt;bo_va = amdgpu_vm_bo_find(vm,
              bo);<br>
              &gt;       }<br>
              &gt;   <br>
              &gt;       if (gds) {<br>
              &gt; @@ -954,20 +962,22 @@ static int
              amdgpu_cs_ib_fill(struct amdgpu_device *adev,<br>
              &gt;               struct drm_amdgpu_cs_chunk_ib
              *chunk_ib;<br>
              &gt;               struct drm_sched_entity *entity;<br>
              &gt;   <br>
              &gt;               chunk = &amp;parser-&gt;chunks[i];<br>
              &gt;               ib = &amp;parser-&gt;job-&gt;ibs[j];<br>
              &gt;               chunk_ib = (struct
              drm_amdgpu_cs_chunk_ib *)chunk-&gt;kdata;<br>
              &gt;   <br>
              &gt;               if (chunk-&gt;chunk_id !=
              AMDGPU_CHUNK_ID_IB)<br>
              &gt;                       continue;<br>
              &gt;   <br>
              &gt; +             parser-&gt;hw_ip =
              chunk_ib-&gt;ip_type;<br>
              &gt; +<br>
              &gt;               if (chunk_ib-&gt;ip_type ==
              AMDGPU_HW_IP_GFX &amp;&amp;<br>
              &gt;                   (amdgpu_mcbp ||
              amdgpu_sriov_vf(adev))) {<br>
              &gt;                       if (chunk_ib-&gt;flags &amp;
              AMDGPU_IB_FLAG_PREEMPT) {<br>
              &gt;                               if (chunk_ib-&gt;flags
              &amp; AMDGPU_IB_FLAG_CE)<br>
              &gt;                                       ce_preempt++;<br>
              &gt;                               else<br>
              &gt;                                       de_preempt++;<br>
              &gt;                       }<br>
              &gt;   <br>
              &gt;                       /* each GFX command submit
              allows 0 or 1 IB preemptible for CE &amp; DE */<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
              &gt; index df8a23554831..0943b8e1d97e 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
              &gt; @@ -26,20 +26,26 @@<br>
              &gt;   <br>
              &gt;   struct amdgpu_ring;<br>
              &gt;   struct amdgpu_bo;<br>
              &gt;   <br>
              &gt;   struct amdgpu_gds {<br>
              &gt;       uint32_t gds_size;<br>
              &gt;       uint32_t gws_size;<br>
              &gt;       uint32_t oa_size;<br>
              &gt;       uint32_t gds_compute_max_wave_id;<br>
              &gt;       uint32_t vgt_gs_max_wave_id;<br>
              &gt; +<br>
              &gt; +     /* Reserved OA for the gfx ring. (gfx10) */<br>
              &gt; +     uint32_t gds_gfx_reservation_size;<br>
              &gt; +     uint32_t oa_gfx_reservation_size;<br>
              &gt; +     struct amdgpu_bo *gds_gfx_bo;<br>
              &gt; +     struct amdgpu_bo *oa_gfx_bo;<br>
              &gt;   };<br>
              &gt;   <br>
              &gt;   struct amdgpu_gds_reg_offset {<br>
              &gt;       uint32_t        mem_base;<br>
              &gt;       uint32_t        mem_size;<br>
              &gt;       uint32_t        gws;<br>
              &gt;       uint32_t        oa;<br>
              &gt;   };<br>
              &gt;   <br>
              &gt;   #endif /* __AMDGPU_GDS_H__ */<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
              b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt; index 618291df659b..3952754c04ff 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt; @@ -1314,20 +1314,33 @@ static int
              gfx_v10_0_sw_init(void *handle)<br>
              &gt;   <br>
              &gt;       kiq = &amp;adev-&gt;gfx.kiq;<br>
              &gt;       r = amdgpu_gfx_kiq_init_ring(adev,
              &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);<br>
              &gt;       if (r)<br>
              &gt;               return r;<br>
              &gt;   <br>
              &gt;       r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct
              v10_compute_mqd));<br>
              &gt;       if (r)<br>
              &gt;               return r;<br>
              &gt;   <br>
              &gt; +     /* allocate reserved GDS resources for
              transform feedback */<br>
              &gt; +     r = amdgpu_bo_create_kernel(adev,
              adev-&gt;gds.gds_gfx_reservation_size,<br>
              &gt; +                                 4,
              AMDGPU_GEM_DOMAIN_GDS,<br>
              &gt; +                               
               &amp;adev-&gt;gds.gds_gfx_bo, NULL, NULL);<br>
              &gt; +     if (r)<br>
              &gt; +             return r;<br>
              &gt; +<br>
              &gt; +     r = amdgpu_bo_create_kernel(adev,
              adev-&gt;gds.oa_gfx_reservation_size,<br>
              &gt; +                                 1,
              AMDGPU_GEM_DOMAIN_OA,<br>
              &gt; +                               
               &amp;adev-&gt;gds.oa_gfx_bo, NULL, NULL);<br>
              &gt; +     if (r)<br>
              &gt; +             return r;<br>
              &gt; +<br>
              &gt;       /* allocate visible FB for rlc auto-loading fw
              */<br>
              &gt;       if (adev-&gt;firmware.load_type ==
              AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {<br>
              &gt;               r =
              gfx_v10_0_rlc_backdoor_autoload_buffer_init(adev);<br>
              &gt;               if (r)<br>
              &gt;                       return r;<br>
              &gt;       }<br>
              &gt;   <br>
              &gt;       adev-&gt;gfx.ce_ram_size =
              F32_CE_PROGRAM_RAM_SIZE;<br>
              &gt;   <br>
              &gt;       gfx_v10_0_gpu_early_init(adev);<br>
              &gt; @@ -1354,20 +1367,23 @@ static void
              gfx_v10_0_me_fini(struct amdgpu_device *adev)<br>
              &gt;     
               amdgpu_bo_free_kernel(&amp;adev-&gt;gfx.me.me_fw_obj,<br>
              &gt;                           
               &amp;adev-&gt;gfx.me.me_fw_gpu_addr,<br>
              &gt;                             (void
              **)&amp;adev-&gt;gfx.me.me_fw_ptr);<br>
              &gt;   }<br>
              &gt;   <br>
              &gt;   static int gfx_v10_0_sw_fini(void *handle)<br>
              &gt;   {<br>
              &gt;       int i;<br>
              &gt;       struct amdgpu_device *adev = (struct
              amdgpu_device *)handle;<br>
              &gt;   <br>
              &gt; +   
               amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gds_gfx_bo, NULL,
              NULL);<br>
              &gt; +   
               amdgpu_bo_free_kernel(&amp;adev-&gt;gds.oa_gfx_bo, NULL,
              NULL);<br>
              &gt; +<br>
              &gt;       for (i = 0; i &lt; adev-&gt;gfx.num_gfx_rings;
              i++)<br>
              &gt;             
               amdgpu_ring_fini(&amp;adev-&gt;gfx.gfx_ring[i]);<br>
              &gt;       for (i = 0; i &lt;
              adev-&gt;gfx.num_compute_rings; i++)<br>
              &gt;             
               amdgpu_ring_fini(&amp;adev-&gt;gfx.compute_ring[i]);<br>
              &gt;   <br>
              &gt;       amdgpu_gfx_mqd_sw_fini(adev);<br>
              &gt;     
               amdgpu_gfx_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring,
              &amp;adev-&gt;gfx.kiq.irq);<br>
              &gt;       amdgpu_gfx_kiq_fini(adev);<br>
              &gt;   <br>
              &gt;       gfx_v10_0_pfp_fini(adev);<br>
              &gt; @@ -5181,20 +5197,24 @@ static void
              gfx_v10_0_set_gds_init(struct amdgpu_device *adev)<br>
              &gt;       case CHIP_NAVI10:<br>
              &gt;       default:<br>
              &gt;               adev-&gt;gds.gds_size = 0x10000;<br>
              &gt;               adev-&gt;gds.gds_compute_max_wave_id =
              0x4ff;<br>
              &gt;               adev-&gt;gds.vgt_gs_max_wave_id =
              0x3ff;<br>
              &gt;               break;<br>
              &gt;       }<br>
              &gt;   <br>
              &gt;       adev-&gt;gds.gws_size = 64;<br>
              &gt;       adev-&gt;gds.oa_size = 16;<br>
              &gt; +<br>
              &gt; +     /* Reserved for transform feedback. */<br>
              &gt; +     adev-&gt;gds.gds_gfx_reservation_size = 256;<br>
              &gt; +     adev-&gt;gds.oa_gfx_reservation_size = 4;<br>
              &gt;   }<br>
              &gt;   <br>
              &gt;   static void
              gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct
              amdgpu_device *adev,<br>
              &gt;                                                     
                 u32 bitmap)<br>
              &gt;   {<br>
              &gt;       u32 data;<br>
              &gt;   <br>
              &gt;       if (!bitmap)<br>
              &gt;               return;<br>
              &gt;   <br>
              <br>
            </blockquote>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------E7C45430DCCF3D702BAA8703--

--===============0383041703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0383041703==--
