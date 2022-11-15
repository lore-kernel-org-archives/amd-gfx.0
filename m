Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB52FC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 14:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AC710E3FC;
	Tue, 15 Nov 2022 14:10:03 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FE210E3FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 14:09:57 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 a7-20020a056830008700b0066c82848060so8556382oto.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 06:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTV+g6QX6TaV162aOnz2QZ30gJK8o3cHZnwovs7ziVI=;
 b=Mc1R9KEaEfyHjpEJIJ9XwXrnosCBI2lIHjvPjz5tbJS38is+a9vay/BA76oVCyB1U6
 Gym0uwurfxExlD4o6gKd6OSyEdkCqws4lDaH0XT5ujZi+4pE0wC2XNF2W0tEZrbFwft0
 RE8LSNmvnVDmHYxE99+drhdHFKsGVQiHbUePJntWTiK27Fr6BqL3cB58jHfMKvYwMNlk
 S0uLZYxaEE/+WR+X+PtVMMbShZtJaBVwd3qKCCokUjK0xor8Dnfe/YUYyzPkNGci5oVJ
 usoqAAOIj6bzxmWsWAfO93RRo45udOnxNVVNmtjFqUZV/japCVLucXiENvPZJP5KjoZs
 dlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTV+g6QX6TaV162aOnz2QZ30gJK8o3cHZnwovs7ziVI=;
 b=mJXFxK0jz0seKoIANhEbTeKfhUvCVZ3LYKOdPzGrsa21rrVCha4QOyj6y0qaHiI0Ug
 vI0mJA6hL02jfW1RXfCIU+PtxzW/p9aE9md6tGQGhibjIln6xrtD9Kc9kNzrH1eJF2Xs
 S6Sd67oVvJzo43/+dJ869X8rTfjNiWXvv+Wv6f9xGfq/4iuZb/hFt+IvQPciE2bfk1/e
 BLrK2qOaiwW5xXkZcHaMAMr9VWAiqctsA6A2iBsRaO16itjXJydn7jC1wWhOyNqjIFU+
 Vjws5ekQqCne1fXHZ1hlqoDf+ZGSING8GsKgrLn/km5aRvRIjmnFgV+BtCFzDvzQ5bta
 oiAg==
X-Gm-Message-State: ANoB5plDMgOsl58KyOvxZ0+Z7FNXX89dHo0k6dRAsFv/A2xN8r2o3oPm
 ZYqZbCuxnRqb37Mt9opbAbNLRD9KYSlVcUOv+JU=
X-Google-Smtp-Source: AA0mqf480AGeh4plo+2ripmUpomSmVWJFmPQyN26Md/s/lz0O5SjNPnZtVEtFWr9T5HK7RWKzG0zaX/y3+G4LQcPK4w=
X-Received: by 2002:a05:6830:40af:b0:66c:6afa:5006 with SMTP id
 x47-20020a05683040af00b0066c6afa5006mr8926272ott.233.1668521397082; Tue, 15
 Nov 2022 06:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20221115094206.6181-1-christian.koenig@amd.com>
 <fc7e683f-4983-8adb-b8ed-3c756e179ef8@amd.com>
In-Reply-To: <fc7e683f-4983-8adb-b8ed-3c756e179ef8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Nov 2022 09:09:45 -0500
Message-ID: <CADnq5_PXG=A4DUhfhnTAoZkCGnOKNm5oFrmZG-0vaxgbXz362w@mail.gmail.com>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Nov 15, 2022 at 4:44 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 15.11.22 um 10:42 schrieb Christian K=C3=B6nig:
> > It turned out that not the last IB specified is the gang leader,
> > but instead the last job allocated.
> >
> > This is a bit unfortunate and not very intuitive for the CS
> > interface, so try to fix this.
>
> Alex could you take a look at this? I would really like to get this into
> the next -rc.
>
> Thanks,
> Christian.
>
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++++++++++++++-------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
> >   2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 1bbd39b3b0fc..fbdf139cf497 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -109,6 +109,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser =
*p,
> >               return r;
> >
> >       ++(num_ibs[r]);
> > +     p->gang_leader_idx =3D r;
> >       return 0;
> >   }
> >
> > @@ -300,7 +301,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser =
*p,
> >               if (ret)
> >                       goto free_all_kdata;
> >       }
> > -     p->gang_leader =3D p->jobs[p->gang_size - 1];
> > +     p->gang_leader =3D p->jobs[p->gang_leader_idx];
> >
> >       if (p->ctx->vram_lost_counter !=3D p->gang_leader->vram_lost_coun=
ter) {
> >               ret =3D -ECANCELED;
> > @@ -1194,16 +1195,18 @@ static int amdgpu_cs_sync_rings(struct amdgpu_c=
s_parser *p)
> >                       return r;
> >       }
> >
> > -     for (i =3D 0; i < p->gang_size - 1; ++i) {
> > +     for (i =3D 0; i < p->gang_size; ++i) {
> > +             if (p->jobs[i] =3D=3D leader)
> > +                     continue;
> > +
> >               r =3D amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync)=
;
> >               if (r)
> >                       return r;
> >       }
> >
> > -     r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size=
 - 1]);
> > +     r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_lead=
er_idx]);
> >       if (r && r !=3D -ERESTARTSYS)
> >               DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> > -
> >       return r;
> >   }
> >
> > @@ -1237,9 +1240,12 @@ static int amdgpu_cs_submit(struct amdgpu_cs_par=
ser *p,
> >       for (i =3D 0; i < p->gang_size; ++i)
> >               drm_sched_job_arm(&p->jobs[i]->base);
> >
> > -     for (i =3D 0; i < (p->gang_size - 1); ++i) {
> > +     for (i =3D 0; i < p->gang_size; ++i) {
> >               struct dma_fence *fence;
> >
> > +             if (p->jobs[i] =3D=3D leader)
> > +                     continue;
> > +
> >               fence =3D &p->jobs[i]->base.s_fence->scheduled;
> >               r =3D amdgpu_sync_fence(&leader->sync, fence);
> >               if (r)
> > @@ -1275,7 +1281,10 @@ static int amdgpu_cs_submit(struct amdgpu_cs_par=
ser *p,
> >       list_for_each_entry(e, &p->validated, tv.head) {
> >
> >               /* Everybody except for the gang leader uses READ */
> > -             for (i =3D 0; i < (p->gang_size - 1); ++i) {
> > +             for (i =3D 0; i < p->gang_size; ++i) {
> > +                     if (p->jobs[i] =3D=3D leader)
> > +                             continue;
> > +
> >                       dma_resv_add_fence(e->tv.bo->base.resv,
> >                                          &p->jobs[i]->base.s_fence->fin=
ished,
> >                                          DMA_RESV_USAGE_READ);
> > @@ -1285,7 +1294,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,
> >               e->tv.num_shared =3D 0;
> >       }
> >
> > -     seq =3D amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1=
],
> > +     seq =3D amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_i=
dx],
> >                                  p->fence);
> >       amdgpu_cs_post_dependencies(p);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.h
> > index cbaa19b2b8a3..f80adf9069ec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> > @@ -54,6 +54,7 @@ struct amdgpu_cs_parser {
> >
> >       /* scheduler job objects */
> >       unsigned int            gang_size;
> > +     unsigned int            gang_leader_idx;
> >       struct drm_sched_entity *entities[AMDGPU_CS_GANG_SIZE];
> >       struct amdgpu_job       *jobs[AMDGPU_CS_GANG_SIZE];
> >       struct amdgpu_job       *gang_leader;
>
