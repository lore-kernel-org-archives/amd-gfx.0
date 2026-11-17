Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF43B606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFNMXJmN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7176310E1DE;
	Tue, 17 Nov 2026 07:42:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C51E10E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:42:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CFC346257;
 Tue, 17 Nov 2026 07:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE551F000C4;
 Tue, 17 Nov 2026 07:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794901347;
 bh=LGLHO6FaLjt3WVsLSrKJO9h5JwwQHziNseIKp2CD1i4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=fFNMXJmNyZEjyxpxUOSY+ZRK9j3Ma0/Ov4cHTnRLhVGhO8WeI9wRVRwuM7COoujkm
 toffb89U61CnyVAmBDZ9VWBJyGQeMKSxLIzN+ADCkyk8y5TdPVb3Dw20g6JTrMGLbU
 Iuwkhswq3cH44liqr8b+BDhYNDoVhLjBcOau5Z2Q/p9fZF257KBAePg6ex7uvUx0C1
 CyqDEmnT/0hb4dmklrA75dQ8w4bq5fw3N44vp47nefKvnsnPHtjuFpxiGkTw6z+ea4
 8Ye33DX21ZadxIrZatdLzf6q/2XdkSl3/pnmtITOAQFTen40+EA0CuzDoO/w9ld5qN
 auY5Ds7PYg5IA==
Message-ID: <sashiko-outbox-218374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 3/4] drm/amdgpu/userq: report invalid VA through
 the broken status flag
To: "Prike Liang" <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117072353.537506-3-Prike.Liang@amd.com>
References: <20261117072353.537506-1-Prike.Liang@amd.com>
 <20261117072353.537506-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:42:26 +0000
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
- [Medium] drm/amdgpu/userq: missing resume_work flush in
  amdgpu_userq_query_status()
--

commit dcee7ab7a079dac06e55c3b0a31589e130baf8e9
Author: Prike Liang <Prike.Liang@amd.com>

drm/amdgpu/userq: report invalid VA through the broken status flag

This commit sets AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN in
amdgpu_userq_query_status() when a usermode queue is in
AMDGPU_USERQ_STATE_INVALID_VA, and updates the UAPI comment in
amdgpu_drm.h.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 496137fca1f0c..b48cf2a2118c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -837,6 +837,7 @@ amdgpu_userq_query_status(struct drm_file *filp, unio=
n drm_amdgpu_userq *args)
> =20
>  	args->out_qs.flags =3D 0;
>  	if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG ||
> +	    queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA ||
>  	    queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm))
>  		args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
>  	amdgpu_userq_put(queue);

[Severity: Medium]
Can amdgpu_userq_query_status() miss AMDGPU_USERQ_STATE_INVALID_VA when
called before uq_mgr->resume_work finishes?

The only place that sets queue->state to AMDGPU_USERQ_STATE_INVALID_VA is
amdgpu_userq_restore_all(), which runs asynchronously from
uq_mgr->resume_work:

CPU0                                  kworker
amdgpu_gem_va_ioctl(UNMAP)
  amdgpu_userq_gem_va_unmap_validate()
    dma_resv_wait_timeout()
                                      amdgpu_eviction_fence_suspend_worker()
                                        amdgpu_userq_evict()
                                          queue->state =3D
                                            AMDGPU_USERQ_STATE_UNMAPPED
                                        dma_fence_signal(ev_fence)
                                        schedule_delayed_work(
                                          &uq_mgr->resume_work, 0)
  drm_exec_fini()
amdgpu_userq_query_status()
  mutex_lock(&uq_mgr->userq_mutex)
  queue->state =3D=3D
    AMDGPU_USERQ_STATE_UNMAPPED  <-- BROKEN not set
  mutex_unlock(&uq_mgr->userq_mutex)
                                      amdgpu_userq_restore_worker()
                                        ...
                                        amdgpu_userq_restore_all()
                                          queue->state =3D
                                            AMDGPU_USERQ_STATE_INVALID_VA

Because amdgpu_gem_va_ioctl() holds the VM reservation lock until
drm_exec_fini() just before returning to userspace, uq_mgr->resume_work
cannot finish validating the VM and calling amdgpu_userq_restore_all()
before the unmap ioctl returns.  Unlike amdgpu_userq_ensure_ev_fence(),
amdgpu_userq_query_status() does not call
flush_delayed_work(&uq_mgr->resume_work) before acquiring
uq_mgr->userq_mutex, so querying queue status after unmapping a queue VA
reports flags as 0 instead of AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN.

Also, if a queue VA mapping is removed via AMDGPU_VA_OP_CLEAR or
AMDGPU_VA_OP_REPLACE (amdgpu_vm_bo_clear_mappings()),
amdgpu_userq_gem_va_unmap_validate() is never called to trigger eviction and
transition the queue to AMDGPU_USERQ_STATE_INVALID_VA.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117072353.5375=
06-1-Prike.Liang@amd.com?part=3D3
