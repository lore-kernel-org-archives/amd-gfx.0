Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF031606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtwDr6+3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEAB910E57F;
	Tue, 17 Nov 2026 07:41:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F88C10E57F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:41:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E5E2541361;
 Tue, 17 Nov 2026 07:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25371F000C4;
 Tue, 17 Nov 2026 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794901295;
 bh=6Eek1tPob0qunWnSeDxR5w9fNcdUas/iQpLYLpeBHxU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=MtwDr6+3H7/anTWdBhqHeEMJ9tJI9OVNn/FOPWEvygiAYWiSimo//OXlTPnopHMP/
 RzhOYy0IB28awwQ2cTouN2fa4FNJgHhYyeG7+bmKL16/46BN5w3G63H80KC7qUhSrZ
 oXP4C9CH992Xeep+fHNcsWcrae8pnMl1hXrG5VJ84AxguqKmimvoINWLV7Zh5G0VX6
 sc+fgeSXmvGbaZNBb31sp8OCDrHXtm+hMXa9CeWqkv3HhAMoZFdY0ImKOS165vyMf/
 oKeuGt2OsXYHPal31ilVY2jD99kmydu4aIBkVAuTDobwQNeLr1iT71mQ/E1YukHWsS
 WYbvzClMZW7kw==
Message-ID: <sashiko-outbox-218372@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 2/4] drm/amdgpu/userq: implement support for
 query status
To: "Prike Liang" <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117072353.537506-2-Prike.Liang@amd.com>
References: <20261117072353.537506-1-Prike.Liang@amd.com>
 <20261117072353.537506-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:41:35 +0000
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
- [High] drm/amdgpu/userq: unlocked queue state and unmap/map in
  mes_userq_reset() [1]
--

commit 8f1348ec761b7ada9e6ca46fe71c338002a3662a
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq: implement support for query status

This commit implements the AMDGPU_USERQ_OP_QUERY_STATUS operation to report
when a usermode queue is hung or its VM generation has changed due to lost
VRAM.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ed6f3b67e8720..496137fca1f0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
[ ... ]
> @@ -817,6 +818,33 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>  	return r;
>  }
> =20
> +static int
> +amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq =
*args)
> +{
> +	struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +	struct amdgpu_device *adev =3D uq_mgr->adev;
> +	struct amdgpu_usermode_queue *queue;
> +	int queue_id =3D args->in.queue_id;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	queue =3D amdgpu_userq_get(uq_mgr, queue_id);
> +	if (!queue) {
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +
> +	args->out_qs.flags =3D 0;
> +	if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG ||
> +	    queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm))
> +		args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;

[Severity: High]
This problem wasn't introduced by this patch, but can a concurrent eviction
in amdgpu_userq_unmap_helper() race with mes_userq_reset_hw() [1] and
overwrite AMDGPU_USERQ_STATE_HUNG?

amdgpu_userq_query_status() and amdgpu_userq_unmap_helper() serialize
queue->state under uq_mgr->userq_mutex, whereas mes_userq_reset_hw() unmaps
the queue and sets queue->state =3D AMDGPU_USERQ_STATE_HUNG without holding
userq_mutex:

CPU0                                  CPU1
amdgpu_userq_hang_detect_work()       amdgpu_eviction_fence_suspend_worker()
  mes_userq_reset()                     mutex_lock(&uq_mgr->userq_mutex)
    mes_userq_reset_hw()                amdgpu_userq_evict_all()
      mes_userq_unmap(queue)              amdgpu_userq_unmap_helper(queue)
                                            // sees AMDGPU_USERQ_STATE_MAPP=
ED
                                            mes_userq_unmap(queue)
      queue->state =3D
        AMDGPU_USERQ_STATE_HUNG
                                            queue->state =3D
                                              AMDGPU_USERQ_STATE_UNMAPPED
                                              <-- clobbers HUNG state
                                        mutex_unlock(&uq_mgr->userq_mutex)

Both paths call mes_userq_unmap() concurrently, issuing duplicate
remove_hw_queue MES packets and double-freeing queue->gang_ctx_array_index.
Overwriting AMDGPU_USERQ_STATE_HUNG with AMDGPU_USERQ_STATE_UNMAPPED also
hides the broken status from amdgpu_userq_query_status() and allows
amdgpu_userq_restore_worker() to remap and re-execute the hung queue.

[1] https://sashiko.dev/#/bug/linux-ea51473b-6c36-421a-880f-c4fff09847a7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117072353.5375=
06-1-Prike.Liang@amd.com?part=3D2
