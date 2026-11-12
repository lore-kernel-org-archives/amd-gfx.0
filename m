Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAD606A32D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ry97D9pD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DF510E688;
	Thu, 12 Nov 2026 23:57:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3747E10E688
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 23:57:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6431661149;
 Thu, 12 Nov 2026 23:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079831F000C4;
 Thu, 12 Nov 2026 23:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794527843;
 bh=gvfT/UZk61KefvD847r1hjWvauQDb6ilAWa2qwYfNyI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Ry97D9pD6WUJmMI3MA+TMIVyTMAJIYh427KMuqrXCv9tIIWBur2q9mMb7VFCcdqmZ
 X064ITfJw+QS3yuAuhboN/xlaczOqmD7U/STIaR9csu/nz2xUr/K0kiyYSrXGKGAoA
 FXvGA7ioRO4PKEEwhNYofn/jmXAsIHAt1aClx5SuTE9QJYRyDiOmF5L9YEWdFKe8yN
 4yjWu4UxmyHgxtRLEZvhafSzR4WS/M0jc5f2UOLjT5z7HR14pNGa4qIZSY+gPoMZRX
 A9mHCn0F36Icv1IuX8bx4UKuTMvbLZwreaKDf5LNz3Eq0buPStItkgBYqyDArKbCCR
 DXDSa9AXFIPEg==
Message-ID: <sashiko-outbox-211970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261112214802.1774412-1-alexander.deucher@amd.com>
References: <20261112214802.1774412-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:57:22 +0000
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
- [High] drm/amdgpu: ring emission in update_spm_vmid() gated on SR-IOV
  1-VF mode
--

commit 90ca59b6e99e6b8e5c6b2f133b97efb1b24aedb0
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu: bring back the ring parameter for update_spm_vmid()

This commit restores the ring parameter to the update_spm_vmid() callback
and passes the ring from amdgpu_ib_schedule() so that GFX11 and GFX12 can
emit the SPM VMID update on the ring instead of using MMIO.

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
>  	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
>  		pre_data =3D RREG32_NO_KIQ(reg);
>  	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index df2fb09bbcd86..07f981f27bcc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c

[ ... ]

> @@ -3978,12 +3979,22 @@ static void gfx_v12_0_update_perf_clk(struct amdg=
pu_device *adev,
> =20
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> +				      struct amdgpu_ring *ring,
>  				      unsigned vmid)
>  {
>  	u32 reg, data;
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
gfx_v11_0_update_spm_vmid() and gfx_v12_0_update_spm_vmid() from emitting
regRLC_SPM_MC_CNTL on bare-metal systems?

amdgpu_sriov_is_pp_one_vf(adev) checks AMDGIM_FEATURE_PP_ONE_VF, which is
only set on SR-IOV single-VF guests:

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:
#define amdgpu_sriov_is_pp_one_vf(adev) \
	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)

On bare metal, calling update_spm_vmid() with a non-NULL ring from
amdgpu_ib_schedule() skips amdgpu_ring_emit_wreg() and falls through to
amdgpu_gfx_off_ctrl() and CPU MMIO on every GFX and compute IB submission.
Because GFXOFF is re-enabled on the CPU before the ring is committed and
executed by the GPU, GFXOFF can re-engage and clear regRLC_SPM_MC_CNTL
without any packet on the ring to restore it.

In addition, the update_spm_vmid() callbacks in gfx_v7_0, gfx_v8_0,
gfx_v9_0, gfx_v9_4_3, and gfx_v10_0 ignore the ring parameter and run the
MMIO path on every IB submission, while the ring path in gfx_v11_0 and
gfx_v12_0 overwrites regRLC_SPM_MC_CNTL without preserving other bits in
the register.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112214802.1774=
412-1-alexander.deucher@amd.com?part=3D1
