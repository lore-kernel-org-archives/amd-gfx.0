Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB33E66882
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 20:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D45410E011;
	Fri, 19 Dec 2025 20:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TeDyM9xE";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23E610E011
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 20:46:07 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-3ec41466a30so1684685fac.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766177167; x=1766781967; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAzzVaM9rbRUDh/TachZn3v79DzJhPIOwuOwvF9XSFo=;
 b=TeDyM9xEqajupTXx4NcZDP831XFSNnyBp9seZbYxTKLB7PT5Qqr0q2oKp/gnV8ubEC
 2Zl+DpvF0mBmAEJzYnT6/vRLHaWQzwwijHaAyCvK266LPPlWfRBkjGUN7S+2eABupM8b
 G1FMZUsSMDnQmkALindd/l90xLHmKIlVKiJ2GVXQV8uuJ0ubTnqBa8kWTPgDZqLyM4qq
 PU7IC1RITQsw76FE5LtVTQj26sxbMdMu5BvI18lVlcSUT+XKRbuTEsykPo9X67TbCmpH
 pVRb4isj6gIwRbDdrvrMiAwOzsHYRLLwCJGzU/QW94oUkyblTvTsqSi5CucFsV5AeuQI
 6zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766177167; x=1766781967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oAzzVaM9rbRUDh/TachZn3v79DzJhPIOwuOwvF9XSFo=;
 b=cfNZBLxSUGgCWyfXN+KRB43lQZLpzyoZ/teBugVLTx8CepApaSoHwIUUErWxNyIVu4
 ZySCEaPfl53RSyXl6lO5LP3TZ5V+RbC9sreRc2mPNZZZYJjgna9MuOLIIQnoa6mIp6mM
 I0S2aZvR42ELztVrTS2O9TB4+C2HS2yGzYNhspmjV6EbdR4hjYFeM5R2uqwthyhvgXwY
 uVvNGYWoca6ODwkQ5WcZABU+GxeBDupo3G6nZ03TzPpNCPHVTddOBnAvXDILz4SD+qzm
 38TSlUl0PYjEd8eSAGzBAItTdzxjT+w9VXQT/cNtxzE2aUOBbA2dZ8tfNxKIgIrCADJE
 qp6w==
X-Gm-Message-State: AOJu0YzAhzUyaiVGb0rhIKOTD5iNksUK2+HVPfwDOeIvGmBQ10DkGosZ
 7r50MuL+nJfIm9Y3dvKX0GMeNpAPRpGB/rPEn8YyUnRrwj0S10ct/sKw0Z1DXmhD
X-Gm-Gg: AY/fxX45sNnLAMPPllt9NTXcmHF96Rt9mvY0PUOBBbeRjSLFawhKTbZ7OoRJeNycI+C
 53UMBswgdit936HaOnCVe7/5zBTw/IDk1Fwh20h0O1HCRcVmocdQhuIyREHlMnYIcWFMoUJy67F
 Jt4Dw+GsIsJazsMN7K32PfUyn/ciObzj5tIDIqSZR39uPuZa+TXe1X8fcJRGAHUayPsAEkD0Iho
 /cZrAbzFPLKbtCzizjYAG5MUgx/Fvn12EIQwUr6bfNJBYNleSnLr5DvgwGgoaqSqii9/Dg+FMmA
 gCWIAzIuGlA0f2JMRoKov67wFYO7ncpdCotMXiRnmRZE9Sna31gbbVRFGqLmwQ9FoL3/oY/OHLd
 BD/TIaO2rkTCKzLBgL+z2xjEsKg18oRx1Opa0ZqMd0IWATY7Lqd8JRhLN58siGgcwDg7RnrobAh
 uYa07elaYbguB9jgGT4VGdKHBa
X-Google-Smtp-Source: AGHT+IF+RzW1Oodb04AebU4qlVksHnBMU+136ClOckoKMvjFBxFWFXqawFAy3vKSMThsK0FsVkxanw==
X-Received: by 2002:a05:6870:14d6:b0:3ec:4067:c684 with SMTP id
 586e51a60fabf-3fda51eb4bamr2276539fac.3.1766177166723; 
 Fri, 19 Dec 2025 12:46:06 -0800 (PST)
Received: from timur-max.localnet ([2806:105e:c:2784:c142:4173:ff05:1321])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaac129c7sm1881578fac.21.2025.12.19.12.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 12:46:06 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiqian Chen <Jiqian.Chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/gfx9: Implement KGQ ring reset
Date: Fri, 19 Dec 2025 14:46:02 -0600
Message-ID: <2577545.lZ2vcFHjTE@timur-max>
In-Reply-To: <20251219182201.5722-5-alexander.deucher@amd.com>
References: <20251219182201.5722-1-alexander.deucher@amd.com>
 <20251219182201.5722-5-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 19., p=C3=A9ntek 12:22:00 k=C3=B6z=C3=A9ps=C5=91 =C3=A1ll=
amokbeli z=C3=B3naid=C5=91 Alex=20
Deucher wrote:
> GFX ring resets work differently on pre-GFX10 hardware since
> there is no MQD managed by the scheduler.
> For ring reset, you need issue the reset via CP_VMID_RESET
> via KIQ or MMIO and submit the following to the gfx ring to
> complete the reset:
> 1. EOP packet with EXEC bit set
> 2. WAIT_REG_MEM to wait for the fence
> 3. Clear CP_VMID_RESET to 0
> 4. EVENT_WRITE ENABLE_LEGACY_PIPELINE
> 5. EOP packet with EXEC bit set
> 6. WAIT_REG_MEM to wait for the fence
> Once those commands have completed the reset should
> be complete and the ring can accept new packets.
>=20
> Tested-by: Jiqian Chen <Jiqian.Chen@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Hi Alex,

Thank you for working on this.
=46or the entire series,
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

I can't test it at the moment but can give it a try in January or so.

Best regards,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 92 ++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index 0d8e797d59b8a..7e9d753f4a808
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2411,8 +2411,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block
> *ip_block) amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>  	adev->gfx.compute_supported_reset =3D
>  		amdgpu_get_soft_full_reset_mask(&adev-
>gfx.compute_ring[0]);
> -	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
> +	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)=20
{
>  		adev->gfx.compute_supported_reset |=3D=20
AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->gfx.gfx_supported_reset |=3D=20
AMDGPU_RESET_TYPE_PER_QUEUE;
> +	}
>=20
>  	r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
>  	if (r) {
> @@ -7172,6 +7174,91 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_r=
ing
> *ring, uint32_t num_nop) amdgpu_ring_insert_nop(ring, num_nop - 1);
>  }
>=20
> +static void gfx_v9_0_ring_emit_wreg_me(struct amdgpu_ring *ring,
> +				       uint32_t reg,
> +				       uint32_t val)
> +{
> +	uint32_t cmd =3D 0;
> +
> +	switch (ring->funcs->type) {
> +	case AMDGPU_RING_TYPE_KIQ:
> +		cmd =3D (1 << 16); /* no inc addr */
> +		break;
> +	default:
> +		cmd =3D WR_CONFIRM;
> +		break;
> +	}
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> +	amdgpu_ring_write(ring, cmd);
> +	amdgpu_ring_write(ring, reg);
> +	amdgpu_ring_write(ring, 0);
> +	amdgpu_ring_write(ring, val);
> +}
> +
> +static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
> +			      unsigned int vmid,
> +			      struct amdgpu_fence *timedout_fence)
> +{
> +	struct amdgpu_device *adev =3D ring->adev;
> +	struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +	struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> +	unsigned long flags;
> +	u32 tmp;
> +	int r;
> +
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, 5)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	/* send the reset - 5 */
> +	tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
> +	gfx_v9_0_ring_emit_wreg(kiq_ring,
> +				SOC15_REG_OFFSET(GC, 0,=20
mmCP_VMID_RESET), tmp);
> +	amdgpu_ring_commit(kiq_ring);
> +	r =3D amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +	if (r)
> +		return r;
> +
> +	if (amdgpu_ring_alloc(ring, 8 + 7 + 5 + 2 + 8 + 7))
> +		return -ENOMEM;
> +	/* emit the fence to finish the reset - 8 */
> +	ring->trail_seq++;
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				 ring->trail_seq,=20
AMDGPU_FENCE_FLAG_EXEC);
> +	/* wait for the fence - 7 */
> +	gfx_v9_0_wait_reg_mem(ring, 0, 1, 0,
> +			      lower_32_bits(ring-
>trail_fence_gpu_addr),
> +			      upper_32_bits(ring-
>trail_fence_gpu_addr),
> +			      ring->trail_seq, 0xffffffff, 4);
> +	/* clear mmCP_VMID_RESET - 5 */
> +	gfx_v9_0_ring_emit_wreg_me(ring,
> +				   SOC15_REG_OFFSET(GC, 0,=20
mmCP_VMID_RESET), 0);
> +	/* event write ENABLE_LEGACY_PIPELINE - 2 */
> +	gfx_v9_0_ring_emit_event_write(ring, ENABLE_LEGACY_PIPELINE, 0);
> +	/* emit a regular fence - 8 */
> +	ring->trail_seq++;
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				 ring->trail_seq,=20
AMDGPU_FENCE_FLAG_EXEC);
> +	/* wait for the fence - 7 */
> +	gfx_v9_0_wait_reg_mem(ring, 1, 1, 0,
> +			      lower_32_bits(ring-
>trail_fence_gpu_addr),
> +			      upper_32_bits(ring-
>trail_fence_gpu_addr),
> +			      ring->trail_seq, 0xffffffff, 4);
> +	amdgpu_ring_commit(ring);
> +	/* wait for the commands to complete */
> +	r =3D amdgpu_ring_test_ring(ring);
> +	if (r)
> +		return r;
> +
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +}
> +
>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  			      unsigned int vmid,
>  			      struct amdgpu_fence *timedout_fence)
> @@ -7450,9 +7537,9 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_gfx =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>  	.emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>  	.emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> +	.reset =3D gfx_v9_0_reset_kgq,
>  	.begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
>  	.end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
> @@ -7551,7 +7638,6 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_compute =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>  	.emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>  	.emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
>  	.reset =3D gfx_v9_0_reset_kcq,




