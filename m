Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA8606A32D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYC8DtAd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B03D111238E;
	Thu, 12 Nov 2026 22:34:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F8311238E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:34:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6892E6118D;
 Thu, 12 Nov 2026 22:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA431F000C4;
 Thu, 12 Nov 2026 22:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794522844;
 bh=xVr2B9zktoyKnvav6UVF7nxeeYW7hQjAGaWcLYXQSYY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=eYC8DtAdxPbihau37UtjdtktnE33aAY9V/rmwW/G3lzVw9ZyM/RQqW8SKokQ3Haq3
 NAtc4SZl+I7J8XjIl5GTDxD/VlLahe6G3a8omQmyn0el3VwJ+hyeW1pPo1yrgLDuf1
 GS9sJEE8ToJXA4FFhJTKM0Tr4K7QWSYgzzcW953v4E9o2rKGueeuy1HhRd+5WEDNU6
 K4N9vjJeDduvRQCvUS0wnhkjgNft3SAixTRLYn05KahxaigvLe7m1k/HsTWjEUY4LA
 UW1kakhSXvvXHa527P/DG9jNCsqWDW+8hJAWrXLpqb9vR15QVVdLoW6CqcJFEjPKJb
 P+Kc+C+TdidBw==
Message-ID: <sashiko-outbox-211914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261112212417.1769071-1-alexander.deucher@amd.com>
References: <20261112212417.1769071-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:34:03 +0000
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
- [High] drm/amdgpu: update_spm_vmid() ring emission gated on SR-IOV
  one-VF mode
- [Medium] drm/amdgpu: unskipped MMIO path and shadowed reg in
  gfx_v12_1_update_spm_vmid()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] drm/amdgpu: null pointer dereference in amdgpu_vm_flush()
  [1]
--

commit 6992ee0f5dfcb4a6c2339de5ec059b2331ca4d48
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu: bring back the ring parameter for update_spm_vmid()

This commit restores the ring parameter to the RLC update_spm_vmid() callba=
ck
so that amdgpu_ib_schedule() can emit the SPM VMID update on the ring inste=
ad
of via MMIO.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 6210edf1937aa..a24cdf5852a32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -213,7 +213,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>  		amdgpu_ring_emit_pipeline_sync(ring);
> =20
>  	if (emit_spm_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring,
>  						     adev->vm_manager.spm_vmid);
> =20
>  	if (emit_gds_needed)

[Severity: Critical]
This problem wasn't introduced by this patch, but can [1]
amdgpu_ib_schedule() dereference a NULL adev->gfx.rlc.funcs pointer when
initializing emit_spm_needed?

drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c:amdgpu_ib_schedule() {
    ...
	bool emit_spm_needed =3D adev->gfx.rlc.funcs->update_spm_vmid &&
		(ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
		 ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
    ...
}

On hardware configurations where adev->gfx.rlc.funcs is not initialized,
evaluating adev->gfx.rlc.funcs->update_spm_vmid during IB submission causes=
 a
NULL pointer dereference and kernel panic.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..ac814c12d60f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

[ ... ]

> @@ -5615,12 +5616,21 @@ static int gfx_v11_0_update_gfx_clock_gating(stru=
ct amdgpu_device *adev,
>  }
> =20
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xc=
c_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 reg, pre_data, data;
> =20
> -	amdgpu_gfx_off_ctrl(adev, false);
>  	reg =3D SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> +
> +	if (ring && amdgpu_sriov_is_pp_one_vf(adev) &&
> +	    ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) ||
> +	     (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) {
> +		data =3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNT=
L__RLC_SPM_VMID__SHIFT;
> +		amdgpu_ring_emit_wreg(ring, reg, data);
> +		return;
> +	}
> +
> +	amdgpu_gfx_off_ctrl(adev, false);

[Severity: High]
Does gating the ring emission on amdgpu_sriov_is_pp_one_vf(adev) prevent
gfx_v11_0_update_spm_vmid(), gfx_v12_0_update_spm_vmid(), and
gfx_v12_1_update_spm_vmid() from ever emitting the SPM update on the ring or
skipping the MMIO path on bare metal?

amdgpu_sriov_is_pp_one_vf(adev) checks AMDGIM_FEATURE_PP_ONE_VF, which is
only set in SR-IOV single-VF mode and is false on bare metal.  When
amdgpu_ib_schedule() passes a non-NULL ring on bare-metal systems, this
condition evaluates to false and execution falls through to the synchronous
amdgpu_gfx_off_ctrl() and MMIO path on every GFX and compute IB submission.
If GFXOFF engages after amdgpu_ib_schedule() re-enables GFXOFF on the CPU a=
nd
before the GPU executes the queued IB, regRLC_SPM_MC_CNTL is cleared by
GFXOFF and never restored by the ring.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 1f57d0fa2c044..2bbe83d98563a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c

[ ... ]

> @@ -2945,7 +2945,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu=
_device *adev,
> =20
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> -				      unsigned int vmid)
> +				      struct amdgpu_ring *ring,
> +				      unsigned vmid)
>  {
>  	u32 reg, data;
> =20
> @@ -2962,6 +2963,14 @@ static void gfx_v12_1_update_spm_vmid(struct amdgp=
u_device *adev,
>  		WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data=
);
>  	else
>  		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
> +
> +	if (ring
> +	    && amdgpu_sriov_is_pp_one_vf(adev)
> +	    && ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX)
> +		|| (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) {
> +		uint32_t reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM=
_MC_CNTL);
> +		amdgpu_ring_emit_wreg(ring, reg, data);
> +	}
>  }

[Severity: Medium]
Should the ring emission check in gfx_v12_1_update_spm_vmid() run and return
before the MMIO read and write, as in gfx_v11_0_update_spm_vmid() and
gfx_v12_0_update_spm_vmid()?

Placing the ring check at the end of the function leaves the MMIO accesses =
to
regRLC_SPM_MC_CNTL unconditional whenever a ring is passed from
amdgpu_ib_schedule().  The inner uint32_t reg declaration also shadows the
outer u32 reg variable that is already initialized to the same offset.

[1] https://sashiko.dev/#/bug/linux-c7bb3824-c8ad-4019-945c-0cd80d5a9da3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112212417.1769=
071-1-alexander.deucher@amd.com?part=3D1
