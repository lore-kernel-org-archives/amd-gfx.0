Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B3606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=WN9qgmjJ;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=DM1eL/kN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7D010E0ED;
	Wed, 25 Nov 2026 14:16:49 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DC510FCA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616118;
 bh=p5dxiYCkIc8wJOdrWanTEXKXF3KIvau0YpqP+PIUBjQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=WN9qgmjJlwxxj53qqBW68pWX54zig3kfkhOpfy7xJgAlWbbrNFKj48SpcZk7T9KaM
 FHBB36rKtRKjZ8yCs+P5vlHJ84aO9/7V1zIflEczO4l0BNoDF+NCXAetQ+D2ioieWn
 4wadG8Z7+Z4o0tf7mnUpmCIK2kii0bRtej1/dQO/H2s4wwaj+txRCK4fcCWHLc1g3D
 36DGt1HdSO/g6K4uVALsYnQAiVdYavFp/qPytXHSvLfdqH1XxFcte4Zz0AEgnikZcc
 JizOmyKvwWEXFQ38m3WZiM5p9REm9RUu25fg7luDEZd00vrH6TlTyzWCU6TLZh4271
 kKBjIDHUaezMA==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 6D2CD17F362
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 15:15:18 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGrhaiVEdRaq for <amd-gfx@lists.freedesktop.org>;
 Wed, 25 Nov 2026 15:15:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616117;
 bh=p5dxiYCkIc8wJOdrWanTEXKXF3KIvau0YpqP+PIUBjQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=DM1eL/kNaQVO8FIedbLOq7lxGzwJo4+EjkBP3E6gpKxMNwcrIX3plODFBN2yaqtCi
 eg+d9pkEz11pnNp8hg1jgSK2sVhnEBvWFvTAAHuKLcs95RZjcN9q/ambrHenedZ84u
 892QwdnTR2LGMzT4E64io2KfUr7SqsxraNdbqqEcpdKYVhsrDNgPVs8JT+gXbzMS6K
 po+KYAJIrv/4kS9p1hmPIhw6P7tjJ6Qn13ppjRnkB747NFW6ex9Zd1FlkYeatanNMd
 Z7J4c5WDNKWQ4MXvF1PVxD1um0vI9hqcPcki80Bouj81JXTTz5hlKiXat8BmOhYpdi
 4o5yhyCEW9Q3w==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 7A80717F361
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 15:15:17 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v1 0/9] drm/amdgpu/amdkfd: fix MES queue lifecycle on
 multi-GPU
Date: Wed, 25 Nov 2026 15:15:15 +0100
Message-ID: <20261125141515.153431-1-zappel@simple-co.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124143433.49736-1-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 14:16:48 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026, sashiko-bot@kernel.org wrote reviews for patches
1 through 8 of this series. Answering all of them in one place since
several findings touch the same code. Line numbers are from the tree
with v1 applied.

Thanks for the review. Of the 32 findings, 16 are real and get fixed in
v2, 2 do not happen, and 14 are in the baseline. Six of the baseline
ones get picked up in v2 anyway because the series leans on that code
or already rewrites the function. Details per patch below, the v2
summary is at the end.


[PATCH v1 1/9] drm/amdgpu/mes: distinguish rejected from timed out commands

> [High] global fw_gen incremented per XCC in mes_v12_1_xcc_hw_init()

Correct in principle, not reachable today. The counter is bumped per XCC
(mes_v12_1.c:1945) and compared device wide. The only per-XCC entry is
gfx_v12_1_xcc_cp_resume() -> amdgpu_mes_kiq_hw_init() -> mes_v12_1_xcc_hw_init(),
whose callers are the whole-device cp_resume and gfx_v12_1_xcp_resume().
amdgpu_xcp_resume() has no caller in the tree. A partition switch sets
AMDGPU_XCP_OPS_KFD and goes through kgd2kfd_check_and_lock_kfd(), which
refuses while kfd_processes_count is non-zero (quarantined queues keep
it non-zero) and then tears KFD down before any MES instance is touched.
So no KFD queue survives into a single-XCC restart.

Still, "the scheduler instance that knew the queue" is an XCC on 12.1,
and a device-wide counter is a trap for the next per-XCC reset path. v2
makes fw_gen per XCC, tickets record the XCC they were submitted on, and
kfd_mes_gen() reads the entry for the node's XCC.

> [Medium] 32-bit status_ptr in mes_v12_1_submit_pkt_ticket() drops upper status

Correct. mes_v12_1.c:173 has u32 *status_ptr, the branch at :243 is only
entered with the low 32 bits zero, so the new "rejected" line prints
0x0000000000000000 every time. The firmware error code in bits 63:32 is
exactly what the patch set out to print, and 12.1 is the hardware this
was debugged on. v11 and v12.0 use u64 and are fine. v2 uses u64 on
12.1, zeroes all 64 bits and prints upper/lower like mes_v12_0 does.

> [Medium] missing dma_rmb() in amdgpu_mes_ticket_poll()

Correct for weakly ordered architectures. The two status loads are to
the same address and stay ordered, but the second status load can be
satisfied before the fence load it is control dependent on. Device
order is status, then fence, so arm64 can see the new fence with the
old status and return FAILED for a completed command. x86 cannot
reorder loads against loads, which is why it did not show. The baseline
submit path has the same shape (poll fence, then read status). v2 adds
dma_rmb() in the ticket poll and after a successful fence wait in the
submit paths.


[PATCH v1 2/9] drm/amdkfd: factor out freeing of per-queue MES resources

> [High] pre-existing: memory leak in pqm_create_queue()

Pre-existing and correct. Patch 2 is a pure move. Patch 5 adds
kfd_queue_free_mes_resources() to err_create_queue, which is where the
leak closes in v1. Since it is a standalone leak a local user can
trigger, v2 moves that fix into its own patch at the front of the
series with a Fixes tag so it can go to stable on its own.


[PATCH v1 3/9] drm/amdkfd: track whether MES knows each queue

> [Medium] missing kfd_mes_fence() call on command timeout in add_queue_mes()

Correct. kfd_hws_hang() only schedules the reset work; until that work
takes reset_domain->sem for writing, down_read_trylock() keeps
succeeding and callers that loop (kfd_resume_all_processes(),
set_perfcount()) submit behind the unanswered ADD_QUEUE at 2.1 s a
piece under the dqm lock. The REMOVE path fences, the ADD path does
not, and the commit message claims both. v2 fences on -ETIMEDOUT in
add_queue_mes(). ADD has no ticket, so the fence is lifted by the
firmware restart the scheduled reset performs. A rejection does not
fence, MES is answering.

> [High] false success in remove_queue_mes_on_reset_option() when queue is not retired

The three early return 0 paths (is_reset, !sched_running, sched_halt)
are the baseline's. After a halt or stop that succeeded every active
queue is UNMAPPED and kfd_mes_queue_retired() at :503 answers before
them. They are only reached for a MAPPED queue after
remove_all_kfd_queues_mes() failed half way, and that first failure
went through the recovery path, which fences MES and schedules a GPU
reset. The MQD rewrite in that window is the baseline's as well
(evict_process_queues_cpsch() does not unpin the MQD BO, that is the S4
path and runs only after a successful removal).

With the state tracking there is no reason to report success for a
queue MES still has, so v2 tightens it: the is_reset shortcut goes away
(the retired check covers a queue the reset removed, and for one it did
not the shortcut is wrong, see the zombie finding on 4/9), and the
!sched_running || sched_halt case returns -EIO for a queue that is not
retired. destroy then quarantines, update leaves the MQD alone, evict
marks the queue evicted without pretending MES dropped it, and the
reaper retries once the scheduler runs.

> [High] ignored remove-after-reset error and unfenced timeout in reset_queue_mes()

Two parts. Ignoring the return value and skipping recovery for
is_for_reset are the baseline's (reset_queue_mes() returned 0 either
way, and "if (!r || is_for_reset) return r;" skipped the reset). Not
fencing a timed-out remove-after-reset is a hole in the new mechanism,
agreed. The state is at least recorded, __remove_queue_mes() leaves the
queue UNKNOWN so destroy quarantines it.

v2: reset_queue_mes() looks at the result. On -ETIMEDOUT it fences MES
and returns the error, so amdgpu_gfx_reset_mes_compute() fails and each
caller escalates (KFD through kfd_hws_hang(), userq through gpu_reset,
KCQ through the ring reset result). A rejection keeps the queue UNKNOWN
and returns 0 as before: MES is alive, the other hung queues should
still be reset, and the quarantine handles the storage.
set_queue_as_reset() still runs, the queue was reset.

> [Medium] unlocked MES state access in kfd_reset_queue_mes()

Pre-existing. kfd_reset_queue_mes() is unchanged from the baseline and
runs without the dqm lock from gfx_v11_0_reset_kcq(),
gfx_v12_0_reset_kcq() and amdgpu_userq_hang_detect_work(), under
adev->gfx.mec.reset_mutex only. It already walks dqm->queues and writes
is_active, has_reset_queue and the queue counters in that state. The
series adds mes_state and mes_ticket to the fields touched there, which
adds a wb slot double free to the possible outcomes, but the lock-less
entry is the problem. It cannot be fixed by taking the dqm lock there:
reset_queues_mes() holds the dqm lock while calling
amdgpu_gfx_reset_mes_compute(), which takes reset_mutex, so a KGD caller
holding reset_mutex and wanting the dqm lock deadlocks against it. This
needs a lock order decision between the KGD and KFD reset paths and is a
separate series.

> [Medium] reset_queues_mes() called behind unanswered REMOVE_QUEUE before fencing

Correct. If the ticket is still PENDING after the 4 s grace period, MES
has not moved its ring for 6.1 s, and SUSPEND, DETECT_AND_RESET and
RESUME queue behind it for up to 6.3 s more under the dqm lock, which
also blocks kgd2kfd_pre_reset(). kfd_mes_wait_retired() already returns
early for a ticket answered with a failure, and that is the case where
MES is alive and the per-queue reset makes sense. v2: still PENDING
after the grace period (or amdgpu_in_reset()) fences MES and goes
straight to the kfd_hws_hang() path. reset_queues_mes() runs only when
MES answered.

> [Medium] missing gang_context_array_index and ticket in reset_queues_mes()

gang_context_array_index: pre-existing, the baseline queue_input in
reset_queues_mes() lacks it too, and mes_v11_0_remove_hw_queue() copies
it unconditionally. ticket: agreed, not passing it frees the status slot
while the command may be in flight, which is what the ticket was added
to prevent. v2 sets both; a non-pending ticket from the earlier
REMOVE_QUEUE is released first so the slot is not leaked. With the
previous fix this path is never entered with a pending ticket.

> [High] duplicate REMOVE_QUEUE after late completion in reset_queues_mes()

Correct, if narrow. The SUSPEND scenario needs MES to wake up after a
6 s stall right before the SUSPEND is processed, but the code must not
reset the GPU for a removal that succeeded. The fix above (no
reset_queues_mes() behind a pending ticket) removes that scenario, and
v2 also re-checks kfd_mes_queue_retired() after a failed
reset_queues_mes() before escalating. The second scenario, a ticket
turning DONE between the caller's retired check and the PENDING test in
__remove_queue_mes(), is a nanosecond window and a trivial fix: v2 makes
__remove_queue_mes() retire the queue on DONE instead of releasing the
ticket and sending a duplicate.

> [High] kfd_dqm_suspend_bad_queue_mes() leaves unremoved queue in MES

Pre-existing. kfd_dqm_suspend_bad_queue_mes() is untouched by the
series; when MES reports other queues hung and not this one,
amdgpu_gfx_reset_mes_compute() resumes it with the rest and never
removes it, and the baseline marks it inactive and evicted regardless.
The series moved the "recovery left this one in MES" removal only into
remove_queue_mes_on_reset_option(), you are right that the other caller
does not get it. What the series does change: destroy_queue_cpsch() and
process_termination_cpsch() now send REMOVE_QUEUE based on
kfd_mes_queue_retired() instead of is_active, so such a queue is removed
at destroy time rather than leaking in MES, and update_queue_locked()
refuses to rewrite its MQD.

v2 moves the explicit post-recovery removal into reset_queues_mes() so
both callers get it, and remove_all_kfd_queues_mes() iterates on
!kfd_mes_queue_retired() like the other teardown paths.

> [High] pre-existing: unbalanced queue unmap in update_queue() on reset queue

Pre-existing and correct: has_reset_queue is tested after the unmap at
update_queue_locked():1407. The series only inserts the retired check
above it. Moving the test ahead of the unmap is the fix; it is
unrelated to this series and should go in on its own.


[PATCH v1 4/9] drm/amdkfd: add a quarantine for queues MES has not retired

> [High] kgd2kfd_teardown_processes() misses exited processes with zombies

Correct. The hash_empty() return at kfd_device.c:1832 comes before the
new kfd_dqm_retire_all() loop and before the kfd_processes_count wait.
kfd_process_table_remove() drops the process from the table at the
start of the notifier release, kfd_processes_count is only decremented
in kfd_process_destroy_pdds(), and the series defers that until the
last mes_hold is gone. Last process exits with a quarantined queue,
device is removed, teardown returns early, device_queue_manager_uninit()
warns on the zombie list and frees the device under it. The baseline has
the same early return and the same gap, but there the gap is until the
release work runs; with the series it is until MES answers, which on an
unplugged device is never. v2: the hash_empty() test only skips the
signalling loop, retire and wait run whenever adev->kfd.dev is set.

> [High] broken zombie queue handling in reset_queue_mes()

Correct on all three points, with one correction. (1) A failed
remove-after-reset followed by set_queue_as_reset() leaves the zombie
MAPPED/UNKNOWN with is_reset set, and the reaper's remove_queue_mes()
returns 0 at the is_reset shortcut forever. Fixed by dropping the
shortcut and by fencing and escalating a timed-out remove-after-reset
(see 3/9). (2) A queue quarantined from create_queue_cpsch() keeps
is_active, the cleanup path decrements without clearing it, and
set_queue_as_reset() decrements again. destroy_queue_cpsch() and
process_termination_cpsch() do clear it, so the "or
process_termination_cpsch()" part is not right, but the create path is a
real underflow. (3) has_reset_queue for a queue user space already
destroyed penalises the process for a queue it no longer owns.

v2: reset_queue_mes() does the MES side for a zombie (reset,
remove-after-reset, state) and skips set_queue_as_reset() for
q->is_zombie, no counter change, no has_reset_queue, no is_reset.
create_queue_cpsch() clears is_active after the decrement.

> [High] unlocked zombie_queues traversal in find_queue_by_doorbell_offset()

Pre-existing, same root as the unlocked kfd_reset_queue_mes() above.
find_queue_by_doorbell_offset() already walks dqm->queues and every
qpd->queues_list without the dqm lock from the KGD paths, racing with
destroy and termination freeing queues under it. The zombie list is one
more list on the same walk and the reaper one more freer, not a new
class of bug, and the fix is the same lock order work. Leaving zombies
out of the lookup is not an option: a quarantined queue MES reports as
hung has to be reset and removed, or it stays hung in MES and the reaper
never frees it.

> [High] kfd_process_wq_release() early return leaves svms.restore_work active

Correct. The notifier release cancels eviction_work, restore_work and
signal_work but not svms.restore_work, which only svm_range_list_fini()
cancels, and that now runs after the early return. Nothing re-arms it
after release (the interval notifier invalidate bails on mmget_not_zero()
of the dying mm), but a delayed work queued before release can fire in
the window, take get_task_mm(p->lead_thread) which is the new mm after
an execve, and validate pranges whose notifiers belong to the old one.
The baseline has the same window between release and
svm_range_list_fini(); the series stretches it for as long as MES holds a
queue. v2 cancels svms.restore_work in
kfd_process_notifier_release_internal() next to the others, which
closes the baseline window too.

> [Critical] pre-existing: invalid free of context ID 0 on alloc failure in create_process()

Pre-existing and correct: kzalloc leaves context_id at 0,
KFD_CONTEXT_ID_MIN is 0, and err_alloc_id runs kfd_process_free_id()
which ida_free()s id 0 from the primary's table. The series only adds
the mes_hold init there. Deserves its own patch (jump to
err_register_notifier instead).

> [High] pre-existing: queue_refcount leak in kfd_queue_buffer_get()

Pre-existing and correct: kfd_queue_buffer_get() bumps queue_refcount
even when base.bo is NULL, and the unref keys on the BO pointer. The new
kfd_queue_ref_bo_va() mirrors the unref and is consistent with it.
Rejecting a mapping without a BO in kfd_queue_buffer_get() is the fix,
separate patch.


[PATCH v1 5/9] drm/amdkfd: keep queue storage until MES confirmed retirement

> [Medium] premature release of user queue buffers when create_queue_cpsch() quarantines queue

Correct. zombie_no_user_bos exists because kfd_ioctl_create_queue()
releases the buffers on its own copy of the properties on every error,
and init_queue() memcpy'd the same BO pointers into q->properties. So
the MQD, doorbell and gang context are kept while the ring, rptr, wptr,
EOP and CWSR buffers that MQD points at lose their references and their
unmap protection right away. That defeats the quarantine for the biggest
part of the queue. v2: when pqm_create_queue() sees a zombie on its
error path, the queue takes its own references (amdgpu_bo_ref() on the
five BOs, the VA queue_refcounts, kfd_queue_buffer_svm_get() for the
CWSR range) before the ioctl drops its set, and the reaper releases them
through the normal path. zombie_no_user_bos goes away.

> [Medium] active queue count underflow on reset of quarantined queue

Correct, same as the second zombie point on 4/9. v2 clears is_active in
the create_queue_cpsch() cleanup path, and set_queue_as_reset() no
longer runs for zombies.

> [Medium] bo_va->queue_refcount race and imbalance in pqm_destroy_queue()

Correct. kfd_queue_unref_bo_va() clamps at zero and kfd_queue_ref_bo_va()
always increments, so the second destroy's unref is a no-op and its
re-ref is a net +1; after the first thread is interrupted and re-refs,
the count is two above the single queue reference and the BOs can never
be unmapped. In the baseline the same race leaves the count at zero
while the queue lives, a transient loss of unmap protection; the series
turns it into a permanent leak. v2 moves kfd_queue_unref_bo_vas() after
dqm->ops.destroy_queue(), run only when the dqm dequeued the queue and
it is not a zombie. References stay while the queue is on hardware and
are dropped exactly once after it is gone. No re-ref on failure, and
kfd_queue_ref_bo_vas() is dropped from 4/9.

> [High] pre-existing: broken queue state and count in kfd_dqm_suspend_bad_queue_mes()

Pre-existing and correct, same pattern patch 5 fixes in
process_termination_cpsch(). Since v2 moves code into reset_queues_mes()
right next to it, v2 adds a separate small patch: decrement only if
is_active is still set after the reset. The "left inactive in MES on
reset failure" half is the kfd_dqm_suspend_bad_queue_mes() finding on
3/9 and is covered by moving the explicit removal into
reset_queues_mes().


[PATCH v1 6/9] drm/amdkfd: keep eviction and restore consistent when MES fails

> [High] kfd_process_evict_queues() overwrites -EIO across multiple PDDs

Pre-existing: the baseline has the same per-pdd overwrite and
evict_process_queues_cpsch() already returned -EIO when the reset
trylock failed. Patch 6 makes -EIO the return for every MES failure
though, and documents the "evicted, do not add back" contract, so the
lost value matters more than before. v2 keeps a sticky -EIO in
kfd_process_evict_queues(), folded into patch 6.

> [High] partial failure in restore_process_queues_cpsch() breaks eviction

Pre-existing. The baseline ends a failed restore in the same state:
qpd->evicted == 1 with the queues restored so far running, the next
evict skips on evicted++ > 0, the next restore decrements and quits. The
baseline was worse in that it marked every queue active before sending
anything and the retry added them twice; patch 6 fixes that. The window
itself is unchanged. v2 goes further and rolls back: on failure the
queues restored in that attempt are deactivated, counted down, marked
evicted and removed from MES best effort (-EIO leaves them MAPPED and
evicted, as evict does). The process is then either fully restored or
fully evicted and the retry starts from a known state.

> [Medium] restore_process_queues_cpsch() misses GFX11 oversubscription work

Correct. Moving increment_queue_count() behind add_queue_mes() means the
queue that crosses the threshold is not counted when add_queue_mes()
checks it, and the notify timer is not armed. The handler only re-arms
itself while already running. GFX11 only, but a regression. v2 restores
the baseline order (count, then add) and undoes the count on failure
instead, which is the same end state patch 6 intended.


[PATCH v1 7/9] drm/amdkfd: apply queue property updates only after unmap

> [High] race on q->pending_props between update_queue and set_perfcount

Correct, and the worst finding in the set. pending_props points into the
ioctl's stack, is set under p->mutex before the dqm lock and cleared
after it, and update_queue_mqd() consumes it whatever minfo says.
set_perfcount() is reachable from kfd_ioctl_profiler() of any
perfmon_capable() process, takes only the dqm lock and runs
update_queue_locked() on every queue of every process. The other
minfo users (GWS, CU mask, debug workaround) run under the same p->mutex
as the properties ioctl; set_perfcount() is the cross-process one. The
stack use after return and the NO_HWS mm WARN both follow.

v2 removes the queue field. The new properties travel with the call:
mqd_update_info gets a new_props pointer that pqm_update_queue_properties()
sets in a local minfo (all other members zero, which every update_mqd()
treats as nothing to do), update_queue_locked() applies it where
update_queue_mqd() runs and clears it to report that it did. A perfcount
or debug update carries no new_props and cannot apply somebody else's.

> [Medium] update_queue_locked() mutates MQD while active queue is in MES

Pre-existing, same path as the remove_queue_mes_on_reset_option()
finding on 3/9: after a successful halt or stop every active queue is
UNMAPPED and the retired check answers first, the shortcut is reached
only after a half-failed halt with MES fenced and a reset scheduled. The
v2 change there (-EIO for a non-retired queue while stopped or halted)
makes update_queue_locked() fail before update_queue_mqd(), and
pqm_update_queue_properties() then drops the new ring and keeps the old.

> [Medium] update_queue_locked() drops update with 0 return on stopped NO_HWS

Correct, minor. Before the series the properties were applied without
the MQD, after it nothing is applied, and both return 0. This is a
should-not-happen state (an active queue while the scheduler is stopped,
hence the WARN_ONCE), NO_HWS only. v2 returns -EBUSY there so the pqm
keeps the old ring and user space sees the failure.


[PATCH v1 8/9] drm/amdkfd: reconcile queue state with MES after a restart

> [High] set_queue_as_reset() clears is_active before MES reconciliation

Does not happen. The reset path is kgd2kfd_pre_reset() ->
kgd2kfd_suspend(kfd, true) -> kfd_suspend_all_processes() ->
evict_process_queues_cpsch(), which marks every queue evicted and
deactivates the active ones with the counters adjusted, then
stop_cpsch(). kgd2kfd_post_reset() runs kfd_dqm_set_queues_as_reset()
and then kfd_resume() -> start_cpsch() -> reconcile. By then every queue
is inactive and evicted, and set_queue_as_reset() adjusted the counters
for anything a partial restore had left active. The !is_active continue
skips queues that need nothing. The deactivate branch is a fallback for a
firmware restart without a preceding eviction, which no current path
produces: every stop_cpsch() with live processes is preceded by
eviction, and in_runpm is impossible while a pdd holds its runtime PM
reference. Your residual case, a queue left active by a partial restore
and then reset: set_queue_as_reset() deactivates it, has_reset_queue and
is_reset are set, and nothing re-adds it. add_all_kfd_queues_mes() keys
on is_active, restore is not run after a reset (processes stay evicted),
update_queue_locked() fails with -EACCES. No second decrement, no re-add.

The commit message describes the fallback as the regular flow, which is
misleading. v2 rewords it, and with the third finding the branch is gone.

> [Medium] kfd_dqm_reconcile_mes_queues() skips active unmapped queues

Intended. is_active with mes_state UNMAPPED is the state halt_cpsch()
and stop_cpsch() leave every active queue in through
remove_all_kfd_queues_mes(), and unhalt_cpsch() -> add_all_kfd_queues_mes()
re-adds exactly the queues with is_active set. add_queue_mes() returning
0 while stopped is the same contract. mes_fw_gen carries no meaning for
an UNMAPPED queue, there is nothing for the reconcile to compare. If the
reconcile deactivated these queues, add_all_kfd_queues_mes() would skip
them on unhalt and restore would too, and they would never come back.
Your "never re-added on resume" needs a stop with active queues followed
by a start with no unhalt and no restore; every resume path that stops
the scheduler with live processes evicts them first and restores them
through kgd2kfd_resume_process(), and S0ix uses halt/unhalt.

> [Medium] incomplete process eviction in kfd_dqm_reconcile_mes_queues()

Correct. When the branch does run it sets qpd->evicted = 1 while
flagging only the stale active queue, inactive siblings keep
is_evicted == false and last_evict_timestamp is not set.
QUEUE_IS_ACTIVE() looks at is_evicted, not qpd->evicted, so an update or
resume_single_queue() on a sibling would add it into an evicted process.
It is a fallback nothing reaches today, but it is wrong as written. v2
drops the deactivate/evict branch. The reconcile keeps what is needed
(retire the stale MES state, release lost tickets, lift the fence) and
warns if it finds a queue still marked active, since that would mean a
restart path forgot to evict. Deactivation stays in set_queue_as_reset()
and evict_process_queues_cpsch(), where it is done right.


Summary of v2 changes

1/9: per-XCC fw_gen, tickets record their XCC; u64 status on 12.1 so
     the firmware error code is printed; dma_rmb() between fence and
     status reads.
2/9: the pqm_create_queue() MES resource leak fix moves out of 5/9 into
     its own patch at the front with a Fixes tag.
3/9: fence on a timed-out ADD_QUEUE; drop the is_reset shortcut and
     return -EIO for a non-retired queue while stopped or halted;
     reset_queue_mes() fences and propagates -ETIMEDOUT of the
     remove-after-reset; a still pending ticket after the grace period
     fences and skips reset_queues_mes(); __remove_queue_mes() retires on
     DONE instead of sending a duplicate and the retired state is
     re-checked after a failed reset_queues_mes(); reset_queues_mes()
     fills gang_context_array_index and ticket; the post-recovery
     explicit removal moves into reset_queues_mes() and
     remove_all_kfd_queues_mes() keys on kfd_mes_queue_retired().
4/9: kgd2kfd_teardown_processes() always retires and waits;
     reset_queue_mes() skips set_queue_as_reset() for zombies;
     svms.restore_work is cancelled in the notifier release;
     kfd_queue_ref_bo_vas() is dropped.
5/9: a quarantined create failure keeps its own references on the user
     buffers, zombie_no_user_bos goes away; create_queue_cpsch() clears
     is_active in the cleanup path; pqm_destroy_queue() unrefs the VAs
     after the dqm dequeued the queue, no re-ref; new small patch for
     the kfd_dqm_suspend_bad_queue_mes() double decrement.
6/9: kfd_process_evict_queues() keeps -EIO across pdds; a failed restore
     rolls back the queues restored in that attempt; count before
     add_queue_mes() and undo on failure.
7/9: new properties travel in mqd_update_info, q->pending_props is
     removed; the NO_HWS stopped case returns -EBUSY.
8/9: the deactivate/evict branch is dropped and replaced by a warning;
     commit message reworded.

Left for separate patches, all pre-existing: the lock order between the
KGD and KFD per-queue reset paths (two findings), has_reset_queue tested
after the unmap in update_queue_locked(), context id 0 freed on alloc
failure in create_process(), queue_refcount on a mapping without a BO.

v2 follows once the retest on the dual R9700 box is done.

Regards,
Armas Spann <zappel@simple-co.de>
