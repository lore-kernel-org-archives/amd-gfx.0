Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D1606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsBkkcCv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDAF10E114;
	Thu, 26 Nov 2026 09:57:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C4110E114
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:57:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 927D362C07;
 Thu, 26 Nov 2026 09:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115E71F0093E;
 Thu, 26 Nov 2026 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795687065;
 bh=sv7vZ4iZiLv8TkrpULnoCQFff/YsU0Dn8EpWeEJJrh0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=FsBkkcCv96Uw7ZFm6xk//YaCxsBz7Kt/cjMnJ/4eBBdABc2JNXpDMfIw85nvQmjg1
 31TuGrdy/TsdjwI2/YNWQROeIHyc/VHsst/KX3S12AunaKWEo7ccrtp93n8dSBk2cJ
 ddosbk4ZRRwx/fu7WbDa4/uwEgAeJk7V9t/EGfR+1gha5Zmxuq8bdHwya5ugebDiG3
 XEEfVEHLKs/ElKDIoeXS6ev8jSFtHu3EUxXLOnrUx7zJzNB/uZfQaaJMEmPH1uhWU6
 cOXXbEeD4rqsegZJg5eEPYWOA5ZrrygSodsPQ2xCxc9P1Xhf/r30mTARea6JTPAhND
 kAk0yjOtQ9afw==
Message-ID: <sashiko-outbox-235204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/15] drm/amdgpu/gfx11: include SOFT_RESET_GFX in
 the gfx engine soft reset
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-12-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-12-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:57:44 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/amdgpu/gfx11: wrong regGCVM_L2_STATUS offset in
  gfx_v11_0_wait_gc_idle()
--

commit b092d369a399e18251a9318c45400741bdc05ea3
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu/gfx11: include SOFT_RESET_GFX in the gfx engine soft reset

This commit halts MES and RLC F32, waits for in-flight GC memory requests
to drain in gfx_v11_0_wait_gc_idle(), and pulses SOFT_RESET_GFX together
with SOFT_RESET_CPF and SOFT_RESET_CPG during a gfx engine soft reset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index a0ed3363f84d1..824d7914bece9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6827,15 +6827,74 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu=
_ring *ring)
>  				 CP_STAT__UTCL2IU_BUSY_MASK)
> =20
>  /* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again. */
> +/*
> + * SOFT_RESET_GFX drops the memory requests in flight through the blocks=
 it
> + * resets, and their clients then wait for them forever: MES still fetch=
es
> + * instructions with its queues suspended, and RLC still writes its DRAM=
 log
> + * in safe mode. The reset halts both, then waits for these busy bits of=
 the
> + * GC memory interfaces to clear.
> + */
> +#define GFX11_GC_MEM_BUSY	(GRBM_STATUS2__EA_BUSY_MASK | \
> +				 GRBM_STATUS2__EA_LINK_BUSY_MASK | \
> +				 GRBM_STATUS2__UTCL2_BUSY_MASK | \
> +				 GRBM_STATUS2__UTCL2_RQ_PENDING_MASK | \
> +				 GRBM_STATUS2__TCP_BUSY_MASK | \
> +				 GRBM_STATUS2__CPC_BUSY_MASK | \
> +				 GRBM_STATUS2__RLC_BUSY_MASK | \
> +				 GRBM_STATUS2__RLC_RQ_PENDING_MASK | \
> +				 GRBM_STATUS2__SDMA_BUSY_MASK | \
> +				 GRBM_STATUS2__SDMA_SCH_RQ_PENDING_MASK | \
> +				 GRBM_STATUS2__SDMA0_RQ_PENDING_MASK | \
> +				 GRBM_STATUS2__SDMA1_RQ_PENDING_MASK)
> +
> +/* The RLC busy bits of its memory requests */
> +#define GFX11_RLC_MEM_BUSY	(RLC_STAT__MC_BUSY_MASK | \
> +				 RLC_STAT__RLC_SRM_BUSY_MASK | \
> +				 RLC_STAT__RLC_SPM_BUSY_MASK)
> +
> +/* Wait for the requests in flight in the GC, with MES and RLC F32 halte=
d. */
> +static int gfx_v11_0_wait_gc_idle(struct amdgpu_device *adev)
> +{
> +	u32 busy, cpc, rlc;
> +	int i;
> +
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		busy =3D RREG32_SOC15(GC, 0, regGRBM_STATUS2) & GFX11_GC_MEM_BUSY;
> +		cpc =3D RREG32_SOC15(GC, 0, regCP_CPC_STATUS);
> +		rlc =3D RREG32_SOC15(GC, 0, regRLC_STAT);
> +
> +		/* The halted MES and F32 can stay busy, not their memory requests. */
> +		if (!(cpc & GENMASK(21, 0) & ~CP_CPC_STATUS__MES_BUSY_MASK))
> +			busy &=3D ~GRBM_STATUS2__CPC_BUSY_MASK;
> +		if (!(rlc & GFX11_RLC_MEM_BUSY))
> +			busy &=3D ~GRBM_STATUS2__RLC_BUSY_MASK;
> +
> +		if (!busy && !(RREG32_SOC15(GC, 0, regGCVM_L2_STATUS) &
> +			       GCVM_L2_STATUS__L2_BUSY_MASK))
> +			return 0;

[Severity: Medium]
Does RREG32_SOC15(GC, 0, regGCVM_L2_STATUS) read the wrong MMIO offset on
GC 11.0.3, GC 11.5.x and GC 11.7.x?

gfx_v11_0.c includes gc/gc_11_0_0_offset.h, where regGCVM_L2_STATUS is
0x15bf (BASE_IDX 0).  On GC 11.0.3 (gc/gc_11_0_3_offset.h) and GC 11.5.x /
11.7.x (gc/gc_11_5_0_offset.h), the gc_gcvml2pfdec block is shifted by 4
dwords (which is why gmc_v11_0_set_gfxhub_funcs() selects
gfxhub_v3_0_3_funcs and gfxhub_v11_5_0_funcs for those IP versions):
regGCVM_L2_CNTL is at 0x15c0 and regGCVM_L2_STATUS is at 0x15c3, leaving
0x15bf in an unmapped gap before regGCVM_L2_CNTL.

On those ASICs (such as GC 11.5.1 and GC 11.5.3 where gfx engine soft
reset is enabled), gfx_v11_0_wait_gc_idle() will not poll the real
GCVM_L2_STATUS register and can pulse SOFT_RESET_GFX while L2 requests are
still in flight, or time out if the unmapped read returns all-ones.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D12
