Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9087C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 14:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA6110E639;
	Wed, 28 May 2025 14:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QA+HYe+5";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C9710E639
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 14:26:23 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b2700de85d0so427480a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748442383; x=1749047183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bahQyYVnk5HrDYCNe//tScm8+SQhpuLjOkblLP/k6g=;
 b=QA+HYe+5UDnjscjg+7JHKNEfogTlqr75xa6Efx5gDNbY92/1nzDFfyTiT9z0ZDeo7g
 wp8zF78wRl53V8lKmpHfYzZCuxTSRvnOKgk5/LKJ0WOTfQ+P6mohckCd6zuSBeF2If+w
 K/S6+wFuVXEZ2bpG5cteH7eprWhw7mAPG1S0968yC0TKJSnIms4UjTQdInsm4wWdJoWE
 3NWUTQd7y0cc7AzGDiYqTyf3xUFeP1O9F5yYtPx4Ee7w2mXNES13lK8WTbvy9mfxOPOa
 3dVpaDQXxOVtcLyhDVEdb1CL5LclHSs5RRbrT+t6Ugz4m0uDXtjv33ik8bqyCp7wMEnx
 hyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442383; x=1749047183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bahQyYVnk5HrDYCNe//tScm8+SQhpuLjOkblLP/k6g=;
 b=uuuIDVwoNcFiRdiSvOxl5L0C7FMzIJFOT3qtq5lyrBrgNy66Kd8Qvwavjup85WeNcq
 xVT5K72cFb4N3tMWJDhWZ2GYj6Ytdc2RnCZeJwLdsV+VSu9NxuClktMYK8+aFppue5xu
 2D4xTOOHUbIXPtZzkkvnmtryD0uR1bTQ/VDTYcA4aDBi6aJWaIggv7j1cOXj/J66z/D6
 MLQxOYr38x6ZomeBgjsDf6qLfBd7duJciQ4VZkodaM5ZhWco1nRRrKOe5E3urBYvww4P
 hcXl0f8MOm68Bp4hkzd0RFc71tEco95t9iVTWCBYQCgU7ztb74SRiM1zjZIPEmTU5XOq
 4bPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZXg5/P4Yrn1OK9UpZXgyQNqEiLbx0Xq4vHeJbp1h6rmvdkcfIu5FEoAWVa9MaobMEQ3CVJlz1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6J8nBC9ONXTMVBgmt3aAD2MJFzufWerD/O6iFwG0IjC+GOAs8
 nuopffjznTpHhH54fnUyTt2xFoaSbdXo3bu85QoJ9AKkrD2P0zJFQNFmsFs+JGhXe8Soqsdw5sP
 dOni2FEy4D5PBbaHgEEF4HhwGh7dtOCArNg==
X-Gm-Gg: ASbGncull2GoIoL1cKbINz0YlnyTmT+qYgHRHLdMLBU9PMj2HEiStQ51tUJjtOG4rGc
 VsCkvTq37Va6KDqGFKZzsXezlbnXFWFVddyULKxRgPeKyt6m/Pd8UBn3kUMmISwd3+FXmAbKgjF
 3EGDYPYgKkU5/3eC0e316sAVS8BVw9uk4T+A==
X-Google-Smtp-Source: AGHT+IFZlmnf5tofu97S5xmsrLSN+bAs8EDSzJoH/7CfrlR2ZmZ6PwMxdpm9hBPGWjJkvpN5Jy/n21OItfBs6ZMdv+E=
X-Received: by 2002:a17:90a:e7cd:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-311c5d93147mr3171889a91.5.1748442383213; Wed, 28 May 2025
 07:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-13-alexander.deucher@amd.com>
 <a85033a1-aea8-47a7-ac43-7e5c4a5d134b@amd.com>
 <CADnq5_M-0ziR25s-FyiiFWi5D_R6ntNkUtB4sTnKnDMNJdGSNA@mail.gmail.com>
 <95cc9164-85d2-4835-a393-0bf125cdb254@amd.com>
 <CADnq5_OpgfhmAwcbQ0sLRqAdWpnzQ07M76xNRw9ugP+umSr7Zg@mail.gmail.com>
In-Reply-To: <CADnq5_OpgfhmAwcbQ0sLRqAdWpnzQ07M76xNRw9ugP+umSr7Zg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 10:26:11 -0400
X-Gm-Features: AX0GCFtKpd-Q8uX8NAtyqgS0heznmSWsYfQN7jVix9WwvCm0MySFWE6X0tfg7tU
Message-ID: <CADnq5_NKS1opMs_vEmsjyUQLMyNX59_C7EFe9cz+G8-f3QDh0g@mail.gmail.com>
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

On Wed, May 28, 2025 at 9:57=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, May 28, 2025 at 9:48=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 5/28/25 15:38, Alex Deucher wrote:
> > > On Wed, May 28, 2025 at 7:40=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >>
> > >> On 5/28/25 06:19, Alex Deucher wrote:
> > >>> Re-emit the unprocessed state after resetting the queue.
> > >>>
> > >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >>> ---
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
> > >>>  1 file changed, 12 insertions(+), 7 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gfx_v10_0.c
> > >>> index 3193eb88b6889..f6e04cf21abcc 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > >>> @@ -9537,6 +9537,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_=
ring *ring, unsigned int vmid)
> > >>>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > >>>       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > >>>       unsigned long flags;
> > >>> +     unsigned int i;
> > >>>       u32 tmp;
> > >>>       u64 addr;
> > >>>       int r;
> > >>> @@ -9571,10 +9572,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu=
_ring *ring, unsigned int vmid)
> > >>>                                    SOC15_REG_OFFSET(GC, 0, mmCP_VMI=
D_RESET), 0, 0xffffffff);
> > >>>       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> > >>>       amdgpu_ring_commit(kiq_ring);
> > >>> -
> > >>> -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > >>> -
> > >>>       r =3D amdgpu_ring_test_ring(kiq_ring);
> > >>
> > >> I don't think we should do a ring test on the KIQ here That basicall=
y doesn't tells as much and might cause additional problems.
> > >
> > > We need some way to wait for the KIQ submission to complete.  This is
> > > a simple way to accomplish that.
> >
> > Ok, that makes sense.
> >
> > >
> > >>
> > >>> +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > >>>       if (r)
> > >>>               return r;
> > >>>
> > >>> @@ -9584,7 +9583,15 @@ static int gfx_v10_0_reset_kgq(struct amdgpu=
_ring *ring, unsigned int vmid)
> > >>>               return r;
> > >>>       }
> > >>>
> > >>> -     return amdgpu_ring_test_ring(ring);
> > >>> +     if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_=
copy))
> > >>> +             return -ENOMEM;
> > >>> +     amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > >>> +                            ring->ring_backup_seq, 0);
> > >>> +     for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> > >>> +             amdgpu_ring_write(ring, ring->ring_backup[i]);
> > >>> +     amdgpu_ring_commit(ring);
> > >>
> > >> I'm not sure if the commands are always relocatable. We should proba=
bly just instruct the ring to re-start with the original RPTR/WPTR.
> > >>
> > >> That would also avoid the need to save/restore the ring content with=
 the CPU.
> > >
> > > I tried that originally, but I couldn't make it work for a few reason=
s:
> > > 1. We need to have enforce isolation enabled otherwise we almost
> > > always reset the wrong VMID so then when we execute the rest of the
> > > pipeline, we hang again.
> > > 2. When enforce isolation is enabled, we need to signal the fence
> > > associated with the guilty job first otherwise we get stuck waiting o=
n
> > > the pipeline sync when we execute the rest of the pipeline
> >
> > So we execute the guilty job submission again? What prevents that one f=
rom running?
>
> Without enforce isolation we usually end up reseting the wrong job. I
> re-emit everything from the ring after the bad job.  What usually
> happens is that a game is running and then you start an app which
> hangs the GPU (e.g., an infinite loop in a shader).  Most of the time
> we reset the game rather than the bad app.  The scheduler times out on
> the app first and then we reset the queue and re-emit the following
> jobs, one of which is the bad app.  Queue reset fails and we fall back
> to a full adapter reset.  With enforce isolation, we reset the bad app
> instead.

Thinking about it more, we'll always end up in a full adapter reset if
we have back to back bad apps.  I think what we need to do is emit the
seq number from the bad app, verify that that completes and use that
to determine success in the reset function then re-emit the follow on
work and exit the function.  That way the reset succeeds and then if
the follow on job times out, we can repeat the process cleanly.

Alex

>
> Alex
>
> >
> > Christian.
> >
> > >
> > > Alex
> > >
> > >>
> > >> Regards,
> > >> Christian.
> > >>
> > >>> +
> > >>> +     return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOU=
T);
> > >>>  }
> > >>>
> > >>>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> > >>> @@ -9612,9 +9619,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_=
ring *ring,
> > >>>       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
> > >>>                                  0, 0);
> > >>>       amdgpu_ring_commit(kiq_ring);
> > >>> -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > >>> -
> > >>>       r =3D amdgpu_ring_test_ring(kiq_ring);
> > >>> +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > >>>       if (r)
> > >>>               return r;
> > >>>
> > >>> @@ -9891,7 +9897,6 @@ static const struct amdgpu_ring_funcs gfx_v10=
_0_ring_funcs_gfx =3D {
> > >>>       .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> > >>>       .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> > >>>       .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_re=
g_wait,
> > >>> -     .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
> > >>>       .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
> > >>>       .reset =3D gfx_v10_0_reset_kgq,
> > >>>       .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> > >>
> >
