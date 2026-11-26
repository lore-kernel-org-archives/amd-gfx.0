Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADA606A32A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHnp+pY+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EA111227C;
	Thu, 26 Nov 2026 10:03:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A1A11227C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:03:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99E3340448;
 Thu, 26 Nov 2026 10:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C971F000F2;
 Thu, 26 Nov 2026 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795687385;
 bh=5E68ZrOmNazJrpjGR9haN/KsuFd6h2qzkqU5YOkZAjc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=PHnp+pY+qQjNTSFHDd2KCkGdfGGdP7SQLOhpoNmI+y8Y96sMb5QTGqfYQNJhR+78u
 LJzPqdz55kpBh11UoJgv87bkWoHoixBq+lozc94AHi4ROXQ2OiRG0svk5hqzQMrj0B
 Z+1ca3zC3V2NPBpw06wO/nt1PP78+ytFlgwkZUbzl96dcXK1YAOWcytRqdeLFJVZPJ
 owBhEXHiVABcJyoz8A/F3MQp3Wa6kTRCJ1hm3Y1tNGs5E44RXc31O4AuelDHk14Hu4
 G+9t7OdRXhK6aQYrHK0P49QUH7W0shHNOWB/amOpl4u0zBOj/I3+sYBw4eHeM7pbaW
 04v7z1kPeebuw==
Message-ID: <sashiko-outbox-235224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/15] drm/amdgpu/userq: add helpers to keep the user
 queues of one engine across a reset
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-8-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-8-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 10:03:04 +0000
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
- [High] drm/amdgpu/userq: unsynchronized xa_for_each() UAF and race in
  HQD helpers
--

commit f5832ab9e726e4c6325d50c80fa806f8412f97f7
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu/userq: add helpers to keep the user queues of one engine across =
a reset

This commit adds helpers to save, restore, and clear the HQDs of user
queues belonging to a single engine across a soft reset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ed6f3b67e8720..495198ba1b0b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1594,3 +1594,110 @@ int amdgpu_userq_post_reset(struct amdgpu_device =
*adev, bool vram_lost)
> =20
>  	return ret;
>  }
> +
> +/**
> + * amdgpu_userq_save_hqds - save the HQDs of the user queues before an e=
ngine reset
> + * @adev: amdgpu device
> + * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
> + */
> +void amdgpu_userq_save_hqds(struct amdgpu_device *adev, u32 queue_type)
> +{
> +	struct amdgpu_gfx_saved_hqd hqd;
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long queue_id;
> +
> +	adev->gfx.num_saved_gfx_hqds =3D 0;
> +	if (!adev->gfx.funcs->save_hqd)
> +		return;
> +
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		if (adev->gfx.num_saved_gfx_hqds >=3D AMDGPU_MAX_GFX_QUEUES)
> +			break;
> +		if (queue->queue_type !=3D queue_type ||
> +		    queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +			continue;
> +		if (adev->gfx.funcs->save_hqd(adev, queue->doorbell_index, &hqd) &&
> +		    hqd.on_hqd)
> +			adev->gfx.saved_gfx_hqds[adev->gfx.num_saved_gfx_hqds++] =3D hqd;
> +	}
> +}
> +
> +static struct amdgpu_gfx_saved_hqd *
> +amdgpu_userq_find_saved_hqd(struct amdgpu_device *adev,
> +			    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_gfx_saved_hqd *hqd;
> +	u32 i;
> +
> +	for (i =3D 0; i < adev->gfx.num_saved_gfx_hqds; i++) {
> +		hqd =3D &adev->gfx.saved_gfx_hqds[i];
> +		/* Check the MQD too: a new queue may reuse the doorbell. */
> +		if (hqd->doorbell_index =3D=3D queue->doorbell_index &&
> +		    hqd->mqd_addr =3D=3D queue->mqd.gpu_addr)
> +			return hqd;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * amdgpu_userq_restore_hqds - restore the user queues after an engine r=
eset
> + * @adev: amdgpu device
> + * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
> + * @guilty: the queue that hung, or NULL
> + *
> + * MES doesn't map a queue whose HQD the reset cleared again on its own:=
 unmap
> + * it from MES, restore its MQD, and map it again.
> + */
> +void amdgpu_userq_restore_hqds(struct amdgpu_device *adev, u32 queue_typ=
e,
> +			       struct amdgpu_usermode_queue *guilty)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs =3D adev->userq_funcs[queu=
e_type];
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_gfx_saved_hqd *hqd;
> +	unsigned long queue_id;
> +	int r;
> +
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		if (queue->queue_type !=3D queue_type ||
> +		    queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +			continue;
> +
> +		if (queue =3D=3D guilty) {
> +			userq_funcs->unmap(queue);
> +			amdgpu_userq_fence_driver_force_completion(queue);
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
> +			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +			continue;
> +		}
> +
> +		hqd =3D amdgpu_userq_find_saved_hqd(adev, queue);
> +		if (!hqd)
> +			continue;
> +
> +		userq_funcs->unmap(queue);
> +		if (adev->gfx.funcs->restore_hqd(adev, queue->mqd.cpu_ptr,
> +						 queue->userq_prop->queue_size,
> +						 hqd))
> +			amdgpu_userq_fence_driver_force_completion_with_seqno(queue,
> +									      hqd->wptr);
> +		r =3D userq_funcs->map(queue);

[Severity: High]
Can amdgpu_userq_save_hqds() and amdgpu_userq_restore_hqds() race with
amdgpu_userq_destroy() and cause a use-after-free on queue?

Unlike a full GPU reset, which holds down_write(&adev->reset_domain->sem),
an engine soft reset in amdgpu_device_ip_soft_reset() only acquires
down_read(&adev->reset_domain->sem).  amdgpu_userq_detach_doorbell() and
amdgpu_userq_unmap_helper() in the queue destruction path also only acquire
down_read(&adev->reset_domain->sem), so queue destruction is not blocked
while these helpers walk userq_doorbell_xa (as the comment in
amdgpu_userq_find_saved_hqd() also notes).  Because xa_for_each() releases
rcu_read_lock() before entering the loop body and nothing pins queue or
holds queue->userq_mgr->userq_mutex:

CPU0                                  CPU1
amdgpu_userq_restore_hqds()
  xa_for_each(..., queue)
                                      amdgpu_userq_destroy()
                                        amdgpu_userq_detach_doorbell(queue)
                                        ...
                                        uq_funcs->mqd_destroy(queue)
                                        kfree(queue)
    if (queue->queue_type !=3D ...)
    userq_funcs->unmap(queue)  <-- use-after-free

Even when the queue is not destroyed, iterating and calling
userq_funcs->unmap() and userq_funcs->map() without holding
queue->userq_mgr->userq_mutex races with concurrent eviction and restore
workers that also run under down_read(&adev->reset_domain->sem), which can
corrupt queue->state or double-unmap and double-free
queue->gang_ctx_array_index.  In addition, if a queue is destroyed and a
new queue is created between amdgpu_userq_save_hqds() and
amdgpu_userq_restore_hqds(), both the freed doorbell index and the freed
GTT MQD address (queue->mqd.gpu_addr) can be reallocated to the new queue,
causing amdgpu_userq_find_saved_hqd() to match and overwrite the new
queue's MQD with the old queue's saved HQD state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D8
