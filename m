Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988E606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.a=rsa-sha256 header.s=google header.b=VaovyHK1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA2C10E2B1;
	Wed, 28 Oct 2026 20:00:19 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A58410FE6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 20:00:13 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so2094172a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 13:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793217612; cv=none;
 d=google.com; s=arc-20260327;
 b=fS443PM1Lt39Nne5S8WHdU+BiQznXDhPGNdAKezVhax3DSNzf7X7T/OOzejlKTdBQ4
 69rHQvrZVLdxDj7atSs6SZuowrELmWZwQQ2liwRi3ibg0dCkAY5lmRkOfzERRCQkK3WH
 Qho6nUS61lyyEBn64qdsGmr83Mj58BeuqPG0R9PKcjkGQvd2oYohX9rV6W+2MXd3fj1B
 gRZbjlx1lZ2V9R/FG0HqKlIRlir4lYU6wQDn6AA6agwrk9HobKQF50fMt0prB98TtqPU
 Q5pRJlT4Sq+8ZqEmpQ+a2Xdgjamb0JPdF3q3ilzjlZdwYh6C1FF7Kq6oCJkn7dxnxpMf
 f5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QDPCjG7iY0GDQkNY8S/83f10vL3yGPFQ3dnGo4S6nqs=;
 fh=W+8y1goK6vrKjx7BovOONJIB1jwMzNy3LrZSgff03+M=;
 b=StEOIefQ3ftdjjHDIPhGZTbq/i1f8K9iI8DfgK+xGqHMeCv7a5iqRJDu79yrjOXbj2
 z55uGr7V7bABNLQh/HOVKCfV8piwqdPiYyA/xWXUuokKBAEK9f4G6fCS9EUVZlLcN+Up
 jST/no21E7fL+jUCd6R4E+u9PSrkRHFMNsFItPxK5JGvQHqVJtgYjeN763Ee97eynMGb
 hEvuUTqDBO3tf1szxg2D6OgiSUn+lvOlDgLtDJ5IUXhaAb9qXpirz4QlGpTCNdtP0om/
 QC5ts/DR5l+u9B3LJ4GXGDnY8N4rXvWJXTOg39Kc97/nj+Il9b9J7jdpbDMQpAgHbuX2
 X1kw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1793217612; x=1793822412;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QDPCjG7iY0GDQkNY8S/83f10vL3yGPFQ3dnGo4S6nqs=;
 b=VaovyHK1wltSnkIw6xzMVPMy5XCpXXw5VmAzHQvy4iixRrY1vVwFeJZCBBa1PzqNdW
 PwkXg4zgoK8xoYy9wJwOq9jlNdTbawIsnQ+i28kBhienkRR7g6ORiDxGjIr13L7cIfoS
 kv3ey6fByLukLOdoV/ZNxnRKBPHkRnftBhTnAi6Sgdb1lD9ao8oL5m20oQ5xDTuaVT60
 ZHczJipPc3iwNqC5OY/Q38k+/so9YwaV2niL85WwNJ+4L7KC9uK4c+3NkrAaS6BLEBrS
 kNY8amhHVsSoSE+Je7Nby5zVLz7ijYVBnYXJceLpBXX3x8CcBYH/+3XnYUf1wPD5Vgs3
 XfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793217612; x=1793822412;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QDPCjG7iY0GDQkNY8S/83f10vL3yGPFQ3dnGo4S6nqs=;
 b=12GBIPmB9i8dGpzwzh2Mb/i9E7h0ZdOmllTUWUbmV5TN4gh4aDnmpKbIIWUe3uPh5/
 Abw2Ke6OIt+ob4+vN6UUmd2bOPuyY4MU2HJUZxBP+TCAIMDnIYOtdd96lOsgKtZZtIE6
 EUlEPXiKvC8XNCqmmjh5klvjW8Xb38umI5QQMyMPqJRqIJXufByCunWUDK9HPTi6lrIn
 heRQqmvIr2/Kep5E0Iw5tos1fbm1HN8M6cL2gDmxRUfTmX3c1GRneyNyKFj3BvN/rhXh
 xaK9Jd8K8sU0fe/miPhqzC9bZSv9WjJw8/L4vXSCfOposvRrIJw4noICSmBk+9wPdSfv
 kDeQ==
X-Gm-Message-State: AFq9FYI4/2ASPqgHWTw8szMxRB0tZRFVenfDmGQnGDU7iAirmdfMXVbE
 IYGun9noi9gghK9Xlf066YmHbTL4ITHnZ0RqH5jIWJhqTGt7hQZED2C0G1nelwW31sYBYReLLgu
 BBUwegO1liYXqFL5iGQOG3g13z7eXkywSjDRfN0cVKQ==
X-Gm-Gg: AYBFou2nP5JdSHLWEG/HtbrZwuyRM2hMjyiz1Jo26Q/mYxoPABold3DxgGV4QExeEJ7
 r88H38HFg5s3Tf8dEINoJkmFwGyuK41/agedtepfC+zOlqY6mhmeOV76lA1jlmZgSZ/SzEztJPk
 Qaa7nAjmKFYKrXJLbH/psbgATKt0ycP/1D6iPP7sZl6meu5VHz/BNu2LMExz5NHv1o3OlbXfuo3
 Cdwyfem8nJFiQMfP+zU4QdRX+SPhemQ7uH3CZsvp6Ytg0DlYYpHjlz88qzCXeyKBP8P0pIhIpKM
 IUiFebaiVkNuYzY7GoSms3yFoJgELuAOlxoCROHzypx90eGzFs4TBdohcFGDEDdtZFrvOaScSEk
 mrGXhFmGla7BrXMch3PZUkW5cdcEhBJogwrjf1LEpytaSHADkRx5MtJWoS7JxjQV/R1FESGCE6u
 W177yJU2pLmc0vKONO4AK9iKxf7kUz0YC7oO5mOA==
X-Received: by 2002:a05:6402:2032:b0:6b3:d0a0:3743 with SMTP id
 4fb4d7f45d1cf-6b49cbd61c1mr1907350a12.7.1793217611287; Wed, 28 Oct 2026
 13:00:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
 <20261022003058.1723817-5-bas@basnieuwenhuizen.nl>
 <9222106f-576f-4921-bf2f-ee59105a7d4f@amd.com>
In-Reply-To: <9222106f-576f-4921-bf2f-ee59105a7d4f@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 28 Oct 2026 19:59:59 +0000
X-Gm-Features: AclHuK8OZpeF-3Vgk85CBBPj22Rf_cM3rG-Ti7niLSytkOw2KJI4wMeWBdIlT0w
Message-ID: <CAP+8YyGggpPyVzjRvAnSCD3q3U2Gdtah0LVPBjhyJvsie+=RHQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Implement disabling implicit sync per
 submission.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, samuel.pitoiset@gmail.com, 
 natalie.vock@gmx.de
Content-Type: multipart/alternative; boundary="000000000000b9e1ce065eec0217"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b9e1ce065eec0217
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:30=E2=80=AFPM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

> On 10/22/26 02:30, Bas Nieuwenhuizen wrote:
> > Implements the UAPI flag to give apps an options to disable
> > implicit sync per submission.
> >
> > v2:
> >  - signal READ fences for the VM root PD, as some unmapping
> >    operations only wait for READ and up.
> >
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 34 +++++++++++++++++++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
> >  2 files changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index afcd254c9884..f0fe9d0f1398 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -49,6 +49,9 @@
> >  #define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW        0xFFFFF
> >  #define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW      0x7FFFF0
> >
> > +/* All flags accepted in drm_amdgpu_cs_in.flags */
> > +#define AMDGPU_CS_FLAGS_MASK AMDGPU_CS_NO_IMPLICIT_SYNC
> > +
> >  static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type type)
> >  {
> >       switch (type) {
> > @@ -188,9 +191,11 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser
> *p,
> >       int ret;
> >       int i;
> >
> > -     if (cs->in.flags)
> > +     if (cs->in.flags & ~AMDGPU_CS_FLAGS_MASK)
> >               return -EINVAL;
> >
> > +     p->flags =3D cs->in.flags;
> > +
> >       chunk_array =3D memdup_array_user(u64_to_user_ptr(cs->in.chunks),
> >                                       cs->in.num_chunks,
> >                                       sizeof(uint64_t));
> > @@ -1220,16 +1225,19 @@ static int amdgpu_cs_sync_rings(struct
> amdgpu_cs_parser *p)
> >       }
> >
> >       drm_exec_for_each_locked_object(&p->exec, obj) {
> > +             /* Implicitly sync only to KERNEL, WRITE and READ */
> > +             enum dma_resv_usage usage =3D DMA_RESV_USAGE_READ;
> >               struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> >
> >               struct dma_resv *resv =3D bo->tbo.base.resv;
> >               enum amdgpu_sync_mode sync_mode;
> >
> > +             if (p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC)
> > +                     usage =3D DMA_RESV_USAGE_KERNEL;
>
> Use DMA_RESV_USAGE_WRITE here.
>
> > +
> >               sync_mode =3D amdgpu_bo_explicit_sync(bo) ?
> >                       AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
> > -             /* Implicitly sync only to KERNEL, WRITE and READ */
> > -             r =3D amdgpu_sync_resv(p->adev, &p->sync, resv,
> > -                                  DMA_RESV_USAGE_READ, sync_mode,
> > +             r =3D amdgpu_sync_resv(p->adev, &p->sync, resv, usage,
> sync_mode,
> >                                    &fpriv->vm);
> >               if (r)
> >                       return r;
> > @@ -1341,9 +1349,23 @@ static int amdgpu_cs_submit(struct
> amdgpu_cs_parser *p,
> >
> >       p->fence =3D dma_fence_get(&leader->base.s_fence->finished);
> >       drm_exec_for_each_locked_object(&p->exec, gobj) {
> > +             enum dma_resv_usage read_usage =3D DMA_RESV_USAGE_READ;
> > +             enum dma_resv_usage write_usage =3D DMA_RESV_USAGE_WRITE;
> >
> >
>  ttm_bo_move_to_lru_tail_unlocked(&gem_to_amdgpu_bo(gobj)->tbo);
> >
> > +             /*
> > +              * Keep READ/WRITE on the root PD resv:
> > +              * amdgpu_vm_bo_update(clear=3Dtrue) only waits on the VM
> root PD
> > +              * resv with read and should still sync to avoid unmappin=
g
> > +              * before the job finishes.
> > +              */
> > +             if ((p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC) &&
> > +                 gobj->resv !=3D vm->root.bo->tbo.base.resv) {
> > +                     read_usage =3D DMA_RESV_USAGE_BOOKKEEP;
> > +                     write_usage =3D DMA_RESV_USAGE_BOOKKEEP;
> > +             }
> > +
>
> Completely drop that.
>
> >               /* Everybody except for the gang leader uses READ */
> >               for (i =3D 0; i < p->gang_size; ++i) {
> >                       if (p->jobs[i] =3D=3D leader)
> > @@ -1351,11 +1373,11 @@ static int amdgpu_cs_submit(struct
> amdgpu_cs_parser *p,
> >
> >                       dma_resv_add_fence(gobj->resv,
> >
> &p->jobs[i]->base.s_fence->finished,
> > -                                        DMA_RESV_USAGE_READ);
> > +                                        read_usage);
> >               }
> >
> >               /* The gang leader as remembered as writer */
> > -             dma_resv_add_fence(gobj->resv, p->fence,
> DMA_RESV_USAGE_WRITE);
> > +             dma_resv_add_fence(gobj->resv, p->fence, write_usage);
>
> Instead just set that here to DMA_RESV_USAGE_READ when the CS is
> explicitely synced.
>
> This way we get amdgpu nearly back to the usage model all other DRM
> drivers uses.
>

I think this has two problems:

1. It doesn't fully solve the problem I'm trying to address. In the common
Vulkan WSI apps for present signal WRITE  and then wait on READ[1], meaning
that the proposed wait on WRITE and signal READ result in submissions from
the compositor still fully participating in implicit sync wrt presents.
Waiting on KERNEL and signalling BOOKKEEP actually resolves this.
2. While the driver landscape is very diverse I think other drivers are
actually pretty much moving to KERNEL/BOOKKEEP. In particular:
- Xe does the KERNEl/BOOKKEEP[2]
- MSMs BO list based path skips waits alltogether with
MSM_SUBMIT_NO_IMPLICT [4], though signals READ/WRITE, but its newer VM_BIND
based submission path does not have any BO list at all and adds a BOOKKEEP
fence to all external BOs imported into the VM[5]
- Panthor skips waits alltogether and signals BOOKKEEP[6]

And finally I think KERNEL/BOOKKEEP follows the dma-resv documentation[3]:
- DMA_RESV_USAGE_READ: This should only be used for userspace command
submissions which add an *implicit read dependency*.
- DMA_RESV_USAGE_BOOKKEEP: This should be used by submissions which don't
want to participate in any implicit synchronization. The most common cases
are preemption fences, page table updates, TLB flushes as well as
*explicitly synced user submissions*.

(emphasis mine)

So I'm not sure why we shouldn't stick with KERNEL/BOOKKEEP?

 - Bas

[1]
https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/vulkan/wsi/wsi_com=
mon_drm.c?ref_type=3Dheads#L48
[2]
https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.=
c#L303-L311
and
https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.=
c#L335-L337
[3]
https://github.com/torvalds/linux/blob/v7.3-rc4/include/linux/dma-resv.h#L7=
1-L116
[4]
https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem=
_submit.c#L678-L682
[5]
https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem=
_submit.c#L410-L413
[6]
https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/panthor/pan=
thor_sched.c#L4056-L4062

>
> Regards,
> Christian.
>
> >       }
> >
> >       seq =3D amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_i=
dx],
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> > index 39c33ad100cb..5c2a5f6b1d55 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> > @@ -50,6 +50,7 @@ struct amdgpu_cs_parser {
> >       struct amdgpu_device    *adev;
> >       struct drm_file         *filp;
> >       struct amdgpu_ctx       *ctx;
> > +     u32                     flags;
> >
> >       /* chunks */
> >       unsigned                nchunks;
>
>

--000000000000b9e1ce065eec0217
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 27,=
 2026 at 1:30=E2=80=AFPM Christian K=C3=B6nig &lt;<a href=3D"mailto:christi=
an.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On 10/22/26 02:30, Bas Nieuwenhu=
izen wrote:<br>
&gt; Implements the UAPI flag to give apps an options to disable<br>
&gt; implicit sync per submission.<br>
&gt; <br>
&gt; v2:<br>
&gt;=C2=A0 - signal READ fences for the VM root PD, as some unmapping<br>
&gt;=C2=A0 =C2=A0 operations only wait for READ and up.<br>
&gt; <br>
&gt; Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenh=
uizen.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
&gt; Reviewed-by: Faith Ekstrand &lt;<a href=3D"mailto:faith.ekstrand@colla=
bora.com" target=3D"_blank">faith.ekstrand@collabora.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 34 ++++++++++++++++++++=
+-----<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |=C2=A0 1 +<br>
&gt;=C2=A0 2 files changed, 29 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.c<br>
&gt; index afcd254c9884..f0fe9d0f1398 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -49,6 +49,9 @@<br>
&gt;=C2=A0 #define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0xFFFFF<br>
&gt;=C2=A0 #define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW=C2=A0 =C2=A0 =C2=A0 0x7F=
FFF0<br>
&gt;=C2=A0 <br>
&gt; +/* All flags accepted in drm_amdgpu_cs_in.flags */<br>
&gt; +#define AMDGPU_CS_FLAGS_MASK AMDGPU_CS_NO_IMPLICIT_SYNC<br>
&gt; +<br>
&gt;=C2=A0 static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type=
 type)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (type) {<br>
&gt; @@ -188,9 +191,11 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parse=
r *p,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (cs-&gt;in.flags)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (cs-&gt;in.flags &amp; ~AMDGPU_CS_FLAGS_MASK)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0p-&gt;flags =3D cs-&gt;in.flags;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0chunk_array =3D memdup_array_user(u64_to_use=
r_ptr(cs-&gt;in.chunks),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt=
;in.num_chunks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof=
(uint64_t));<br>
&gt; @@ -1220,16 +1225,19 @@ static int amdgpu_cs_sync_rings(struct amdgpu_=
cs_parser *p)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_exec_for_each_locked_object(&amp;p-&gt;e=
xec, obj) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Implicitly sync on=
ly to KERNEL, WRITE and READ */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum dma_resv_usage u=
sage =3D DMA_RESV_USAGE_READ;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo=
 *bo =3D gem_to_amdgpu_bo(obj);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_resv =
*resv =3D bo-&gt;tbo.base.resv;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum amdgpu_sync=
_mode sync_mode;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;flags &amp;=
 AMDGPU_CS_NO_IMPLICIT_SYNC)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0usage =3D DMA_RESV_USAGE_KERNEL;<br>
<br>
Use DMA_RESV_USAGE_WRITE here.<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sync_mode =3D am=
dgpu_bo_explicit_sync(bo) ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Implicitly sync on=
ly to KERNEL, WRITE and READ */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_res=
v(p-&gt;adev, &amp;p-&gt;sync, resv,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMA_RESV_USAGE_READ, sync=
_mode,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_res=
v(p-&gt;adev, &amp;p-&gt;sync, resv, usage, sync_mode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;fpriv-&gt;vm);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return r;<br>
&gt; @@ -1341,9 +1349,23 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pa=
rser *p,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;fence =3D dma_fence_get(&amp;leader-&g=
t;base.s_fence-&gt;finished);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_exec_for_each_locked_object(&amp;p-&gt;e=
xec, gobj) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum dma_resv_usage r=
ead_usage =3D DMA_RESV_USAGE_READ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum dma_resv_usage w=
rite_usage =3D DMA_RESV_USAGE_WRITE;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttm_bo_move_to_l=
ru_tail_unlocked(&amp;gem_to_amdgpu_bo(gobj)-&gt;tbo);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Keep READ/WRITE on=
 the root PD resv:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * amdgpu_vm_bo_updat=
e(clear=3Dtrue) only waits on the VM root PD<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * resv with read and=
 should still sync to avoid unmapping<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * before the job fin=
ishes.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((p-&gt;flags &amp=
; AMDGPU_CS_NO_IMPLICIT_SYNC) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gobj-&g=
t;resv !=3D vm-&gt;root.bo-&gt;tbo.base.resv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0read_usage =3D DMA_RESV_USAGE_BOOKKEEP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0write_usage =3D DMA_RESV_USAGE_BOOKKEEP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
<br>
Completely drop that.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Everybody exc=
ept for the gang leader uses READ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; p-&gt;gang_size; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (p-&gt;jobs[i] =3D=3D leader)<br>
&gt; @@ -1351,11 +1373,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_p=
arser *p,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dma_resv_add_fence(gobj-&gt;resv,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;p-&gt;jobs[i]-&gt;base.s_fence-&gt;finished,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMA_=
RESV_USAGE_READ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read=
_usage);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The gang lead=
er as remembered as writer */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_resv_add_fence(go=
bj-&gt;resv, p-&gt;fence, DMA_RESV_USAGE_WRITE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_resv_add_fence(go=
bj-&gt;resv, p-&gt;fence, write_usage);<br>
<br>
Instead just set that here to DMA_RESV_USAGE_READ when the CS is explicitel=
y synced.<br>
<br>
This way we get amdgpu nearly back to the usage model all other DRM drivers=
 uses.<br></blockquote><div><br></div><div>I think this has two problems:</=
div><div><br></div><div>1. It doesn&#39;t fully solve the problem I&#39;m t=
rying to address. In the common Vulkan WSI apps for present signal WRITE=C2=
=A0 and then wait on READ[1], meaning that the proposed wait on WRITE and s=
ignal READ result in submissions from the compositor still fully participat=
ing in implicit sync wrt presents. Waiting on KERNEL and signalling BOOKKEE=
P actually resolves this.</div><div>2. While the driver landscape is very d=
iverse I think other drivers are actually pretty much moving to KERNEL/BOOK=
KEEP. In particular:</div><div>- Xe does the KERNEl/BOOKKEEP[2]</div><div>-=
 MSMs BO list based path skips waits alltogether with MSM_SUBMIT_NO_IMPLICT=
 [4], though signals READ/WRITE, but its newer VM_BIND based submission pat=
h does not have any BO list at all and adds a BOOKKEEP fence to all externa=
l BOs imported into the VM[5]</div><div>- Panthor skips waits alltogether a=
nd signals BOOKKEEP[6]</div><div><br></div><div>And finally I think KERNEL/=
BOOKKEEP follows the dma-resv documentation[3]:</div><div>- DMA_RESV_USAGE_=
READ:=C2=A0This should only be used for userspace command submissions which=
 add an *implicit read dependency*.</div><div>-=C2=A0DMA_RESV_USAGE_BOOKKEE=
P:=C2=A0This should be used by submissions which don&#39;t want to particip=
ate in=C2=A0any implicit synchronization.=C2=A0The most common cases are pr=
eemption fences, page table updates, TLB=C2=A0flushes as well as *explicitl=
y synced user submissions*.</div><div><br></div><div>(emphasis mine)</div><=
div><br></div><div>So I&#39;m not sure why we shouldn&#39;t stick with KERN=
EL/BOOKKEEP?</div><div><br></div><div>=C2=A0- Bas</div><div><br></div><div>=
[1]=C2=A0<a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/sr=
c/vulkan/wsi/wsi_common_drm.c?ref_type=3Dheads#L48">https://gitlab.freedesk=
top.org/mesa/mesa/-/blob/main/src/vulkan/wsi/wsi_common_drm.c?ref_type=3Dhe=
ads#L48</a></div><div>[2] <a href=3D"https://github.com/torvalds/linux/blob=
/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.c#L303-L311">https://github.com/torval=
ds/linux/blob/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.c#L303-L311</a> and=C2=A0=
<a href=3D"https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/=
xe/xe_exec.c#L335-L337">https://github.com/torvalds/linux/blob/v7.3-rc4/dri=
vers/gpu/drm/xe/xe_exec.c#L335-L337</a></div><div>[3] <a href=3D"https://gi=
thub.com/torvalds/linux/blob/v7.3-rc4/include/linux/dma-resv.h#L71-L116">ht=
tps://github.com/torvalds/linux/blob/v7.3-rc4/include/linux/dma-resv.h#L71-=
L116</a></div><div>[4] <a href=3D"https://github.com/torvalds/linux/blob/v7=
.3-rc4/drivers/gpu/drm/msm/msm_gem_submit.c#L678-L682">https://github.com/t=
orvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem_submit.c#L678-L682<=
/a></div><div>[5] <a href=3D"https://github.com/torvalds/linux/blob/v7.3-rc=
4/drivers/gpu/drm/msm/msm_gem_submit.c#L410-L413">https://github.com/torval=
ds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem_submit.c#L410-L413</a></=
div><div>[6]=C2=A0<a href=3D"https://github.com/torvalds/linux/blob/v7.3-rc=
4/drivers/gpu/drm/panthor/panthor_sched.c#L4056-L4062">https://github.com/t=
orvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/panthor/panthor_sched.c#L4056-L=
4062</a></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
Christian.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0seq =3D amdgpu_ctx_add_fence(p-&gt;ctx, p-&g=
t;entities[p-&gt;gang_leader_idx],<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.h<br>
&gt; index 39c33ad100cb..5c2a5f6b1d55 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h<br>
&gt; @@ -50,6 +50,7 @@ struct amdgpu_cs_parser {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device=C2=A0 =C2=A0 *adev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0*filp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ctx=C2=A0 =C2=A0 =C2=A0 =C2=A0=
*ctx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* chunks */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 nchunks;<br>
<br>
</blockquote></div></div>

--000000000000b9e1ce065eec0217--
