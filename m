Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39842C83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 14:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D9B898F0;
	Mon,  7 Jul 2025 14:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QMtw7kgK";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88631898F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 14:25:30 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-313bcf6e565so706793a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jul 2025 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751898330; x=1752503130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmNuM6L1hXBFLI1AB5ReiYfefXTx6RKjyDiyfZDnMmw=;
 b=QMtw7kgKy6COAQjKCbb10vyy1hNODSi4U0QDVk0shjyXBYn5mc1ioskGLaCs80Isi0
 vRYFyPU6sw413CtwOKzrxn/pRtMzVbBu6mhfjB6txjwPp7mdpd1SUHnjq+CmzdA2f76l
 uw24Gn3FnMoWnwE9rbaSxnsqW330V0sjPp2R//zENbr8xuTnUuKTDH3B4L1ZGJHBZmf8
 tCctoGa6JtOlNwoBKHCRQx6H1h6xssCj4ouL5lgj9+Wh5NBxK498YANnF5RSIfA1d4DY
 EZ4Z6nDCuVQp0QtHIf/m4qH/U36gJZVnWr8wq/GyVS29ckNCqOgqQTxY1Fn6bNvZgXn6
 LujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751898330; x=1752503130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmNuM6L1hXBFLI1AB5ReiYfefXTx6RKjyDiyfZDnMmw=;
 b=ZxGhSB1DivV+6uXOLpDHFYqBn+TqvPOj5W60L+iLzlncMTaPq26UdrcbtukYfeOt3E
 lQ03Nt1HevNTZq3lUpJuuU9z1qDW5yT3Tx4Uhb9cZQEmfW8L7zfIfV73XMSpHXa66Fcr
 MpcP/TvSol55Yc4uBwtCYuKbMEAx7vyQoUzxA7hsY+P5CW/q13Ed/tQIxhwOxblVr3wS
 hVGcR2dXeGKdjfumfa3LfUpWtw35izk8eiBjVSnhsRA6DRjdlwe/+iRwLYjGbfF5iNdp
 ltpTOZqN9Q+yddHrin0vZ0ijkEN1QCjCDdnmng3wtKD6LYp2PqP9ODQfbO4QLHbK8AAH
 fJ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSQP6SjyG5YbpKEZdMZojUy5aCBIphEuU4hdKbIyeib8J3ZUESiWePEX/yWnEMePGWkVGryuIK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwqZ7ML4iRzDvvh6MOTSYDuOG4HLrBEHHxdSBhAp/aiCjQ/pMy
 S4M04aC53Gx77eVPIywEmTbnC+6R/tQGGv0AEsS5nusVCTL4ca5rmeT58WO+XsfcPKXQyjt7lPc
 n2QpizjX6QoD0wzSKlfcLxUUAIoc3Eh8=
X-Gm-Gg: ASbGncvNuh8/4iX4AzAwxYnI5GEop68WVxNvEk9T34p8aoW4VbFmDxgKzgxI04tyk0x
 oEghY1HIi4hE/jLS/z5St0LixRtfMIjCiQaJ/vVA+YLMh5nga5PrZzD+jiZ6gtR61ntBrD6PrpE
 WYuN4CqnJo8WDFbV8DkMt36ha/kY/6AtzLeYRNpD1YOuhN
X-Google-Smtp-Source: AGHT+IH2RHZLPf4WPrGAzQ6zPegEWmXTeZvCc07rfco6K3xErauwm2bDdvRBhh+mLu2iGSLDY3YKT3YRttc2tbX8RrQ=
X-Received: by 2002:a17:90b:3fc3:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-31aac44a149mr7658291a91.1.1751898329684; Mon, 07 Jul 2025
 07:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-7-alexander.deucher@amd.com>
 <a465ueihzix76srte55bwmshugihbks2fnr3yiq36xdy3wp3b7@ij3toxl3ahac>
In-Reply-To: <a465ueihzix76srte55bwmshugihbks2fnr3yiq36xdy3wp3b7@ij3toxl3ahac>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jul 2025 10:25:17 -0400
X-Gm-Features: Ac12FXzjdjKtwGLpO27HmQrkfzzA3NMYhJfsmaVUK2jMdhEszgvQDPeF6JexNsk
Message-ID: <CADnq5_Me8nStdhUJQb_FYBHqpierKE8nLV_x2kqvmWpXaXUt+A@mail.gmail.com>
Subject: Re: [PATCH 06/28] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
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

On Sun, Jul 6, 2025 at 10:59=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 07/01, Alex Deucher wrote:
> > Re-emit the unprocessed state after resetting the queue.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 41 ++++----------------------
> >  1 file changed, 6 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 5e099b5dc9a3c..65429afb33ec3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wa=
it(struct amdgpu_ring *ring,
> >                                                          ref, mask);
> >  }
> >
> > -static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
> > -                                      unsigned int vmid)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -     uint32_t value =3D 0;
> > -
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> > -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> > -     WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> > -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -}
> > -
>
> You are eliminating the gfx_v10_0_ring_soft_recovery here, but why you
> did not remove it in the GFX9 (previous commit)?

gfx9 doesn't implement graphics reset yet so we still need soft recovery.

>
> Also, I suppose the new recovery method from this series will replace
> this soft_recovery, right? If so, I suggest you include this information
> in the commit message.

Correct.  Will update the message.

Alex

>
> Thanks
>
> >  static void
> >  gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
> >                                     uint32_t me, uint32_t pipe,
> > @@ -9540,7 +9525,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring,
> >       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> >               return -EINVAL;
> >
> > -     drm_sched_wqueue_stop(&ring->sched);
> > +     amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> >
> >       spin_lock_irqsave(&kiq->ring_lock, flags);
> >
> > @@ -9589,12 +9574,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_rin=
g *ring,
> >       if (r)
> >               return r;
> >
> > -     r =3D amdgpu_ring_test_ring(ring);
> > -     if (r)
> > -             return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > -     drm_sched_wqueue_start(&ring->sched);
> > -     return 0;
> > +     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> >  }
> >
> >  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> > @@ -9613,7 +9593,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring=
 *ring,
> >       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> >               return -EINVAL;
> >
> > -     drm_sched_wqueue_stop(&ring->sched);
> > +     amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> >
> >       spin_lock_irqsave(&kiq->ring_lock, flags);
> >
> > @@ -9625,9 +9605,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring=
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
> > @@ -9663,18 +9642,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ri=
ng *ring,
> >       }
> >       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> >       amdgpu_ring_commit(kiq_ring);
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r)
> >               return r;
> >
> > -     r =3D amdgpu_ring_test_ring(ring);
> > -     if (r)
> > -             return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > -     drm_sched_wqueue_start(&ring->sched);
> > -     return 0;
> > +     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> >  }
> >
> >  static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct =
drm_printer *p)
> > @@ -9909,7 +9882,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_r=
ing_funcs_gfx =3D {
> >       .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> > -     .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
> >       .reset =3D gfx_v10_0_reset_kgq,
> >       .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> > @@ -9950,7 +9922,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_r=
ing_funcs_compute =3D {
> >       .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> > -     .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
> >       .reset =3D gfx_v10_0_reset_kcq,
> >       .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> > --
> > 2.50.0
> >
>
> --
> Rodrigo Siqueira
