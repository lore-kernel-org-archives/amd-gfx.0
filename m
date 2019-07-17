From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: reserve GDS resources on the gfx ring for
 gfx10
Date: Wed, 17 Jul 2019 10:54:19 -0400
Message-ID: <CAAxE2A67J0gN=ZV2t66zPc+E9kJDyFghd6oGobu4DLT5hvK1gA@mail.gmail.com>
References: <20190717000606.7181-1-maraeo@gmail.com>
 <26330d7e-3cc0-f460-b7e0-b234597f382d@gmail.com>
 <CAAxE2A6s2SOhqhkZydtN7kzzFRzHKwRnSG-JgYGy_GceofHAsQ@mail.gmail.com>
 <57de127c-a6ac-c459-fc77-4da8578a41ae@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1926491740=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57de127c-a6ac-c459-fc77-4da8578a41ae-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1926491740==
Content-Type: multipart/alternative; boundary="000000000000c4d2ff058de1abe6"

--000000000000c4d2ff058de1abe6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed., Jul. 17, 2019, 10:43 Christian K=C3=B6nig, <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 17.07.19 um 16:27 schrieb Marek Ol=C5=A1=C3=A1k:
>
>
>
> On Wed., Jul. 17, 2019, 03:15 Christian K=C3=B6nig, <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> Am 17.07.19 um 02:06 schrieb Marek Ol=C5=A1=C3=A1k:
>> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>> >
>> > Hopefully we'll only use 1 gfx ring, because otherwise we'd have to ha=
ve
>> > separate GDS buffers for each gfx ring.
>> >
>> > This is a workaround to ensure stability of transform feedback. Shader=
s
>> hang
>> > waiting for a GDS instruction (ds_sub, not ds_ordered_count).
>> >
>> > The disadvantage is that compute IBs might get a different VMID,
>> > because now gfx always has GDS and compute doesn't.
>>
>> So far compute is only using GWS, but I don't think that those
>> reservations are a good idea in general.
>>
>> How severe is the ENOMEM problem you see with using an explicit GWS
>> allocation?
>>
>
> I guess you mean GDS or OA.
>
>
> Yeah, just a typo. Compute is using GWS and we want to use GDS and OA her=
e.
>
> There is no ENOMEM, it just hangs. I don't know why. The shader is waitin=
g
> for ds_sub and can't continue, but GDS is idle.
>
>
> Well could it be because we don't correctly handle non zero offsets or
> stuff like that?
>

I don't know what you mean.


> Does it work with this hack when you don't allocate GDS/OA from the start=
?
> (Just allocate it twice or something like this).
>

It's only allocated once by the kernel with this hack.

Marek


> Christian.
>
>
> Marek
>
>
>> Regards,
>> Christian.
>>
>> >
>> > Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 10 ++++++++++
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h |  6 ++++++
>> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 20 ++++++++++++++++++++
>> >   4 files changed, 37 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> > index 4b514a44184c..cbd55d061b72 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> > @@ -456,20 +456,21 @@ struct amdgpu_cs_parser {
>> >       struct drm_file         *filp;
>> >       struct amdgpu_ctx       *ctx;
>> >
>> >       /* chunks */
>> >       unsigned                nchunks;
>> >       struct amdgpu_cs_chunk  *chunks;
>> >
>> >       /* scheduler job object */
>> >       struct amdgpu_job       *job;
>> >       struct drm_sched_entity *entity;
>> > +     unsigned                hw_ip;
>> >
>> >       /* buffer objects */
>> >       struct ww_acquire_ctx           ticket;
>> >       struct amdgpu_bo_list           *bo_list;
>> >       struct amdgpu_mn                *mn;
>> >       struct amdgpu_bo_list_entry     vm_pd;
>> >       struct list_head                validated;
>> >       struct dma_fence                *fence;
>> >       uint64_t                        bytes_moved_threshold;
>> >       uint64_t                        bytes_moved_vis_threshold;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > index c691df6f7a57..9125cd69a124 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > @@ -678,20 +678,28 @@ static int amdgpu_cs_parser_bos(struct
>> amdgpu_cs_parser *p,
>> >       if (r)
>> >               goto error_validate;
>> >
>> >       amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>> >                                    p->bytes_moved_vis);
>> >
>> >       gds =3D p->bo_list->gds_obj;
>> >       gws =3D p->bo_list->gws_obj;
>> >       oa =3D p->bo_list->oa_obj;
>> >
>> > +     if (p->hw_ip =3D=3D AMDGPU_HW_IP_GFX) {
>> > +             /* Only gfx10 allocates these. */
>> > +             if (!gds)
>> > +                     gds =3D p->adev->gds.gds_gfx_bo;
>> > +             if (!oa)
>> > +                     oa =3D p->adev->gds.oa_gfx_bo;
>> > +     }
>> > +
>> >       amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>> >               struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(e->tv.bo);
>> >
>> >               /* Make sure we use the exclusive slot for shared BOs */
>> >               if (bo->prime_shared_count)
>> >                       e->tv.num_shared =3D 0;
>> >               e->bo_va =3D amdgpu_vm_bo_find(vm, bo);
>> >       }
>> >
>> >       if (gds) {
>> > @@ -954,20 +962,22 @@ static int amdgpu_cs_ib_fill(struct amdgpu_devic=
e
>> *adev,
>> >               struct drm_amdgpu_cs_chunk_ib *chunk_ib;
>> >               struct drm_sched_entity *entity;
>> >
>> >               chunk =3D &parser->chunks[i];
>> >               ib =3D &parser->job->ibs[j];
>> >               chunk_ib =3D (struct drm_amdgpu_cs_chunk_ib *)chunk->kda=
ta;
>> >
>> >               if (chunk->chunk_id !=3D AMDGPU_CHUNK_ID_IB)
>> >                       continue;
>> >
>> > +             parser->hw_ip =3D chunk_ib->ip_type;
>> > +
>> >               if (chunk_ib->ip_type =3D=3D AMDGPU_HW_IP_GFX &&
>> >                   (amdgpu_mcbp || amdgpu_sriov_vf(adev))) {
>> >                       if (chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
>> >                               if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
>> >                                       ce_preempt++;
>> >                               else
>> >                                       de_preempt++;
>> >                       }
>> >
>> >                       /* each GFX command submit allows 0 or 1 IB
>> preemptible for CE & DE */
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>> > index df8a23554831..0943b8e1d97e 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>> > @@ -26,20 +26,26 @@
>> >
>> >   struct amdgpu_ring;
>> >   struct amdgpu_bo;
>> >
>> >   struct amdgpu_gds {
>> >       uint32_t gds_size;
>> >       uint32_t gws_size;
>> >       uint32_t oa_size;
>> >       uint32_t gds_compute_max_wave_id;
>> >       uint32_t vgt_gs_max_wave_id;
>> > +
>> > +     /* Reserved OA for the gfx ring. (gfx10) */
>> > +     uint32_t gds_gfx_reservation_size;
>> > +     uint32_t oa_gfx_reservation_size;
>> > +     struct amdgpu_bo *gds_gfx_bo;
>> > +     struct amdgpu_bo *oa_gfx_bo;
>> >   };
>> >
>> >   struct amdgpu_gds_reg_offset {
>> >       uint32_t        mem_base;
>> >       uint32_t        mem_size;
>> >       uint32_t        gws;
>> >       uint32_t        oa;
>> >   };
>> >
>> >   #endif /* __AMDGPU_GDS_H__ */
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> > index 618291df659b..3952754c04ff 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> > @@ -1314,20 +1314,33 @@ static int gfx_v10_0_sw_init(void *handle)
>> >
>> >       kiq =3D &adev->gfx.kiq;
>> >       r =3D amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
>> >       if (r)
>> >               return r;
>> >
>> >       r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd=
));
>> >       if (r)
>> >               return r;
>> >
>> > +     /* allocate reserved GDS resources for transform feedback */
>> > +     r =3D amdgpu_bo_create_kernel(adev,
>> adev->gds.gds_gfx_reservation_size,
>> > +                                 4, AMDGPU_GEM_DOMAIN_GDS,
>> > +                                 &adev->gds.gds_gfx_bo, NULL, NULL);
>> > +     if (r)
>> > +             return r;
>> > +
>> > +     r =3D amdgpu_bo_create_kernel(adev,
>> adev->gds.oa_gfx_reservation_size,
>> > +                                 1, AMDGPU_GEM_DOMAIN_OA,
>> > +                                 &adev->gds.oa_gfx_bo, NULL, NULL);
>> > +     if (r)
>> > +             return r;
>> > +
>> >       /* allocate visible FB for rlc auto-loading fw */
>> >       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_RLC_BACKDOOR_=
AUTO)
>> {
>> >               r =3D gfx_v10_0_rlc_backdoor_autoload_buffer_init(adev);
>> >               if (r)
>> >                       return r;
>> >       }
>> >
>> >       adev->gfx.ce_ram_size =3D F32_CE_PROGRAM_RAM_SIZE;
>> >
>> >       gfx_v10_0_gpu_early_init(adev);
>> > @@ -1354,20 +1367,23 @@ static void gfx_v10_0_me_fini(struct
>> amdgpu_device *adev)
>> >       amdgpu_bo_free_kernel(&adev->gfx.me.me_fw_obj,
>> >                             &adev->gfx.me.me_fw_gpu_addr,
>> >                             (void **)&adev->gfx.me.me_fw_ptr);
>> >   }
>> >
>> >   static int gfx_v10_0_sw_fini(void *handle)
>> >   {
>> >       int i;
>> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> >
>> > +     amdgpu_bo_free_kernel(&adev->gds.gds_gfx_bo, NULL, NULL);
>> > +     amdgpu_bo_free_kernel(&adev->gds.oa_gfx_bo, NULL, NULL);
>> > +
>> >       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>> >               amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>> >       for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>> >               amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>> >
>> >       amdgpu_gfx_mqd_sw_fini(adev);
>> >       amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq=
);
>> >       amdgpu_gfx_kiq_fini(adev);
>> >
>> >       gfx_v10_0_pfp_fini(adev);
>> > @@ -5181,20 +5197,24 @@ static void gfx_v10_0_set_gds_init(struct
>> amdgpu_device *adev)
>> >       case CHIP_NAVI10:
>> >       default:
>> >               adev->gds.gds_size =3D 0x10000;
>> >               adev->gds.gds_compute_max_wave_id =3D 0x4ff;
>> >               adev->gds.vgt_gs_max_wave_id =3D 0x3ff;
>> >               break;
>> >       }
>> >
>> >       adev->gds.gws_size =3D 64;
>> >       adev->gds.oa_size =3D 16;
>> > +
>> > +     /* Reserved for transform feedback. */
>> > +     adev->gds.gds_gfx_reservation_size =3D 256;
>> > +     adev->gds.oa_gfx_reservation_size =3D 4;
>> >   }
>> >
>> >   static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct
>> amdgpu_device *adev,
>> >                                                         u32 bitmap)
>> >   {
>> >       u32 data;
>> >
>> >       if (!bitmap)
>> >               return;
>> >
>>
>>
> _______________________________________________
> amd-gfx mailing listamd-gfx-PD4FTy7X32lNgt0PjOBp934avgP/u3fG0wdF1cv0I5s@public.gmane.org://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--000000000000c4d2ff058de1abe6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed., Jul. 17, 2019, 10:43 Christian K=C3=B6nig, &l=
t;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerke=
n@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"m_-8743640733505943180moz-cite-prefix">Am 17.07.19 um 16:=
27 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">
        <div><br>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Wed., Jul. 17, 2019,
              03:15 Christian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">ckoenig.leichtz=
umerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Am
              17.07.19 um 02:06 schrieb Marek Ol=C5=A1=C3=A1k:<br>
              &gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.=
olsak-5C7GfCeVMHo@public.gmane.org" rel=3D"noreferrer noreferrer" target=3D"_blank">marek.olsak@=
amd.com</a>&gt;<br>
              &gt;<br>
              &gt; Hopefully we&#39;ll only use 1 gfx ring, because
              otherwise we&#39;d have to have<br>
              &gt; separate GDS buffers for each gfx ring.<br>
              &gt;<br>
              &gt; This is a workaround to ensure stability of transform
              feedback. Shaders hang<br>
              &gt; waiting for a GDS instruction (ds_sub, not
              ds_ordered_count).<br>
              &gt;<br>
              &gt; The disadvantage is that compute IBs might get a
              different VMID,<br>
              &gt; because now gfx always has GDS and compute doesn&#39;t.<=
br>
              <br>
              So far compute is only using GWS, but I don&#39;t think that
              those <br>
              reservations are a good idea in general.<br>
              <br>
              How severe is the ENOMEM problem you see with using an
              explicit GWS <br>
              allocation?<br>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">I guess you mean GDS or OA.</div>
      </div>
    </blockquote>
    <br>
    Yeah, just a typo. Compute is using GWS and we want to use GDS and
    OA here.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"auto">
        <div dir=3D"auto">There is no ENOMEM, it just hangs. I don&#39;t kn=
ow
          why. The shader is waiting for ds_sub and can&#39;t continue, but
          GDS is idle.</div>
      </div>
    </blockquote>
    <br>
    Well could it be because we don&#39;t correctly handle non zero offsets
    or stuff like that?</div></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">I don&#39;t know what you mean.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div text=3D"#000000" bgcolor=3D"#F=
FFFFF">
    <br>
    Does it work with this hack when you don&#39;t allocate GDS/OA from the
    start? (Just allocate it twice or something like this).<br></div></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s o=
nly allocated once by the kernel with this hack.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div tex=
t=3D"#000000" bgcolor=3D"#FFFFFF">
    <br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"auto">
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              &gt;<br>
              &gt; Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mail=
to:marek.olsak-5C7GfCeVMHo@public.gmane.org" rel=3D"noreferrer noreferrer" target=3D"_blank">mar=
ek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
              &gt; ---<br>
              &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
              &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0=
 | 10
              ++++++++++<br>
              &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h |=C2=
=A0 6 ++++++<br>
              &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c=C2=A0=
 | 20
              ++++++++++++++++++++<br>
              &gt;=C2=A0 =C2=A04 files changed, 37 insertions(+)<br>
              &gt;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; index 4b514a44184c..cbd55d061b72 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; @@ -456,20 +456,21 @@ struct amdgpu_cs_parser {<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*filp;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ctx=C2=A0 =C2=A0=
 =C2=A0 =C2=A0*ctx;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* chunks */<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nchunks;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_cs_chunk=C2=A0 *=
chunks;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* scheduler job object */<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_job=C2=A0 =C2=A0=
 =C2=A0 =C2=A0*job;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_sched_entity *entit=
y;<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0unsigned=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_ip;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* buffer objects */<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ww_acquire_ctx=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ticket;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo_list=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*bo_list;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_mn=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *mn;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo_list_entry=C2=
=A0 =C2=A0 =C2=A0vm_pd;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 validated;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *fence;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              bytes_moved_threshold;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              bytes_moved_vis_threshold;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; index c691df6f7a57..9125cd69a124 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; @@ -678,20 +678,28 @@ static int
              amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0go=
to error_validate;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_cs_report_moved_bytes(p=
-&gt;adev,
              p-&gt;bytes_moved,<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              p-&gt;bytes_moved_vis);<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gds =3D p-&gt;bo_list-&gt;gds_=
obj;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gws =3D p-&gt;bo_list-&gt;gws_=
obj;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0oa =3D p-&gt;bo_list-&gt;oa_ob=
j;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0if (p-&gt;hw_ip =3D=3D AMDGPU_HW_IP=
_GFX) {<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Only=
 gfx10 allocates these. */<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!gd=
s)<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0gds =3D
              p-&gt;adev-&gt;gds.gds_gfx_bo;<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!oa=
)<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0oa =3D
              p-&gt;adev-&gt;gds.oa_gfx_bo;<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
              &gt; +<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_list_for_each_entry(=
e, p-&gt;bo_list)
              {<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct amdgpu_bo *bo =3D
              ttm_to_amdgpu_bo(e-&gt;<a href=3D"http://tv.bo" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">tv.bo</a>);<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Make sure we use the exclusive slot
              for shared BOs */<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (bo-&gt;prime_shared_count)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0e-&gt;tv.num_shared =3D 0;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e-=
&gt;bo_va =3D amdgpu_vm_bo_find(vm,
              bo);<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (gds) {<br>
              &gt; @@ -954,20 +962,22 @@ static int
              amdgpu_cs_ib_fill(struct amdgpu_device *adev,<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct drm_amdgpu_cs_chunk_ib
              *chunk_ib;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct drm_sched_entity *entity;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch=
unk =3D &amp;parser-&gt;chunks[i];<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib=
 =3D &amp;parser-&gt;job-&gt;ibs[j];<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch=
unk_ib =3D (struct
              drm_amdgpu_cs_chunk_ib *)chunk-&gt;kdata;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (chunk-&gt;chunk_id !=3D
              AMDGPU_CHUNK_ID_IB)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser-=
&gt;hw_ip =3D
              chunk_ib-&gt;ip_type;<br>
              &gt; +<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (chunk_ib-&gt;ip_type =3D=3D
              AMDGPU_HW_IP_GFX &amp;&amp;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(amdgpu_mcbp ||
              amdgpu_sriov_vf(adev))) {<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (chunk_ib-&gt;flags &amp;
              AMDGPU_IB_FLAG_PREEMPT) {<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chunk_ib-&gt;fla=
gs
              &amp; AMDGPU_IB_FLAG_CE)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ce_preempt++;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0de_preempt++;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* each GFX command submit
              allows 0 or 1 IB preemptible for CE &amp; DE */<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
              &gt; index df8a23554831..0943b8e1d97e 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
              &gt; @@ -26,20 +26,26 @@<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0struct amdgpu_ring;<br>
              &gt;=C2=A0 =C2=A0struct amdgpu_bo;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0struct amdgpu_gds {<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t gds_size;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t gws_size;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t oa_size;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t gds_compute_max_wave_=
id;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t vgt_gs_max_wave_id;<b=
r>
              &gt; +<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0/* Reserved OA for the gfx ring. (g=
fx10) */<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0uint32_t gds_gfx_reservation_size;<=
br>
              &gt; +=C2=A0 =C2=A0 =C2=A0uint32_t oa_gfx_reservation_size;<b=
r>
              &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_bo *gds_gfx_bo;<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_bo *oa_gfx_bo;<br>
              &gt;=C2=A0 =C2=A0};<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0struct amdgpu_gds_reg_offset {<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mem_base;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mem_size;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 gws;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 oa;<br>
              &gt;=C2=A0 =C2=A0};<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0#endif /* __AMDGPU_GDS_H__ */<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
              b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt; index 618291df659b..3952754c04ff 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt; @@ -1314,20 +1314,33 @@ static int
              gfx_v10_0_sw_init(void *handle)<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0kiq =3D &amp;adev-&gt;gfx.kiq;=
<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_gfx_kiq_init_ring=
(adev,
              &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn r;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_gfx_mqd_sw_init(a=
dev, sizeof(struct
              v10_compute_mqd));<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn r;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0/* allocate reserved GDS resources =
for
              transform feedback */<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_kernel(adev,
              adev-&gt;gds.gds_gfx_reservation_size,<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04,
              AMDGPU_GEM_DOMAIN_GDS,<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0&amp;adev-&gt;gds.gds_gfx_bo, NULL, NULL);<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0if (r)<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
r;<br>
              &gt; +<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_kernel(adev,
              adev-&gt;gds.oa_gfx_reservation_size,<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01,
              AMDGPU_GEM_DOMAIN_OA,<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0&amp;adev-&gt;gds.oa_gfx_bo, NULL, NULL);<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0if (r)<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
r;<br>
              &gt; +<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* allocate visible FB for rlc=
 auto-loading fw
              */<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;firmware.load_typ=
e =3D=3D
              AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =
=3D
              gfx_v10_0_rlc_backdoor_autoload_buffer_init(adev);<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (r)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.ce_ram_size =3D
              F32_CE_PROGRAM_RAM_SIZE;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_gpu_early_init(adev)=
;<br>
              &gt; @@ -1354,20 +1367,23 @@ static void
              gfx_v10_0_me_fini(struct amdgpu_device *adev)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0
              =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gfx.me.me_fw_obj,<b=
r>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0&amp;adev-&gt;gfx.me.me_fw_gpu_addr,<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void
              **)&amp;adev-&gt;gfx.me.me_fw_ptr);<br>
              &gt;=C2=A0 =C2=A0}<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0static int gfx_v10_0_sw_fini(void *handle)<b=
r>
              &gt;=C2=A0 =C2=A0{<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D=
 (struct
              amdgpu_device *)handle;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt; +=C2=A0 =C2=A0
              =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gds_gfx_bo, NUL=
L,
              NULL);<br>
              &gt; +=C2=A0 =C2=A0
              =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.oa_gfx_bo, NULL=
,
              NULL);<br>
              &gt; +<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; adev-&gt;=
gfx.num_gfx_rings;
              i++)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0amdgpu_ring_fini(&amp;adev-&gt;gfx.gfx_ring[i]);<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt;
              adev-&gt;gfx.num_compute_rings; i++)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0amdgpu_ring_fini(&amp;adev-&gt;gfx.compute_ring[i]);<br=
>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_mqd_sw_fini(adev);<=
br>
              &gt;=C2=A0 =C2=A0 =C2=A0
              =C2=A0amdgpu_gfx_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring,
              &amp;adev-&gt;gfx.kiq.irq);<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_kiq_fini(adev);<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_pfp_fini(adev);<br>
              &gt; @@ -5181,20 +5197,24 @@ static void
              gfx_v10_0_set_gds_init(struct amdgpu_device *adev)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_NAVI10:<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ad=
ev-&gt;gds.gds_size =3D 0x10000;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ad=
ev-&gt;gds.gds_compute_max_wave_id =3D
              0x4ff;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ad=
ev-&gt;gds.vgt_gs_max_wave_id =3D
              0x3ff;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak;<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws_size =3D 64;<=
br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa_size =3D 16;<b=
r>
              &gt; +<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0/* Reserved for transform feedback.=
 */<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_gfx_reservation_si=
ze =3D 256;<br>
              &gt; +=C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa_gfx_reservation_siz=
e =3D 4;<br>
              &gt;=C2=A0 =C2=A0}<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0static void
              gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct
              amdgpu_device *adev,<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0 =C2=A0u32 bitmap)<br>
              &gt;=C2=A0 =C2=A0{<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 data;<br>
              &gt;=C2=A0 =C2=A0<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!bitmap)<br>
              &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn;<br>
              &gt;=C2=A0 =C2=A0<br>
              <br>
            </blockquote>
          </div>
        </div>
      </div>
      <br>
      <fieldset class=3D"m_-8743640733505943180mimeAttachmentHeader"></fiel=
dset>
      <pre class=3D"m_-8743640733505943180moz-quote-pre">__________________=
_____________________________
amd-gfx mailing list
<a class=3D"m_-8743640733505943180moz-txt-link-abbreviated" href=3D"mailto:=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx=
@lists.freedesktop.org</a>
<a class=3D"m_-8743640733505943180moz-txt-link-freetext" href=3D"https://li=
sts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" rel=3D"nore=
ferrer">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </div>

</blockquote></div></div></div>

--000000000000c4d2ff058de1abe6--

--===============1926491740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1926491740==--
