Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DD606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZNmttFK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B0E112230;
	Thu, 12 Nov 2026 16:53:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43182112230
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 16:52:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F209745678;
 Thu, 12 Nov 2026 16:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA4C1F000C4;
 Thu, 12 Nov 2026 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794502378;
 bh=g5KPTtRgdX1QKi9K8WqUQ7NMuZEeDpZKd6mNfUCgFL4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UZNmttFKLSUe4kPgUMSTMdAKMDOEWmPsuUkTYB90Hh/Xcnm5URmgZs94575r+6dRk
 JwOx+YI7BCopaHFFFCSz/O5jO1hOlino1m8JqV6E5Q57+pPHj9LhELovAPMGKDC9Mi
 uBz7BXuJJ4LT9xOoETNauWDh56pE+7UhTcgv7AYRHrJ1/UpYa7nq0Krlpr4yPPu0do
 FCp6D+9e/hFHY3yumINduRVqfsC9MfQ2SMBYPCelqtu1DWyNvRNgHaoFGcwKGqKBfs
 QJFv9D957LjSYlF1lPyLxmGKlih43QGz0h7pV3NccDu32af8e0I4G+bYeS6DVq+uXO
 oNoLqwasLoJgA==
Message-ID: <sashiko-outbox-211541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu/object: get rid of amdgpu_bo_fence
To: "Benjamin Cheng" <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261112164408.1748006-4-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-4-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:52:58 +0000
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
- [High] drm/amdgpu: build failure due to remaining amdgpu_bo_fence()
  call
--

commit ad8f0288ef23c9d2bb8ccdc99b45b97d28e2518c
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

[Severity: High]
Does removing amdgpu_bo_fence() break the build in
amdgpu_gem_object_close()?

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:amdgpu_gem_object_close() {
    ...
	if (r || !fence)
		goto out_unlock;

	amdgpu_bo_fence(bo, fence, true);
	dma_fence_put(fence);
    ...
}

amdgpu_gem_object_close() still calls amdgpu_bo_fence(), which causes an
implicit function declaration error when compiling amdgpu_gem.c.  Since
amdgpu_gem_object_close() already reserves a fence slot via
drm_exec_prepare_obj(), that caller can use dma_resv_add_fence() directly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112164408.1748=
006-1-benjamin.cheng@amd.com?part=3D3
