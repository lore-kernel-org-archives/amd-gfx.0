Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1891EC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8644A10E613;
	Wed, 28 May 2025 13:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/XXGkv+";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3155610E60E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:38:38 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-311ea13388fso51343a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748439518; x=1749044318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzqgGPfdh+pthziS6dfE4aLnbVr+O4BuSUPbDXg8KDc=;
 b=P/XXGkv+xzgt0lksvbKmItVwEHV41gxaXig8xrTCWgIefStd5kNdRJwBOoJ8j0gZpz
 pPzbiOX8bs1xU4G0tO62wFWM+HIx8B7vgK/k9pJwFnUlJMBQNgE83i2+FySlNLLYsElf
 NZfI4HmhX7lfVAMZzIuayF/nOrK0ZV2rQXWAqJ4yh4cB/j+ZKsz6cbzr3+xccz4V5ea3
 HtlEN046Zk27z3So5PK1r8zUp5VBFmX4dZs/UFSYsNuo3dP8HGACOky1AO68gpPb+B1e
 3PERLEPIZ2v1VzcJzdcMLOmfIBWUYpvS4beZr6AMxRfvcLgkq+LMMhnR5J372qmY9uDG
 UiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748439518; x=1749044318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzqgGPfdh+pthziS6dfE4aLnbVr+O4BuSUPbDXg8KDc=;
 b=V9NO0vLD63Evnd17ybadKo54E8AgvigzRBRtfYKvY9b/3vKdNgXhL1FY+76KKL3wxD
 bv9Ka5yXuU+n5HL+aSnNE+SsORAJAqHgKSKNNcmMLXfb9LKHwIPdExLNyrAxOGDmqDag
 w7Hwh43I8lF4D6RMNaCQlFxorJxMQQmZxbyYgBBhpPOQO/37wli8uhAcSKAI5UNr/JTi
 KCl4RDbRqK+GURFhDdzClcwHXPGTH85iWUaySaIOqIdjnELbUM3nblMBfJx1ZIPM9NjU
 PY9EuVO4QqkZTzW4k1lSG9fCJr8Kl8jAt0s06O/saDB0KKBMT2JOLgu1U7NCTTLdsClT
 wRvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPBeZZ1wHqI/UR5kXWuO30EmlPq0aF1mEG851AI/A367r8+aupuQ0USaUdh/4gGOTYKvumthB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywd7REQCqgITFmCWMBxmtLqbFK9/hk3ZCB5veXdzdSolWpgjwCv
 Y2f+xzbQYQKfXfD84wKnuSsPtJWE0QcXMWh4C8AvI6o0Gv+4oLPhFd/4heboLqM0i1NLAlPS/CN
 ZjgV4lEOPPW0MvPNTrs/h/HKjEb5pKaE=
X-Gm-Gg: ASbGncs8J4px70tsh+9RRNt6pKmypXmseK4ytEeKySUFReg/JPxSKajQp+x9UB+a6Y5
 tDdIFzzmUulYgQroyPPumYNo4smD+zbc3mBBjI39KpdppdKe5BahvC9UtIka5dvdNDUNZ09wj8w
 7Mkwb4lK1Qlsj7AqZbJKle2Fo7MNk3PJVyrQ==
X-Google-Smtp-Source: AGHT+IFYy3OSQ2ZR6EkNDS/aXElVO3NHPLSkqz385bfOaaSHwS9dQLV/K7H3qcxEGz5XEpE4vfkQIIP4FpGIgwULV9M=
X-Received: by 2002:a17:90b:4b06:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-3110f0eb80amr10034500a91.2.1748439517477; Wed, 28 May 2025
 06:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-13-alexander.deucher@amd.com>
 <a85033a1-aea8-47a7-ac43-7e5c4a5d134b@amd.com>
In-Reply-To: <a85033a1-aea8-47a7-ac43-7e5c4a5d134b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 09:38:24 -0400
X-Gm-Features: AX0GCFvF5PmxMxcadtsuQqedor11ssCKEo7jrrqiOhwxpto41ntIdDYawUCBm3g
Message-ID: <CADnq5_M-0ziR25s-FyiiFWi5D_R6ntNkUtB4sTnKnDMNJdGSNA@mail.gmail.com>
Subject: Re: [PATCH 12/19] drm/amdgpu/gfx10: re-emit unprocessed state on kgq
 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, May 28, 2025 at 7:40=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/28/25 06:19, Alex Deucher wrote:
> > Re-emit the unprocessed state after resetting the queue.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 3193eb88b6889..f6e04cf21abcc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -9537,6 +9537,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> >       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> >       unsigned long flags;
> > +     unsigned int i;
> >       u32 tmp;
> >       u64 addr;
> >       int r;
> > @@ -9571,10 +9572,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_rin=
g *ring, unsigned int vmid)
> >                                    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RE=
SET), 0, 0xffffffff);
> >       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> >       amdgpu_ring_commit(kiq_ring);
> > -
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
>
> I don't think we should do a ring test on the KIQ here That basically doe=
sn't tells as much and might cause additional problems.

We need some way to wait for the KIQ submission to complete.  This is
a simple way to accomplish that.

>
> > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r)
> >               return r;
> >
> > @@ -9584,7 +9583,15 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_rin=
g *ring, unsigned int vmid)
> >               return r;
> >       }
> >
> > -     return amdgpu_ring_test_ring(ring);
> > +     if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy=
))
> > +             return -ENOMEM;
> > +     amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > +                            ring->ring_backup_seq, 0);
> > +     for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> > +             amdgpu_ring_write(ring, ring->ring_backup[i]);
> > +     amdgpu_ring_commit(ring);
>
> I'm not sure if the commands are always relocatable. We should probably j=
ust instruct the ring to re-start with the original RPTR/WPTR.
>
> That would also avoid the need to save/restore the ring content with the =
CPU.

I tried that originally, but I couldn't make it work for a few reasons:
1. We need to have enforce isolation enabled otherwise we almost
always reset the wrong VMID so then when we execute the rest of the
pipeline, we hang again.
2. When enforce isolation is enabled, we need to signal the fence
associated with the guilty job first otherwise we get stuck waiting on
the pipeline sync when we execute the rest of the pipeline

Alex

>
> Regards,
> Christian.
>
> > +
> > +     return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
> >  }
> >
> >  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> > @@ -9612,9 +9619,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring=
 *ring,
> >       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
> >                                  0, 0);
> >       amdgpu_ring_commit(kiq_ring);
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r)
> >               return r;
> >
> > @@ -9891,7 +9897,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_r=
ing_funcs_gfx =3D {
> >       .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> > -     .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
> >       .reset =3D gfx_v10_0_reset_kgq,
> >       .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
>
