Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C97DCFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 15:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48CE10E02F;
	Tue,  2 Dec 2025 15:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JO9IY60T";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED1110E02F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 15:00:21 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7ba92341f07so287063b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Dec 2025 07:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764687621; x=1765292421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QkZm87ORlbOiLJr135OFUHbQAIgZOftaIUjzPrzWTs=;
 b=JO9IY60TM2tK8z6RuX+MLsZhk8XzRwRQoGzkTK2sbclAcr9/B3qiWAoq+oSgUSkqF9
 V3FvZQV/ZvYFyj+qfTRCHTWrUUasyT9I6GmVo5/5OTep5Kb2ndTgWUnCSwS9o9bY8Neh
 4b8RGUsYPfac3D2XY+0ISpD1bGxyjbeQBuTJn7j4urMqVD3A8tashvT3nnh94DMlO+0d
 3umjgbDVtz079COkqOPqhf7C2Gk3E5Ktyw/vw5RTaYg+N4zqVSJPpO+444kFrshuftOj
 HXpPUAeJVeqcDUkCp4EI7O8PecJHTIwtYnbHre9QZMrnHqXhje2R5GxJKsJ87ID4Aknx
 1lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764687621; x=1765292421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QkZm87ORlbOiLJr135OFUHbQAIgZOftaIUjzPrzWTs=;
 b=vllh/DSu6pMLNR+WYcth7dYUJIEfhdtoPlpRnUk+ulQca4bRQng3AyX/Mu7RTRW6+9
 jKSWmT07zcGY7/rBpQbLySwEgLuO3nVs80oCGm/lT4kDBKGwt2VW3fYr8VNqnOHHhFaq
 Q3qS+i3VKR0pOKMFWMvABPBjYLuPtTTQ/471ymXsahQK/5dz1rDa/RVBjxbkLS5BrBeE
 AEe2K5EWU1RJbZ3SD1SGhxCEqH1uV0XP5jT3KoQW/BSNdW40vL8dMQeH0FKhSBSOQbVh
 TSYliBcThFF5f6hp8sX/mSHVFxnQR3OqL+qbZmlCrdvJL2pIBxfnwhMNc9tLkxNh9HFO
 9nXg==
X-Gm-Message-State: AOJu0Yzuy5H+VPc1TeIFOEuDq35NAUqdbvoYFD7L19M7bsWEsmHVoku/
 ds3IeH9FHvppNhmHDT1pcNmloFAKw5yJ2OzSo4Q4F6uy5yOA6WgDhTdwq4Vjx57fw7oR1J0/qT4
 n0OuhPNIBqnsWzqnW8fURPDifq5h/pMrMvg==
X-Gm-Gg: ASbGncuo2OklCyHhnZ7cec5vZ7v8GRRQVoa/894FBmzslUo7WsgRjP4mMyL3KrcCyKf
 vaHh/PjuElgpOOrw7pLDBEmlNgoCILFsmXsZTKwRO5CRe+9sSoQAQf5gM247hW8OrYnh4e/tmEq
 z6BBX/TKSu70LL2Vuh3cT3r1LwfUd5TK+AgCug+fzFuX5n39etGTD/LOeVbWMUMZF6rT+Yt4Heh
 9gb1qyMqJm/XbHpuDaPrQ5lRFnJ5Ds/PahQ2ybgR51yTeM/XZA4AbOdA+dYkGkq4/lXHX4=
X-Google-Smtp-Source: AGHT+IHkc/7THC1I9fpJwJpRl6zWhB61exTFH0s2Nie5R/TpgfsedgbizwGgK/h69OBSBiWDbMqHgnHDfcMJEScVYBc=
X-Received: by 2002:a05:7022:ea46:10b0:11b:65e:f33 with SMTP id
 a92af1059eb24-11c9d70be14mr22479739c88.1.1764687620566; Tue, 02 Dec 2025
 07:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20251119203004.22742-1-alexander.deucher@amd.com>
 <CADnq5_MHBxCAjJ_zYCVptR5PcsVwy=ij9f06DuaB-FNYY9sC+g@mail.gmail.com>
In-Reply-To: <CADnq5_MHBxCAjJ_zYCVptR5PcsVwy=ij9f06DuaB-FNYY9sC+g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Dec 2025 10:00:08 -0500
X-Gm-Features: AWmQ_blUn6YsIQaJyDFIn12LPWAP5kw58xQ1oeYI_xpcjdm4RG2rlSHh17ompo0
Message-ID: <CADnq5_PEDM+QCt5ggabVzt7jzX8GtxN6BXp8Z8SdFMvow0WWag@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: don't reemit ring contents more than once
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping again?

On Wed, Nov 26, 2025 at 9:11=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping on this series?
>
> On Wed, Nov 19, 2025 at 4:09=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > If we cancel a bad job and reemit the ring contents, and
> > we get another timeout, cancel everything rather than reemitting.
> > The wptr markers are only relevant for the original emit.  If
> > we reemit, the wptr markers are no longer correct.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
> >  2 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 1fe31d2f27060..334ddd6e48c06 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(st=
ruct amdgpu_fence *af)
> >         struct amdgpu_ring *ring =3D af->ring;
> >         unsigned long flags;
> >         u32 seq, last_seq;
> > +       bool reemitted =3D false;
> >
> >         last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fenc=
es_mask;
> >         seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_m=
ask;
> > @@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(st=
ruct amdgpu_fence *af)
> >                 if (unprocessed && !dma_fence_is_signaled_locked(unproc=
essed)) {
> >                         fence =3D container_of(unprocessed, struct amdg=
pu_fence, base);
> >
> > -                       if (fence =3D=3D af)
> > +                       if (fence->reemitted > 1)
> > +                               reemitted =3D true;
> > +                       else if (fence =3D=3D af)
> >                                 dma_fence_set_error(&fence->base, -ETIM=
E);
> >                         else if (fence->context =3D=3D af->context)
> >                                 dma_fence_set_error(&fence->base, -ECAN=
CELED);
> > @@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(s=
truct amdgpu_fence *af)
> >                 rcu_read_unlock();
> >         } while (last_seq !=3D seq);
> >         spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> > -       /* signal the guilty fence */
> > -       amdgpu_fence_write(ring, (u32)af->base.seqno);
> > -       amdgpu_fence_process(ring);
> > +
> > +       if (reemitted) {
> > +               /* if we've already reemitted once then just cancel eve=
rything */
> > +               amdgpu_fence_driver_force_completion(af->ring);
> > +               af->ring->ring_backup_entries_to_copy =3D 0;
> > +       } else {
> > +               /* signal the guilty fence */
> > +               amdgpu_fence_write(ring, (u32)af->base.seqno);
> > +               amdgpu_fence_process(ring);
> > +       }
> >  }
> >
> >  void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> > @@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(stru=
ct amdgpu_ring *ring,
> >                         /* save everything if the ring is not guilty, o=
therwise
> >                          * just save the content from other contexts.
> >                          */
> > -                       if (!guilty_fence || (fence->context !=3D guilt=
y_fence->context))
> > +                       if (!fence->reemitted &&
> > +                           (!guilty_fence || (fence->context !=3D guil=
ty_fence->context)))
> >                                 amdgpu_ring_backup_unprocessed_command(=
ring, wptr,
> >                                                                        =
fence->wptr);
> >                         wptr =3D fence->wptr;
> > +                       fence->reemitted++;
> >                 }
> >                 rcu_read_unlock();
> >         } while (last_seq !=3D seq);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 52c7597870eb9..f93bf83f7f5e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -155,6 +155,8 @@ struct amdgpu_fence {
> >         u64                             wptr;
> >         /* fence context for resets */
> >         u64                             context;
> > +       /* has this fence been reemitted */
> > +       unsigned int                    reemitted;
> >  };
> >
> >  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> > --
> > 2.51.1
> >
