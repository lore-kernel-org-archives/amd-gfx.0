Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A96606A332
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnzxxn3r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFB610E7E5;
	Fri, 13 Nov 2026 16:15:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD7010E7E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 16:15:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BDC945045;
 Fri, 13 Nov 2026 16:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C510E1F000C4;
 Fri, 13 Nov 2026 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586538;
 bh=+G/2kJGWAnXC/KZwxm+6gDs+lpqKKDn1EWnZo8a6aTM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gnzxxn3rxsbsHkI9v8C5rQvkX3L6Fr0w14uA2AbEmWHBLgWpYeSj3hHpkym0nlZmk
 cJdWpzwX4zdPitONr2hhmYyO67HpfOOkfsKP2RAySyqEDjDuGqLpPAKffxDvhGNxV4
 2e7TIqAZm/pZ1GdYmWDw+DLIuIA2x/l1K4fVaAla8LvB3UoxqsWHWeSWJ3Ij1VZM+T
 77xM8BzFSyAsKXGmwcfI0eDz6DqnWPsDoQoTX4UbB4iwzdsI4BRcrdixR9v1l6eB+w
 RaEhyh4k8mAmf4Nkypnw6V+MFUTkf/Hb/wCG3su8jm0jymvVhghMEUk8KOW5JmAJBW
 UqcvUP36LmFjQ==
Message-ID: <sashiko-outbox-213179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113154954.1865439-3-alexander.deucher@amd.com>
References: <20261113154954.1865439-1-alexander.deucher@amd.com>
 <20261113154954.1865439-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:15:38 +0000
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
- [High] drm/amdgpu: update_spm_vmid() runs MMIO on every IB on
  GFX7/8/9.4.3/12.1
- [Medium] drm/amdgpu: missing update_spm_vmid() dwords in GFX9/10/12
  emit_frame_size
--

commit ffe1064b12164c8a48cc5a74a5943685b8d92ee1
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu: bring back the ring parameter for update_spm_vmid()

This commit restores the ring parameter to update_spm_vmid() and calls it
from amdgpu_ib_schedule() on GFX and compute rings so chips with GFXOFF
emit the SPM VMID update via the ring instead of MMIO.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index f98a7c6797b3c..ae028eeacaed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -121,6 +121,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
>  		       struct dma_fence **f)
>  {
>  	struct amdgpu_device *adev =3D ring->adev;
> +	bool emit_spm_needed =3D adev->gfx.rlc.funcs &&
> +		adev->gfx.rlc.funcs->update_spm_vmid &&
> +		(ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> +		 ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
>  	struct amdgpu_ib *ib;
>  	struct dma_fence *tmp =3D NULL;
>  	struct amdgpu_fence *af;
> @@ -209,6 +213,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
>  	if (need_pipe_sync)
>  		amdgpu_ring_emit_pipeline_sync(ring);
> =20
> +	if (emit_spm_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring,
> +						     adev->vm_manager.spm_vmid);
> +
>  	if (emit_gds_needed)
>  		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>  					    job->gds_size, job->gws_base,
[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 7683e8a0a4380..9d58af0c678c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8187,8 +8187,17 @@ static void gfx_v10_0_update_spm_vmid_internal(str=
uct amdgpu_device *adev,
>  }
> =20
>  static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xc=
c_id,
> -		unsigned int vmid)
> -{
> +		struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	if (ring &&
> +	    ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) ||
> +	     (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) {
> +		u32 reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
> +		u32 data =3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC=
_CNTL__RLC_SPM_VMID__SHIFT;
> +		amdgpu_ring_emit_wreg(ring, reg, data);
> +		return;
> +	}
> +
>  	amdgpu_gfx_off_ctrl(adev, false);
> =20
>  	gfx_v10_0_update_spm_vmid_internal(adev, vmid);
[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index df2fb09bbcd86..b01e239db195f 100644
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
> +	if (ring &&
> +	    ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) ||
> +	     (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) {
> +		data =3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNT=
L__RLC_SPM_VMID__SHIFT;
> +		amdgpu_ring_emit_wreg(ring, reg, data);
> +		return;
> +	}
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
>  	if (amdgpu_sriov_is_pp_one_vf(adev))
>  		data =3D RREG32_NO_KIQ(reg);
>  	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 1f57d0fa2c044..bf69d71e6b065 100644
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 72c84b61fda16..43dea0810137b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
[ ... ]
> @@ -3483,7 +3483,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device=
 *adev)
>  }
> =20
>  static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 data;
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 4666aa5b38c75..360a958f7577d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
[ ... ]
> @@ -5484,7 +5484,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_=
device *adev, int xcc_id)
>  }
> =20
>  static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 data;
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 2e2673a6dbbf5..7d001d7e3a0d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5227,8 +5227,17 @@ static void gfx_v9_0_update_spm_vmid_internal(stru=
ct amdgpu_device *adev,
>  }
> =20
>  static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -		unsigned int vmid)
> -{
> +		struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	if (ring &&
> +	    ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) ||
> +	     (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) {
> +		u32 reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
> +		u32 data =3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC=
_CNTL__RLC_SPM_VMID__SHIFT;
> +		amdgpu_ring_emit_wreg(ring, reg, data);
> +		return;
> +	}
> +
>  	amdgpu_gfx_off_ctrl(adev, false);
> =20
>  	gfx_v9_0_update_spm_vmid_internal(adev, vmid);

[Severity: Medium]
Do gfx_v9_0, gfx_v10_0, and gfx_v12_0 need 5 additional DWords in
.emit_frame_size for the new amdgpu_ring_emit_wreg() call in
update_spm_vmid()?

While gfx_v11_0_ring_funcs_gfx and gfx_v11_0_ring_funcs_compute already
include 5 DWords for update_spm_vmid in .emit_frame_size, that accounting
is missing from gfx_v9_0_ring_funcs_gfx, gfx_v9_0_sw_ring_funcs_gfx,
gfx_v9_0_ring_funcs_compute, gfx_v10_0_ring_funcs_gfx,
gfx_v10_0_ring_funcs_compute, gfx_v12_0_ring_funcs_gfx, and
gfx_v12_0_ring_funcs_compute.

When a submission emits the full frame and alloc_size lands within 4 DWords
below a 256-DWord alignment boundary (for example, 15 IBs on
gfx_v10_0_ring_funcs_gfx gives 196 + 60 =3D 256 DWords), emitting 261 DWords
underflows ring->count_dw in amdgpu_ring_commit(), logging an error and
padding with NOPs into the next unallocated 256-DWord block.  On
gfx_v9_0_ring_funcs_compute, 125 IBs also pushes the total from 1020 to
1025 DWords, exceeding the 1024-DWord max_dw passed to amdgpu_ring_init().

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index da031caa4e9e6..30c8b751849cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
[ ... ]
> @@ -1609,7 +1609,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_devi=
ce *adev)
>  }
> =20
>  static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -					      int inst, unsigned int vmid)
> +					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	u32 reg, pre_data, data;

[Severity: High]
Should gfx_v7_0_update_spm_vmid(), gfx_v8_0_update_spm_vmid(),
gfx_v9_4_3_update_spm_vmid(), and gfx_v12_1_update_spm_vmid() return early
when ring is non-NULL?

Because amdgpu_ib_schedule() now calls update_spm_vmid() on every GFX and
compute IB submission whenever the callback is present, and these four
implementations ignore the ring parameter, they run synchronous MMIO on
every IB submission.  On GFX7 and GFX8, every submission calls
amdgpu_gfx_off_ctrl(), RREG32(), and WREG32(); on GFX9.4.3, every compute
submission runs RREG32() (which dispatches and polls KIQ under SR-IOV
runtime); and on GFX12.1 when kernel compute queues are enabled via
amdgpu_user_queue=3D0, concurrent per-ring scheduler threads perform
unserialized RREG32() and WREG32_SOC15() read-modify-writes without
disengaging GFXOFF.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113154954.1865=
439-1-alexander.deucher@amd.com?part=3D3
