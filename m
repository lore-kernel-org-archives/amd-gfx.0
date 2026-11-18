Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D89606B103
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDV6dgA5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F53310FFAF;
	Wed, 18 Nov 2026 19:29:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BAD10FFAF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:29:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6886B62F87;
 Wed, 18 Nov 2026 19:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3611F000C5;
 Wed, 18 Nov 2026 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795030165;
 bh=QC3xhCIkdJKwDg95t1J94FgAy/3oeB1V6f6Fff3uS60=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZDV6dgA5KvkHAQ6euVaCxW5GsoB0jEwPF+iZjYoj2lNO7S9sMMC66ywJoHu17jr7C
 kB2RVE/Ry1Mrr2cY9yVqKL1KlIHq1eWHu6ShNBhaKLFFkRZvuP+GBxzFYJFDH5tACd
 k7MHx23zT+PJ4h4IleMULTtQAW9I8XLaaCmYU/2OAcXgKJ8VJuU5/Ldqej/o+rvM6I
 sLOEMPdKEPD98DWPdqnzTTdX4jXg1U8QDTLRS4YycdgZmdv/sKmg8D8jmefI+z7JCw
 Ipbmdode3hoE3QG5GDKpM+pxR+3khGiEOt5uLgNNiqmOvz2AnN1TMD/H1Yl5RRdL5t
 QO1RmcQTW5VWg==
Message-ID: <sashiko-outbox-221861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] drm/amdgpu/object: get rid of amdgpu_bo_fence
To: "Benjamin Cheng" <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118190735.1863676-11-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261118190735.1863676-11-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:29:24 +0000
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
- [High] drm/amdgpu: removing amdgpu_bo_fence() breaks
  amdgpu_gem_object_close() build
--

commit 6a4de07fd2509683647edc1a8831db741d691fd3
Author: Benjamin Cheng <benjamin.cheng@amd.com>

drm/amdgpu/object: get rid of amdgpu_bo_fence

This commit removes the definition and declaration of amdgpu_bo_fence().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 6aa895f63aeaf..7fc43363ec626 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1441,31 +1441,6 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct t=
tm_buffer_object *bo)
>  	return 0;
>  }
> =20
> -/**
> - * amdgpu_bo_fence - add fence to buffer object
> - *
> - * @bo: buffer object in question
> - * @fence: fence to add
> - * @shared: true if fence should be added shared
> - *
> - */
> -void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> -		     bool shared)
> -{
> -	struct dma_resv *resv =3D bo->tbo.base.resv;
> -	int r;
> -
> -	r =3D dma_resv_reserve_fences(resv, 1);
> -	if (r) {
> -		/* As last resort on OOM we block for the fence */
> -		dma_fence_wait(fence, false);
> -		return;
> -	}
> -
> -	dma_resv_add_fence(resv, fence, shared ? DMA_RESV_USAGE_READ :
> -			   DMA_RESV_USAGE_WRITE);
> -}
> -
>  /**
>   * amdgpu_bo_sync_wait_resv - Wait for BO reservation fences
>   *

[Severity: High]
Does removing amdgpu_bo_fence() break the build in
amdgpu_gem_object_close()?

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:amdgpu_gem_object_close() {
	...
	r =3D amdgpu_vm_clear_freed(adev, vm, &fence);
	if (unlikely(r < 0) && !drm_dev_is_unplugged(adev_to_drm(adev)))
		dev_err(adev->dev, "failed to clear page "
			"tables on GEM object close (%ld)\n", r);
	if (r || !fence)
		goto out_unlock;

	amdgpu_bo_fence(bo, fence, true);
	dma_fence_put(fence);
	...
}

amdgpu_gem_object_close() still calls amdgpu_bo_fence(), so removing it
causes compilation of amdgpu_gem.c to fail with an implicit function
declaration error.

Also note that in amdgpu_gem_object_close(), drm_exec_prepare_obj(&exec,
&bo->tbo.base, 1) is followed by amdgpu_vm_lock_pd(vm, &exec,
AMDGPU_VM_UPDATE_FENCES).  Because dma_resv_reserve_fences() is not
additive, only AMDGPU_VM_UPDATE_FENCES slots remain reserved when bo
shares the VM root PD dma_resv, while amdgpu_vm_clear_freed() plus adding
the fence to bo requires AMDGPU_VM_UPDATE_FENCES + 1 slots if replaced
with a direct dma_resv_add_fence() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118190735.1863=
676-1-benjamin.cheng@amd.com?part=3D10
