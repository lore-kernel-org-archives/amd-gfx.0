Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24346606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3CW4AIl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9971F10E648;
	Tue, 24 Nov 2026 16:42:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F49810E648
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:42:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4957A4117F;
 Tue, 24 Nov 2026 16:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB2B1F000C4;
 Tue, 24 Nov 2026 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795538556;
 bh=8a2CVi65ofzBOKH2mJaZbOSlLAqel/UjfYCZwoJ5iZA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=c3CW4AIlEyBV0FAWvDnAtKQCxJzD1mnqtJBEGEeGDDn2SGpG+IFrs+2VxwOd0U9VY
 0GxGeuddHc171eXg5eRy1BaIEvbxuYKcf4PCwVYIllXLouCGQPNpSriXp80QQDFFLz
 hNzvbnU+OFyUWTYR/5hJnboA53b6cBWD1NNj+O3HksdIYoGeC8Gqm304x0R2a8CnGF
 5uIbjtjIQeyD94G14mtDTR9RbyDhTxRwyoI9Ldtmk5jauniSwCFpxC1YPgfBD1J9yK
 G0os6NydEddM/gsokCxgoL7A8HMvDWKEAyr3L5q2mbhuVFfPXbebUO1NsW58O9B55S
 x97pwk9syXlYQ==
Message-ID: <sashiko-outbox-231581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/9] drm/amdkfd: apply queue property updates only
 after unmap
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-8-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-8-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:42:35 +0000
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
- [High] drm/amdkfd: race on q->pending_props between update_queue and
  set_perfcount
- [Medium] drm/amdkfd: update_queue_locked() mutates MQD while active
  queue is in MES
- [Medium] drm/amdkfd: update_queue_locked() drops update with 0 return
  on stopped NO_HWS
--

commit 04bc122a04713e23b8e6ce8e16afe2c0ab475963
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: apply queue property updates only after unmap

This commit defers applying new queue properties and swapping the ring
buffer BO reference until update_queue_mqd() runs after unmapping the
queue.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index dbbc6c0794ed3..1c348f36cd3c3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1325,6 +1325,22 @@ static void update_queue_mqd(struct device_queue_m=
anager *dqm, struct queue *q,
>  		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>  	bool prev_active =3D q->properties.is_active;
> =20
> +	/*
> +	 * The queue is off the hardware now. Only from here on may its
> +	 * properties change, otherwise a failed unmap would leave the
> +	 * scheduler running the old ring under the new description.
> +	 */
> +	if (q->pending_props) {
> +		const struct queue_properties *np =3D q->pending_props;
> +
> +		q->properties.queue_address =3D np->queue_address;
> +		q->properties.queue_size =3D np->queue_size;
> +		q->properties.queue_percent =3D np->queue_percent;
> +		q->properties.priority =3D np->priority;
> +		q->properties.pm4_target_xcc =3D np->pm4_target_xcc;
> +		q->pending_props =3D NULL;
> +	}
> +
>  	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
> =20
>  	/*

[Severity: Medium]
Can update_queue_mqd() still overwrite q->properties and q->mqd while an
active queue remains in MES?

In update_queue_locked(), the kfd_mes_queue_retired(dqm, q) check only
runs when !prev_active.  When prev_active is true and the scheduler is
halted or stopped (!dqm->sched_running || dqm->sched_halt),
remove_queue_mes() -> remove_queue_mes_on_reset_option() returns 0
without sending REMOVE_QUEUE to MES.  If halt_cpsch() or stop_cpsch()
left the queue unretired in MES, update_queue_locked() proceeds to
update_queue_mqd(), clears q->pending_props, and lets
pqm_update_queue_properties() drop the unmap protection and BO reference
on old_ring_bo while MES still holds the queue.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 29827a736f7d4..a7070e87305b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -644,60 +644,73 @@ int pqm_update_queue_properties(struct process_queu=
e_manager *pqm, unsigned int qid)
>  int pqm_update_queue_properties(struct process_queue_manager *pqm,
>  				unsigned int qid, struct queue_properties *p)
>  {

[ ... ]

> +	/*
> +	 * The dqm applies the new properties once the queue is unmapped. If
> +	 * it fails before that, the queue still runs on the old ring and
> +	 * keeps its old properties.
> +	 */
> +	q->pending_props =3D p;
> +	retval =3D q->device->dqm->ops.update_queue(q->device->dqm, q, NULL);
> +
> +	if (q->pending_props) {
> +		/* Not applied. Drop the reference on the new ring. */
> +		q->pending_props =3D NULL;
> +		old_ring_bo =3D new_ring_bo;
> +	} else if (new_ring_bo) {
> +		old_ring_bo =3D q->properties.ring_bo;
> +		q->properties.ring_bo =3D new_ring_bo;
> +	} else {
> +		old_ring_bo =3D NULL;
> +	}
> =20
> -	retval =3D pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q, NULL);
> -	if (retval !=3D 0)
> -		return retval;
> +	/* There is an old ring to drop only if a new one was looked up */
> +	if (old_ring_bo) {
> +		if (!amdgpu_bo_reserve(vm->root.bo, true)) {
> +			kfd_queue_unref_bo_va(vm, &old_ring_bo);
> +			amdgpu_bo_unreserve(vm->root.bo);
> +		}
> +		kfd_queue_buffer_put(&old_ring_bo);
> +	}
> =20
> -	return 0;
> +	return retval;
>  }

[Severity: High]
Can set_perfcount() race with pqm_update_queue_properties() on
q->pending_props and cause a stack use-after-return or map a queue with
an unreferenced ring buffer?

kfd_ioctl_update_queue() allocates struct queue_properties on its stack
and calls pqm_update_queue_properties() under p->mutex.  However,
q->pending_props is written before update_queue() acquires dqm_lock(dqm)
and tested/cleared after update_queue() releases dqm_lock(dqm).
Meanwhile, set_perfcount() iterates over all queues under dqm_lock(dqm)
without holding p->mutex and calls update_queue_mqd(), which
unconditionally consumes q->pending_props even when minfo !=3D NULL:

CPU0                                   CPU1
kfd_ioctl_update_queue()
  lock(&p->mutex)
  pqm_update_queue_properties(..., &props)
    q->pending_props =3D &props
    update_queue()
      dqm_lock(dqm)
      /* fails before update_queue_mqd() */
      dqm_unlock(dqm)
                                       set_perfcount()
                                         dqm_lock(dqm)
                                         update_queue_mqd()
                                           np =3D q->pending_props
    if (q->pending_props)
      q->pending_props =3D NULL
      /* drops new_ring_bo ref */
  unlock(&p->mutex)
  return; /* pops props off stack */
                                           q->properties.queue_address =3D
                                             np->queue_address
                                             <-- stack use-after-return

If CPU1 clears q->pending_props before CPU0 checks it, CPU0 also sees
q->pending_props =3D=3D NULL after a failed update_queue(), swaps in
new_ring_bo, drops old_ring_bo, and returns the error to userspace.  Or
if set_perfcount() runs after q->pending_props =3D p and before
update_queue() takes dqm_lock(dqm), set_perfcount() consumes
q->pending_props early; under KFD_SCHED_POLICY_NO_HWS, if that update
activates the queue from another process context, update_queue_locked()
triggers WARN(q->process->mm !=3D current->mm) and skips load_mqd() while
leaving q->properties.is_active true.

Only consuming q->pending_props when update_queue_mqd() is called for a
property update (minfo =3D=3D NULL), or setting and clearing
q->pending_props strictly under dqm_lock(dqm), would avoid this race.

[Severity: Medium]
Under KFD_SCHED_POLICY_NO_HWS, does updating an active queue while
!dqm->sched_running now silently discard the new properties while
returning 0?

In update_queue_locked(), the NO_HWS branch checks !dqm->sched_running
when prev_active is true and returns retval (which is 0) before calling
update_queue_mqd():

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:update_queue_locked()=
 {
	...
	} else if (prev_active &&
		   (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE ||
		    q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
		    q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)) {

		if (!dqm->sched_running) {
			WARN_ONCE(1, "Update non-HWS queue while stopped\n");
			return retval;
		}
	...
}

Because update_queue_mqd() is not reached, q->pending_props remains
non-NULL, so pqm_update_queue_properties() drops the reference on
new_ring_bo, leaves q->properties unchanged, and returns 0 to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D7
