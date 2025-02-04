Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B51C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449E510E692;
	Tue,  4 Feb 2025 15:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bSfqCKae";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4F410E692
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:04:53 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f2f5e91393so1175556a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738681493; x=1739286293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPA+jsq1TAEvCBlUlpWk6ke85l8ivs29lgARa/G7YUM=;
 b=bSfqCKae6oOIxvgUFg8OvIqjfDwkijYoKb5eoY4SHoOe1Ljj4NVbmrDius7eis225T
 tmPseB5LOlDsRNcZUD2/y4B5wnY4y95WI2lEcbZltpDmpdLQLcXqAmyze/yzFgu7txiA
 oIUuIxwg1AHj96ju2T1zELdxiiepJsN96waVbiE5WTzfXh1sfEwp9HVSOSkANwTCOAvO
 jCWMdfP6lGg6rUXAdD1HGxinkOxXRHwfzQFr6+uAjU4rRXqVSos97M1T1GPV3HIgpqIQ
 /0qgsSKT/i2crL2vvOxOUgjMv6CTydfO79ov/Lnj46ZcDEVPsrcTBCxjQcUujgj9j6qF
 3EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681493; x=1739286293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPA+jsq1TAEvCBlUlpWk6ke85l8ivs29lgARa/G7YUM=;
 b=hsjNzh8iIq5ky2ViF3pxrSbsF8wLQqyWh86k32M4rJUTaqgvObB2dWEQmQ0SogrqLI
 D0WdbqcPqxDrvShQrO/Ruk136NnC9j6N7p8LtfCRc7QyoAFt+OByMvhTwyTU1MeguVK2
 tGoAILChOg8ERBmtu3t6e8JtiSXLu8WADr2cPLMeiScFXpsCB6lb+7dbyPrjJqQak70j
 AAaXydKcSemACsTnrCs8E5VXb/dDTYHxPzrdxydV3K86wqtex5oF88p3PdRIsM7C6JsA
 Dxaf0zDl1dEPe91wzlJYr2DvLbdWWxgENxD56KDm9PrOFtgNsxnR3SnDFJStjnf6KdNk
 ywYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVgYkVAUwTrN66CkuEkoTs68QzIMOAa3Xqi97hIl4MVqf2upmqVJt4nAWYYx7Rx2MsLVN1MVXs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwJ5AmeXBjZsXALj6LD5nlA8otQoh1hzZzsJy3XyXYQ9Fo9GKm
 qhySkuNM9WIIM4gJsOxINaP6+KUpZsKB+O4Ma1zhYdmCoA5z7HQ1M5oBiAetfvLNUXKR5jaYB4r
 QoAoo/FMAEEHgJT4Jpj0IrQpwaak=
X-Gm-Gg: ASbGncvFCH9bPX90XHTGxkhj3/K168baLXF4Z9brYaZwlEI7p8Yu0MtRGoZmp4OvZmm
 A5+U6PJV/htCJxenNm4143uC2yrPLBScsP6WkVB6zM+BruCZ90pCrFgEdeE+XXG2+vImACHHX
X-Google-Smtp-Source: AGHT+IFrFU1cdlATDkeJ0lMrElQzL7ibuD7wfqE923uRWukYde6ALtCnBBnZrxjSmIVYWZPVcI4A0howEa6u3VQC5cE=
X-Received: by 2002:a17:90b:2b87:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2f9b8c16097mr2350199a91.1.1738681492820; Tue, 04 Feb 2025
 07:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20250204143113.6320-1-christian.koenig@amd.com>
 <20250204143113.6320-6-christian.koenig@amd.com>
In-Reply-To: <20250204143113.6320-6-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Feb 2025 10:04:41 -0500
X-Gm-Features: AWEUYZlY5zC-fNwTYP6FkC4MVkObvVY6VS97i4vt2NsYaT6ay9dZil-j0acbtdU
Message-ID: <CADnq5_Ph2bJGCXYmQxiFwknSd3BJ=vHJt818FKa5COz_uTuk6w@mail.gmail.com>
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

Does disabling the second  gfx pipe help?  E.g., set
adev->gfx.me.num_pipe_per_me =3D 1;

Alex

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
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kcq,
>         .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> --
> 2.34.1
>
