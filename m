From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add AMDGPU_IB_FLAG_GET_START_SYNCOBJ to
 expose scheduled fence
Date: Tue, 29 Jan 2019 08:32:55 -0500
Message-ID: <CAAxE2A6F+Wexxe_fY22P7iWk1DwKbP6DOmxyoUV164YQFTvdaA@mail.gmail.com>
References: <20190128215239.32498-1-maraeo@gmail.com>
 <762485e9-7fe4-3ffb-16a4-f83436871451@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1828586409=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <762485e9-7fe4-3ffb-16a4-f83436871451-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1828586409==
Content-Type: multipart/alternative; boundary="000000000000688c63058098d512"

--000000000000688c63058098d512
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019, 3:01 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> Am 28.01.19 um 22:52 schrieb Marek Ol=C5=A1=C3=A1k:
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >
> > Normal syncobjs signal when an IB finishes. Start syncobjs signal when
> > an IB starts.
>
> That approach has quite a number of problems (for example you can't
> allocate memory at this point).
>
> Better add a flag that we should only sync on scheduling for a
> dependency/syncobj instead.
>

I don't understand. Can you give me an example of the interface and how the
implementation would look?

Thanks,
Marek


> Christian.
>
> >
> > Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 18 ++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
> >   include/uapi/drm/amdgpu_drm.h           | 13 ++++++++++++-
> >   4 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index d67f8b1dfe80..8e2f7e558bc9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -453,20 +453,21 @@ struct amdgpu_cs_parser {
> >       struct dma_fence                *fence;
> >       uint64_t                        bytes_moved_threshold;
> >       uint64_t                        bytes_moved_vis_threshold;
> >       uint64_t                        bytes_moved;
> >       uint64_t                        bytes_moved_vis;
> >       struct amdgpu_bo_list_entry     *evictable;
> >
> >       /* user fence */
> >       struct amdgpu_bo_list_entry     uf_entry;
> >
> > +     bool                            get_start_syncobj;
> >       unsigned num_post_dep_syncobjs;
> >       struct drm_syncobj **post_dep_syncobjs;
> >   };
> >
> >   static inline u32 amdgpu_get_ib_value(struct amdgpu_cs_parser *p,
> >                                     uint32_t ib_idx, int idx)
> >   {
> >       return p->job->ibs[ib_idx].ptr[idx];
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 1c49b8266d69..917f3818c61c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1022,20 +1022,23 @@ static int amdgpu_cs_ib_fill(struct
> amdgpu_device *adev,
> >               r =3D amdgpu_ctx_get_entity(parser->ctx, chunk_ib->ip_typ=
e,
> >                                         chunk_ib->ip_instance,
> chunk_ib->ring,
> >                                         &entity);
> >               if (r)
> >                       return r;
> >
> >               if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
> >                       parser->job->preamble_status |=3D
> >                               AMDGPU_PREAMBLE_IB_PRESENT;
> >
> > +             if (chunk_ib->flags & AMDGPU_IB_FLAG_GET_START_SYNCOBJ)
> > +                     parser->get_start_syncobj =3D true;
> > +
> >               if (parser->entity && parser->entity !=3D entity)
> >                       return -EINVAL;
> >
> >               parser->entity =3D entity;
> >
> >               ring =3D to_amdgpu_ring(entity->rq->sched);
> >               r =3D  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
> >                                  chunk_ib->ib_bytes : 0, ib);
> >               if (r) {
> >                       DRM_ERROR("Failed to get ib !\n");
> > @@ -1227,20 +1230,35 @@ static int amdgpu_cs_submit(struct
> amdgpu_cs_parser *p,
> >       amdgpu_mn_lock(p->mn);
> >       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> >               struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(e->tv.bo);
> >
> >               if (amdgpu_ttm_tt_userptr_needs_pages(bo->tbo.ttm)) {
> >                       r =3D -ERESTARTSYS;
> >                       goto error_abort;
> >               }
> >       }
> >
> > +     if (p->get_start_syncobj) {
> > +             struct drm_syncobj *syncobj;
> > +
> > +             r =3D drm_syncobj_create(&syncobj, 0,
> > +                                    &job->base.s_fence->scheduled);
> > +             if (r)
> > +                     goto error_abort;
> > +
> > +             r =3D drm_syncobj_get_handle(p->filp, syncobj,
> > +                                        &cs->out.start_syncobj);
> > +             if (r)
> > +                     goto error_abort;
> > +             drm_syncobj_put(syncobj);
> > +     }
> > +
> >       job->owner =3D p->filp;
> >       p->fence =3D dma_fence_get(&job->base.s_fence->finished);
> >
> >       amdgpu_ctx_add_fence(p->ctx, entity, p->fence, &seq);
> >       amdgpu_cs_post_dependencies(p);
> >
> >       if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
> >           !p->ctx->preamble_presented) {
> >               job->preamble_status |=3D AMDGPU_PREAMBLE_IB_PRESENT_FIRS=
T;
> >               p->ctx->preamble_presented =3D true;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index c806f984bcc5..a230a30722d4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -64,23 +64,24 @@
> >    * - 3.18.0 - Export gpu always on cu bitmap
> >    * - 3.19.0 - Add support for UVD MJPEG decode
> >    * - 3.20.0 - Add support for local BOs
> >    * - 3.21.0 - Add DRM_AMDGPU_FENCE_TO_HANDLE ioctl
> >    * - 3.22.0 - Add DRM_AMDGPU_SCHED ioctl
> >    * - 3.23.0 - Add query for VRAM lost counter
> >    * - 3.24.0 - Add high priority compute support for gfx9
> >    * - 3.25.0 - Add support for sensor query info (stable pstate
> sclk/mclk).
> >    * - 3.26.0 - GFX9: Process AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE.
> >    * - 3.27.0 - Add new chunk to to AMDGPU_CS to enable BO_LIST creatio=
n.
> > + * - 3.28.0 - AMDGPU_IB_FLAG_GET_START_SYNCOBJ
> >    */
> >   #define KMS_DRIVER_MAJOR    3
> > -#define KMS_DRIVER_MINOR     27
> > +#define KMS_DRIVER_MINOR     28
> >   #define KMS_DRIVER_PATCHLEVEL       0
> >
> >   int amdgpu_vram_limit =3D 0;
> >   int amdgpu_vis_vram_limit =3D 0;
> >   int amdgpu_gart_size =3D -1; /* auto */
> >   int amdgpu_gtt_size =3D -1; /* auto */
> >   int amdgpu_moverate =3D -1; /* auto */
> >   int amdgpu_benchmarking =3D 0;
> >   int amdgpu_testing =3D 0;
> >   int amdgpu_audio =3D -1;
> > diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> > index 662d379ea624..d0e0c99cea32 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -538,21 +538,23 @@ struct drm_amdgpu_cs_in {
> >       __u32           ctx_id;
> >       /**  Handle of resource list associated with CS */
> >       __u32           bo_list_handle;
> >       __u32           num_chunks;
> >       __u32           _pad;
> >       /** this points to __u64 * which point to cs chunks */
> >       __u64           chunks;
> >   };
> >
> >   struct drm_amdgpu_cs_out {
> > -     __u64 handle;
> > +     __u64 handle; /* sequence number */
> > +     __u32 start_syncobj; /* signalled when IB execution begins */
> > +     __u32 _pad;
> >   };
> >
> >   union drm_amdgpu_cs {
> >       struct drm_amdgpu_cs_in in;
> >       struct drm_amdgpu_cs_out out;
> >   };
> >
> >   /* Specify flags to be used for IB */
> >
> >   /* This IB should be submitted to CE */
> > @@ -566,20 +568,29 @@ union drm_amdgpu_cs {
> >
> >   /* The IB fence should do the L2 writeback but not invalidate any
> shader
> >    * caches (L2/vL1/sL1/I$). */
> >   #define AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE (1 << 3)
> >
> >   /* Set GDS_COMPUTE_MAX_WAVE_ID =3D DEFAULT before
> PACKET3_INDIRECT_BUFFER.
> >    * This will reset wave ID counters for the IB.
> >    */
> >   #define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
> >
> > +/* The CS ioctl will return a syncobj representing when all IBs begin
> > + * execution. If set, this applies to all IBs. The returned syncobj ca=
n
> be
> > + * used as an IB dependency for other IBs.
> > + *
> > + * This is used for GPU deadlock prevention when userspace uses mid-IB
> fences
> > + * to wait for mid-IB work on other rings.
> > + */
> > +#define AMDGPU_IB_FLAG_GET_START_SYNCOBJ (1 << 5)
> > +
> >   struct drm_amdgpu_cs_chunk_ib {
> >       __u32 _pad;
> >       /** AMDGPU_IB_FLAG_* */
> >       __u32 flags;
> >       /** Virtual address to begin IB execution */
> >       __u64 va_start;
> >       /** Size of submission */
> >       __u32 ib_bytes;
> >       /** HW IP to submit to */
> >       __u32 ip_type;
>
>

--000000000000688c63058098d512
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Tue, Jan 29, 2019, 3:01 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ck=
oenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Am 28.01.19 um 22:52 schrieb Marek=
 Ol=C5=A1=C3=A1k:<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank" rel=3D"noreferrer">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; Normal syncobjs signal when an IB finishes. Start syncobjs signal when=
<br>
&gt; an IB starts.<br>
<br>
That approach has quite a number of problems (for example you can&#39;t <br=
>
allocate memory at this point).<br>
<br>
Better add a flag that we should only sync on scheduling for a <br>
dependency/syncobj instead.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">I don&#39;t understand. Can you give me an examp=
le of the interface and how the implementation would look?</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Marek</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak=
@amd.com" target=3D"_blank" rel=3D"noreferrer">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<=
br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 | 18 ++++++++=
++++++++++<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |=C2=A0 3 ++-<br>
&gt;=C2=A0 =C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 13 ++++++++++++-<br>
&gt;=C2=A0 =C2=A04 files changed, 33 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index d67f8b1dfe80..8e2f7e558bc9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -453,20 +453,21 @@ struct amdgpu_cs_parser {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fence;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_moved_threshold;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_moved_vis_threshold;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_moved;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_moved_vis;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo_list_entry=C2=A0 =C2=A0 =C2=
=A0*evictable;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* user fence */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo_list_entry=C2=A0 =C2=A0 =C2=
=A0uf_entry;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_start_syncobj;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned num_post_dep_syncobjs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj **post_dep_syncobjs;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static inline u32 amdgpu_get_ib_value(struct amdgpu_cs_par=
ser *p,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ib_i=
dx, int idx)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return p-&gt;job-&gt;ibs[ib_idx].ptr[idx];<b=
r>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.c<br>
&gt; index 1c49b8266d69..917f3818c61c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -1022,20 +1022,23 @@ static int amdgpu_cs_ib_fill(struct amdgpu_dev=
ice *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ctx=
_get_entity(parser-&gt;ctx, chunk_ib-&gt;ip_type,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0chunk_ib-&gt;ip_instance, chunk_ib-&gt;ring,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;entity);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chunk_ib-&gt=
;flags &amp; AMDGPU_IB_FLAG_PREAMBLE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0parser-&gt;job-&gt;preamble_status |=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMDGPU_PREAMBLE_IB_PRESENT;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chunk_ib-&gt;flag=
s &amp; AMDGPU_IB_FLAG_GET_START_SYNCOBJ)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0parser-&gt;get_start_syncobj =3D true;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (parser-&gt;e=
ntity &amp;&amp; parser-&gt;entity !=3D entity)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser-&gt;entit=
y =3D entity;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring =3D to_amdg=
pu_ring(entity-&gt;rq-&gt;sched);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D=C2=A0 amdg=
pu_ib_get(adev, vm, ring-&gt;funcs-&gt;parse_cs ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chunk_ib-&gt;ib_bytes : 0,=
 ib);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0DRM_ERROR(&quot;Failed to get ib !\n&quot;);<br>
&gt; @@ -1227,20 +1230,35 @@ static int amdgpu_cs_submit(struct amdgpu_cs_p=
arser *p,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_mn_lock(p-&gt;mn);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_list_for_each_userptr_entry(e, p-&=
gt;bo_list) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo=
 *bo =3D ttm_to_amdgpu_bo(e-&gt;<a href=3D"http://tv.bo" rel=3D"noreferrer =
noreferrer" target=3D"_blank">tv.bo</a>);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_ttm_t=
t_userptr_needs_pages(bo-&gt;tbo.ttm)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0r =3D -ERESTARTSYS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto error_abort;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (p-&gt;get_start_syncobj) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *s=
yncobj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drm_syncobj_cre=
ate(&amp;syncobj, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;job-&gt;base.=
s_fence-&gt;scheduled);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto error_abort;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drm_syncobj_get=
_handle(p-&gt;filp, syncobj,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;cs-&gt;out.start_syncobj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto error_abort;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(synco=
bj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0job-&gt;owner =3D p-&gt;filp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;fence =3D dma_fence_get(&amp;job-&gt;b=
ase.s_fence-&gt;finished);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ctx_add_fence(p-&gt;ctx, entity, p-&g=
t;fence, &amp;seq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_cs_post_dependencies(p);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((job-&gt;preamble_status &amp; AMDGPU_PR=
EAMBLE_IB_PRESENT) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!p-&gt;ctx-&gt;preamble_presen=
ted) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0job-&gt;preamble=
_status |=3D AMDGPU_PREAMBLE_IB_PRESENT_FIRST;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;ctx-&gt;pr=
eamble_presented =3D true;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index c806f984bcc5..a230a30722d4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -64,23 +64,24 @@<br>
&gt;=C2=A0 =C2=A0 * - 3.18.0 - Export gpu always on cu bitmap<br>
&gt;=C2=A0 =C2=A0 * - 3.19.0 - Add support for UVD MJPEG decode<br>
&gt;=C2=A0 =C2=A0 * - 3.20.0 - Add support for local BOs<br>
&gt;=C2=A0 =C2=A0 * - 3.21.0 - Add DRM_AMDGPU_FENCE_TO_HANDLE ioctl<br>
&gt;=C2=A0 =C2=A0 * - 3.22.0 - Add DRM_AMDGPU_SCHED ioctl<br>
&gt;=C2=A0 =C2=A0 * - 3.23.0 - Add query for VRAM lost counter<br>
&gt;=C2=A0 =C2=A0 * - 3.24.0 - Add high priority compute support for gfx9<b=
r>
&gt;=C2=A0 =C2=A0 * - 3.25.0 - Add support for sensor query info (stable ps=
tate sclk/mclk).<br>
&gt;=C2=A0 =C2=A0 * - 3.26.0 - GFX9: Process AMDGPU_IB_FLAG_TC_WB_NOT_INVAL=
IDATE.<br>
&gt;=C2=A0 =C2=A0 * - 3.27.0 - Add new chunk to to AMDGPU_CS to enable BO_L=
IST creation.<br>
&gt; + * - 3.28.0 - AMDGPU_IB_FLAG_GET_START_SYNCOBJ<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0#define KMS_DRIVER_MAJOR=C2=A0 =C2=A0 3<br>
&gt; -#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A027<br>
&gt; +#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A028<br>
&gt;=C2=A0 =C2=A0#define KMS_DRIVER_PATCHLEVEL=C2=A0 =C2=A0 =C2=A0 =C2=A00<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int amdgpu_vram_limit =3D 0;<br>
&gt;=C2=A0 =C2=A0int amdgpu_vis_vram_limit =3D 0;<br>
&gt;=C2=A0 =C2=A0int amdgpu_gart_size =3D -1; /* auto */<br>
&gt;=C2=A0 =C2=A0int amdgpu_gtt_size =3D -1; /* auto */<br>
&gt;=C2=A0 =C2=A0int amdgpu_moverate =3D -1; /* auto */<br>
&gt;=C2=A0 =C2=A0int amdgpu_benchmarking =3D 0;<br>
&gt;=C2=A0 =C2=A0int amdgpu_testing =3D 0;<br>
&gt;=C2=A0 =C2=A0int amdgpu_audio =3D -1;<br>
&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h<br>
&gt; index 662d379ea624..d0e0c99cea32 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -538,21 +538,23 @@ struct drm_amdgpu_cs_in {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/**=C2=A0 Handle of resource list associated=
 with CS */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bo_list_handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0num_chunks;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0_pad;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** this points to __u64 * which point to cs=
 chunks */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0chunks;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0struct drm_amdgpu_cs_out {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0__u64 handle;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u64 handle; /* sequence number */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 start_syncobj; /* signalled when IB executi=
on begins */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 _pad;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0union drm_amdgpu_cs {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_cs_in in;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_cs_out out;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* Specify flags to be used for IB */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* This IB should be submitted to CE */<br>
&gt; @@ -566,20 +568,29 @@ union drm_amdgpu_cs {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* The IB fence should do the L2 writeback but not invalid=
ate any shader<br>
&gt;=C2=A0 =C2=A0 * caches (L2/vL1/sL1/I$). */<br>
&gt;=C2=A0 =C2=A0#define AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE (1 &lt;&lt; 3)=
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* Set GDS_COMPUTE_MAX_WAVE_ID =3D DEFAULT before PACKET3_=
INDIRECT_BUFFER.<br>
&gt;=C2=A0 =C2=A0 * This will reset wave ID counters for the IB.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0#define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 &lt;&lt; 4=
)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* The CS ioctl will return a syncobj representing when all IBs begin=
<br>
&gt; + * execution. If set, this applies to all IBs. The returned syncobj c=
an be<br>
&gt; + * used as an IB dependency for other IBs.<br>
&gt; + *<br>
&gt; + * This is used for GPU deadlock prevention when userspace uses mid-I=
B fences<br>
&gt; + * to wait for mid-IB work on other rings.<br>
&gt; + */<br>
&gt; +#define AMDGPU_IB_FLAG_GET_START_SYNCOBJ (1 &lt;&lt; 5)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0struct drm_amdgpu_cs_chunk_ib {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 _pad;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** AMDGPU_IB_FLAG_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Virtual address to begin IB execution */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 va_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Size of submission */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 ib_bytes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** HW IP to submit to */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 ip_type;<br>
<br>
</blockquote></div></div></div>

--000000000000688c63058098d512--

--===============1828586409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1828586409==--
