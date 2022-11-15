Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DFEC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 14:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BCB10E3FE;
	Tue, 15 Nov 2022 14:10:22 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C32B10E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 14:10:18 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 a13-20020a9d6e8d000000b00668d65fc44fso8546686otr.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 06:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElRZ+9Sg4WuVMOCoQqa1jc6KoyAHzYvRYe40o+0MZ7g=;
 b=D2QP0gB7y+cSvvpGYJyKJnKI2S1CheCbu9xoWsuIMdnp7fIDMNQuUWzkE6dEmvmFUq
 vjhwVMoKng6Nrqbddh0yHQKo08Y1rNCOoNbbV5qgUCi/h9THiQEAYRKu4moFGWHgU7IH
 W0SId5fN8Nx0cWqCLkcfZdHMTQ3bBvglQ9znim91u5+PXTowE2uiX1nOot2VpkiYee85
 p9HvJ0U536HkjcZAsmSD0nEjK01ia+FpMYP7RKARYYXc4fvhR5oKnWPfXMYNFUHXiadP
 /KqV9v35X8/XsDupps5OrEggdBu3xfvh8pKBrgnwsZTvnBSp3IrFuNlYvd+7NEztWcLf
 VQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElRZ+9Sg4WuVMOCoQqa1jc6KoyAHzYvRYe40o+0MZ7g=;
 b=bluGAj/wvsL7IXIbY7Ck3nKMH7K7bQRMxoI1KdA641vUYGGr7nAKqkvvSEcLVjQLzn
 Fp1VnuNUBPg+G0SBBj9sQgjA29K1udCrACywuhdWXCqfBRFRpk3pFz0QbB7+uc4TTEM7
 cTm7jZ818KN5Q87RDlKPMwNWWcMkdwsZKVk+d7Crrv5mX3+etfFV4cLYAeO/fAxDsxe+
 Sx2/mKFO+ElO5d6wAU6HPHBwfzPYlFgCXteC8rzE1vsSscojBRpnZteUGXualMimu2kR
 9H9diYJ1gaB0IhDsJUq9Nq0f7gXgJ0Q+Qf7gL9l01UebZlQXqNKPJ6c/trujoC1SxLEw
 BrZQ==
X-Gm-Message-State: ANoB5pk5VUAUA5TEvenfFRfq4qS0AUYkH2dj39WjMHyTd5Qr+wT4oVC4
 A/OhMLrLGQ3ARNNtqQPTeBphHYXi/pJCXEtP4d3hBzlc
X-Google-Smtp-Source: AA0mqf7l0EY19gt8d1Vl3wiWhgbhDpOJr+hAHqJy/mUUtnuJTNB4fmMCPucLv4bQ7Q1wh7E4Ef1blI1dk3YH9L+jEPE=
X-Received: by 2002:a9d:32f:0:b0:66c:7982:2d45 with SMTP id
 44-20020a9d032f000000b0066c79822d45mr8785751otv.123.1668521418182; Tue, 15
 Nov 2022 06:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20221115094206.6181-1-christian.koenig@amd.com>
 <fc7e683f-4983-8adb-b8ed-3c756e179ef8@amd.com>
 <CADnq5_PXG=A4DUhfhnTAoZkCGnOKNm5oFrmZG-0vaxgbXz362w@mail.gmail.com>
In-Reply-To: <CADnq5_PXG=A4DUhfhnTAoZkCGnOKNm5oFrmZG-0vaxgbXz362w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Nov 2022 09:10:06 -0500
Message-ID: <CADnq5_MDYLpvxUeRpASp9gk4wuthot3RwkckQCny5fKEE_X2Pg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use the last IB as gang leader v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <Alexander.Deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Would be good to add a Fixes tag.

Alex

On Tue, Nov 15, 2022 at 9:09 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> On Tue, Nov 15, 2022 at 4:44 AM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 15.11.22 um 10:42 schrieb Christian K=C3=B6nig:
> > > It turned out that not the last IB specified is the gang leader,
> > > but instead the last job allocated.
> > >
> > > This is a bit unfortunate and not very intuitive for the CS
> > > interface, so try to fix this.
> >
> > Alex could you take a look at this? I would really like to get this int=
o
> > the next -rc.
> >
> > Thanks,
> > Christian.
> >
> > >
> > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++++++++++++++-------
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
> > >   2 files changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_cs.c
> > > index 1bbd39b3b0fc..fbdf139cf497 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > @@ -109,6 +109,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parse=
r *p,
> > >               return r;
> > >
> > >       ++(num_ibs[r]);
> > > +     p->gang_leader_idx =3D r;
> > >       return 0;
> > >   }
> > >
> > > @@ -300,7 +301,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parse=
r *p,
> > >               if (ret)
> > >                       goto free_all_kdata;
> > >       }
> > > -     p->gang_leader =3D p->jobs[p->gang_size - 1];
> > > +     p->gang_leader =3D p->jobs[p->gang_leader_idx];
> > >
> > >       if (p->ctx->vram_lost_counter !=3D p->gang_leader->vram_lost_co=
unter) {
> > >               ret =3D -ECANCELED;
> > > @@ -1194,16 +1195,18 @@ static int amdgpu_cs_sync_rings(struct amdgpu=
_cs_parser *p)
> > >                       return r;
> > >       }
> > >
> > > -     for (i =3D 0; i < p->gang_size - 1; ++i) {
> > > +     for (i =3D 0; i < p->gang_size; ++i) {
> > > +             if (p->jobs[i] =3D=3D leader)
> > > +                     continue;
> > > +
> > >               r =3D amdgpu_sync_clone(&leader->sync, &p->jobs[i]->syn=
c);
> > >               if (r)
> > >                       return r;
> > >       }
> > >
> > > -     r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_si=
ze - 1]);
> > > +     r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_le=
ader_idx]);
> > >       if (r && r !=3D -ERESTARTSYS)
> > >               DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> > > -
> > >       return r;
> > >   }
> > >
> > > @@ -1237,9 +1240,12 @@ static int amdgpu_cs_submit(struct amdgpu_cs_p=
arser *p,
> > >       for (i =3D 0; i < p->gang_size; ++i)
> > >               drm_sched_job_arm(&p->jobs[i]->base);
> > >
> > > -     for (i =3D 0; i < (p->gang_size - 1); ++i) {
> > > +     for (i =3D 0; i < p->gang_size; ++i) {
> > >               struct dma_fence *fence;
> > >
> > > +             if (p->jobs[i] =3D=3D leader)
> > > +                     continue;
> > > +
> > >               fence =3D &p->jobs[i]->base.s_fence->scheduled;
> > >               r =3D amdgpu_sync_fence(&leader->sync, fence);
> > >               if (r)
> > > @@ -1275,7 +1281,10 @@ static int amdgpu_cs_submit(struct amdgpu_cs_p=
arser *p,
> > >       list_for_each_entry(e, &p->validated, tv.head) {
> > >
> > >               /* Everybody except for the gang leader uses READ */
> > > -             for (i =3D 0; i < (p->gang_size - 1); ++i) {
> > > +             for (i =3D 0; i < p->gang_size; ++i) {
> > > +                     if (p->jobs[i] =3D=3D leader)
> > > +                             continue;
> > > +
> > >                       dma_resv_add_fence(e->tv.bo->base.resv,
> > >                                          &p->jobs[i]->base.s_fence->f=
inished,
> > >                                          DMA_RESV_USAGE_READ);
> > > @@ -1285,7 +1294,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pa=
rser *p,
> > >               e->tv.num_shared =3D 0;
> > >       }
> > >
> > > -     seq =3D amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size -=
 1],
> > > +     seq =3D amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader=
_idx],
> > >                                  p->fence);
> > >       amdgpu_cs_post_dependencies(p);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_cs.h
> > > index cbaa19b2b8a3..f80adf9069ec 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> > > @@ -54,6 +54,7 @@ struct amdgpu_cs_parser {
> > >
> > >       /* scheduler job objects */
> > >       unsigned int            gang_size;
> > > +     unsigned int            gang_leader_idx;
> > >       struct drm_sched_entity *entities[AMDGPU_CS_GANG_SIZE];
> > >       struct amdgpu_job       *jobs[AMDGPU_CS_GANG_SIZE];
> > >       struct amdgpu_job       *gang_leader;
> >
