Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C14606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjKmZ5J2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A4710F64F;
	Tue, 24 Nov 2026 16:29:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EAC10F64F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:29:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7589A434A2;
 Tue, 24 Nov 2026 16:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC511F000C6;
 Tue, 24 Nov 2026 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537756;
 bh=DetWoASEjwZzji0CDt3hzjtt7xu6vv5U5e9DJ31OeG4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=KjKmZ5J2zW0K33CqmtCSjims1Om9FimoA/HvGmdjfC11rDMvFFKcX8WBRVFFkWad9
 aH7RD3GKlc7nOJkn7/8VSXPR6c8+d9newP0RVseqWQIF5vEpG5j1xjm2l8NeNhWJJC
 8hJwrPQgt3zTwI0huclMVLUbii5XTXLb0TpPuRm3gZOvZuCB1Ek219AjXNWjF1aKBQ
 1J4EO7IezdEmfT+UnkL1yRQv6TKE+f5Fr3KK3U+BTgyQ+I8+lJuJhid62Ck/KmBDug
 qMqIlyBq/iPAZV/G87fG7geDTqYgJVnvujVKP4wlzvJ9ELeQt+yrKFeOSUYIdg82WD
 RrjHBalCpZZ3Q==
Message-ID: <sashiko-outbox-231568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/9] drm/amdkfd: add a quarantine for queues MES has
 not retired
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-5-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-5-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:29:16 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/amdkfd: kgd2kfd_teardown_processes() misses exited
  processes with zombies
- [High] drm/amdkfd: broken zombie queue handling in reset_queue_mes()
- [High] drm/amdkfd: unlocked zombie_queues traversal in
  find_queue_by_doorbell_offset()
- [High] drm/amdkfd: kfd_process_wq_release() early return leaves
  svms.restore_work active
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [Critical] drm/amdkfd: invalid free of context ID 0 on alloc failure
  in create_process() [1]
- [High] drm/amdkfd: queue_refcount leak in kfd_queue_buffer_get() [2]
--

commit b3a1e7e946a15fc197590f432e1ffb64a5706fc6
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: add a quarantine for queues MES has not retired

This commit adds per-device quarantine lists, a delayed reaper work item,
and process storage holds to retain queue and process resources until MES
confirms queue retirement or is restarted.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index edafbd9377b5d..8080fbe3f7a17 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1824,6 +1824,15 @@ void kgd2kfd_teardown_processes(struct amdgpu_devi=
ce *adev)
>  	if (!adev->kfd.dev)
>  		return;
> =20
> +	/*
> +	 * Queues that MES never confirmed as removed keep their process
> +	 * alive. The device is going away, so stop waiting for MES.
> +	 */
> +	if (adev->kfd.dev->init_complete) {
> +		for (unsigned int i =3D 0; i < adev->kfd.dev->num_nodes; i++)
> +			kfd_dqm_retire_all(adev->kfd.dev->nodes[i]->dqm);
> +	}
> +
>  	/*
>  	 * Wait for all KFD processes using adev to terminate. Must be
>  	 * unbounded: device state is freed once they are gone.

[Severity: High]
Can kgd2kfd_teardown_processes() skip kfd_dqm_retire_all() and the
kfd_processes_count wait when every KFD process has already exited user
space but still has quarantined queues?

When a process exits, kfd_process_notifier_release_internal() removes it
from kfd_processes_table before queue teardown, while its quarantined
queues hold p->mes_hold and defer kfd_process_destroy_pdds() (keeping
kfd_processes_count > 0).  If no other live KFD processes remain when the
device is removed, kgd2kfd_teardown_processes() returns early at
if (hash_empty(kfd_processes_table)), so device_queue_manager_uninit()
cancels dqm->zombie_work, hits WARN_ON(!list_empty(&dqm->zombie_queues)),
and frees the device structures while the zombies and deferred kfd_process
still reference them.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 684037d333bf1..2f57cb06f540f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c

[ ... ]

> @@ -2913,6 +3059,12 @@ static struct queue *find_queue_by_doorbell_offset=
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
Does returning a quarantined queue to kfd_reset_queue_mes() ->
reset_queue_mes() corrupt queue state and wedge the reaper?

In reset_queue_mes(), remove_queue_mes_on_reset_option() is called with
its return value ignored, followed unconditionally by set_queue_as_reset():

1. If remove_queue_mes_on_reset_option() skips or fails removal (where
   is_for_reset =3D=3D true returns early without calling kfd_hws_hang()),
   set_queue_as_reset() sets q->properties.is_reset =3D true while
   q->mes_state is still MAPPED or UNKNOWN.  Every subsequent run of
   kfd_dqm_zombie_worker() calls remove_queue_mes(), which returns 0 early
   on q->properties.is_reset without retiring the queue, polling every
   500 ms indefinitely and leaking the queue and process holds.
2. When a queue is quarantined from create_queue_cpsch() or
   process_termination_cpsch(), decrement_queue_count() has already run
   without clearing q->properties.is_active =3D false.  set_queue_as_reset()
   sees q->properties.is_active =3D=3D true and calls decrement_queue_count=
()
   a second time, underflowing dqm->active_queue_count.
3. set_queue_as_reset() sets pdd->has_reset_queue =3D true for a queue user
   space already destroyed (or that failed creation), causing later
   update_queue() calls on the process's remaining live queues to fail
   with -EACCES.

[Severity: High]
Can find_queue_by_doorbell_offset() walk dqm->zombie_queues without
dqm_lock(dqm) held and race with kfd_dqm_zombie_worker() freeing the
queue?

When KGD resets hung compute queues from gfx_v11_0_reset_kcq(),
gfx_v12_0_reset_kcq(), or amdgpu_userq_hang_detect_work(),
amdgpu_gfx_reset_mes_compute() holds only adev->gfx.mec.reset_mutex and
does not acquire dqm_lock(dqm):

CPU0 (KGD reset)                  CPU1 (kworker)
amdgpu_gfx_reset_mes_compute()    kfd_dqm_zombie_worker()
  ...                               dqm_lock(dqm)
  kfd_reset_queue_mes()             list_move_tail(&q->zombie_node,
    find_queue_by_doorbell_offset()                &retired)
      /* walks dqm->zombie_queues   dqm_unlock(dqm)
       * without dqm_lock */        kfd_dqm_release_zombie(dqm, q)
                                      uninit_queue(q)
    reset_queue_mes(dqm, q, ...)        kfree(q)
      /* dereferences q */              <-- use-after-free

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 546721b4d59ac..3aa6ddf49ad49 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c

[ ... ]

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
> +
>  	kfd_process_kunmap_signal_bo(p);
>  	kfd_process_free_outstanding_kfd_bos(p);
>  	svm_range_list_fini(p);

[Severity: High]
Does returning early before svm_range_list_fini(p) leave
p->svms.restore_work running against the wrong mm_struct across execve()?

kfd_process_notifier_release_internal() cancels p->eviction_work,
p->restore_work, and p->signal_work when the old mm is torn down, but
p->svms.restore_work is only cancelled in svm_range_list_fini().  If the
process tore down its old mm via execve() and has a quarantined queue,
p->lead_thread stays alive with a new mm while kfd_process_wq_release()
returns early here.  When svm_range_restore_work() runs during the
quarantine window, get_task_mm(p->lead_thread) returns the post-execve()
new_mm, locks new_mm->mmap_lock, and passes prange->notifier (whose
notifier.mm still points to the destroyed old_mm) to
amdgpu_hmm_range_get_pages() -> hmm_range_fault(), triggering
mmap_assert_locked(old_mm) and walking the freed old_mm page tables.

[ ... ]

> @@ -1702,6 +1734,7 @@ struct kfd_process *create_process(const struct tas=
k_struct *thread, bool primar
>  		goto err_alloc_process;
> =20
>  	kref_init(&process->ref);
> +	atomic_set(&process->mes_hold, 1);
>  	mutex_init(&process->mutex);
>  	process->mm =3D thread->mm;
>  	process->lead_thread =3D thread->group_leader;

[Severity: Critical]
This problem wasn't introduced by this patch, but in create_process()
[1], can a kfd_process_alloc_id() failure free context ID 0 while
another secondary process is using it?

process is zero-initialized, so process->context_id starts at 0
(KFD_CONTEXT_ID_MIN).  If kfd_process_alloc_id() fails for a secondary
process, it leaves process->context_id at 0 and jumps to err_alloc_id,
which calls kfd_process_free_id(process) -> ida_free(..., 0) on
primary_process->id_table, releasing an active secondary process's context
ID and allowing duplicate context ID assignment.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index cd41b10e08731..ad01308a7d812 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -423,6 +423,36 @@ int kfd_queue_unref_bo_vas(struct kfd_process_device=
 *pdd,
>  	return 0;
>  }
> =20
> +static void kfd_queue_ref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo *=
bo)
> +{
> +	struct amdgpu_bo_va *bo_va;
> +
> +	if (!bo)
> +		return;
> +
> +	bo_va =3D amdgpu_vm_bo_find(vm, bo);
> +	if (bo_va)
> +		bo_va->queue_refcount++;
> +}

[Severity: High]
This problem wasn't introduced by this patch, but does
kfd_queue_buffer_get() leak bo_va->queue_refcount [2] when a
mapping's underlying BO is NULL (such as a PRT mapping)?

In kfd_queue_buffer_get(), *pbo is set to
amdgpu_bo_ref(mapping->bo_va->base.bo) (which is NULL when base.bo is
NULL), while mapping->bo_va->queue_refcount is still incremented.  Because
kfd_queue_unref_bo_va() (and kfd_queue_ref_bo_va() here) checks for a
non-NULL bo before looking up bo_va, queue_refcount is never decremented
on teardown, leaving the mapping permanently non-zero and blocking unmap
with -EBUSY.

[1] https://sashiko.dev/#/bug/linux-73836404-f2c8-4863-97fc-8a10e19441a4
[2] https://sashiko.dev/#/bug/linux-7d2cfadd-e9fb-4657-8f39-fe57b15f1bfe

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D4
