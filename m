Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC766606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=djMn7/YB;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=Coge9Vde
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A000C112113;
	Thu, 26 Nov 2026 08:09:53 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D82B10FCA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616377;
 bh=1QfSHjLWRZ0lv0ESu2e6Vf6a+iTFooaEGPJoV0TkI7E=;
 h=From:To:Cc:Subject:Date:From;
 b=djMn7/YBC+KW3o7IpDyXiw5gKX3CjguPsGlsp5P+n7QUiY3u7LWxiBxX2ZCYaFuUZ
 gf7/un6CXTwj1EkB0Et18izPht74PJ3ti1BsFoGd+9oV7PPNhdcM5PYC3BcuM85Hnj
 T3ICXzo9RKP0A5P7q06kg6WWw2Z+hnYZGh7wL/Hk/hhXYKGdcPCNXN86wN562ub68b
 w7PJcK94h++ZiCcVozk4jn8ymDyK91ozW4lgScU8pSlg1YcFxVw89zJsyYqp640DWS
 z3GBb4lIxVbq/jeZB3oR0bfpZXNcIJer1rI6bYkfCJic4CnXyGiBoz2HP4PoMXpoHU
 I2puXewEgo6aQ==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 42A3E17F366;
 Wed, 25 Nov 2026 15:19:37 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MxgXwQ8bBJ4; Wed, 25 Nov 2026 15:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616376;
 bh=1QfSHjLWRZ0lv0ESu2e6Vf6a+iTFooaEGPJoV0TkI7E=;
 h=From:To:Cc:Subject:Date:From;
 b=Coge9Vde5PUvoNH6qscfKnvEms1aoY1VAMNkzApfr2wjzKVajM36+yKmgDXMcZX0i
 HP5ZumiKc+nIJyFp6MdzRJN3n6ah+AFPIJSteFDJnk1cdbNJ2esPJZ4oZapQeaZjFc
 4iDq+wrcUPDd+TrMCE/+Yb/Otq85bAf2tjt8miW/0colulQMBVDlEpXu9qOgKhhZ2U
 TbLoz7HzleeacD7poBbjM6rhARDsrERkkPDZ/FT61euGjw65CpyFkERAlndr9Je6DN
 m/DRyFPaVB9fsoBjJBwpkt2cd3UNYWMNv44ccWB20jNAvf2iKTTbe3f8zWuiHK1f66
 2SjfKhhTH/nvw==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id A013917F362;
 Wed, 25 Nov 2026 15:19:36 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 0/9] drm/amdgpu/amdkfd: fix MES queue lifecycle on multi-GPU
Date: Wed, 25 Nov 2026 15:19:23 +0100
Message-ID: <20261125141933.154222-1-zappel@simple-co.de>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a dual R9700 Pro (gfx 12.0.1) system running RCCL distributed
training, MES hits 2-second preemption timeouts on REMOVE_QUEUE and
SUSPEND after 90 to 120 seconds of operation. Both GPUs fail during
RCCL collectives. The timeout triggers a MODE1 reset, which loses VRAM
and cascades into a second reset on the peer GPU.

Root cause: cwsr_enable=0 prevents MES from preempting running compute
waves. When an RCCL kernel on GPU0 waits for its peer on GPU1, and
GPU1's queue gets evicted, MES cannot preempt GPU0's kernel because
there is no CWSR. The 2s MES preemption timeout fires, MES rejects the
command, and the driver treats it as a hang.

Separately, KFD frees queue storage (MQD, doorbell id, gang context)
before MES has confirmed the removal. A REMOVE_QUEUE that completes
late writes the queue state back into an MQD that has been given to the
next queue. This is a use-after-free on the firmware side.

This series fixes both problems:

  1/9  Distinguish rejected from timed-out MES commands so callers
       can tell a firmware that said no from one that stopped answering.
       Add a ticket for late completion polling.
  2/9  Factor out per-queue MES resource freeing into a helper.
  3/9  Track per-queue MES state (mapped/unmapped/pending) so the rest
       of the dqm knows whether MES may still reference storage.
  4/9  Add a quarantine for queues that MES has not released. A reaper
       workqueue polls for late completions and cleans up.
  5/9  Defer freeing of queue storage until MES has confirmed retirement
       in all four teardown paths (destroy, create failure, termination,
       process exit).
  6/9  Keep eviction and restore consistent when MES fails. Do not
       restore a queue whose eviction was not confirmed.
  7/9  Apply queue property updates only after the queue is unmapped,
       not while MES still owns it.
  8/9  Reconcile KFD queue state with MES after a scheduler restart.
       Queues from the previous firmware instance are retired.
  9/9  Force cwsr_enable=1 on gfx11+ discrete GPUs when a second MES
       GPU is present. Per-device decision, logged to dmesg.

Tested on a dual R9700 Pro system (gfx 12.0.1, Threadripper 1950X,
64GB, Gentoo, kernel 7.3.5-p1 with these patches):

  - F5-TTS dual-GPU training (batch 4 + grad accum 2): 30 min,
    500+ updates, 2.93s/update, both GPUs 100%, stable
  - F5-TTS dual-GPU training (default frame batching, pretrained
    weights): 10 min, 319 updates, 1.58s/update, both GPUs 100%
  - dmesg after all tests: zero MES rejects, zero resets
  - Patch 9 override test (cwsr_enable=0 in cmdline): kernel forces 1,
    logs warning per affected GPU
  - VRAM usage stable at 65% throughout, no OOM under normal batch
    sizes

Related reports:

  https://github.com/ROCm/hrx-system/issues/2938
  https://github.com/ROCm/TheRock/issues/9279
  https://github.com/ROCm/TheRock/issues/9299
  https://github.com/ROCm/rccl/issues/2193

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>

Armas Spann (9):
  drm/amdgpu/mes: distinguish rejected from timed out commands
  drm/amdkfd: factor out freeing of per-queue MES resources
  drm/amdkfd: track whether MES knows each queue
  drm/amdkfd: add a quarantine for queues MES has not retired
  drm/amdkfd: keep queue storage until MES confirmed retirement
  drm/amdkfd: keep eviction and restore consistent when MES fails
  drm/amdkfd: apply queue property updates only after unmap
  drm/amdkfd: reconcile queue state with MES after a restart
  drm/amdkfd: force CWSR on with more than one MES GPU

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  99 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  85 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  53 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  54 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  55 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  89 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  42 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 747 ++++++++++++++++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  31 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  48 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  64 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 183 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  63 +-
 14 files changed, 1460 insertions(+), 154 deletions(-)

Changes v1 -> v2:

Addresses the review of v1. Nine patches as before, the fixes went
into the patches that introduced the problems.

1/9 drm/amdgpu/mes: distinguish rejected from timed out commands
  - mes.fw_gen is one counter per XCC, incremented in the xcc_hw_init of
    each MES version; a ticket records the XCC it was submitted on and
    the poll compares against that entry
  - mes_v12_1 reads the status slot as 64 bits and prints the firmware
    error code in the upper half; it was read as 32 bits, so the code
    the patch set out to print was never seen there
  - dma_rmb() between the fence and the status read in
    amdgpu_mes_ticket_poll() and after the fence poll in the three
    submit paths

3/9 drm/amdkfd: track whether MES knows each queue
  - fence MES on a timed out ADD_QUEUE, as the REMOVE path does
  - a removal that cannot be sent because the scheduler is halted or
    stopped returns -EIO for a queue MES still has, instead of success;
    the is_reset shortcut is gone
  - reset_queue_mes() looks at the result of the remove-after-reset:
    a timeout fences MES and fails the per-queue reset so that the
    caller escalates to a GPU reset, a rejection keeps the queue
    UNKNOWN as before
  - after the grace period, a REMOVE_QUEUE that is still unanswered
    fences MES and escalates directly; reset_queues_mes() and its three
    commands only run when MES answered
  - __remove_queue_mes() retires a queue whose earlier REMOVE_QUEUE
    completed between the caller's check and its own, instead of
    sending a duplicate; after a failed reset_queues_mes() the retired
    state is re-checked before escalating
  - reset_queues_mes() fills gang_context_array_index and the ticket of
    the REMOVE_QUEUE it hands to amdgpu_gfx_reset_mes_compute(), and
    refuses to run behind an unanswered command
  - the explicit removal of a queue the recovery left in MES moved from
    remove_queue_mes_on_reset_option() into reset_queues_mes(), so
    kfd_dqm_suspend_bad_queue_mes() gets it too
  - remove_all_kfd_queues_mes() keys on kfd_mes_queue_retired() instead
    of is_active, like the other teardown paths

4/9 drm/amdkfd: add a quarantine for queues MES has not retired
  - kgd2kfd_teardown_processes() retires the queues and waits for the
    processes also when the process table is already empty; a process
    with zombies leaves the table before it is freed
  - a per-queue reset of a zombie does the MES side only and skips
    set_queue_as_reset(): no counter change, no has_reset_queue and no
    is_reset for a queue the process no longer owns
  - cancel svms.restore_work in the notifier release, next to the other
    works of the process, instead of in the deferred release
  - kfd_queue_ref_bo_vas() dropped (see 5/9)

5/9 drm/amdkfd: keep queue storage until MES confirmed retirement
  - pqm_destroy_queue() drops the bo_va queue_refcounts once, after the
    dqm has dequeued the queue, instead of before the destroy with a
    re-ref on failure; a second destroy of a queue id while the first
    one sleeps on a suspended queue no longer leaves one count too many
  - a queue quarantined from a failed create takes its own references
    on the ring, pointer, EOP and CWSR buffers (kfd_queue_hold_buffers())
    before the ioctl drops its set; zombie_no_user_bos is gone and the
    reaper releases the buffers of every zombie
  - the cleanup path of create_queue_cpsch() clears is_active after it
    decremented the count, so a later per-queue reset of the zombie
    cannot decrement it again
  - kfd_dqm_suspend_bad_queue_mes() decrements the active count only if
    the reset it asked for has not done so already (pre-existing)
  - kfd_queue_unref_bo_vas() reserves the VM without being
    interruptible, it runs after the queue is gone now

6/9 drm/amdkfd: keep eviction and restore consistent when MES fails
  - kfd_process_evict_queues() returns -EIO when any device returned
    it, instead of the result of the last device (pre-existing)
  - a failed restore_process_queues_cpsch() takes the queues restored
    in that attempt off the hardware again, so the process is fully
    evicted and the retry starts from a known state (pre-existing)
  - a queue is counted before ADD_QUEUE is sent and taken out of the
    count on failure, so the GFX11 oversubscription check in
    add_queue_mes() sees it

7/9 drm/amdkfd: apply queue property updates only after unmap
  - the new properties travel in struct mqd_update_info (new_props)
    with the update_queue() call, q->pending_props is gone; a perfcount
    update from another process can no longer apply, or race with, the
    properties of an update in flight
  - update_queue_locked() returns -EBUSY for a no-HWS queue updated
    while the scheduler is stopped, instead of 0 with nothing applied

8/9 drm/amdkfd: reconcile queue state with MES after a restart
  - the deactivate/evict branch is gone; the reconcile retires the
    stale MES state, releases lost tickets and lifts the fence, and
    warns if it finds a queue still marked active. Deactivation stays
    in set_queue_as_reset() and evict_process_queues_cpsch()
  - commit message reworded accordingly

Unchanged: 2/9, 9/9.

Not addressed here, pre-existing and for separate patches: the lock
order between the KGD and KFD per-queue reset paths
(kfd_reset_queue_mes() without the dqm lock), has_reset_queue tested
after the unmap in update_queue(), context id 0 freed on an allocation
failure in create_process(), and the queue_refcount taken on a mapping
without a BO in kfd_queue_buffer_get().

-- 
2.47.3

