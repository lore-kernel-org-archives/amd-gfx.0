Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE95606A69B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=P2EX76Z3;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=ski/cwRl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655C910E23E;
	Tue, 24 Nov 2026 15:54:45 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C4A10F69A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530883;
 bh=ii8EE9Djx47NZz1Z0n9LRAxcKolrWDXzJRurxZBu/EM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P2EX76Z3MkkG50+A+0tRgRIa3U0sBs3xJ1uFShrf1bOIWxFP/Zk03uygskOGyXezO
 ZLo4py/G3Lls1+fx6louR/HY2jMqcXZnQ1brglEFBV3hWYpya/z2i99Nlnp3h23e/X
 qL39X/d95dAbQaiWVUsuH6YXE8I0mDHwErkeVJJnbxJwdVAhDOzvmkwCdXhOBgJMR+
 qYULzGGU7y26UzoQGvRnyiX4IbTUFBb4Ch/ZOZrEo4A5Ir3RNHLNH6B1wQnYO88b1B
 JERZsSB12nXO1b7UOwMLul2B0+AEPflXwJPF7FixMju9WmiJ09kq6qxtPiih2pCTdf
 A4NhTWU1XgIEA==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 9C86F17F0D1;
 Tue, 24 Nov 2026 15:34:43 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjLtOdGWYx-s; Tue, 24 Nov 2026 15:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530882;
 bh=ii8EE9Djx47NZz1Z0n9LRAxcKolrWDXzJRurxZBu/EM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ski/cwRlLt+8FLZ+U4PwUG9w49h9vC0dea4Q5jkJK8hKx277gE995d64CiZuaFdGw
 +0N5dPxt41RX7nXZ+l4qLy3PR6QXo6AUHbdit6SrKDM7bUSXFR0o9HrdChtZ4j5n/u
 yeZWCwRodtM+3MDh/FqQ6CU9oa38rxDMIN/CrEpaWKWxJO6lemy/Nnp/E61rLb6MjI
 WxBVxW8z9UlWRDT20fGIUhiMGkCOQIrpAMBDZb7pTR89M5yM5xlULTd3AIzZfCBwlO
 LRh6MN6nBSdxLMwpzmV8qwnVRKpmDcnJnaoanGy9TbdPdut5SnNwQ6Mjcw4LjRv2+y
 a80ZT/bF6lgcQ==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 907FA17F067;
 Tue, 24 Nov 2026 15:34:42 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>,
 "Claude Fable 5.2" <noreply@anthropic.com>
Subject: [PATCH v1 5/9] drm/amdkfd: keep queue storage until MES confirmed
 retirement
Date: Tue, 24 Nov 2026 15:34:28 +0100
Message-ID: <20261124143433.49736-6-zappel@simple-co.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124143433.49736-1-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
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
has unlinked the queue, and takes the buffer references back when it has
not.

User space sees no difference. A destroy still removes the queue id and
returns what it returned before.

Two defects on the same paths are fixed along the way. Process
termination clears is_active when it deactivates a queue, so a per-queue
reset during termination does not decrement the active count a second
time. The gang context and write pointer mapping of a queue whose
creation failed are freed. They were leaked.

On devices without MES kfd_mes_queue_retired() is always true. What
changes there is that ids are released after the unmap, and that a
destroy which failed after the queue was unlinked is completed.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 93 ++++++++++++++-----
 .../amd/amdkfd/kfd_process_queue_manager.c    | 77 +++++++++++----
 2 files changed, 127 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 842a3249e..e85bead1b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1255,6 +1255,7 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 		qpd->reset_wavefronts = true;
 
 	list_del(&q->list);
+	q->dqm_dequeued = true;
 	if (list_empty(&qpd->queues_list)) {
 		if (qpd->reset_wavefronts) {
 			pr_warn("Resetting wave fronts (nocpsch) on dev %p\n",
@@ -1691,9 +1692,9 @@ static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
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
 
@@ -2880,6 +2881,16 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	list_del(&q->list);
 	if (q->properties.is_active)
 		decrement_queue_count(dqm, qpd, q);
+	if (!kfd_mes_queue_retired(dqm, q)) {
+		/*
+		 * ADD_QUEUE was not confirmed, MES may still map the queue.
+		 * The MQD and the doorbell and SDMA ids stay with it.
+		 */
+		q->zombie_no_user_bos = true;
+		dqm_quarantine_queue(dqm, qpd, q);
+		dqm_unlock(dqm);
+		return retval;
+	}
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 	dqm_unlock(dqm);
 out_deallocate_doorbell:
@@ -3391,6 +3402,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	uint64_t sdma_val = 0;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct device *dev = dqm->dev->adev->dev;
+	bool retired;
 
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
@@ -3433,13 +3445,9 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
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
@@ -3450,11 +3458,18 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
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
@@ -3465,6 +3480,21 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
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
@@ -3475,9 +3505,11 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
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
 
@@ -3683,20 +3715,18 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 
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
@@ -3732,7 +3762,22 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ef9ad6dc8..29827a736 100644
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
@@ -518,7 +530,14 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	return retval;
 
 err_create_queue:
-	uninit_queue(q);
+	if (q && q->is_zombie) {
+		/* The dqm still needs the MQD, the ids and what MES uses */
+		kfd_dqm_zombie_ready(dev->dqm, q);
+	} else {
+		if (q)
+			kfd_queue_free_mes_resources(dev, q);
+		uninit_queue(q);
+	}
 	if (kq)
 		kernel_queue_uninit(kq);
 	kfree(pqn);
@@ -571,23 +590,43 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
-		retval = kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
+		struct queue *q = pqn->q;
+
+		retval = kfd_queue_unref_bo_vas(pdd, &q->properties);
 		if (retval)
 			goto err_destroy_queue;
 
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
+			if (!q->dqm_dequeued) {
+				kfd_queue_ref_bo_vas(pdd, &q->properties);
 				goto err_destroy_queue;
+			}
+		}
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
+			/* MES may still use the buffers, keep them mapped */
+			kfd_queue_ref_bo_vas(pdd, &q->properties);
+			/* The queue belongs to the reaper after this call */
+			kfd_dqm_zombie_ready(dqm, q);
+		} else {
+			kfd_queue_release_buffers(pdd, &q->properties, false);
+			pqm_clean_queue_resource(pqm, pqn);
+			uninit_queue(q);
 		}
-		kfd_procfs_del_queue(pqn->q);
-		kfd_queue_release_buffers(pdd, &pqn->q->properties, false);
-		pqm_clean_queue_resource(pqm, pqn);
-		uninit_queue(pqn->q);
 	}
 
 	list_del(&pqn->process_queue_list);
-- 
2.56.1

