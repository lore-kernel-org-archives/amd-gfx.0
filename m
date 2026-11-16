Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9B606A32C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSL9VUHy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2CF10F322;
	Mon, 16 Nov 2026 17:20:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C56810F322
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 17:20:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF0DD62337;
 Mon, 16 Nov 2026 17:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8761F000C4;
 Mon, 16 Nov 2026 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794849612;
 bh=AO6lZfpAclDsDwSyPZaVG2McMuhodr+PwkdQOln1vK0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=NSL9VUHytBt4daTcdXv6xlF8SvXTL/sW31Kw+0YMipW5vOURBjjRICdK1IHDqSXNI
 qazfBokcEhY8iHSNjDWRYMQXFAB3xljnYzmn15UrVTl1x/3mFykugA5GdNwi1OeUxq
 uWLoHkr5D0ji0v1apmJbXKr0L2WMArm0+YhYD9ilzVZM5ZR1YoFD4WwRmfMMpKEVRM
 iUG8UedONcNo15puHeJ/O8boRgalsd6gC2se8+fmXOdwnP/jKe8dIxU4gp4gVCnPox
 +8nlbOCDq0iEBw2hgAO+4poFHLeoQ2Kt5i/x3Zuncuh45IpXAyHRHamSRLjCZ5LM7O
 vTJlJn+6K11UQ==
Message-ID: <sashiko-outbox-217426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/amdgpu/gfx9.4.3: program the RLC SPM in RLC resume
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116165713.1945549-4-alexander.deucher@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
 <20261116165713.1945549-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:20:11 +0000
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
- [High] drm/amdgpu: gfx_v9_4_3_xcc_rlc_resume() passes 0 instead of
  xcc_id
- [Medium] drm/amdgpu: moving update_spm_vmid() to
  gfx_v9_4_3_xcc_rlc_resume() skips VFs
--

commit 754d99a96da547c9e401d40cfbeb309d0d3aa36f
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/gfx9.4.3: program the RLC SPM in RLC resume

This commit moves the RLC SPM VMID programming from gfx_v9_4_3_rlc_init()
to gfx_v9_4_3_xcc_rlc_resume() so that the register is reprogrammed after
suspend/resume and GPU reset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index da031caa4e9e6..151336e6094f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(s=
truct amdgpu_device *adev)
> =20
>  static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>  {
> -	/* init spm vmid with 0xf */
> -	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmi=
d);
> -
>  	return 0;
>  }
> =20
> @@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu=
_device *adev, int xcc_id)
>  	gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
> =20
> +	/* init spm vmid with 0xf */
> +	if (adev->gfx.rlc.funcs->update_spm_vmid)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmi=
d);
> +
>  	return 0;
>  }

[Severity: High]
Should update_spm_vmid() pass xcc_id instead of 0 here?

gfx_v9_4_3_rlc_resume() and gfx_v9_4_3_xcp_resume() call
gfx_v9_4_3_xcc_rlc_resume() for each XCC instance, and
gfx_v9_4_3_update_spm_vmid() uses the instance argument with
GET_INST(GC, inst) to select which XCC's regRLC_SPM_MC_CNTL register to
write.  Passing 0 programs XCC 0 on every iteration and leaves
regRLC_SPM_MC_CNTL on all other XCCs at its hardware reset default of
VMID 0.

[Severity: Medium]
Does moving update_spm_vmid() into gfx_v9_4_3_xcc_rlc_resume() skip SPM
VMID initialization on SR-IOV VFs?

Both callers of gfx_v9_4_3_xcc_rlc_resume() (gfx_v9_4_3_rlc_resume() and
gfx_v9_4_3_xcp_resume()) skip calling it when amdgpu_sriov_vf(adev) is
true:

drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:gfx_v9_4_3_rlc_resume() {
	if (amdgpu_sriov_vf(adev))
		return 0;

	num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
	for (i =3D 0; i < num_xcc; i++) {
		r =3D gfx_v9_4_3_xcc_rlc_resume(adev, i);
    ...
}

Unlike gfx_v9_4_3_rlc_init(), which ran during sw_init on VFs as well,
gfx_v9_4_3_update_spm_vmid() is no longer reached on SR-IOV VFs, leaving
regRLC_SPM_MC_CNTL unprogrammed in SR-IOV one-VF mode despite the
amdgpu_sriov_is_pp_one_vf(adev) handling in gfx_v9_4_3_update_spm_vmid().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116165713.1945=
549-1-alexander.deucher@amd.com?part=3D4
