Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914D5C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D3A10E690;
	Tue,  4 Feb 2025 15:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTAR1eSc";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D903A10E690
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:03:14 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2f45526dea0so1223239a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738681394; x=1739286194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiPdeiJPI0lSc3WVnQ9XcQgiiQ/3YEFumfqbuf0AA/Y=;
 b=gTAR1eSce8ZtbzpXDFJk98/bp5fE8lb+gc5GqZQaRoeuxMe4ns26tNTOFGzYFs09DR
 jD1oj2AdqhZjRNWsiKUvhOC1/+MkUjSx1zB9e6w9QNQ262+MBUTCVRQa/NtCL5DBYvv5
 0UPKQLe7Qt2C5wAuH8F5xbp0PpXu4OCc0kgCQrNg2h7CG78qmP230cf12IAVNCCGlV6f
 /25LlkB1xfn5r6mL5LBVlCVTcyXuWJq/YFCR+xOn7qWDZ4Ti48B8OwlZIG0W8dUZePkD
 fic6nccehYqwgqJJptZ6NBnt07zjHh25Y9h5FGbpsZec6jwTgUZ8+QsN2Sma2Sd7Ptjg
 DgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681394; x=1739286194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiPdeiJPI0lSc3WVnQ9XcQgiiQ/3YEFumfqbuf0AA/Y=;
 b=tbJKpqMfZ75+LUXZ8V0Fpo6zMAHI5XLhX0fd92Ekrpx9ZiaEB093HOkithFSxVsCuh
 +n0oH/dg9JDn6pSdhgg+YCCaPntdCw8KRLvXB4A1HDvk6kdoPFzBphXQOSBEvXquJbek
 5q7XXDuTZaRwiNVWuc55/chXcTAQpue8eQnsYyK9mOC9vUELVhNL57ewwjklbbz5sLpQ
 npky6hmfVWnoBilnh1wYiD0YTjzFKBXsHJAgMF+RhYDWB8kGeb7+xqJvQI0lUCAVJBDm
 gmApoNXn+aVOZBpzJBpdq53sEA58iScQEw++d6mP7GbimOZsE5o+2ywDcS2YUddVuLER
 3RZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWQ3u6FhE2OiXvIIate3+DKp2Zv0QwRqX4+H326xCT5eVOWsoGk6ccjJj7CVZBSe2bsZlIgyF+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxUe6omAwnrr8LgF6lFTkoXulk628E18xuI44vcQ2aoIEwIZLG
 lSneR8jG2xzX2DK8pw5pmlcI/S7m2eh+qc/d8qQQW+S/Ik0zH9c1eK7eM6ltf7Ihxf53YAxUHqx
 uWQjHBtXtVgmHYG0eDwETgJaiQ4XGtA==
X-Gm-Gg: ASbGnctqbqAMw5pz7YQ9S1BIeUM2eDGL4kVUWsSeEzQ6uP9Mxr1Dovi6oKZuG57uw1j
 30Y95f9tqxdBhcB1D786rlcKZN+OA/ksdmP6tmkJfnX/3itlARpqBeVBLYWu1XIabV/4wOIHG
X-Google-Smtp-Source: AGHT+IE3YDLQ1DQBeyMg4njxQGj/LXBuPpCoF4ASPHk3fLOkrhzIHdVhUgfdyXjlfCAtCmXvW8m44Bxq3ZIs1nEZato=
X-Received: by 2002:a17:90b:37c5:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2f9b8c882d5mr2226396a91.3.1738681394205; Tue, 04 Feb 2025
 07:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20250204143113.6320-1-christian.koenig@amd.com>
 <20250204143113.6320-6-christian.koenig@amd.com>
In-Reply-To: <20250204143113.6320-6-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Feb 2025 10:03:02 -0500
X-Gm-Features: AWEUYZkF2_Fs2K1lx7XPYWApXmbOUyLgqqtxxP8tkA8FzMzzOj4DU65QO9aeubs
Message-ID: <CADnq5_OS+Uzr7_2fES2aREs8wQwg1Af8UpLAmitxKmgX9XUfVg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: rework gfx10 queue reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: timur.kristof@gmail.com, Alexander.Deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Feb 4, 2025 at 9:57=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Apply the same changes to gfx10 as done to gfx9.
>
> The general idea to reset the whole kernel queue and then asking the kiq
> to map it again didn't worked at all. Background is that we don't use per
> application kernel queues for gfx10 on Linux for performance reasons.
>
> So instead use the gfx9 approach here as well and only reset all
> submissions from a specific VMID instead of the whole queue.
>
> This also avoids reserving and kmap the MQD which are operations
> generally not allowed in the reset handler.
>
> This approach seems to work for at least some time, but not as reliable
> as it is on gfx9. It will probably need some more work until it survives
> a whole night of reset stress testing.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 65 +++++++-------------------
>  1 file changed, 16 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 5ba263fe5512..7ffdba974f87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8684,7 +8684,17 @@ static void gfx_v10_0_ring_emit_pipeline_sync(stru=
ct amdgpu_ring *ring)
>         int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
>         uint32_t seq =3D ring->fence_drv.sync_seq;
>         uint64_t addr =3D ring->fence_drv.gpu_addr;
> +       struct amdgpu_device *adev =3D ring->adev;
>
> +       amdgpu_ring_emit_reg_wait(ring,
> +                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET=
),
> +                                 0, 0xffff);
> +       amdgpu_ring_emit_wreg(ring,
> +                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
> +                             0);
> +       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +                              ring->fence_drv.sync_seq,
> +                              AMDGPU_FENCE_FLAG_EXEC);
>         gfx_v10_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
>                                upper_32_bits(addr), seq, 0xffffffff, 4);
>  }
> @@ -8984,21 +8994,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait=
(struct amdgpu_ring *ring,
>                                                            ref, mask);
>  }
>
> -static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
> -                                        unsigned int vmid)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t value =3D 0;
> -
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> -       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -       WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> -       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -}
> -
>  static void
>  gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
>                                       uint32_t me, uint32_t pipe,
> @@ -9467,7 +9462,6 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *=
ring, unsigned int vmid)
>         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
>         unsigned long flags;
>         u32 tmp;
> -       u64 addr;
>         int r;
>
>         if (amdgpu_sriov_vf(adev))
> @@ -9478,27 +9472,14 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
>
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>
> -       if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_=
size)) {
> +       if (amdgpu_ring_alloc(kiq_ring, 5)) {
>                 spin_unlock_irqrestore(&kiq->ring_lock, flags);
>                 return -ENOMEM;
>         }
>
> -       addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj) +
> -               offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
>         tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid)=
;
> -       if (ring->pipe =3D=3D 0)
> -               tmp =3D REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1=
 << ring->queue);
> -       else
> -               tmp =3D REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1=
 << ring->queue);
> -
>         gfx_v10_0_ring_emit_wreg(kiq_ring,
>                                  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET)=
, tmp);
> -       gfx_v10_0_wait_reg_mem(kiq_ring, 0, 1, 0,
> -                              lower_32_bits(addr), upper_32_bits(addr),
> -                              0, 1, 0x20);
> -       gfx_v10_0_ring_emit_reg_wait(kiq_ring,
> -                                    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RE=
SET), 0, 0xffffffff);
> -       kiq->pmf->kiq_map_queues(kiq_ring, ring);
>         amdgpu_ring_commit(kiq_ring);
>
>         spin_unlock_irqrestore(&kiq->ring_lock, flags);
> @@ -9507,24 +9488,12 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)) {
> -               DRM_ERROR("fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v10_0_kgq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> -       if (r) {
> -               DRM_ERROR("fail to unresv mqd_obj\n");
> -               return r;
> -       }
> +       if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
> +               return -ENOMEM;
> +       gfx_v10_0_ring_emit_pipeline_sync(ring);
> +       amdgpu_ring_commit(ring);
>
> -       return amdgpu_ring_test_ring(ring);
> +       return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>
>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -9819,7 +9788,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_gfx =3D {
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> -       .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kgq,
>         .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> @@ -9860,7 +9828,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_compute =3D {
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> -       .soft_recovery =3D gfx_v10_0_ring_soft_recovery,

And here.

Alex

>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kcq,
>         .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> --
> 2.34.1
>
