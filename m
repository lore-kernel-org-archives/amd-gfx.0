Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCCD606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=G9rBy1na;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=lyFffS/D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AA1112101;
	Thu, 26 Nov 2026 08:09:34 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ABE010FCB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616379;
 bh=kUJmfQnIs/amTfocQc3tcTaaz1TiSYeSLc1N5jqZx2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G9rBy1na5KtBNBHb+mDKUK75gTr2s7IowpYZi38o09X6Glj2ACOt2fMINmLNP5Yeu
 1TXvAX3z1YskdqJ8Lh/5xJVBhaM5Oz7Nzj0Q12QJ+/cDB0bjZNbLX5ztzom/MBNWoW
 BzVmGuiMM1GNSQmGR53KhNP+Ksn2hDc3cncI/SNdsduGJdAsQNeYS/qWeivDfCrxi8
 ArEguTu+PAiD95w0zeA3XbJ/zEHsCv9ZcaNZyjRNpPVpTToac3fDR0JYJca3h8msyQ
 Cl+x/Ad+9CHM/VCKIffCKfq1rMe9Wd3UltFsN7kU0bltdTGVB49MbZqMA/qFQNcXJN
 Q4Do/EcgTx5Pw==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 74D1C17F36A;
 Wed, 25 Nov 2026 15:19:39 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nV01KpoJjDC0; Wed, 25 Nov 2026 15:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=kUJmfQnIs/amTfocQc3tcTaaz1TiSYeSLc1N5jqZx2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lyFffS/DxcLBtojMx9h7j4Zk6+QevVTclbXCwEr7S/NUWpv26gUcaAoj+FTG/d7PV
 tKPynVzLMRM/NJz28PIHlbEbpNND+zVgMjgwlVjgPOFotBofXx/tZcDVhCGl92iB3X
 gcfXsYXdC6cjFVxNZcQUWl9mU/SZs2hUO6pxJbMrq/NSynMV9oxAHwkEiW+Va/mRXD
 8UITzUa6qlADQB2cCkVbvp8qtqu/X/+zr04uXD0N5NNQarsx1jtXyFXjHkkXupTf0y
 XDt+0Pxmx1G0eC/TUeCgrJeJ6CqiUzpzD1LFWpX+LXzzyD+7apr5z8rvt7zLoRUE6B
 Dxlgi5Wrtj4+w==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id DE30017F364;
 Wed, 25 Nov 2026 15:19:37 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 5/9] drm/amdkfd: keep queue storage until MES confirmed
 retirement
Date: Wed, 25 Nov 2026 15:19:28 +0100
Message-ID: <20261125141933.154222-6-zappel@simple-co.de>
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

KFD frees and reuses the storage of a queue without requiring that MES
confirmed the removal of the queue:

- destroy_queue_cpsch() gives the doorbell id back before REMOVE_QUEUE
  is sent, and frees the MQD whatever the command returned.
- pqm_destroy_queue() goes on to free the gang context, the write
  pointer mapping and the user buffer references on -ETIME and -EIO. On
  any other error it bails out and keeps the pqm node of a queue that
  the dqm has already unlinked and whose MQD is freed. A second destroy
  of that queue id corrupts the list and frees the MQD twice.
- The error path of queue creation frees the MQD and the ids when
  ADD_QUEUE failed, although a command that timed out can still be
  executed.
- process_termination_cpsch() logs REMOVE_QUEUE failures and frees
  everything.

A REMOVE_QUEUE that completes late writes the queue state back into an
MQD that has been given to, and zeroed for, the next queue.

Make all four paths ask kfd_mes_queue_retired() and hand the queue to
the quarantine when the answer is no. Ids are released after the unmap
and no longer before it. The pqm completes a destroy whenever the dqm
has unlinked the queue.

The user buffers of a queue go with it. pqm_destroy_queue() dropped the
unmap protection of the ring, pointers, EOP and CWSR buffers before the
queue was taken off the hardware, and took it back when that failed.
While a debugger has the queue suspended the destroy sleeps without the
locks, and a second destroy of the same queue id in that window ends
with one unmap protection too many that nothing drops. Drop the
references once, after the dqm has dequeued the queue. A quarantined
queue keeps them until the reaper frees it. A quarantined queue from a
failed create takes references of its own on the buffers, because the
ioctl drops its set on the error path while the MQD keeps pointing at
the buffers.

User space sees no difference. A destroy still removes the queue id and
returns what it returned before.

Three defects on the same paths are fixed along the way. Process
termination and the cleanup of a failed create clear is_active when
they deactivate a queue, so a per-queue reset later does not decrement
the active count a second time, and kfd_dqm_suspend_bad_queue_mes()
decrements only if the reset it asked for has not done so already. The
gang context and write pointer mapping of a queue whose creation failed
are freed. They were leaked.

On devices without MES kfd_mes_queue_retired() is always true. What
changes there is that ids and buffer references are released after the
unmap, and that a destroy which failed after the queue was unlinked is
completed.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 109 +++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
 .../amd/amdkfd/kfd_process_queue_manager.c    |  91 +++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  63 +++++++++-
 4 files changed, 216 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index cb0263881..c691df753 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1341,6 +1341,7 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 		qpd->reset_wavefronts = true;
 
 	list_del(&q->list);
+	q->dqm_dequeued = true;
 	if (list_empty(&qpd->queues_list)) {
 		if (qpd->reset_wavefronts) {
 			pr_warn("Resetting wave fronts (nocpsch) on dev %p\n",
@@ -1777,9 +1778,9 @@ static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
  */
 
 /* dqm lock held. @q is off qpd->queues_list already. */
-static void __maybe_unused dqm_quarantine_queue(struct device_queue_manager *dqm,
-						struct qcm_process_device *qpd,
-						struct queue *q)
+static void dqm_quarantine_queue(struct device_queue_manager *dqm,
+				 struct qcm_process_device *qpd,
+				 struct queue *q)
 {
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 
@@ -2962,8 +2963,21 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 cleanup_queue:
 	qpd->queue_count--;
 	list_del(&q->list);
-	if (q->properties.is_active)
+	if (q->properties.is_active) {
 		decrement_queue_count(dqm, qpd, q);
+		/* Not counted any more, a reset must not count it down again */
+		q->properties.is_active = false;
+	}
+	if (!kfd_mes_queue_retired(dqm, q)) {
+		/*
+		 * ADD_QUEUE was not confirmed, MES may still map the queue.
+		 * The MQD and the doorbell and SDMA ids stay with it, the pqm
+		 * takes care of the user buffers.
+		 */
+		dqm_quarantine_queue(dqm, qpd, q);
+		dqm_unlock(dqm);
+		return retval;
+	}
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 	dqm_unlock(dqm);
 out_deallocate_doorbell:
@@ -3475,6 +3489,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	uint64_t sdma_val = 0;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct device *dev = dqm->dev->adev->dev;
+	bool retired;
 
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
@@ -3517,13 +3532,9 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
-	deallocate_doorbell(qpd, q);
-
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
-	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		deallocate_sdma_queue(dqm, q);
+	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI))
 		pdd->sdma_past_activity_counter += sdma_val;
-	}
 
 	if (q->properties.is_active) {
 		decrement_queue_count(dqm, qpd, q);
@@ -3534,11 +3545,18 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 						      USE_DEFAULT_GRACE_PERIOD);
 			if (retval == -ETIME)
 				qpd->reset_wavefronts = true;
-		} else {
-			retval = remove_queue_mes(dqm, q, qpd);
 		}
 	}
+
+	/*
+	 * Not only for active queues: an evicted queue can be inactive with
+	 * a REMOVE_QUEUE that MES never confirmed.
+	 */
+	if (!kfd_mes_queue_retired(dqm, q))
+		retval = remove_queue_mes(dqm, q, qpd);
+
 	list_del(&q->list);
+	q->dqm_dequeued = true;
 	qpd->queue_count--;
 
 	/*
@@ -3549,6 +3567,21 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	pr_debug("Total of %d queues are accountable so far\n",
 			dqm->total_queue_count);
 
+	/*
+	 * MES identifies the queue by its doorbell. The doorbell and SDMA
+	 * ids can be handed out again only when MES has forgotten the queue.
+	 * Until then the queue keeps them, together with its MQD.
+	 */
+	retired = kfd_mes_queue_retired(dqm, q);
+	if (retired) {
+		deallocate_doorbell(qpd, q);
+		if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+		    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
+			deallocate_sdma_queue(dqm, q);
+	} else {
+		dqm_quarantine_queue(dqm, qpd, q);
+	}
+
 	dqm_unlock(dqm);
 
 	/*
@@ -3559,9 +3592,11 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				qpd->pqm->process, q->device,
 				-1, false, NULL, 0);
 
-	/* Repin the MQD BO if still evicted for hibernation, before it is freed. */
-	dqm_repin_mqd_bo(dqm, q);
-	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+	if (retired) {
+		/* Repin the MQD BO if still evicted for hibernation, before it is freed. */
+		dqm_repin_mqd_bo(dqm, q);
+		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+	}
 
 	return retval;
 
@@ -3767,20 +3802,18 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 
 	/* Clear all user mode queues */
 	list_for_each_entry(q, &qpd->queues_list, list) {
-		if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-			deallocate_sdma_queue(dqm, q);
-		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-			deallocate_sdma_queue(dqm, q);
-
 		if (q->properties.is_active) {
 			decrement_queue_count(dqm, qpd, q);
+			/* set_queue_as_reset() must not count it down again */
+			q->properties.is_active = false;
+		}
 
-			if (dqm->dev->kfd->shared_resources.enable_mes) {
-				retval = remove_queue_mes(dqm, q, qpd);
-				if (retval)
-					dev_err(dev, "Failed to remove queue %d\n",
-						q->properties.queue_id);
-			}
+		/* Inactive queues can have an unconfirmed REMOVE_QUEUE too */
+		if (!kfd_mes_queue_retired(dqm, q)) {
+			retval = remove_queue_mes(dqm, q, qpd);
+			if (retval)
+				dev_err(dev, "Failed to remove queue %d\n",
+					q->properties.queue_id);
 		}
 
 		dqm->total_queue_count--;
@@ -3816,7 +3849,22 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		list_del(&q->list);
+		q->dqm_dequeued = true;
 		qpd->queue_count--;
+
+		/*
+		 * Decide once whether MES has let go. A late completion can
+		 * change the answer at any time, and the SDMA id has to
+		 * follow the same decision as the MQD.
+		 */
+		if (!kfd_mes_queue_retired(dqm, q)) {
+			dqm_quarantine_queue(dqm, qpd, q);
+			continue;
+		}
+		if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+		    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
+			deallocate_sdma_queue(dqm, q);
+
 		dqm_unlock(dqm);
 		/* Repin the MQD BO if still evicted for hibernation, before free. */
 		dqm_repin_mqd_bo(dqm, q);
@@ -4082,8 +4130,15 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
 				reset_queues_mes(dqm, q);
 				q->properties.is_evicted = true;
-				q->properties.is_active = false;
-				decrement_queue_count(dqm, qpd, q);
+				/*
+				 * When MES reported the queue itself as hung,
+				 * the per-queue reset has deactivated it and
+				 * counted it down already.
+				 */
+				if (q->properties.is_active) {
+					q->properties.is_active = false;
+					decrement_queue_count(dqm, qpd, q);
+				}
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 711779665..23fc74aa0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1436,6 +1436,8 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 			   struct queue_properties *properties);
+int kfd_queue_hold_buffers(struct kfd_process_device *pdd,
+			   struct queue_properties *properties);
 void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
 int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ef9ad6dc8..e44ccc803 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -236,19 +236,31 @@ void pqm_uninit(struct process_queue_manager *pqm)
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
 		if (pqn->q) {
-			struct kfd_process_device *pdd = kfd_get_process_device_data(pqn->q->device,
-										     pqm->process);
-			if (pdd) {
-				kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
-				kfd_queue_release_buffers(pdd, &pqn->q->properties, false);
+			struct queue *q = pqn->q;
+			struct kfd_process_device *pdd =
+				kfd_get_process_device_data(q->device,
+							    pqm->process);
+
+			kfd_procfs_del_queue(q);
+			if (q->is_zombie) {
+				/*
+				 * The dqm has quarantined the queue. All of
+				 * its storage, the user buffers included,
+				 * stays until MES has let go of it.
+				 */
+				kfd_dqm_zombie_ready(q->device->dqm, q);
 			} else {
-				WARN_ON(!pdd);
+				if (pdd) {
+					kfd_queue_unref_bo_vas(pdd, &q->properties);
+					kfd_queue_release_buffers(pdd, &q->properties, false);
+				} else {
+					WARN_ON(!pdd);
+				}
+				pqm_clean_queue_resource(pqm, pqn);
+				uninit_queue(q);
 			}
-			pqm_clean_queue_resource(pqm, pqn);
 		}
 
-		kfd_procfs_del_queue(pqn->q);
-		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
 		kfree(pqn);
 	}
@@ -518,7 +530,23 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	return retval;
 
 err_create_queue:
-	uninit_queue(q);
+	if (q && q->is_zombie) {
+		/*
+		 * The dqm still needs the MQD, the ids and what MES uses. The
+		 * user buffers are part of that: MES may yet execute the
+		 * ADD_QUEUE and run the queue from them. The ioctl drops its
+		 * references on them when this returns, so take our own. The
+		 * reaper drops them once MES has let go of the queue.
+		 */
+		if (kfd_queue_hold_buffers(pdd, &q->properties))
+			pr_warn("process pid %d: quarantined queue holds no reference on its CWSR area\n",
+				pqm->process->lead_thread->pid);
+		kfd_dqm_zombie_ready(dev->dqm, q);
+	} else {
+		if (q)
+			kfd_queue_free_mes_resources(dev, q);
+		uninit_queue(q);
+	}
 	if (kq)
 		kernel_queue_uninit(kq);
 	kfree(pqn);
@@ -571,23 +599,44 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
-		retval = kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
-		if (retval)
-			goto err_destroy_queue;
+		struct queue *q = pqn->q;
 
-		dqm = pqn->q->device->dqm;
-		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
+		dqm = q->device->dqm;
+		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, q);
 		if (retval) {
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pdd->pasid,
-				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME && retval != -EIO)
+				q->properties.queue_id, retval);
+			/* The dqm left the queue alone, it stays usable */
+			if (!q->dqm_dequeued)
 				goto err_destroy_queue;
 		}
-		kfd_procfs_del_queue(pqn->q);
-		kfd_queue_release_buffers(pdd, &pqn->q->properties, false);
-		pqm_clean_queue_resource(pqm, pqn);
-		uninit_queue(pqn->q);
+
+		/*
+		 * The dqm has taken the queue off its lists. Whatever it
+		 * returned, the destroy has to be completed from here on.
+		 */
+		kfd_procfs_del_queue(q);
+		if (q->is_zombie) {
+			/* What pqm_clean_queue_resource() does for GWS */
+			if (q->gws)
+				pdd->qpd.num_gws = 0;
+			/*
+			 * MES may still use the buffers. They keep their
+			 * references, the reaper drops them once MES has let
+			 * go. The queue belongs to the reaper after this call.
+			 */
+			kfd_dqm_zombie_ready(dqm, q);
+		} else {
+			/*
+			 * The queue is off the hardware. Only now may its
+			 * buffers be unmapped and freed.
+			 */
+			kfd_queue_unref_bo_vas(pdd, &q->properties);
+			kfd_queue_release_buffers(pdd, &q->properties, false);
+			pqm_clean_queue_resource(pqm, pqn);
+			uninit_queue(q);
+		}
 	}
 
 	list_del(&pqn->process_queue_list);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index cd41b10e0..b31488582 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -409,7 +409,8 @@ int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 	int err;
 
 	vm = drm_priv_to_vm(pdd->drm_priv);
-	err = amdgpu_bo_reserve(vm->root.bo, false);
+	/* Called once the queue is gone, so this cannot be interrupted */
+	err = amdgpu_bo_reserve(vm->root.bo, true);
 	if (err)
 		return err;
 
@@ -423,6 +424,66 @@ int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 	return 0;
 }
 
+static void kfd_queue_hold_bo(struct amdgpu_vm *vm, struct amdgpu_bo *bo)
+{
+	struct amdgpu_bo_va *bo_va;
+
+	if (!bo)
+		return;
+
+	amdgpu_bo_ref(bo);
+	bo_va = amdgpu_vm_bo_find(vm, bo);
+	if (bo_va)
+		bo_va->queue_refcount++;
+}
+
+/*
+ * Take references of our own on the user buffers of a queue whose
+ * creation failed but that MES may still map: the ioctl drops its set
+ * on the error path, while the MQD keeps pointing at the buffers. What
+ * kfd_queue_acquire_buffers() takes, for a queue whose buffers are known
+ * already. Undone by kfd_queue_unref_bo_vas() and
+ * kfd_queue_release_buffers().
+ */
+int kfd_queue_hold_buffers(struct kfd_process_device *pdd,
+			   struct queue_properties *properties)
+{
+	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
+	struct kfd_topology_device *topo_dev;
+	u64 total_cwsr_size;
+	int err;
+
+	err = amdgpu_bo_reserve(vm->root.bo, true);
+	if (err)
+		return err;
+
+	kfd_queue_hold_bo(vm, properties->wptr_bo);
+	kfd_queue_hold_bo(vm, properties->rptr_bo);
+	kfd_queue_hold_bo(vm, properties->ring_bo);
+	kfd_queue_hold_bo(vm, properties->eop_buf_bo);
+	kfd_queue_hold_bo(vm, properties->cwsr_bo);
+
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	/* The CWSR area of a compute queue is a BO, or an SVM range */
+	if (properties->type != KFD_QUEUE_TYPE_COMPUTE || properties->cwsr_bo)
+		return 0;
+
+	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+	if (!topo_dev)
+		return -EINVAL;
+	total_cwsr_size = (u64)properties->ctx_save_restore_area_size +
+			  topo_dev->node_props.debug_memory_size;
+	if (check_mul_overflow(total_cwsr_size,
+			       NUM_XCC(pdd->dev->xcc_mask),
+			       &total_cwsr_size))
+		return -EINVAL;
+	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
+	return kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
+					total_cwsr_size);
+}
+
 #define DEBUGGER_BYTES_ALIGN	64
 #define DEBUGGER_BYTES_PER_WAVE	32
 
-- 
2.47.3

