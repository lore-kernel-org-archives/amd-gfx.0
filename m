Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE1606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB/dh5kR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB16010E0C0;
	Thu, 26 Nov 2026 08:39:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1A110E0C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 08:39:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79D364170F;
 Thu, 26 Nov 2026 08:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AD31F000C4;
 Thu, 26 Nov 2026 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682383;
 bh=7CG9tZq4C9SfbiNKBPwNcTSeoRWVTRK7OzW5rFeMP9g=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=jB/dh5kRzDDCRysapW9DAB3foC/GN6DUWjgKqP28pg7yD2sXhi5pwRXjH5S/WDbHZ
 UEkqUGDB2mhOATrSRGgqPI/nx1STOpImAojO+X4lUx52XSS4Gqc5GGZftwOH7lI4a5
 doiSkGVsDbprwYm4kOIi5xH4zQgnCoDwWsaW2MSHvHJS5FMwxF1FEE5OwuHtqhZ0E0
 TLnsZ+nBtLGHCgFVCP5yIzEi+F0FH3B7ZDAJvwShTuO9KXBDI6UPF6ov6/fvk+N4O2
 HYVep3Fh6WjRrJ7zfcMEx+FjiJSU0TSLercXF19M79wpoR1AJb5zhWxTi+vlVg52WR
 SuZcaP3p8tZyw==
Message-ID: <sashiko-outbox-235045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] drm/amdkfd: keep queue storage until MES
 confirmed retirement
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125141933.154222-6-zappel@simple-co.de>
References: <20261125141933.154222-1-zappel@simple-co.de>
 <20261125141933.154222-6-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:39:42 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdkfd: unretired queue visibility gap in
  process_termination_cpsch()
- [Medium] drm/amdkfd: unbalanced SVM queue_refcount put when
  kfd_queue_hold_buffers() fails
--

commit 1de59d68e639f24ab5a36271e17baa8bd9d8fd34
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: keep queue storage until MES confirmed retirement

This commit quarantines queues whose retirement MES has not confirmed during
queue creation error cleanup, queue destruction, and process termination,
keeping their MQDs, IDs, and user buffer references until MES releases them.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0c72cf55224cc..eabb9a6953451 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c

[ ... ]

> @@ -3813,7 +3846,22 @@ static int process_termination_cpsch(struct device=
_queue_manager *dqm,
>  		mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>  				q->properties.type)];
>  		list_del(&q->list);
> +		q->dqm_dequeued =3D true;
>  		qpd->queue_count--;
> +
> +		/*
> +		 * Decide once whether MES has let go. A late completion can
> +		 * change the answer at any time, and the SDMA id has to
> +		 * follow the same decision as the MQD.
> +		 */
> +		if (!kfd_mes_queue_retired(dqm, q)) {
> +			dqm_quarantine_queue(dqm, qpd, q);
> +			continue;
> +		}
> +		if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
> +		    q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
> +			deallocate_sdma_queue(dqm, q);
> +
>  		dqm_unlock(dqm);
>  		/* Repin the MQD BO if still evicted for hibernation, before free. */
>  		dqm_repin_mqd_bo(dqm, q);

[Severity: Medium]
Can an unretired queue in qpd->queues_list be missed by a concurrent MES
per-queue reset while dqm_lock(dqm) is dropped to free an earlier retired
queue's MQD?

process_termination_cpsch() unlinks qpd from dqm->queues before running this
drain loop, and find_queue_by_doorbell_offset() only searches dqm->queues a=
nd
dqm->zombie_queues:

CPU0                                  CPU1
process_termination_cpsch()
  /* unlink qpd from dqm->queues */
  /* q1 is retired, q2 is not */
  list_del(&q1->list)
  dqm_unlock(dqm)
                                      kfd_reset_queue_mes()
                                        dqm_lock(dqm)
                                        find_queue_by_doorbell_offset(..., =
q2)
                                          /* not in dqm->queues or
                                           * dqm->zombie_queues -> NULL
                                           */
                                        dqm_unlock(dqm)
  mqd_mgr->free_mqd(..., q1->mqd, ...)
  dqm_lock(dqm)
  list_del(&q2->list)
  dqm_quarantine_queue(dqm, qpd, q2)

If MES reports q2 as hung during that window, kfd_reset_queue_mes() fails to
find q2 and skips resetting and removing it in MES.  Moving unretired queues
to dqm->zombie_queues before dropping dqm_lock(dqm), or unlinking qpd from
dqm->queues after qpd->queues_list is drained, would keep q2 visible.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index ef9ad6dc874dc..e44ccc803024c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c

[ ... ]

> @@ -518,7 +530,23 @@ int pqm_create_queue(struct process_queue_manager *p=
qm,
>  	return retval;
> =20
>  err_create_queue:
> -	uninit_queue(q);
> +	if (q && q->is_zombie) {
> +		/*
> +		 * The dqm still needs the MQD, the ids and what MES uses. The
> +		 * user buffers are part of that: MES may yet execute the
> +		 * ADD_QUEUE and run the queue from them. The ioctl drops its
> +		 * references on them when this returns, so take our own. The
> +		 * reaper drops them once MES has let go of the queue.
> +		 */
> +		if (kfd_queue_hold_buffers(pdd, &q->properties))
> +			pr_warn("process pid %d: quarantined queue holds no reference on its =
CWSR area\n",
> +				pqm->process->lead_thread->pid);
> +		kfd_dqm_zombie_ready(dev->dqm, q);

[Severity: Medium]
If kfd_queue_hold_buffers() fails in kfd_queue_buffer_svm_get(), will the
zombie reaper later underflow prange->queue_refcount?

When kfd_queue_hold_buffers() returns an error, no extra SVM reference is
taken for the quarantined queue, and kfd_ioctl_create_queue() drops the
initial reference taken by kfd_queue_acquire_buffers().  Because
q->properties.ctx_save_restore_area_address and ctx_save_restore_area_size
remain set, kfd_dqm_release_zombie() -> kfd_queue_release_buffers() ->
kfd_queue_buffer_svm_put() still decrements prange->queue_refcount when the
zombie queue is reaped:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:kfd_dqm_release_zombi=
e() {
    ...
	mutex_lock(&p->mutex);
	deallocate_doorbell(&pdd->qpd, q);
	kfd_queue_unref_bo_vas(pdd, &q->properties);
	kfd_queue_release_buffers(pdd, &q->properties, false);
	mutex_unlock(&p->mutex);
    ...
}

If another queue of the process shares or reuses that SVM range for its CWSR
area before the zombie is reaped, its prange->queue_refcount is decremented
early, allowing the range to be unmapped without evicting the active queue.
Clearing q->properties.ctx_save_restore_area_address (or zeroing
ctx_save_restore_area_size) when kfd_queue_buffer_svm_get() fails would avo=
id
the unmatched put.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125141933.1542=
22-1-zappel@simple-co.de?part=3D5
