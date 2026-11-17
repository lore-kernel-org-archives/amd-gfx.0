Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428E606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrMJM9yl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4417B10F8F6;
	Tue, 17 Nov 2026 19:45:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C48F10F8F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:44:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D41CA41787;
 Tue, 17 Nov 2026 19:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1921F000C4;
 Tue, 17 Nov 2026 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944694;
 bh=D8yE91COtfLF5f7n4bZYegqd1OwKesGDgrDnCWjjlx8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=BrMJM9ylsat8ehq97gT0kInb9d16rRsKytkn25awGKoI9J/Fpa2dDon3nkFDbrgjF
 b0xx2xRNC1QRlj9jCrKoZuadG3F+0L0aQ+Xq2MlwgwjtbdlgzG2FiZ9lOKdTQppVcf
 AAz3ZM5X2oSFYs9iYGwrBUSDMES3l2FhPbfrTg7nA7kqyM+luSZKYPpl28lpQzvqhi
 JCbWMgd4vhWfiUwGh8VzCWbeJVX/r1IOJBjrRAJTQaIfQnq7tzCZ/+/pBncpmmFV/M
 6VlGVbPYlApZhKiikfN6YrbC0l/0X5YyoxfYGWDyOdJmt6YXJBRQvxeo1L7KI37a3w
 N/JaecEKeXh8w==
Message-ID: <sashiko-outbox-219520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] drm/amdgpu/userq: enable support for creating gangs
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117192415.810117-9-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
 <20261117192415.810117-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:44:54 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/amdgpu/userq: missing CREATE_GANG case in
  amdgpu_userq_input_args_validate()
- [High] drm/amdgpu/userq: kref leak on queues in
  amdgpu_userq_create_gang()
- [High] drm/amdgpu/userq: missing gang_secondary teardown in
  amdgpu_userq_destroy()
- [High] drm/amdgpu/userq: out-of-bounds gang_context_addr offset in
  mes_set_gang()
- [Medium] drm/amdgpu/userq: self-ganging allowed in
  amdgpu_userq_create_gang()
- [Medium] drm/amdgpu/userq: unrolled gang state on set_gang() failure
- [Medium] drm/amdgpu/userq: set_gang() called without checking queue
  state or reset_domain
- [Medium] drm/amdgpu/userq: set_gang() skipped when secondary queue is
  mapped/restored first
--

commit 41bbabcb54c434e03323740262dcec73dc8bedd4
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq: enable support for creating gangs

This commit adds the AMDGPU_USERQ_OP_CREATE_GANG ioctl operation and
amdgpu_userq_create_gang() to link a primary and secondary usermode queue
into a gang.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index e41f0e10c8a36..61416518fd702 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -896,6 +896,67 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
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
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	primary_queue =3D amdgpu_userq_get(uq_mgr, primary_queue_id);
> +	if (!primary_queue) {
> +		dev_err(adev->dev, "Invalid gang primary queue id\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +	if ((primary_queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
> +	    (primary_queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE) &&
> +	    (primary_queue->queue_type !=3D AMDGPU_HW_IP_DMA)) {
> +		dev_err(adev->dev, "Invalid gang primary queue type\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +	if (primary_queue->in_gang) {
> +		dev_err(adev->dev, "Primary queue already in a gang\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +	secondary_queue =3D amdgpu_userq_get(uq_mgr, secondary_queue_id);
> +	if (!secondary_queue) {
> +		dev_err(adev->dev, "Invalid gang secondary queue id\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +	if ((secondary_queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
> +	    (secondary_queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE) &&
> +	    (secondary_queue->queue_type !=3D AMDGPU_HW_IP_DMA)) {
> +		dev_err(adev->dev, "Invalid gang secondary queue type\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +	if (secondary_queue->in_gang) {
> +		dev_err(adev->dev, "Secondary queue already in a gang\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Can userspace pass primary_queue_id =3D=3D secondary_queue_id to gang a que=
ue
with itself?  primary_queue->in_gang is still false when
secondary_queue->in_gang is checked, so both lookups return the same queue
and pass validation, setting primary_queue->gang_secondary to itself and
passing identical primary and secondary gang context addresses to MES.

> +
> +	primary_queue->gang_primary =3D true;
> +	primary_queue->in_gang =3D true;
> +	primary_queue->gang_secondary =3D secondary_queue;

[Severity: High]
What happens to primary_queue->gang_secondary when a ganged queue is freed
in amdgpu_userq_destroy()?

amdgpu_userq_preempt_helper(), amdgpu_userq_restore_helper(),
amdgpu_userq_unmap_helper(), and amdgpu_userq_map_helper() all dereference
queue->gang_secondary whenever queue->gang_primary is set, but
amdgpu_userq_destroy() neither clears primary_queue->gang_secondary when
secondary_queue is destroyed nor releases a reference on
queue->gang_secondary when primary_queue is destroyed.  If gang_secondary
does not hold a kref on secondary_queue, freeing secondary_queue via
AMDGPU_USERQ_OP_FREE leaves primary_queue->gang_secondary as a dangling
pointer that is dereferenced on the next unmap, preempt, restore, or
destroy of primary_queue; if it does hold a kref, destroying primary_queue
leaks secondary_queue and leaves it in adev->userq_doorbell_xa after file
close.

> +	secondary_queue->in_gang =3D true;
> +	userq_funcs =3D adev->userq_funcs[primary_queue->queue_type];
> +	r =3D userq_funcs->set_gang(primary_queue, secondary_queue);

[Severity: High]
Does userq_funcs->set_gang() pass out-of-bounds gang context addresses to
MES?

drivers/gpu/drm/amd/amdgpu/mes_userqueue.c:mes_set_gang() {
	...
	input.primary_gang_context_addr =3D
		primary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
	input.secondary_gang_context_addr =3D
		secondary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
	...
}

Since 97bcaf15ad25 ("drm/amdgpu: implement per-process MES context"),
mes_userq_create_ctx_space() allocates each queue's fw_obj with size
AMDGPU_USERQ_GANG_CTX_SZ (one page), and mes_userq_map() sets
gang_context_addr to ctx->gpu_addr.  Adding AMDGPU_USERQ_PROC_CTX_SZ points
one page past the end of each 1-page fw_obj BO and does not match the
gang_context_addr registered with MES.

[Severity: Medium]
Should amdgpu_userq_create_gang() hold adev->reset_domain->sem and verify
that both queues are in AMDGPU_USERQ_STATE_MAPPED before calling
userq_funcs->set_gang()?  Unlike amdgpu_userq_map_helper() and
amdgpu_userq_unmap_helper(), this calls into MES without locking
reset_domain->sem and even when either queue is unmapped (for example,
while adev->userq_halt_for_enforce_isolation is set or while queues are
evicted), preempted, or hung.

[Severity: Medium]
Can gang scheduling also be lost when queues are remapped or restored after
eviction, suspend/resume, or reset?

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_map_helper() {
	...
	if (secondary_queue &&
	    secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
		...
			secondary_queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
			r =3D userq_funcs->set_gang(queue, secondary_queue);
		}
	}
}

amdgpu_userq_restore_all(), amdgpu_userq_resume(), and
amdgpu_userq_start_sched_for_enforce_isolation() iterate queues in
ascending xarray index order via xa_for_each().  Whenever secondary_queue
has a lower queue_id or doorbell_index than primary_queue, it is mapped or
restored first, so secondary_queue->state is already
AMDGPU_USERQ_STATE_MAPPED when primary_queue is processed and
userq_funcs->set_gang() is skipped in both amdgpu_userq_map_helper() and
amdgpu_userq_restore_helper().  In addition, amdgpu_userq_post_reset()
remaps hung queues via userq_funcs->map() directly without calling
set_gang().

[Severity: Medium]
If userq_funcs->set_gang() fails here, should gang_primary, in_gang, and
gang_secondary be rolled back on primary_queue and secondary_queue?
Leaving them set marks both queues as ganged even though the MES gang setup
failed, causing subsequent map, unmap, preempt, and restore helpers to
treat the failed gang as active and preventing userspace from retrying.

> +	mutex_unlock(&uq_mgr->userq_mutex);
> +
> +	return r;
> +}

[Severity: High]
Does amdgpu_userq_create_gang() leak the kref references acquired by
amdgpu_userq_get() on primary_queue and secondary_queue?

Neither the validation error returns nor the exit path calls
amdgpu_userq_put() on primary_queue or secondary_queue, so their refcounts
never drop to zero in AMDGPU_USERQ_OP_FREE or amdgpu_userq_mgr_fini().
That leaks both queues and their BOs, and leaves them registered in
adev->userq_doorbell_xa with dangling pointers to fpriv after file close.
Note that amdgpu_userq_put() will need to be called after dropping
uq_mgr->userq_mutex because amdgpu_userq_destroy() acquires
uq_mgr->userq_mutex.

> @@ -1016,7 +1077,13 @@ int amdgpu_userq_ioctl(struct drm_device *dev, voi=
d *data,
>  		amdgpu_userq_put(queue);
>  		break;
>  	}
> -
> +	case AMDGPU_USERQ_OP_CREATE_GANG:
> +		if (args->in_cg.pad)
> +			return -EINVAL;
> +		r =3D amdgpu_userq_create_gang(filp, args);
> +		if (r)
> +			drm_file_err(filp, "Failed to create usermode queue gang\n");
> +		break;
>  	default:
>  		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.=
op);
>  		return -EINVAL;

[Severity: High]
Is this AMDGPU_USERQ_OP_CREATE_GANG case reachable?  amdgpu_userq_ioctl()
calls amdgpu_userq_input_args_validate() before switching on args->in.op,
and amdgpu_userq_input_args_validate() only handles AMDGPU_USERQ_OP_CREATE
and AMDGPU_USERQ_OP_FREE, returning -EINVAL in its default branch for every
AMDGPU_USERQ_OP_CREATE_GANG call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117192415.8101=
17-1-alexander.deucher@amd.com?part=3D9
