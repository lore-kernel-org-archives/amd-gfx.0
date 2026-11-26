Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A6606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsuPVQvT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689FB112278;
	Thu, 26 Nov 2026 09:59:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026AF112277
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:59:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7761A42E6D;
 Thu, 26 Nov 2026 09:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EF11F000D0;
 Thu, 26 Nov 2026 09:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795687158;
 bh=oTpu0dNC+Ubn87IQJZPJbt3y21MVDde9BrsWy5ynpfg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=NsuPVQvTvwjEM2FV4AW2RRB02cJrELgBzWpqhK5eranOv6bswxpjsUXWV3kAwHFqy
 DNorfspENr6oNV44uEPGF+6trCxd8oLUcrfLl5Ete5ZVqrAJD3l7G6/toWZMmPS2CL
 9vQvYs7A5PPQrWflj7c67Wc31oMLU/gVbRTXvkjyaD1a90liiObOsNC9AXulBgDLsS
 xyslnJds4+1601SGs8fELWQHGpqgpGxdNRoicA/9DX+OqcgmUgY43YeDIf4WDsQx1q
 ppLuVTBpxSwl9NVV9ZucaXki0TbKSKFmhPRQ1jXsMSGycG+mooeZN5NHVXdtgD9Co9
 DtTWH1m8nXvdw==
Message-ID: <sashiko-outbox-235213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/15] drm/amdgpu/gfx11: add a gfx engine soft reset
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-10-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-10-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:59:17 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] amdgpu: missing pre-pulse CP_VMID_RESET clear in
  gfx_v11_0_soft_reset_gfx_cp()
- [Medium] amdgpu: gfx_ring[0] left mapped on disable_kq in
  gfx_v11_0_soft_reset_engine()
--

commit 4f83c926ed3d12feae57fed7044a2f21e92280c8
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu/gfx11: add a gfx engine soft reset

This commit implements the soft_reset_engine() callback for the graphics
engine on GFX11 by resetting CPF/CPG, PFP/ME, and the GFX HQDs, then
restarting the kernel and usermode GFX queues.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index ecf8a156b7ec4..a0ed3363f84d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6820,6 +6820,132 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu=
_ring *ring)
>  	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
> =20
> +/* The CP DMA and the interfaces its memory requests go through */
> +#define GFX11_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
> +				 CP_STAT__TCIU_BUSY_MASK | \
> +				 CP_STAT__RCIU_BUSY_MASK | \
> +				 CP_STAT__UTCL2IU_BUSY_MASK)
> +
> +/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again. */
> +static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
> +{
> +	u32 tmp, cntl, me_cntl;
> +	int i;
> +
> +	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +	/* MES fetches its queues through CPF: keep it out of the reset. */
> +	amdgpu_mes_lock(&adev->mes);
> +
> +	me_cntl =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +
> +	tmp =3D REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
> +	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	udelay(50);
> +
> +	/* A CP DMA in flight during the reset leaves the ME busy after it. */
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
> +			break;
> +		udelay(1);
> +	}
> +
> +	/* GFX_ONLY keeps compute and MES out; CPF alone leaves the stream stuc=
k. */
> +	cntl =3D RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
> +	tmp =3D REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL, GFX_ONLY_SOFT_RESET, 1);
> +	tmp =3D REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL, GFX_HQD_REG_RESET, 1);
> +	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
> +
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
> +	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +	udelay(50);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 0);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 0);
> +	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +
> +	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
> +
> +	/* The halted PFP stays busy: only wait for the memory requests. */
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
> +			break;
> +		udelay(1);
> +	}
> +	/* A VMID reset the hung PFP didn't handle survives the reset. */
> +	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);

[Severity: Medium]
Should regCP_VMID_RESET also be cleared to 0 before asserting
SOFT_RESET_CPF and SOFT_RESET_CPG in regGRBM_SOFT_RESET, as
gfx_v12_0_soft_reset_gfx_cp() does?

When PFP is hung, the preceding per-queue and per-pipe MMIO resets in
mes_v11_0_reset_queue_mmio() and mes_v11_0_reset_gfx_pipe_mmio() write a
reset request to regCP_VMID_RESET and time out waiting for PFP to clear
it.  Pulsing regGRBM_SOFT_RESET while that VMID reset is still active can
cause the CP soft reset to fail and escalate to a full GPU reset.

[ ... ]

> +static int gfx_v11_0_soft_reset_engine(struct amdgpu_ip_block *ip_block,
> +				       enum amdgpu_ring_type ring_type, u32 inst,
> +				       struct amdgpu_usermode_queue *guilty_queue)
> +{
> +	struct amdgpu_device *adev =3D ip_block->adev;
> +	int i, r;
> +
> +	if (ring_type !=3D AMDGPU_RING_TYPE_GFX || inst)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&adev->gfx.mec.reset_mutex);
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
> +	/* A hung gfx stream can keep MES from suspending: reset anyway. */
> +	amdgpu_mes_suspend(adev, 0);
> +	amdgpu_userq_save_hqds(adev, AMDGPU_HW_IP_GFX);
> +
> +	r =3D gfx_v11_0_soft_reset_gfx_cp(adev);
> +	if (r) {
> +		dev_err(adev->dev, "gfx CP still busy after reset, CP_STAT 0x%08x\n",
> +			RREG32_SOC15(GC, 0, regCP_STAT));
> +		goto fail;
> +	}
> +
> +	/* The reset cleared the HQD of the kernel gfx queue: map it again. */
> +	r =3D amdgpu_gfx_disable_kgq(adev, 0);
> +	if (r)
> +		goto fail;
> +	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> +		amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
> +	r =3D amdgpu_gfx_enable_kgq(adev, 0);
> +	if (!r)
> +		r =3D gfx_v11_0_cp_gfx_start(adev);
> +	if (r)
> +		goto fail;
> +
> +	amdgpu_userq_restore_hqds(adev, AMDGPU_HW_IP_GFX, guilty_queue);
> +	r =3D amdgpu_mes_resume(adev, 0);

[Severity: Medium]
Does this leave adev->gfx.gfx_ring[0] mapped on HQD 0 when
adev->gfx.disable_kq is true?

Unlike GFX12, gfx_v11_0_early_init() keeps adev->gfx.num_gfx_rings =3D 1
when disable_kq is set so gfx_v11_0_cp_gfx_start() can submit the clear
state on gfx_ring[0], while amdgpu_mes_init() gives HQD 0 to MES for user
queues.  In gfx_v11_0_cp_resume(), the driver drains gfx_ring[0] and
unmaps it before user queues run:

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:gfx_v11_0_cp_resume() {
    ...
	if (adev->gfx.disable_kq) {
		for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
			ring =3D &adev->gfx.gfx_ring[i];
			/* we don't want to set ring->ready */
			r =3D amdgpu_ring_test_ring(ring);
			if (r)
				return r;
		}
		amdgpu_gfx_disable_kgq(adev, 0);
	}
    ...
}

Here, gfx_v11_0_soft_reset_engine() calls amdgpu_gfx_disable_kgq() while
gfx_ring[0] is already unmapped, then maps gfx_ring[0] and submits the
clear state without testing the ring or calling amdgpu_gfx_disable_kgq()
afterward, leaving the temporary kernel ring mapped on HQD 0 in conflict
with restored MES usermode queues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D10
