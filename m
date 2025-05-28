Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85722C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2676B10E2D3;
	Wed, 28 May 2025 13:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXXGOy8N";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF3D10E2D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:57:23 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b16c64b8cbcso639323a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748440642; x=1749045442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hdvl9G7Np3UXsUkzoeZZX5keMkv5hwe8nLw5Z20u4U=;
 b=WXXGOy8NKCuq9pyoc5A40N+rKE1TiTTBgCttCPhNY+s8N3etMqMqFt+SsHIY2D2sr3
 8ldt1+NvKbjwLIDOyNbuZBoIKluLW2MbaNRPvpXZQMEeL0Znl6ekaNmOJKeZwH1gdtFV
 mNLxUL10TJjKCfHPCpTpQJ9w0ln4s7W8pGRsgM9T8+E6niLCUpR6FhHej7Hbm0YykMbN
 nF0WUTVAksTVBn0ZBS8TRY0UNbgBa32ZIF4ZR4acvV97i6+cmg8CCJ3tPkV+QA0b1Y0f
 16JlfJOsUlC/HS06HxTKvylei75bdSQEkCa0DNvkcFePlMwuiAQfkYVdJEKepsxgz0A+
 PxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748440642; x=1749045442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hdvl9G7Np3UXsUkzoeZZX5keMkv5hwe8nLw5Z20u4U=;
 b=pDf4DPbaAway+//B5TkjKbqMgTg+t2JFz5nG9H3leMoGtkPZ60SNeok3JcPPQEbhFd
 tXLVW2RcyQ/fdSGDTyi8NmxYjOmaZ8LZyJtzofQtfExUg9EDNnaLtvMqZsAJA52W6PZS
 Kds363xL3u8FmtLBKCdOpwRLvIH2zXxyrJTbZD65GmsP8ZQ1R9fvbGFdLrUgi9Fh8H+f
 Hao9rwvsLWgE0kx5Wxg1OHNw2c53CqwlPENvV1jYFssRUFlWwgmtAuudUPMFdyZR8Zve
 SpH/VMoJUHTQAiLozc1pwTfy2MDPF7JRwEleZd40FC8jr+rLo7vAe/r4fE1KC/v2cN4l
 zO0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdTiYoZmRcnAIZZCMBpwkbtdcn0X1swmSPakJ5j2nSo7UP5f/TGl6qP9qyhaBvZNdahsVviF2e@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVZAi9m0nhv4Wr0u5RhYYi0Sxiha0m0IwajIC2hLNu+GWcWClT
 jGYxzo5y0KjMb9v+5mxtlpnOTsQy0qyc4UvkrrFIvekW8w3b9Rls/UAg/3WM68F4r9jU/t7Acke
 HXCowE8VgGYSLXr6vsoiS5BLi1xRSAaYR3A==
X-Gm-Gg: ASbGncuYhQPb5DKV9XIokg1CDVSuhinDYtb47acDos2mL7kl5/9xTnnRT3SX/5R+/Pl
 NNF0B7CK9AvmDKzHdwCpdKODFB9AkjUQPFZVe3fYVWT8c9Z9+6Euz3AzdIYFAxCTiopb6ZEJWU2
 ISla7ZH/wCifixnxhj6hS2rl1Y8siCNabdRg==
X-Google-Smtp-Source: AGHT+IGl09dqeOj84HYi942LEzOGQm2IgXFpELzm2kJZInl1Ex3ZiNhfNjrkYoffncEsqFbdYSORcickdHG6Vi04ly8=
X-Received: by 2002:a17:90b:4d8f:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-311e03a7f6amr1669553a91.0.1748440642370; Wed, 28 May 2025
 06:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-13-alexander.deucher@amd.com>
 <a85033a1-aea8-47a7-ac43-7e5c4a5d134b@amd.com>
 <CADnq5_M-0ziR25s-FyiiFWi5D_R6ntNkUtB4sTnKnDMNJdGSNA@mail.gmail.com>
 <95cc9164-85d2-4835-a393-0bf125cdb254@amd.com>
In-Reply-To: <95cc9164-85d2-4835-a393-0bf125cdb254@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 09:57:10 -0400
X-Gm-Features: AX0GCFv3vyLSbRQ5z8C2JVwpOt0C1Sr0Usa7jK-uqwF3qCWqbidYQlEolTlGXAQ
Message-ID: <CADnq5_OpgfhmAwcbQ0sLRqAdWpnzQ07M76xNRw9ugP+umSr7Zg@mail.gmail.com>
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

On Wed, May 28, 2025 at 9:48=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/28/25 15:38, Alex Deucher wrote:
> > On Wed, May 28, 2025 at 7:40=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/28/25 06:19, Alex Deucher wrote:
> >>> Re-emit the unprocessed state after resetting the queue.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
> >>>  1 file changed, 12 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v10_0.c
> >>> index 3193eb88b6889..f6e04cf21abcc 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> @@ -9537,6 +9537,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> >>>       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> >>>       unsigned long flags;
> >>> +     unsigned int i;
> >>>       u32 tmp;
> >>>       u64 addr;
> >>>       int r;
> >>> @@ -9571,10 +9572,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_r=
ing *ring, unsigned int vmid)
> >>>                                    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_=
RESET), 0, 0xffffffff);
> >>>       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> >>>       amdgpu_ring_commit(kiq_ring);
> >>> -
> >>> -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >>> -
> >>>       r =3D amdgpu_ring_test_ring(kiq_ring);
> >>
> >> I don't think we should do a ring test on the KIQ here That basically =
doesn't tells as much and might cause additional problems.
> >
> > We need some way to wait for the KIQ submission to complete.  This is
> > a simple way to accomplish that.
>
> Ok, that makes sense.
>
> >
> >>
> >>> +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >>>       if (r)
> >>>               return r;
> >>>
> >>> @@ -9584,7 +9583,15 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_r=
ing *ring, unsigned int vmid)
> >>>               return r;
> >>>       }
> >>>
> >>> -     return amdgpu_ring_test_ring(ring);
> >>> +     if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_co=
py))
> >>> +             return -ENOMEM;
> >>> +     amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> >>> +                            ring->ring_backup_seq, 0);
> >>> +     for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> >>> +             amdgpu_ring_write(ring, ring->ring_backup[i]);
> >>> +     amdgpu_ring_commit(ring);
> >>
> >> I'm not sure if the commands are always relocatable. We should probabl=
y just instruct the ring to re-start with the original RPTR/WPTR.
> >>
> >> That would also avoid the need to save/restore the ring content with t=
he CPU.
> >
> > I tried that originally, but I couldn't make it work for a few reasons:
> > 1. We need to have enforce isolation enabled otherwise we almost
> > always reset the wrong VMID so then when we execute the rest of the
> > pipeline, we hang again.
> > 2. When enforce isolation is enabled, we need to signal the fence
> > associated with the guilty job first otherwise we get stuck waiting on
> > the pipeline sync when we execute the rest of the pipeline
>
> So we execute the guilty job submission again? What prevents that one fro=
m running?

Without enforce isolation we usually end up reseting the wrong job. I
re-emit everything from the ring after the bad job.  What usually
happens is that a game is running and then you start an app which
hangs the GPU (e.g., an infinite loop in a shader).  Most of the time
we reset the game rather than the bad app.  The scheduler times out on
the app first and then we reset the queue and re-emit the following
jobs, one of which is the bad app.  Queue reset fails and we fall back
to a full adapter reset.  With enforce isolation, we reset the bad app
instead.

Alex

>
> Christian.
>
> >
> > Alex
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>> +
> >>> +     return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT)=
;
> >>>  }
> >>>
> >>>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> >>> @@ -9612,9 +9619,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ri=
ng *ring,
> >>>       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
> >>>                                  0, 0);
> >>>       amdgpu_ring_commit(kiq_ring);
> >>> -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >>> -
> >>>       r =3D amdgpu_ring_test_ring(kiq_ring);
> >>> +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >>>       if (r)
> >>>               return r;
> >>>
> >>> @@ -9891,7 +9897,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0=
_ring_funcs_gfx =3D {
> >>>       .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> >>>       .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> >>>       .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_=
wait,
> >>> -     .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
> >>>       .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
> >>>       .reset =3D gfx_v10_0_reset_kgq,
> >>>       .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> >>
>
