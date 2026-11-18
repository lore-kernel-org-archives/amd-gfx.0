Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084C606A330
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzZDwwFi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A31B1120AE;
	Wed, 18 Nov 2026 22:58:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F351120AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:58:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19F6F40540;
 Wed, 18 Nov 2026 22:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D591F000C4;
 Wed, 18 Nov 2026 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795042705;
 bh=T8Z+zGJTzOKopdLbTHcWVO0yOoKL5QjfhFktvgS0pRE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=VzZDwwFizMwfrQfsA2DqDP/bz2qqkSF7br6KUtkdzJxRckTk17jUw3g2QWKltHVBb
 bcUIJBOAslC1VrqMc+bdVYSaNNTJlgZpquPEzwHOZCnjOgy4VO++aWMi94ShPWeKRM
 k0FtTX/6Lex/r14yw3js9Wc4PUyEFVytXOQnIRy01ImTMwjzDlnAlDbhpJqp8WrHGQ
 9xgFf6O0djDcMyg/IgRPg2cRzkigskujRdH3Tq/7iiwQtOQ/0BEOli5juFMlfdzKbo
 CztdrIFrsF1wa7Eki14sGIbYXzdcwkwi1k2+YldsQ7pIXfdHoEfHaVftFNcQX8y6MP
 rCnHnTv/clZzQ==
Message-ID: <sashiko-outbox-222136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] drm/amdgpu/userq: enable support for creating gangs
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118223712.2518580-10-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
 <20261118223712.2518580-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:58:24 +0000
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
- [High] drm/amdgpu/userq: lock order inversion in
  amdgpu_userq_create_gang()
- [High] drm/amdgpu/userq: race between amdgpu_userq_destroy() and
  post_reset()
- [Medium] drm/amdgpu/userq: missing INVALID_VA check in
  amdgpu_userq_create_gang()
--

commit 8106c51d4a0229062b3c666f8f9004011c7d6501
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq: enable support for creating gangs

This commit adds the AMDGPU_USERQ_OP_CREATE_GANG ioctl operation to link
primary and secondary usermode queues into a gang and cleans up the gang
links when a queue is destroyed.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 3afd17af28548..388385380d8bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -566,6 +566,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr,=
 struct amdgpu_usermode_que
>  {
>  	struct amdgpu_device *adev =3D uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[queue->=
queue_type];
> +	struct amdgpu_usermode_queue *other_gang_queue;
>  	int r =3D 0;
> =20
>  	trace_amdgpu_userq_destroy_start(queue);
> @@ -585,6 +586,17 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr=
, struct amdgpu_usermode_que
>  	debugfs_remove_recursive(queue->debugfs_queue);
>  #endif
>  	r =3D amdgpu_userq_unmap_helper(queue);
> +	/* clean up gangs */
> +	if (queue->gang_primary) {
> +		other_gang_queue =3D queue->gang_primary;
> +		other_gang_queue->gang_secondary =3D NULL;
> +		queue->gang_primary =3D NULL;
> +	}
> +	if (queue->gang_secondary) {
> +		other_gang_queue =3D queue->gang_secondary;
> +		other_gang_queue->gang_primary =3D NULL;
> +		queue->gang_secondary =3D NULL;
> +	}
>  	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  	amdgpu_userq_fence_driver_free(queue);
>  	queue->fence_drv =3D NULL;

[Severity: High]
Can amdgpu_userq_destroy() race with amdgpu_userq_post_reset() on the
partner queue's gang_secondary pointer and cause a use-after-free?

amdgpu_userq_destroy() holds uq_mgr->userq_mutex, while
amdgpu_userq_detach_doorbell() and amdgpu_userq_unmap_helper() each take
and release adev->reset_domain->sem individually.  During a GPU reset,
amdgpu_userq_post_reset() iterates adev->userq_doorbell_xa under
down_write(&adev->reset_domain->sem) without taking uq_mgr->userq_mutex:

CPU0                                  CPU1 (GPU reset)
amdgpu_userq_destroy(secondary)
  mutex_lock(&uq_mgr->userq_mutex)
  amdgpu_userq_detach_doorbell()
  amdgpu_userq_unmap_helper()
    /* releases reset_domain->sem */
                                      down_write(&adev->reset_domain->sem)
                                      amdgpu_userq_post_reset()
                                        amdgpu_userq_set_gang_helper(primar=
y)
                                          sec =3D primary->gang_secondary
  primary->gang_secondary =3D NULL
  mutex_unlock(&uq_mgr->userq_mutex)
  uq_funcs->mqd_destroy(secondary)
  kfree(secondary)
                                          if (sec->state =3D=3D ...)
                                            <-- use-after-free

In addition, if the reset begins between amdgpu_userq_detach_doorbell()
and amdgpu_userq_unmap_helper(), secondary is already erased from
adev->userq_doorbell_xa while still in AMDGPU_USERQ_STATE_MAPPED, and
amdgpu_userq_destroy() blocks on reset_domain->sem inside
amdgpu_userq_unmap_helper() before clearing primary->gang_secondary.
amdgpu_userq_post_reset() then remaps primary and calls
userq_funcs->set_gang(primary, secondary) on a secondary queue that was
never remapped after the reset and is about to be destroyed.

> @@ -838,6 +850,106 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
>  	return r;
>  }
> =20
> +static int
> +amdgpu_userq_create_gang(struct drm_file *filp, union drm_amdgpu_userq *=
args)
> +{
> +	struct amdgpu_usermode_queue *primary_queue, *secondary_queue;
> +	struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_device *adev =3D uq_mgr->adev;
> +	int primary_queue_id =3D args->in_cg.primary_queue_id;
> +	int secondary_queue_id =3D args->in_cg.secondary_queue_id;
> +	int r;
> +
> +	/* The reset changes the queue state and the MES is unusable meanwhile =
*/
> +	guard(rwsem_read)(&adev->reset_domain->sem);
> +
> +	mutex_lock(&uq_mgr->userq_mutex);

[Severity: High]
Does taking adev->reset_domain->sem before uq_mgr->userq_mutex invert the
lock hierarchy and risk an ABBA deadlock?

amdgpu_lockdep_init() and the rest of amdgpu_userq.c establish
uq_mgr->userq_mutex outer to adev->reset_domain->sem:

CPU0                              CPU1
----                              ----
lock(&uq_mgr->userq_mutex)
                                  down_read(&adev->reset_domain->sem)
down_read(&adev->reset_domain->sem)
                                  lock(&uq_mgr->userq_mutex)

 *** DEADLOCK ***

CPU0: amdgpu_userq_destroy() -> amdgpu_userq_unmap_helper()
CPU1: amdgpu_userq_create_gang()
(when a GPU reset writer is queued on adev->reset_domain->sem)

Also, because guard(rwsem_read)(&adev->reset_domain->sem) has function
scope, it is still held at the out label when amdgpu_userq_put() runs.
If a concurrent AMDGPU_USERQ_OP_FREE dropped the queue's base reference,
amdgpu_userq_put() enters amdgpu_userq_destroy() while holding
reset_domain->sem, waiting on cancel_delayed_work_sync() under the reset
semaphore and taking reset_domain->sem recursively in
amdgpu_userq_detach_doorbell() and amdgpu_userq_unmap_helper().

[ ... ]

> +	if (primary_queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG) {
> +		drm_file_err(uq_mgr->file, "Primary queue is hung\n");
> +		r =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if ((secondary_queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
> +	    (secondary_queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE) &&
> +	    (secondary_queue->queue_type !=3D AMDGPU_HW_IP_DMA)) {
> +		drm_file_err(uq_mgr->file, "Invalid gang secondary queue type\n");
> +		r =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (secondary_queue->gang_primary || secondary_queue->gang_secondary) {
> +		drm_file_err(uq_mgr->file, "Secondary queue already in a gang\n");
> +		r =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG) {
> +		drm_file_err(uq_mgr->file, "Secondary queue is hung\n");
> +		r =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	userq_funcs =3D adev->userq_funcs[primary_queue->queue_type];
> +	if ((primary_queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +	     primary_queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) &&
> +	    (secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +	     secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED))
> +		r =3D userq_funcs->set_gang(primary_queue, secondary_queue);
> +	else
> +		/* if the queues are currently unmapped, the gang state will get
> +		 * updated when they get mapped.
> +		 */
> +		r =3D 0;

[Severity: Medium]
Should amdgpu_userq_create_gang() also reject queues in
AMDGPU_USERQ_STATE_INVALID_VA?

If a queue was marked AMDGPU_USERQ_STATE_INVALID_VA in
amdgpu_userq_restore_all(), amdgpu_userq_map_helper() will never remap it
(it only maps queues in AMDGPU_USERQ_STATE_UNMAPPED).  Here it passes the
HUNG checks and falls into the else branch with r =3D 0, linking a dead
queue into the partner queue's gang pointer without ever programming the
gang in MES.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223712.2518=
580-1-alexander.deucher@amd.com?part=3D10
