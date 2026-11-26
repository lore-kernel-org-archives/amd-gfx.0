Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2D606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUsOyrtb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E12112176;
	Thu, 26 Nov 2026 08:49:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA659112176
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 08:49:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 196A2612AE;
 Thu, 26 Nov 2026 08:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DF41F000D0;
 Thu, 26 Nov 2026 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682991;
 bh=EngN7X1SDPRH2rM6zQy6xdYf+9eD2dRUrXjirVD63RQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=eUsOyrtbwcICydMbqqUiFDjhHR7FeB7HAguzpk0Jp8BGyd4BHZ0A7zowIAftx+UfP
 3ii07niidsBSE1sEJ409o4SzP3zF92NE426Ttaa60h+AjVqbsTwv6q8jGmq7n8zgSP
 um+8qeFelyqT/9H9+g/LmraIdWW6OcTiStRn43ciZV1mrAvHwdTWn909b1uchhKrpK
 0pIdI0fm3kog/wLc4atEMnZjQ3NvePV9IdFgK/xcwqnK73+3h4T5l+HsmW4z2dujTw
 qFRBEqo/b0WTL9epD9s3tI3UR+xtNcteaslNfqaEQV0NGLxM94dJ8FGLxHk+7mOmD2
 kY7fsQm4ZF6oA==
Message-ID: <sashiko-outbox-235056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] drm/amdkfd: add a quarantine for queues MES has
 not retired
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125141933.154222-5-zappel@simple-co.de>
References: <20261125141933.154222-1-zappel@simple-co.de>
 <20261125141933.154222-5-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:49:51 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/amdkfd: unlocked zombie_queues traversal in
  find_queue_by_doorbell_offset()
- [High] drm/amdkfd: unsignaled eviction fence and context_id alias on
  zombie wait
- [Medium] drm/amdkfd: per-process mes_hold stalls teardown on other
  GPUs
- [Medium] drm/amdkfd: cancel_delayed_work_sync() on uninitialized
  svms.restore_work
- [Medium] drm/amdkfd: restore_userptr_work not cancelled on notifier
  release
- [Medium] drm/amdkfd: svm_range_evict() can re-queue restore_work after
  notifier release
--

commit cec5d10251f9be4279a707b9cd0296feef08c241
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: add a quarantine for queues MES has not retired

This commit introduces a per-device zombie queue list and a delayed reaper
work item to hold queue and process storage until MES confirms that a
destroyed queue has been retired.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index edafbd9377b5d..f631047e88b9d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1824,6 +1819,17 @@ void kgd2kfd_teardown_processes(struct amdgpu_devi=
ce *adev)
>  	if (!adev->kfd.dev)
>  		return;
> =20
> +	/*
> +	 * Queues that MES never confirmed as removed keep their process
> +	 * alive, and such a process is counted in kfd_processes_count after
> +	 * it has left the table. The device is going away, so stop waiting
> +	 * for MES, whether the table is empty or not.
> +	 */
> +	if (adev->kfd.dev->init_complete) {
> +		for (unsigned int i =3D 0; i < adev->kfd.dev->num_nodes; i++)
> +			kfd_dqm_retire_all(adev->kfd.dev->nodes[i]->dqm);
> +	}
> +
>  	/*
>  	 * Wait for all KFD processes using adev to terminate. Must be
>  	 * unbounded: device state is freed once they are gone.

[Severity: Medium]
Can an unretired zombie queue on another GPU cause
kgd2kfd_teardown_processes() to spin forever on
adev->kfd.dev->kfd_processes_count?

kfd_init_apertures() creates a PDD and increments kfd_processes_count on
every GPU in the topology, while kfd_process_destroy_pdds() only decrements
kfd_processes_count after p->mes_hold drops to zero for the whole process.
If an exited process has a zombie queue on GPU B, kfd_dqm_retire_all() on
GPU A does not retire GPU B's queue, so GPU A's kfd_processes_count never
reaches zero and teardown of GPU A hangs waiting for GPU B.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 646bc0ce05be8..0c72cf55224cc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
[ ... ]
> @@ -684,7 +688,13 @@ static int reset_queue_mes(struct device_queue_manag=
er *dqm, struct queue *q,
>  	 * its storage until MES is restarted.
>  	 */
>  	r =3D remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
> -	set_queue_as_reset(dqm, q, &pdd->qpd, true);
> +	/*
> +	 * A quarantined queue is destroyed as far as its process is
> +	 * concerned: it is not counted, and the process is not punished
> +	 * for a queue it no longer owns. Only the MES side was needed.
> +	 */
> +	if (!q->is_zombie)
> +		set_queue_as_reset(dqm, q, &pdd->qpd, true);
[ ... ]
> @@ -2993,6 +3143,12 @@ static struct queue *find_queue_by_doorbell_offset=
(struct device_queue_manager *
>  		}
>  	}
> =20
> +	/* MES may report a quarantined queue as hung, it still has it */
> +	list_for_each_entry(q, &dqm->zombie_queues, zombie_node) {
> +		if (doorbell_offset =3D=3D q->properties.doorbell_off)
> +			return q;
> +	}
> +
>  	return NULL;
>  }

[Severity: High]
Can find_queue_by_doorbell_offset() and reset_queue_mes() race with
kfd_dqm_zombie_worker() on dqm->zombie_queues and use a zombie queue after
it is freed?

When amdgpu_gfx_reset_mes_compute() is called from KGD reset paths such as
gfx_v11_0_reset_kcq(), gfx_v12_0_reset_kcq(), or
amdgpu_userq_hang_detect_work(), only adev->gfx.mec.reset_mutex is held,
not dqm_lock(dqm).  kfd_reset_queue_mes() then walks dqm->zombie_queues and
calls reset_queue_mes() without dqm_lock(dqm):

CPU0                                  CPU1 (kfd_dqm_zombie_worker)
amdgpu_gfx_reset_mes_compute()
  ...
  kfd_reset_queue_mes()
    find_queue_by_doorbell_offset()
      /* walks dqm->zombie_queues
         without dqm_lock */
    reset_queue_mes(dqm, q, ...)
      remove_queue_mes_on_reset_option()
        q->mes_state =3D KFD_MES_QUEUE_UNMAPPED
                                      dqm_lock(dqm)
                                      kfd_mes_queue_retired(dqm, q) =3D=3D =
true
                                      list_move_tail(&q->zombie_node, &reti=
red)
                                      dqm_unlock(dqm)
                                      kfd_dqm_release_zombie(dqm, q)
                                        uninit_queue(q) /* frees q */
      if (!q->is_zombie)  <-- use-after-free

Even before reset_queue_mes() runs, walking dqm->zombie_queues in
find_queue_by_doorbell_offset() without dqm_lock(dqm) races with
dqm_quarantine_queue() and kfd_dqm_zombie_worker() modifying the list.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 546721b4d59ac..51c3fa39fcc20 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1331,20 +1331,15 @@ static void kfd_process_wq_release(struct work_st=
ruct *work)
>  					     release_work);
>  	struct dma_fence *ef;
> =20
> +	/* Second run, queued when the last quarantined queue was freed */
> +	if (p->mes_hold_dropped)
> +		goto release_storage;
> +
>  	/*
>  	 * If GPU in reset, user queues may still running, wait for reset compl=
ete.
>  	 */
>  	kfd_process_wait_gpu_reset_complete(p);
> =20
> -	/* Signal the eviction fence after user mode queues are
> -	 * destroyed. This allows any BOs to be freed without
> -	 * triggering pointless evictions or waiting for fences.
> -	 */
> -	synchronize_rcu();
> -	ef =3D rcu_access_pointer(p->ef);
> -	if (ef)
> -		dma_fence_signal(ef);
> -
>  	if (p->context_id !=3D KFD_CONTEXT_ID_PRIMARY)
>  		kfd_process_free_id(p);
>  	else
> @@ -1359,6 +1354,32 @@ static void kfd_process_wq_release(struct work_str=
uct *work)
>  	 */
>  	kfd_process_remove_sysfs(p);
> =20
> +	/*
> +	 * Queues that MES has not let go of still use the pdds, the process
> +	 * context, the doorbell page and the GPU VM. Everything that carries
> +	 * the pid is gone at this point, so stop here. The reaper queues
> +	 * this work again when it frees the last of those queues. Do not
> +	 * wait instead: kfd_create_process() flushes this workqueue. A work
> +	 * item never runs twice at the same time, so the second run cannot
> +	 * free the process under us.
> +	 */
> +	p->mes_hold_dropped =3D true;
> +	if (!atomic_dec_and_test(&p->mes_hold)) {
> +		pr_warn("Process pid %d: release waits for MES to retire %d queue(s), =
a GPU reset retires them\n",
> +			p->lead_thread->pid, atomic_read(&p->mes_hold));
> +		return;
> +	}

[Severity: Medium]
When kfd_process_wq_release() returns early here, can
p->kgd_process_info->restore_userptr_work keep running against a post-execve
mm?

During exit_mmap(), mn_itree_release() invalidates userptr BOs and queues
process_info->restore_userptr_work before mn_hlist_release() calls
kfd_process_notifier_release_internal() and removes p from
kfd_processes_table.  Because restore_userptr_work is only cancelled in
amdgpu_amdkfd_gpuvm_destroy_cb() during kfd_process_destroy_pdds(),
deferring release_storage allows amdgpu_amdkfd_restore_userptr_worker() to
look up process_info->pid after execve(), acquire the new mm, fail
get_user_pages() on the old mm with -ESRCH, and reschedule itself every
10 ms against the new mm until all zombies retire.

> +
> +release_storage:
> +	/* Signal the eviction fence after user mode queues are
> +	 * destroyed. This allows any BOs to be freed without
> +	 * triggering pointless evictions or waiting for fences.
> +	 */
> +	synchronize_rcu();
> +	ef =3D rcu_access_pointer(p->ef);
> +	if (ef)
> +		dma_fence_signal(ef);

[Severity: High]
Does deferring dma_fence_signal(ef) until release_storage stall in-flight
TTM evictions and alias p->context_id while zombies are quarantined?

If TTM enabled signaling on p->ef before kfd_process_table_remove(p),
amdkfd_fence_enable_signaling() scheduled p->eviction_work and returned
true without signaling p->ef.  kfd_process_notifier_release_internal() then
cancels p->eviction_work, so returning early before dma_fence_signal(ef)
leaves p->ef unsignaled with DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT set, stalling
any TTM move job waiting on p->ef until every zombie queue retires.

In addition, for a secondary context, kfd_process_free_id(p) frees
p->context_id before the early return while p->ef is still unsignaled and
attached to p's BOs.  If a new secondary context in the same mm reuses that
context_id, a later eviction of the old context's BOs matches the new
context in kfd_lookup_process_by_id(), evicting the new context while
leaving the old p->ef unsignaled.

[ ... ]

> @@ -1422,6 +1454,12 @@ void kfd_process_notifier_release_internal(struct =
kfd_process *p)
>  	kfd_process_table_remove(p);
>  	cancel_delayed_work_sync(&p->eviction_work);
>  	cancel_delayed_work_sync(&p->restore_work);
> +	/*
> +	 * Not left to svm_range_list_fini(): the release worker may now
> +	 * run long after this, and the SVM restore work would look up the
> +	 * mm of the lead thread, which can be a new one by then.
> +	 */

[Severity: Medium]
Can svm_range_evict() re-queue p->svms.restore_work after
cancel_delayed_work_sync() returns here?

prange->notifier is only unregistered in svm_range_list_fini() at
release_storage, and mn_itree_release() leaves interval notifiers linked in
the old mm until exit_mmap() finishes tearing down VMAs and page tables.
Because svm_range_evict() ignores the -ESRCH return from
kgd2kfd_quiesce_mm() and unconditionally queues svms->restore_work, any
concurrent non-UNMAP invalidation on the old mm after this point can
re-queue p->svms.restore_work, which then looks up p->lead_thread->mm after
execve().  Using disable_delayed_work_sync(&p->svms.restore_work) (or
checking r !=3D -ESRCH in svm_range_evict()) would prevent it from being
queued again.

> +	cancel_delayed_work_sync(&p->svms.restore_work);

[Severity: Medium]
Does calling cancel_delayed_work_sync(&p->svms.restore_work) unconditionally
trigger WARN_ON(!work->func) in __flush_work() when CONFIG_HSA_AMD_SVM is
disabled?

When CONFIG_HSA_AMD_SVM=3Dn, svm_range_list_init() is a no-op stub and never
initializes p->svms.restore_work, so every exiting KFD process hits the
warning in __flush_work().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125141933.1542=
22-1-zappel@simple-co.de?part=3D4
