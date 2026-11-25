Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D25606A32C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UToDz5YF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2B310E303;
	Wed, 25 Nov 2026 09:23:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D5410E303
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 09:22:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADB8C600DB;
 Wed, 25 Nov 2026 09:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C801F000C0;
 Wed, 25 Nov 2026 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795598575;
 bh=xuMWdXiscGbS7vSWxRiiT2PNAHofsOofIspbYK1ZTvk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UToDz5YFJOm8ZrO3QBNlsL4sdtnJOXFIVoN7itG8IjwKn31VibthNYLUaniJHAQzO
 G0FXgGQzgYO/D3FN4cFgRVGe8j+Mzeip9A7S97C9/vw8BUDjLIP7XGEY0OMpv3fdbp
 j/y6vUKmmmE8W27k5cnd9ZsGTrMGewqvQFUJTlO7pXC8cbycTkecWrEkqTxAt54sTa
 0Dlg5kEC6MVi4lohXL7aSQNaY4U1B5vdfIDoko9E5aekUGrebL91lI4NFcVe9KISOn
 /boqrTaHZWeRQRO7KKJYirbSRLGm8lD/X/Z/18c9agPMiEVckduXDIIG5sjVtQ25/y
 tRVOjcklMAsCg==
Message-ID: <sashiko-outbox-233002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: unlink userptr bo_vas under the
 notifier_lock
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125090415.3345401-1-Jesse.Zhang@amd.com>
References: <20261125090415.3345401-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:22:54 +0000
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
- [High] drm/amdgpu:bo_va UAF in amdgpu_vm_bo_del() when
  group_leader->mm is NULL
--

commit cfb11e728a1b3b102cad849d9bad6a5262a6b72c
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu: unlink userptr bo_vas under the notifier_lock

This commit takes adev->notifier_lock in amdgpu_vm_bo_del() when unlinking
a userptr bo_va from bo->vm_bo to serialize against concurrent MMU
notifier invalidations.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e0..7a6de95e902e4 100644
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
> +		bool userptr =3D amdgpu_ttm_tt_get_usermm(bo->tbo.ttm);
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
> =20
>  	spin_lock(&vm->individual_lock);

[Severity: High]
Can amdgpu_vm_bo_del() still skip adev->notifier_lock and free bo_va while
amdgpu_hmm_invalidate_gfx() walks bo->vm_bo if the thread group leader has
already exited?

amdgpu_ttm_tt_set_userptr() binds gtt->usertask to current->group_leader,
and amdgpu_ttm_tt_get_usermm() returns gtt->usertask->mm:

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:amdgpu_ttm_tt_get_usermm() {
    ...
	if (gtt->usertask =3D=3D NULL)
		return NULL;

	return gtt->usertask->mm;
}

Meanwhile, amdgpu_hmm_register() inserts bo->notifier into current->mm,
where it stays active until amdgpu_gem_object_free() calls
amdgpu_hmm_unregister().  In a multi-threaded process, if the thread group
leader exits via pthread_exit() while other threads remain alive, exit_mm()
clears gtt->usertask->mm to NULL while the shared mm_struct and
bo->notifier are still live:

CPU0 (group leader)           CPU1                          CPU2
do_exit()
  exit_mm()
    tsk->mm =3D NULL
                              drm_gem_close_ioctl()
                                ...
                                amdgpu_vm_bo_del()
                                  /* get_usermm() =3D=3D NULL */
                                                            madvise(MADV_DO=
NTNEED)
                                                              ...
                                                              amdgpu_hmm_in=
validate_gfx()
                                                                mutex_lock(=
&adev->notifier_lock)
                                                                amdgpu_vm_b=
o_invalidate()
                                  *base =3D bo_va->base.next
                                  kfree(bo_va)
                                                                  /* walks =
bo->vm_bo */
                                                                  <-- use-a=
fter-free

The same happens during process exit when do_exit() runs exit_mm() before
exit_files() closes the DRM file descriptor while another task sharing the
mm or file triggers an invalidation.

Checking amdgpu_ttm_tt_get_usertask() (or bo->notifier.mm) instead of
amdgpu_ttm_tt_get_usermm() would keep adev->notifier_lock serialized for as
long as the userptr BO exists.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125090415.3345=
401-1-Jesse.Zhang@amd.com?part=3D1
