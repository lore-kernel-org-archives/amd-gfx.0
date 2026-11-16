Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB760A2620
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cclsS13k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB2310EA84;
	Mon, 16 Nov 2026 17:26:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538C010F32A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 17:26:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FDB261D19;
 Mon, 16 Nov 2026 17:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C781F000CF;
 Mon, 16 Nov 2026 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794849994;
 bh=7mY+14ipNpbsXfC5jacwd0SmO0tRzcE0IUG/a6xxrgA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=cclsS13k5YuOpicI2AkWzVuu/rq7hb58j+YrrP5KM2+zcqyD06ZuvNt9qS9hyQwfO
 GrII0EqjSIX5sZqRMHWlAAWi/qxz03JlCGxD0PWE9gerL2YRhImAL5+EzFz2r73XfM
 VZk1W0JDYpnqmkOcYvBq8qIBUT8kzZK3zjjow1kW57VfwKwtiLhlXaAm4ew178eb3n
 Kj9zHyymTD+gxojL5mdE5nrNTgJVPD9BNa+UikjSyHiyzImrbjqtJ9cGoWLml9VRjW
 PlN4w4R2SPSqqgOJlp5G7505XSLFvOt2oA0051dcVvz7T8uKzInVFQbcOvrCJp5V5r
 hSi8rmx0hUNPw==
Message-ID: <sashiko-outbox-217433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116165713.1945549-5-alexander.deucher@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
 <20261116165713.1945549-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:26:33 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdgpu: hardcoded XCC 0 in gfx_v9_4_3_xcc_rlc_resume()
  skips XCCs 1..N-1
- [Medium] drm/amdgpu: gfx9 compute emit_frame_size exceeds max_dw in
  amdgpu_ring_init()
- [Medium] drm/amdgpu: update_spm_vmid() skipped on SR-IOV VFs in
  gfx_v8_0 and gfx_v9_4_3
--

commit 08b45306962b59cde3c232193cc26534f308aaa2
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu: bring back the ring parameter for update_spm_vmid()

This commit restores the ring parameter to update_spm_vmid() so that GFX9,
GFX10, GFX11, and GFX12.0 emit the SPM VMID update on the ring during IB
scheduling while skipping MMIO updates when a ring is provided.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index df935827b002a..e818280139791 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4084,7 +4084,8 @@ static int gfx_v8_0_rlc_resume(struct amdgpu_device=
 *adev)
> =20
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmi=
d);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.s=
pm_vmid);
> +
>  	return 0;
>  }
> =20
> @@ -5483,10 +5484,13 @@ static void gfx_v8_0_unset_safe_mode(struct amdgp=
u_device *adev, int xcc_id)
>  }
> =20
>  static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 data;
> =20
> +	if (ring)
> +		return;
> +
>  	amdgpu_gfx_off_ctrl(adev, false);
> =20
>  	if (amdgpu_sriov_is_pp_one_vf(adev))

[Severity: Medium]
Does returning early when ring is non-NULL leave mmRLC_SPM_VMID unprogrammed
on SR-IOV VFs in one-VF mode?

gfx_v8_0_rlc_resume() returns early when amdgpu_sriov_vf(adev) is true befo=
re
reaching the update_spm_vmid(adev, 0, NULL, ...) call:

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:gfx_v8_0_rlc_resume() {
	if (amdgpu_sriov_vf(adev)) {
		gfx_v8_0_init_csb(adev);
		return 0;
	}
    ...
}

With amdgpu_ib_schedule() passing a non-NULL ring, gfx_v8_0_update_spm_vmid=
()
now returns before reaching the amdgpu_sriov_is_pp_one_vf(adev) branch, so
mmRLC_SPM_VMID is never programmed on SR-IOV VFs.  The same issue affects
gfx_v9_4_3_update_spm_vmid(), because both gfx_v9_4_3_rlc_resume() and
gfx_v9_4_3_xcp_resume() skip calling gfx_v9_4_3_xcc_rlc_resume() when
amdgpu_sriov_vf(adev) is true.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 2e2673a6dbbf5..be45c10b6f579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c

[ ... ]

> @@ -7663,6 +7675,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>  	.get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
>  	.set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
>  	.emit_frame_size =3D
> +		5 + /* update_spm_vmid */
>  		20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */

[Severity: Medium]
Does adding 5 dwords here trigger WARN_ON(max_ibs_dw > max_dw) in
amdgpu_ring_init() for every GFX9 compute ring?

This increases gfx_v9_0_ring_funcs_compute.emit_frame_size from 145 to 150.
In amdgpu_ring_init(), max_ibs_dw is 150 + 125 * 7 =3D 1025, which rounds u=
p to
1280 with align_mask (0xff), exceeding the max_dw of 1024 passed by
gfx_v9_0_compute_ring_init().

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 151336e6094f7..f28ffe8a5ac55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1586,7 +1586,7 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_=
device *adev, int xcc_id)
> =20
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmi=
d);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.s=
pm_vmid);
> =20
>  	return 0;
>  }
> @@ -1609,10 +1609,13 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_de=
vice *adev)
>  }
> =20
>  static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -					      int inst, unsigned int vmid)
> +					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	u32 reg, pre_data, data;
> =20
> +	if (ring)
> +		return;
> +
>  	reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);

[Severity: High]
Should gfx_v9_4_3_xcc_rlc_resume() pass xcc_id instead of 0 to
update_spm_vmid()?

Previously, amdgpu_ib_schedule() called update_spm_vmid() with ring->xcc_id=
 on
each IB submission, programming regRLC_SPM_MC_CNTL on all XCCs.  Now that
gfx_v9_4_3_update_spm_vmid() returns early when ring is non-NULL,
gfx_v9_4_3_xcc_rlc_resume() is the only caller that programs the register, =
and
passing hardcoded 0 leaves XCCs 1..num_xcc-1 at their hardware reset value =
of
VMID 0 (the kernel VMID).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116165713.1945=
549-1-alexander.deucher@amd.com?part=3D5
