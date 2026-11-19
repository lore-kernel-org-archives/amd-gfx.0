Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E81606A334
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Udji3lkL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B77E1124D9;
	Thu, 19 Nov 2026 14:46:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3E01124D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:46:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBC6D44234;
 Thu, 19 Nov 2026 14:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CC01F000C4;
 Thu, 19 Nov 2026 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795099575;
 bh=89/67nlE8m00KOikiNXX06p0+FLYTZeaSo+TKuHzvZo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Udji3lkLcXaY7zYHKVJSahkLQm6pFtMnkLh7l0GF6wUtJEOaY0qkJuUJG3Aym3FJ6
 2QqMm6pF3mBJYsgS683EnwZrg6ztrmq0IGqUFBTk8HEna5IU5aCOFl4pthmPzf+1r/
 cAvaytrQkmvxHlw8MxRfDj3zG8Hwh2tU/CRZOQ/MDufPEAAeovXxBO6A/ZZBq5Oiv9
 jcH6FHHtS32wCEmDTXCS+PFJFVJxbvaR5Kg6hRi4wEm5nqM8zsL7Nxfa1/9yo5TB+6
 HkfgGOjg0XMNUAOaRRZdRJOWwVV5zgn8EeBwToZfzeg+YvoInR3KRVGSTl6DFl2rzc
 uSOA1GEssd//Q==
Message-ID: <sashiko-outbox-223314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] drm/amdgpu/object: get rid of amdgpu_bo_fence
To: "Benjamin Cheng" <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119144049.2057674-7-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-7-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:46:15 +0000
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
- [High] drm/amdgpu: build failure in amdgpu_gem_object_close() after
  removing amdgpu_bo_fence()
--

commit 0712370b9809b23c4190422dc542ee1195e75ba2
Author: Benjamin Cheng <benjamin.cheng@amd.com>

drm/amdgpu/object: get rid of amdgpu_bo_fence

This commit removes the amdgpu_bo_fence() helper and its declaration.

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

amdgpu_gem_object_close() still calls amdgpu_bo_fence(), so compiling
amdgpu_gem.c fails with an implicit declaration error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119144049.2057=
674-1-benjamin.cheng@amd.com?part=3D7
