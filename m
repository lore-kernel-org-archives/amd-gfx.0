Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F6606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWtzwJjv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1035610F7A4;
	Tue, 24 Nov 2026 16:29:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B24C10F771
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:29:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F66162376;
 Tue, 24 Nov 2026 16:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52D51F000D1;
 Tue, 24 Nov 2026 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537764;
 bh=wJJduHGYYqeij2RWJ+BJglEG8ikqd76fGZ/s9UwmglY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=GWtzwJjvkk08NNd/aRfJsAZEnO1HHjMGcLVl4hBQLBV45IM95XfOZLxr9FZULLc1q
 Bh4wsnoQF75qhk4KiKJHJh4z6nspI1PP6mjy9p21qS/wI1kShZBPETW9sfcZ/3lJsF
 7S5d5jQIE31uO7z3f/xFvkWq7TxzGFUBndtJBebB8eW09FN4T06LL+lBpBaBoXo0wA
 NHXcg9ypQAYgWHIB7yREaezMfjdzhop82CMJK3RttJscQ4VzokKzXM2jEUS6mzIETN
 vvdNMfiUwfcDYPKe6SoWjD+dmauXPEs+F9WQkmSpCwQXsKy641nJmpRADIhzBFlIqt
 jOa8GQ3x+Gziw==
Message-ID: <sashiko-outbox-231569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/9] drm/amdkfd: keep queue storage until MES
 confirmed retirement
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-6-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-6-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:29:23 +0000
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
- [Medium] drm/amdkfd: active queue count underflow on reset of
  quarantined queue
- [Medium] drm/amdkfd: bo_va->queue_refcount race and imbalance in
  pqm_destroy_queue()
- [Medium] drm/amdkfd: premature release of user queue buffers when
  create_queue_cpsch() quarantines queue
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/amdkfd: broken queue state and count in
  kfd_dqm_suspend_bad_queue_mes() [1]
--

commit 848d4620ce3c40efb53d488158a7d0f3fddf5733
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: keep queue storage until MES confirmed retirement

This commit quarantines queues whose retirement has not been confirmed by
MES across queue creation failure, queue destruction, and process
termination so their MQDs, doorbell IDs, SDMA IDs, and buffers are not
reused while MES may still access them.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2f57cb06f540f..0d40053b34c88 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
[ ... ]
> @@ -2877,6 +2878,16 @@ static int create_queue_cpsch(struct device_queue_=
manager *dqm, struct queue *q,
>  	list_del(&q->list);
>  	if (q->properties.is_active)
>  		decrement_queue_count(dqm, qpd, q);
> +	if (!kfd_mes_queue_retired(dqm, q)) {
> +		/*
> +		 * ADD_QUEUE was not confirmed, MES may still map the queue.
> +		 * The MQD and the doorbell and SDMA ids stay with it.
> +		 */
> +		q->zombie_no_user_bos =3D true;

[Severity: Medium]
Does setting q->zombie_no_user_bos here allow the user queue buffers to be
unmapped and freed while MES may still map the queue?

When pqm_create_queue() returns an error to kfd_ioctl_create_queue(), the
ioctl error path calls kfd_queue_unref_bo_vas() and
kfd_queue_release_buffers(), dropping the BO VA queue refcounts, the BO
references, and the CWSR SVM range reference immediately.  Because queue
creation failed, userspace can unmap and reuse wptr_bo, rptr_bo, ring_bo,
eop_buf_bo, and cwsr_bo while the MQD submitted to MES and the pinned
wptr_bo_gart mapping still point to them.  If the timed-out ADD_QUEUE
executes late, MES, CP, or SDMA can read or write unmapped or reallocated
user memory.

> +		dqm_quarantine_queue(dqm, qpd, q);
> +		dqm_unlock(dqm);
> +		return retval;
> +	}

[Severity: Medium]
Should this path also clear q->properties.is_active after calling
decrement_queue_count(), the same way destroy_queue_cpsch() and
process_termination_cpsch() do?

If MES later reports the quarantined queue as hung during a per-queue
reset, kfd_reset_queue_mes() finds it on dqm->zombie_queues via
find_queue_by_doorbell_offset() and calls reset_queue_mes() ->
set_queue_as_reset():

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:set_queue_as_reset() {
    ...
	if (q->properties.is_active) {
		q->properties.is_active =3D false;
		decrement_queue_count(dqm, qpd, q);
	}
}

Because q->properties.is_active was left true, set_queue_as_reset() calls
decrement_queue_count() a second time and underflows the DQM active queue
counters.

[ ... ]
> @@ -3680,20 +3712,18 @@ static int process_termination_cpsch(struct devic=
e_queue_manager *dqm,
> =20
>  	/* Clear all user mode queues */
>  	list_for_each_entry(q, &qpd->queues_list, list) {
> -		if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
> -			deallocate_sdma_queue(dqm, q);
> -		else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
> -			deallocate_sdma_queue(dqm, q);
> -
>  		if (q->properties.is_active) {
>  			decrement_queue_count(dqm, qpd, q);
> +			/* set_queue_as_reset() must not count it down again */
> +			q->properties.is_active =3D false;
> +		}

[Severity: High]
This problem wasn't introduced by this patch, but
kfd_dqm_suspend_bad_queue_mes() has the same double decrement and leaves
the queue marked inactive on reset failure [1]:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:kfd_dqm_suspend_bad_q=
ueue_mes() {
    ...
		list_for_each_entry(q, &qpd->queues_list, list) {
			if (q->doorbell_id =3D=3D doorbell_id && q->properties.is_active) {
				reset_queues_mes(dqm, q);
				q->properties.is_evicted =3D true;
				q->properties.is_active =3D false;
				decrement_queue_count(dqm, qpd, q);
				break;
			}
		}
    ...
}

When reset_queues_mes() resets the queue as hung via reset_queue_mes() ->
set_queue_as_reset(), set_queue_as_reset() already clears
q->properties.is_active and calls decrement_queue_count(), so the
unconditional decrement_queue_count() afterwards underflows
dqm->active_queue_count.  If reset_queues_mes() fails instead, clearing
q->properties.is_active causes later paths to treat a still-mapped queue
as inactive.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index ef9ad6dc874dc..29827a736f7d4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
[ ... ]
> @@ -571,23 +590,43 @@ int pqm_destroy_queue(struct process_queue_manager =
*pqm, unsigned int qid)
>  	}
> =20
>  	if (pqn->q) {
> -		retval =3D kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
> +		struct queue *q =3D pqn->q;
> +
> +		retval =3D kfd_queue_unref_bo_vas(pdd, &q->properties);
>  		if (retval)
>  			goto err_destroy_queue;
> =20
> -		dqm =3D pqn->q->device->dqm;
> -		retval =3D dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
> +		dqm =3D q->device->dqm;
> +		retval =3D dqm->ops.destroy_queue(dqm, &pdd->qpd, q);
>  		if (retval) {
>  			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
>  				pdd->pasid,
> -				pqn->q->properties.queue_id, retval);
> -			if (retval !=3D -ETIME && retval !=3D -EIO)
> +				q->properties.queue_id, retval);
> +			/* The dqm left the queue alone, it stays usable */
> +			if (!q->dqm_dequeued) {
> +				kfd_queue_ref_bo_vas(pdd, &q->properties);
>  				goto err_destroy_queue;
> +			}
> +		}

[Severity: Medium]
Can calling kfd_queue_unref_bo_vas() before dqm->ops.destroy_queue() race
when wait_on_destroy_queue() drops q->process->mutex for a suspended queue
of a debugged process?

CPU0                                  CPU1
pqm_destroy_queue(qid)
  kfd_queue_unref_bo_vas()
    bo_va->queue_refcount-- (1 -> 0)
  destroy_queue_cpsch()
    wait_on_destroy_queue()
      q->properties.is_being_destroyed =3D true
      dqm_unlock(dqm)
      mutex_unlock(&q->process->mutex)
      wait_event_interruptible(...)
                                      pqm_destroy_queue(qid)
                                        kfd_queue_unref_bo_vas()
                                          /* refcount is 0, no-op */
                                        destroy_queue_cpsch()
                                          wait_on_destroy_queue()
                                            returns -EBUSY
                                        /* !q->dqm_dequeued */
                                        kfd_queue_ref_bo_vas()
                                          bo_va->queue_refcount++ (0 -> 1)
      /* interrupted by signal */
      returns -ERESTARTSYS
  /* !q->dqm_dequeued */
  kfd_queue_ref_bo_vas()
    bo_va->queue_refcount++ (1 -> 2)  <-- refcount leaked

Because kfd_queue_unref_bo_va() only decrements when bo_va->queue_refcount
is non-zero while kfd_queue_ref_bo_va() increments unconditionally, a
second destroy attempt during the wait_on_destroy_queue() sleep window
permanently inflates bo_va->queue_refcount and prevents the BOs from being
unmapped.  While CPU0 is sleeping with bo_va->queue_refcount =3D=3D 0, anot=
her
thread can also unmap the queue's BOs via unmap_bo_from_gpuvm() before the
queue is destroyed.

[1] https://sashiko.dev/#/bug/linux-7affa616-c8be-4685-80a8-eb0c3ae7d034

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D5
