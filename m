Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AD3D6E2A5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 15:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1102210EA15;
	Thu, 18 Dec 2025 15:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y5I+UIOh";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B1610E30E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 15:37:10 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7baa5787440so29113b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 07:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766072230; x=1766677030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQzEeSP+iEmx88YDS2wmKP/BdRZ9YjLfYs2k9FdUarw=;
 b=Y5I+UIOhUx8PpqqO40iirr998LGRhuv/wOEpEyGSAXMGXDqopiV39OOjk91j6rkiov
 fIY05Pu5/ayQhsPf5UD7SlJ8cu1I3fslJIf8zAv8itWS3CCEq4RlpVuKhdBvNEmdRC9b
 u85nBuHq1HUlJJAZ5R5z73m0mBBuBIC1KvuIYK9gG/Cgjjt9v03LWPAQVFI1/LiCWwbS
 h8AOeKiT7TjQSeOm6GJUJLvYsv0zxT89SR/jwxQCTo0rQbgHgbqADf4LZwd98PGoJPxE
 YSvdT8FY7rbbdye+T7juzXFcsgW+xozdOdmaz8Cv10kF8P3yvUKWgmWV/fAKgKBcKvcy
 +aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766072230; x=1766677030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wQzEeSP+iEmx88YDS2wmKP/BdRZ9YjLfYs2k9FdUarw=;
 b=O48QkIfQjflfluz3d+0VfPg7siwJw3YbdtxahY21Yne0l1qQ218BitrlYld2oBrv1A
 3aGhBUidzBNzgz8W/JHiJ0sWFAJBQH8uB3vR9qnhJnhoxPsnx2jGkXdjy6YsVWj0Rh/1
 ddMTdwhe4yvvd++vSZygzMbust/jdq4i64BmaVBUAQBB0lPaX6UUFLdCFKCVs6cDVfgh
 JDwCbmJFHtrq53nDHEj/Oblrh5sjEOW6n4xM5ozJnWCgXA4g6pLeQMUFTqjs/jT1uBqc
 E0E6j7KMfOr+JjV5acJYhAXfhbVzHf21nBYF32RUrMH4uciQoOJ3zXogoU0mk2Kb5Udr
 8ltw==
X-Gm-Message-State: AOJu0Yz6oOSQQSKSvU8rgTbBiw9TVkDTNt2LWo2LaTq7GJbz6HhC3PsL
 dKV1Lr0j0PIVTt7b50HvxgkDxrtyGThOgv8o8+7XQo8KX8vbXUMK+a/W7N+4+aOj3/D/xgHwOzZ
 Vb6vMRcFa/pT513L1GOqsZud0MCXf4DI=
X-Gm-Gg: AY/fxX75Pq602ZUvZGmAHpyWB8z0V+82gLzUm3b00FJJsdf/+OEGYTHSXVAIv8jPuRK
 1CYDPrkEV8HQ5vHoPuOfa4InITpSFCGyV3Yv0UZA1nztjz0ei2ehJFWXRIB/j7UMvnV+5FQniGB
 L4HenHEhP17etD3eaqCgmdKCwcOY/djjP+Gq88dtnONJS2t4+bwuQi7cdtzSrV5QlXcpGzcUsyl
 6UybNwdwLiQ1ohiocKWqWnSTQ/AjKVX5B+LPwyZ1Zn/8a+nvuAumH3RfFsbr8ZibdNYQFRa
X-Google-Smtp-Source: AGHT+IEAuyC1ahjdsW+RlVh6xHGlhcpxvWzVagcxUTzGK/ORVsgusZmmQ4WGB/pmGg1vPA8LaYXTZ1RmoRKl5OfAgTQ=
X-Received: by 2002:a05:7022:208f:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-1206281f55dmr1089941c88.2.1766072229593; Thu, 18 Dec 2025
 07:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <2459360.yiUUSuA9gR@timur-max>
In-Reply-To: <2459360.yiUUSuA9gR@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Dec 2025 10:36:57 -0500
X-Gm-Features: AQt7F2r1zvW5kbpquSNi0rT4OO3WeskXoJyA6lpOPTNCqm7mFCWFM36G7wFW6Oc
Message-ID: <CADnq5_MrscrX+4vpNwpzK47+nLvF0ognLrB=56hqfv89y-LA6g@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: don't reemit ring contents more than once
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Dec 18, 2025 at 12:36=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On 2025. december 15., h=C3=A9tf=C5=91 10:07:06 k=C3=B6z=C3=A9ps=C5=91 =
=C3=A1llamokbeli z=C3=B3naid=C5=91 Alex Deucher
> wrote:
> > If we cancel a bad job and reemit the ring contents, and
> > we get another timeout, cancel everything rather than reemitting.
> > The wptr markers are only relevant for the original emit.  If
> > we reemit, the wptr markers are no longer correct.
>
> I see the point of not reemitting, considering the wptrs are no longer
> correct. However, would it be possible to correct the wptrs instead?
>

Yes, that could be done, but it's more complicated.  This is just a
short term fix until that is implemented.

Alex

> As it is, this sounds like it would make the reset less reliable when the=
re is
> more than one job emitted that can cause hangs.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
> >  2 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c index
> > 1fe31d2f27060..334ddd6e48c06 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(st=
ruct
> > amdgpu_fence *af) struct amdgpu_ring *ring =3D af->ring;
> >       unsigned long flags;
> >       u32 seq, last_seq;
> > +     bool reemitted =3D false;
> >
> >       last_seq =3D amdgpu_fence_read(ring) & ring-
> >fence_drv.num_fences_mask;
> >       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mas=
k;
> > @@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(st=
ruct
> > amdgpu_fence *af) if (unprocessed &&
> > !dma_fence_is_signaled_locked(unprocessed)) { fence =3D
> > container_of(unprocessed, struct amdgpu_fence, base);
> >
> > -                     if (fence =3D=3D af)
> > +                     if (fence->reemitted > 1)
> > +                             reemitted =3D true;
> > +                     else if (fence =3D=3D af)
> >                               dma_fence_set_error(&fence->base,
> -ETIME);
> >                       else if (fence->context =3D=3D af->context)
> >                               dma_fence_set_error(&fence->base,
> -ECANCELED);
> > @@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(s=
truct
> > amdgpu_fence *af) rcu_read_unlock();
> >       } while (last_seq !=3D seq);
> >       spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> > -     /* signal the guilty fence */
> > -     amdgpu_fence_write(ring, (u32)af->base.seqno);
> > -     amdgpu_fence_process(ring);
> > +
> > +     if (reemitted) {
> > +             /* if we've already reemitted once then just cancel
> everything */
> > +             amdgpu_fence_driver_force_completion(af->ring);
> > +             af->ring->ring_backup_entries_to_copy =3D 0;
> > +     } else {
> > +             /* signal the guilty fence */
> > +             amdgpu_fence_write(ring, (u32)af->base.seqno);
> > +             amdgpu_fence_process(ring);
> > +     }
> >  }
> >
> >  void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> > @@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(stru=
ct
> > amdgpu_ring *ring, /* save everything if the ring is not guilty, otherw=
ise
> >                        * just save the content from other
> contexts.
> >                        */
> > -                     if (!guilty_fence || (fence->context !=3D
> guilty_fence->context))
> > +                     if (!fence->reemitted &&
> > +                         (!guilty_fence || (fence->context !=3D
> guilty_fence->context)))
> >
> amdgpu_ring_backup_unprocessed_command(ring, wptr,
> >
>        fence->wptr);
> >                       wptr =3D fence->wptr;
> > +                     fence->reemitted++;
> >               }
> >               rcu_read_unlock();
> >       } while (last_seq !=3D seq);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index
> > a1fb0fadb6eab..d881829528976 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -150,6 +150,8 @@ struct amdgpu_fence {
> >       u64                             wptr;
> >       /* fence context for resets */
> >       u64                             context;
> > +     /* has this fence been reemitted */
> > +     unsigned int                    reemitted;
> >  };
> >
> >  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>
>
>
>
