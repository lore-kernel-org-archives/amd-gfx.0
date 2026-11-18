Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF3606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKCQqQfe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0497F10FF8A;
	Wed, 18 Nov 2026 19:05:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F9810FF8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:05:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22C5946F8E;
 Wed, 18 Nov 2026 19:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24191F000C4;
 Wed, 18 Nov 2026 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795028742;
 bh=8ozVze3lGkj7R7xvAVwMP9Sj09yKVk1PXT8EderpLbk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=oKCQqQfeOSxWfh7g8cij4IyJeqW+zrJnHreZJv9OK1cdZudkHyZb+TfK+VQYJZsd8
 APUr4CnsNvfXr8+QiFh+ElayTnqColGwJsGAKARWJ+LLI8a859Fh58xVQnP6iiA/ws
 L3r3lSCTlvYxkOCbxnUep0HLxNkwAmENFYpx1MuQ226/V1DlZ1dEjGoK+FJhq9A+ZC
 4m8FlDZ78dp7lPjUyCA7JN/uShbWiwgUdgG9vx89bGRTdjePFnZwEjxm3cDjWuzXo9
 3fC6qz+C+i2GbdNuM02Au1/e7MLZvndXezSMMmIJ8WC6sF+/LFkdHeYPlvL9iy9IIM
 CVFdehfBmhGjA==
Message-ID: <sashiko-outbox-221793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] drm/amdgpu/userq: remove extra fence request when
 locking PD
To: "Benjamin Cheng" <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118185225.1857845-6-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-6-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:05:41 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amdgpu: ignored WPTR mapping offsets in userqueue
  synchronization [1]
--

commit c736ecb92e4ba4e91728f33ea27cd11d90100ae5
Author: Benjamin Cheng <benjamin.cheng@amd.com>

drm/amdgpu/userq: remove extra fence request when locking PD

This commit changes amdgpu_vm_lock_pd() calls in
amdgpu_userq_fence_read_wptr() and mes_userq_create_wptr_mapping() to
request zero fence slots instead of one.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 6d1f5811d39c3..07a0af9feaf08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -380,7 +380,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu=
_device *adev,
> =20
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
>  	drm_exec_until_all_locked(&exec) {
> -		ret =3D amdgpu_vm_lock_pd(queue->vm, &exec, 1);
> +		ret =3D amdgpu_vm_lock_pd(queue->vm, &exec, 0);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto lock_error;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59a..8b07e21d26862 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -48,7 +48,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *ade=
v,
> =20
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
>  	drm_exec_until_all_locked(&exec) {
> -		ret =3D amdgpu_vm_lock_pd(vm, &exec, 1);
> +		ret =3D amdgpu_vm_lock_pd(vm, &exec, 0);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto fail_lock;

[Severity: High]
This problem wasn't introduced by this patch, but does
mes_userq_create_wptr_mapping() ignore the internal mapping and sub-page
offset when setting queue->wptr_obj.gpu_addr [1]?

drivers/gpu/drm/amd/amdgpu/mes_userqueue.c:mes_userq_create_wptr_mapping() {
    ...
	queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset(wptr_obj->obj);
    ...
}

When a usermode queue places its WPTR at a non-zero offset within the
backing BO, mes_userq_create_wptr_mapping() sets queue->wptr_obj.gpu_addr
to the base GPU offset of wptr_obj->obj without adding the mapping and
sub-page offsets (and if amdgpu_userq_fence_read_wptr() reads *ptr at
offset 0 directly, it misses the offset on the CPU side as well).  This
causes the firmware and CPU fence polling to read the wrong memory address,
leading to premature fence signaling or command submission deadlocks.

[1] https://sashiko.dev/#/bug/linux-485b27a5-4aad-464a-b5b7-ad02f7bafded

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118185225.1857=
845-1-benjamin.cheng@amd.com?part=3D5
