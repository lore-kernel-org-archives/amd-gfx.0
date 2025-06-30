Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99A6C8302F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 13:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB5E10E22B;
	Mon, 30 Jun 2025 13:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dm0aXa+N";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BFF10E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 13:47:55 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-235248ba788so3767245ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751291275; x=1751896075; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjLzaSa7CvdyySN2FZPZYerDLeovMkF4sruVdsf3XJ8=;
 b=dm0aXa+N3pEbdkjvtvinCIzQYmoT6ETwU68aNiPjJSj30jIMmqn0YrXolqa5nPh/Ft
 MXDHrzoCB31YBprA+KnOf86UnAairM2gApefcVCSvvhyCAKlFJlXxQMmQPwAe/4cExIR
 Ou8B7YDE5pH/4kDeZ0J6/qRUMJSzv/HIRZnfddAdmmgn4dAe1if7WPCN5QCjM9d0J3zV
 UUs8aGCAQPNdk2dnUOjrlDRupvudYhtWUPUTDUR+3E/budpTexs9MufDHZVFV7zzVHIb
 k1xDWmhGmCLZMWZvws1p5WR0n0+XgcvEAVmpBIW1Dz3rLm2myL17XtvoGheAQZNXR4xZ
 +/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751291275; x=1751896075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JjLzaSa7CvdyySN2FZPZYerDLeovMkF4sruVdsf3XJ8=;
 b=lg8YawB01CVzNqU7YhekKfu1akzr3Eu/0Y2ryGB12NWT6PmbLbZkDVoWvO2irBIYlf
 TWMtmvcj+APV+A8ABbIvLGEwna4c95QbDFeARc7gtNw8IJWuPUnNMfSntG+vJYHHaGOT
 j0je46xEhOeXLhGIEA0MhMihqdkf01gVvp2r1PyGFNRiI5K2SC64OeDewQtMQjORhq+C
 o1kFGZpqTkNJHsPWFVeSt1h0GRiDY25BhmHml66+Xi2gLKXE4HuQtedEAd7HNZf/r2zN
 BnISExvSPB53RBiPWF7GyfxuLIRFxqfuRbZWK//CoCzEXTVrx7svnMIP7sHMJU35ocPX
 0GTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZCA/u8ZqiL4l9475/h1WCPzctse+kgicMcqKYvOMiAgCk+RpO0bTnq3L7lYU5YZl72wHXhzz5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHr8j1ZqIf4xmtjG9imQrZuWW7QGliUy525QbJN+Lfsi3MWdJz
 HoC1BtuyiDXyd7n4K571DRTUv/bRCAl6W7TYNuL0Ow5GjUzLx7nuwTbM3r2WViOdJ5dKlZXoNda
 zal5yisLtaG/RL+/DCh9UL8jZhHrkDOdUAQ==
X-Gm-Gg: ASbGnct4Hej+AXB8lhckbSNfhkaloHLIALZl09OhoawUK2/B4ebsjWleRvnwc0PAMoq
 6L0cjNd1ejRbIVa9mjwFuzrn7KDjpIkrJ+Vq/Sj5OoxwrX/RIsIxOj3Vz20AcxNNjLje4gDnvFj
 VUg4tRu0ndWm3fzIx0ROod4Ti840yDUokw/0HLPWoseHae
X-Google-Smtp-Source: AGHT+IFHUxp2UBtOqOtY0CCYVVWhKPRHcBbzAfK9Id8R7LnwLY/CHGIwmZHNDfYIiQ75gGUoRVLZaiFt2fu8arDfFZQ=
X-Received: by 2002:a17:902:e747:b0:234:1163:ffa0 with SMTP id
 d9443c01a7336-23ae943ca15mr57135095ad.13.1751291275223; Mon, 30 Jun 2025
 06:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <20250627034002.5590-3-alexander.deucher@amd.com>
 <fd35ac26-d510-47ac-a98f-0643c1525f1c@amd.com>
In-Reply-To: <fd35ac26-d510-47ac-a98f-0643c1525f1c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Jun 2025 09:47:43 -0400
X-Gm-Features: Ac12FXzbhEU0pF2ho7w5qJD8YER1cmgHgMsYJYY6U1_V2qSGClceADA_ScOHRtw
Message-ID: <CADnq5_M8hU+-wjLRs6p_wjmmuCVCgV02Q-zVv3irqjpeV6wh9g@mail.gmail.com>
Subject: Re: [PATCH 02/33] drm/amdgpu/sdma: consolidate engine reset handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 sasundar@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 30, 2025 at 4:48=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 27.06.25 05:39, Alex Deucher wrote:
> > Move the force completion handling into the common
> > engine reset function.  No need to duplicate it for
> > every IP version.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +----------------
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 ++----
> >  4 files changed, 9 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_sdma.c
> > index 7e26a44dcc1fd..56939bb1d1a95 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > @@ -590,9 +590,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device =
*adev, uint32_t instance_id)
> >        * to be submitted to the queues after the reset is complete.
> >        */
> >       if (!ret) {
> > +             amdgpu_fence_driver_force_completion(gfx_ring);
> >               drm_sched_wqueue_start(&gfx_ring->sched);
> > -             if (adev->sdma.has_page_queue)
> > +             if (adev->sdma.has_page_queue) {
> > +                     amdgpu_fence_driver_force_completion(page_ring);
>
> Calling amdgpu_fence_driver_force_completion() here sounds like a really =
bad idea in the first place.
>
> That will mark all fences as completed making it impossible to execute th=
e remaingin work.

That is the current behavior of the ring reset code so this just moves
the existing code around.  Also, SDMA 5.x and older is a bit special
because the hardware only supports engine reset (all queues) so when
we reset we lose all the queues.  Also SDMA resets can come in via KFD
as well so at this point, we just mark everything as lost when we
reset the engine.  This could potentially be optimized in the future.
I've done this for SDMA 5.x later in the series.

Alex

>
> Regards,
> Christian.
>
> >                       drm_sched_wqueue_start(&page_ring->sched);
> > +             }
> >       }
> >       mutex_unlock(&sdma_instance->engine_reset_mutex);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v4_4_2.c
> > index d3072bca43e3f..572d105420ec3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1714,7 +1714,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_r=
ing *ring)
> >  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     u32 inst_mask, tmp_mask;
> > +     u32 inst_mask;
> >       int i, r;
> >
> >       inst_mask =3D 1 << ring->me;
> > @@ -1733,21 +1733,6 @@ static int sdma_v4_4_2_restore_queue(struct amdg=
pu_ring *ring)
> >       }
> >
> >       r =3D sdma_v4_4_2_inst_start(adev, inst_mask, true);
> > -     if (r)
> > -             return r;
> > -
> > -     tmp_mask =3D inst_mask;
> > -     for_each_inst(i, tmp_mask) {
> > -             ring =3D &adev->sdma.instance[i].ring;
> > -
> > -             amdgpu_fence_driver_force_completion(ring);
> > -
> > -             if (adev->sdma.has_page_queue) {
> > -                     struct amdgpu_ring *page =3D &adev->sdma.instance=
[i].page;
> > -
> > -                     amdgpu_fence_driver_force_completion(page);
> > -             }
> > -     }
> >
> >       return r;
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_0.c
> > index 4d72b085b3dd7..ed1706da7deec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1618,10 +1618,8 @@ static int sdma_v5_0_restore_queue(struct amdgpu=
_ring *ring)
> >
> >       r =3D sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
> >       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -     if (r)
> > -             return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > -     return 0;
> > +
> > +     return r;
> >  }
> >
> >  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 42a25150f83ac..b87a4b44fa939 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -1534,10 +1534,8 @@ static int sdma_v5_2_restore_queue(struct amdgpu=
_ring *ring)
> >       r =3D sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
> >
> >       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -     if (r)
> > -             return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > -     return 0;
> > +
> > +     return r;
> >  }
> >
> >  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
>
