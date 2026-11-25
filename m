Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B831606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=gQFBSrV7;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=AXsbmZZL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E736011211E;
	Thu, 26 Nov 2026 08:10:15 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988A210FCBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=IrZCuIs3y6xyZM695J8hgHiugnCxC7GC4cVXGopDX1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gQFBSrV72LQekX71UUpsaI8Be741XacgZQud7VvGdIepGZ/6xkIl/lDCCFNgxWdzB
 GGAyLgcUUMxR91r68NkxV8lMp+Qfuipsad7h46/a3uFGiSxNxHtOyQ3nbkIDv3Lp86
 ql3siZS+Z2KCTPnDnSGYWJltygUAWRG+7JpWoIkjH+T39cSN/ltSqin0rcT1XHVJYo
 QtBN4kdOVllNUFr1/k2dFaUGqmRT544Bl0wqiZiQSeFaQ1o+es8Qk1LUFVwZ+N6bEV
 LHu8kZqLCaEd4Og6KVfs7Wg+UvgeTWUaeJYkAHTjeNWWl+R4Wg2pi8X/23swgzdlJU
 kFb/SxyQAUceQ==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 5860317F36C;
 Wed, 25 Nov 2026 15:19:38 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSa1ogwcgzFh; Wed, 25 Nov 2026 15:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616377;
 bh=IrZCuIs3y6xyZM695J8hgHiugnCxC7GC4cVXGopDX1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AXsbmZZLcl7uRD41GwnhZ6qpcE9BnAPhoIXiw6KKI3XLoApPeGJpJcjmTdYETDHL2
 JchX6kA60onk/941vs3LYNn6NmFpkFu8DaBmFj2lFkS4stxCFxZiRiB75G0ckuMqWs
 vWCCcxtIulboIGR6E473GAmkxCzy2l/qiP51XZ1awlld8uXVlCsnMKt9Q1GIy9HRLO
 c0+0jaVh/Xw1MQQl1IGKIAGLqfPzb79fmdQcTkllNYhqkl1EuDsERk1QyjwPK8Up+l
 1LqCjYH6IUcYYUYKI4uEOWxYvKNWqhisI6nNeAKKOKbOqCy61erqYXdjL9lnFPCuts
 ZPDFPx5AXmX8w==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id A088817F36A;
 Wed, 25 Nov 2026 15:19:37 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 4/9] drm/amdkfd: add a quarantine for queues MES has not
 retired
Date: Wed, 25 Nov 2026 15:19:27 +0100
Message-ID: <20261125141933.154222-5-zappel@simple-co.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125141933.154222-1-zappel@simple-co.de>
References: <20261125141933.154222-1-zappel@simple-co.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A queue that is destroyed while MES may still reference it has to keep
its MQD, gang context, write pointer mapping, user buffers and its
doorbell and SDMA ids. On gfx12 the MQD comes from a first fit
sub-allocator and the doorbell id from a first fit bitmap, so both are
normally handed to the very next queue the process creates.

Add the machinery to park such a queue: a per-device list of zombies and
a delayed work that frees a zombie once kfd_mes_queue_retired() is true
for it. The usual way out is the MES restart done by the GPU reset that
the failed command asked for. start_cpsch() kicks the reaper for that
case.

If the removal was skipped and did not fail (scheduler halted or
stopped, GPU reset in progress), the reaper sends it once that becomes
possible.

MES can report a quarantined queue as hung. The per-queue reset then
does the MES side for it, the reset and the removal, and leaves the
process alone: the queue is not counted any more, and the process is
not marked as having a reset queue for one it no longer owns.

A zombie uses the pdd, the process context, the doorbell page and the
GPU VM of its process, so it takes a hold on the process. The release
worker frees those only when the last hold is gone. It must not block
for that, because kfd_create_process() flushes the release workqueue and
every new KFD process would hang behind it. The worker removes the
debugfs and sysfs entries and the context id, which is what a new
process with the same pid needs gone, and returns. The reaper queues the
work again when it frees the last zombie of the process. As a side
effect the eviction fence of every exiting process is now signalled
after those entries are removed, no longer before.

The SVM restore work of the process was cancelled in the release worker,
which now runs an unbounded time after the notifier release. Cancel it
in the notifier release with the other works of the process, before the
mm it would look up can be a different one.

Device removal must not wait for MES. kgd2kfd_teardown_processes()
declares every queue of the device retired and waits for the processes
to go, whether the process table still lists any or not: a process that
has exited is off the table while its zombies keep it alive.

Nothing is quarantined yet. The next patch converts the paths that free
queue storage.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  16 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 163 +++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  14 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  25 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  57 +++++-
 5 files changed, 260 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index edafbd937..f631047e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1805,11 +1805,6 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 
 	mutex_lock(&kfd_processes_mutex);
 
-	if (hash_empty(kfd_processes_table)) {
-		mutex_unlock(&kfd_processes_mutex);
-		return;
-	}
-
 	hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_processes) {
 		for (int i = 0; i < p->n_pdds; i++) {
 			dev = p->pdds[i]->dev;
@@ -1824,6 +1819,17 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 	if (!adev->kfd.dev)
 		return;
 
+	/*
+	 * Queues that MES never confirmed as removed keep their process
+	 * alive, and such a process is counted in kfd_processes_count after
+	 * it has left the table. The device is going away, so stop waiting
+	 * for MES, whether the table is empty or not.
+	 */
+	if (adev->kfd.dev->init_complete) {
+		for (unsigned int i = 0; i < adev->kfd.dev->num_nodes; i++)
+			kfd_dqm_retire_all(adev->kfd.dev->nodes[i]->dqm);
+	}
+
 	/*
 	 * Wait for all KFD processes using adev to terminate. Must be
 	 * unbounded: device state is freed once they are gone.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 550ad428e..cb0263881 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -249,6 +249,10 @@ static bool kfd_mes_queue_retired(struct device_queue_manager *dqm,
 	if (q->mes_state == KFD_MES_QUEUE_UNMAPPED)
 		return true;
 
+	/* The device is being removed and MES is shut down next */
+	if (dqm->mes_retire_all)
+		goto retired;
+
 	/* The firmware instance that knew the queue is gone */
 	if (q->mes_fw_gen != kfd_mes_gen(dqm))
 		goto retired;
@@ -684,7 +688,13 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	 * its storage until MES is restarted.
 	 */
 	r = remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
-	set_queue_as_reset(dqm, q, &pdd->qpd, true);
+	/*
+	 * A quarantined queue is destroyed as far as its process is
+	 * concerned: it is not counted, and the process is not punished
+	 * for a queue it no longer owns. Only the MES side was needed.
+	 */
+	if (!q->is_zombie)
+		set_queue_as_reset(dqm, q, &pdd->qpd, true);
 	if (r == -ETIMEDOUT)
 		return r;
 	if (r)
@@ -1748,6 +1758,142 @@ static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
 	return 0;
 }
 
+/*
+ * Quarantine
+ *
+ * A queue that is destroyed before MES has confirmed its removal keeps its
+ * MQD, gang context, wptr mapping, user buffers and its doorbell and SDMA
+ * ids. It is taken off the lists of its process, so user space sees it
+ * destroyed, and parked on dqm->zombie_queues. The reaper frees it once
+ * kfd_mes_queue_retired() says MES has let go, which normally means the
+ * firmware was restarted by the GPU reset the failed command asked for.
+ *
+ * A zombie points at its kfd_process_device. It takes a hold on the
+ * process (p->mes_hold), so the pdd, the process context, the doorbell
+ * page and the GPU VM outlive every zombie of the process.
+ *
+ * The reaper takes p->mutex and the dqm lock one after the other and never
+ * nested. It frees buffer objects, so it does that outside the dqm lock.
+ */
+
+/* dqm lock held. @q is off qpd->queues_list already. */
+static void __maybe_unused dqm_quarantine_queue(struct device_queue_manager *dqm,
+						struct qcm_process_device *qpd,
+						struct queue *q)
+{
+	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
+
+	dev_warn(dqm->dev->adev->dev,
+		 "MES did not confirm retirement of queue doorbell=0x%x, keeping its storage\n",
+		 q->properties.doorbell_off);
+
+	q->is_zombie = true;
+	q->zombie_pdd = pdd;
+	atomic_inc(&pdd->process->mes_hold);
+	list_add_tail(&q->zombie_node, &dqm->zombie_queues);
+}
+
+/*
+ * Called by the pqm when it holds no more references to a quarantined
+ * queue. The queue belongs to the reaper afterwards and the caller must
+ * not touch it again.
+ */
+void kfd_dqm_zombie_ready(struct device_queue_manager *dqm, struct queue *q)
+{
+	dqm_lock(dqm);
+	q->zombie_ready = true;
+	dqm_unlock(dqm);
+
+	mod_delayed_work(system_dfl_wq, &dqm->zombie_work, 0);
+}
+
+/* No locks held. @q is off dqm->zombie_queues and retired. */
+static void kfd_dqm_release_zombie(struct device_queue_manager *dqm,
+				   struct queue *q)
+{
+	struct kfd_process_device *pdd = q->zombie_pdd;
+	struct kfd_process *p = pdd->process;
+	struct kfd_node *dev = q->device;
+	struct mqd_manager *mqd_mgr =
+		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
+
+	/* Process side. The pdd is alive, the queue has a hold on it. */
+	mutex_lock(&p->mutex);
+	deallocate_doorbell(&pdd->qpd, q);
+	kfd_queue_unref_bo_vas(pdd, &q->properties);
+	kfd_queue_release_buffers(pdd, &q->properties, false);
+	mutex_unlock(&p->mutex);
+
+	/* Device side */
+	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
+		dqm_lock(dqm);
+		deallocate_sdma_queue(dqm, q);
+		dqm_unlock(dqm);
+	}
+	dqm_repin_mqd_bo(dqm, q);
+	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+	kfd_queue_free_mes_resources(dev, q);
+	uninit_queue(q);
+
+	/* Last access to the pdd, the process may be freed after this */
+	kfd_process_put_mes_hold(p);
+}
+
+static void kfd_dqm_zombie_worker(struct work_struct *work)
+{
+	struct device_queue_manager *dqm =
+		container_of(to_delayed_work(work),
+			     struct device_queue_manager, zombie_work);
+	struct queue *q, *tmp;
+	LIST_HEAD(retired);
+	bool more;
+
+	dqm_lock(dqm);
+	list_for_each_entry_safe(q, tmp, &dqm->zombie_queues, zombie_node) {
+		if (!q->zombie_ready)
+			continue;
+
+		/*
+		 * No REMOVE_QUEUE was sent for this queue because the
+		 * scheduler was stopped or halted, or a reset held it off.
+		 * Send it once that is possible. A failure leaves the queue
+		 * UNKNOWN, so this is not repeated.
+		 */
+		if (q->mes_state == KFD_MES_QUEUE_MAPPED &&
+		    !kfd_mes_queue_retired(dqm, q))
+			remove_queue_mes(dqm, q, &q->zombie_pdd->qpd);
+
+		if (kfd_mes_queue_retired(dqm, q))
+			list_move_tail(&q->zombie_node, &retired);
+	}
+	more = !list_empty(&dqm->zombie_queues);
+	dqm_unlock(dqm);
+
+	list_for_each_entry_safe(q, tmp, &retired, zombie_node) {
+		list_del(&q->zombie_node);
+		kfd_dqm_release_zombie(dqm, q);
+	}
+
+	if (more)
+		queue_delayed_work(system_dfl_wq, &dqm->zombie_work,
+				   msecs_to_jiffies(KFD_MES_ZOMBIE_POLL_MS));
+}
+
+/*
+ * The device is being removed. MES is shut down right after, so nothing a
+ * quarantined queue holds can be handed to a new owner that MES would then
+ * corrupt. Release all zombies so process teardown can finish.
+ */
+void kfd_dqm_retire_all(struct device_queue_manager *dqm)
+{
+	dqm_lock(dqm);
+	dqm->mes_retire_all = true;
+	dqm_unlock(dqm);
+
+	mod_delayed_work(system_dfl_wq, &dqm->zombie_work, 0);
+}
+
 static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
@@ -2617,6 +2763,10 @@ static int start_cpsch(struct device_queue_manager *dqm)
 		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
 		GFP_KERNEL);
 
+	/* A restart of the MES firmware retires every quarantined queue */
+	if (!list_empty(&dqm->zombie_queues))
+		mod_delayed_work(system_dfl_wq, &dqm->zombie_work, 0);
+
 	dqm_unlock(dqm);
 
 	return 0;
@@ -2996,6 +3146,12 @@ static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *
 		}
 	}
 
+	/* MES may report a quarantined queue as hung, it still has it */
+	list_for_each_entry(q, &dqm->zombie_queues, zombie_node) {
+		if (doorbell_offset == q->properties.doorbell_off)
+			return q;
+	}
+
 	return NULL;
 }
 
@@ -3757,6 +3913,9 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 	if (!dqm)
 		return NULL;
 
+	INIT_LIST_HEAD(&dqm->zombie_queues);
+	INIT_DELAYED_WORK(&dqm->zombie_work, kfd_dqm_zombie_worker);
+
 	switch (dev->adev->asic_type) {
 	/* HWS is not available on Hawaii. */
 	case CHIP_HAWAII:
@@ -3893,6 +4052,8 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
 	cancel_delayed_work_sync(&dqm->notify_unmap_work);
 	dqm->ops.stop(dqm);
+	cancel_delayed_work_sync(&dqm->zombie_work);
+	WARN_ON(!list_empty(&dqm->zombie_queues));
 	dqm->ops.uninitialize(dqm);
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		deallocate_hiq_sdma_mqd(dqm->dev, &dqm->hiq_sdma_mqd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 239168838..a2defcb99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -44,6 +44,9 @@
 #define KFD_MES_REMOVE_GRACE_MS		4000
 #define KFD_MES_REMOVE_POLL_US		2000
 
+/* How often the reaper looks at quarantined queues */
+#define KFD_MES_ZOMBIE_POLL_MS		500
+
 struct device_process_node {
 	struct qcm_process_device *qpd;
 	struct list_head list;
@@ -309,6 +312,15 @@ struct device_queue_manager {
 	u32			mes_fence_gen;
 	/* copy of the unanswered ticket, never released through this copy */
 	struct amdgpu_mes_cmd_ticket mes_fence_ticket;
+
+	/*
+	 * Destroyed queues that MES has not confirmed as removed, and the
+	 * reaper that frees them. The list is protected by the dqm lock.
+	 */
+	struct list_head	zombie_queues;
+	struct delayed_work	zombie_work;
+	/* the device is going away, treat every queue as retired */
+	bool			mes_retire_all;
 };
 
 void device_queue_manager_init_cik(
@@ -356,6 +368,8 @@ bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 void kfd_dqm_set_queues_as_reset(struct device_queue_manager *dqm);
 int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
 			int pipe, int queue, unsigned int db);
+void kfd_dqm_zombie_ready(struct device_queue_manager *dqm, struct queue *q);
+void kfd_dqm_retire_all(struct device_queue_manager *dqm);
 size_t mqd_size_from_queue_type(struct device_queue_manager *dqm,
 				enum kfd_queue_type type);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b5eae33d8..711779665 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -658,6 +658,19 @@ struct queue {
 	/* REMOVE_QUEUE that MES has not answered yet */
 	struct amdgpu_mes_cmd_ticket mes_ticket;
 
+	/*
+	 * Quarantine. A queue that is destroyed while MES may still use it
+	 * keeps all of its storage and waits on dqm->zombie_queues.
+	 */
+	struct list_head zombie_node;	/* dqm lock */
+	struct kfd_process_device *zombie_pdd;
+	/* written once under the dqm lock, stable afterwards */
+	bool is_zombie;
+	/* the pqm is done with the queue, the reaper may free it. dqm lock */
+	bool zombie_ready;
+	/* the dqm took the queue off its lists, the pqm has to finish */
+	bool dqm_dequeued;
+
 	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
 	 * TTM evicts it into the hibernation image, and repinned on resume. Set
 	 * while the BO is unpinned so the resume path knows to repin it.
@@ -963,6 +976,17 @@ struct kfd_process {
 	struct kref ref;
 	struct work_struct release_work;
 
+	/*
+	 * Holds on the storage of the process: one for the process itself,
+	 * one for each of its queues on a dqm->zombie_queues list. A zombie
+	 * uses the pdd, the process context, the doorbell page and the GPU
+	 * VM, so the release worker frees those only when the last hold is
+	 * gone.
+	 */
+	atomic_t mes_hold;
+	/* the release worker has dropped the hold of the process itself */
+	bool mes_hold_dropped;
+
 	struct mutex mutex;
 
 	/*
@@ -1446,6 +1470,7 @@ struct process_queue_node {
 
 void kfd_process_dequeue_from_device(struct kfd_process_device *pdd);
 void kfd_process_dequeue_from_all_devices(struct kfd_process *p);
+void kfd_process_put_mes_hold(struct kfd_process *p);
 int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p);
 void pqm_uninit(struct process_queue_manager *pqm);
 int pqm_create_queue(struct process_queue_manager *pqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d..51c3fa39f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1331,20 +1331,15 @@ static void kfd_process_wq_release(struct work_struct *work)
 					     release_work);
 	struct dma_fence *ef;
 
+	/* Second run, queued when the last quarantined queue was freed */
+	if (p->mes_hold_dropped)
+		goto release_storage;
+
 	/*
 	 * If GPU in reset, user queues may still running, wait for reset complete.
 	 */
 	kfd_process_wait_gpu_reset_complete(p);
 
-	/* Signal the eviction fence after user mode queues are
-	 * destroyed. This allows any BOs to be freed without
-	 * triggering pointless evictions or waiting for fences.
-	 */
-	synchronize_rcu();
-	ef = rcu_access_pointer(p->ef);
-	if (ef)
-		dma_fence_signal(ef);
-
 	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
 		kfd_process_free_id(p);
 	else
@@ -1359,6 +1354,32 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 */
 	kfd_process_remove_sysfs(p);
 
+	/*
+	 * Queues that MES has not let go of still use the pdds, the process
+	 * context, the doorbell page and the GPU VM. Everything that carries
+	 * the pid is gone at this point, so stop here. The reaper queues
+	 * this work again when it frees the last of those queues. Do not
+	 * wait instead: kfd_create_process() flushes this workqueue. A work
+	 * item never runs twice at the same time, so the second run cannot
+	 * free the process under us.
+	 */
+	p->mes_hold_dropped = true;
+	if (!atomic_dec_and_test(&p->mes_hold)) {
+		pr_warn("Process pid %d: release waits for MES to retire %d queue(s), a GPU reset retires them\n",
+			p->lead_thread->pid, atomic_read(&p->mes_hold));
+		return;
+	}
+
+release_storage:
+	/* Signal the eviction fence after user mode queues are
+	 * destroyed. This allows any BOs to be freed without
+	 * triggering pointless evictions or waiting for fences.
+	 */
+	synchronize_rcu();
+	ef = rcu_access_pointer(p->ef);
+	if (ef)
+		dma_fence_signal(ef);
+
 	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
@@ -1375,6 +1396,17 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfree(p);
 }
 
+/*
+ * Drop the hold a quarantined queue had on its process. Called by the dqm
+ * when the queue has been freed. The last one finishes a release that
+ * kfd_process_wq_release() had to put off.
+ */
+void kfd_process_put_mes_hold(struct kfd_process *p)
+{
+	if (atomic_dec_and_test(&p->mes_hold))
+		queue_work(kfd_process_wq, &p->release_work);
+}
+
 static void kfd_process_ref_release(struct kref *ref)
 {
 	struct kfd_process *p = container_of(ref, struct kfd_process, ref);
@@ -1422,6 +1454,12 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 	kfd_process_table_remove(p);
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
+	/*
+	 * Not left to svm_range_list_fini(): the release worker may now
+	 * run long after this, and the SVM restore work would look up the
+	 * mm of the lead thread, which can be a new one by then.
+	 */
+	cancel_delayed_work_sync(&p->svms.restore_work);
 	/*
 	 * If work pending, cancel it and drop the extra ref
 	 */
@@ -1702,6 +1740,7 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 		goto err_alloc_process;
 
 	kref_init(&process->ref);
+	atomic_set(&process->mes_hold, 1);
 	mutex_init(&process->mutex);
 	process->mm = thread->mm;
 	process->lead_thread = thread->group_leader;
-- 
2.47.3

