Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B72606A332
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf0lCEfk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000AE10E0FA;
	Wed, 25 Nov 2026 07:51:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5539C10E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 07:51:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7503360E22;
 Wed, 25 Nov 2026 07:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B629D1F000C0;
 Wed, 25 Nov 2026 07:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795593101;
 bh=MHziPxtpsh8G75IZKkcWMWax9uY9YK7thntlZK+uU/c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hf0lCEfk5jiZsJby+TXk2CVK6xhaL8Fcq8su7bwtOMP6Lj1lRd3wiqDxtM1Y+2qIL
 HBYmdbynCR+hWWJ6lddfIYQWXeGBt6uaP+fkB5HmeiwQkicUckh4nygt6o3ioZbh4H
 HAGNxHwKCVU5e+ZDjW3fZiWPUOuFFBt3VoT1rP8V1XGbCxfyhHFmRGTZYQT3MTRKYp
 g+vJP9aJdN+heZay+dT53CXH3yXiTLn5D+YYr/FY+HUOMhlmXJiJ77uZz+jrclK6iB
 2kqxP59fDTKhG46Sts3+e0raVrPHdjqKHVT7G86sRQEMgOoUH5bZ+6TEDPWYZgoa1F
 L1XNXom1b0VEA==
Message-ID: <sashiko-outbox-232842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: unlink userptr bo_vas under the notifier_lock
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125073502.3144422-1-Jesse.Zhang@amd.com>
References: <20261125073502.3144422-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:51:41 +0000
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
- [High] drm/amdgpu: notifier_lock bypass for addr 0 userptr in
  amdgpu_vm_bo_del()
--

commit 22400668ad8179b001864d3570debe97ad11a006
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu: unlink userptr bo_vas under the notifier_lock

This commit acquires adev->notifier_lock in amdgpu_vm_bo_del() when
unlinking userptr bo_vas from bo->vm_bo to serialize against concurrent
MMU notifier invalidations.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e0..d33dcfd7059cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2252,10 +2252,18 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> =20
>  	if (bo) {
> +		/*
> +		 * The MMU notifier of a userptr walks bo->vm_bo under the
> +		 * notifier_lock, it can't take the BO reservation.
> +		 */
> +		bool userptr =3D amdgpu_ttm_tt_is_userptr(bo->tbo.ttm);
> +
>  		dma_resv_assert_held(bo->tbo.base.resv);
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo))
>  			ttm_bo_set_bulk_move(&bo->tbo, NULL);
> =20
> +		if (userptr)
> +			mutex_lock(&adev->notifier_lock);
>  		for (base =3D &bo_va->base.bo->vm_bo; *base;
>  		     base =3D &(*base)->next) {
>  			if (*base !=3D &bo_va->base)
> @@ -2265,6 +2273,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  			*base =3D bo_va->base.next;
>  			break;
>  		}
> +		if (userptr)
> +			mutex_unlock(&adev->notifier_lock);
>  	}

[Severity: High]
Can a userptr BO created at address 0 bypass adev->notifier_lock here and
still hit the use-after-free on bo_va?

amdgpu_gem_userptr_ioctl() accepts args->addr =3D=3D 0 with a non-zero
page-aligned size and AMDGPU_GEM_USERPTR_REGISTER, setting gtt->userptr =3D=
 0
and registering the MMU interval notifier for [0, args->size).  However,
amdgpu_ttm_tt_is_userptr() tests !gtt->userptr:

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:amdgpu_ttm_tt_is_userptr() {
	struct amdgpu_ttm_tt *gtt =3D ttm_to_amdgpu_ttm_tt(ttm);

	if (gtt =3D=3D NULL || !gtt->userptr)
		return false;

	return true;
}

When gtt->userptr is 0, userptr evaluates to false, so amdgpu_vm_bo_del()
skips adev->notifier_lock while an MMU invalidation on a VMA overlapping
[0, args->size) can concurrently walk bo->vm_bo in
amdgpu_hmm_invalidate_gfx() -> amdgpu_vm_bo_invalidate().

Checking amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) (or gtt->usertask in
amdgpu_ttm_tt_is_userptr()) would cover userptr BOs at address 0 as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125073502.3144=
422-1-Jesse.Zhang@amd.com?part=3D1
