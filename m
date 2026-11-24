Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40646606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=YnYEQrA3;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=e2AmeA0m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D51E10F758;
	Tue, 24 Nov 2026 15:54:55 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005C710F695
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530884;
 bh=+TsifUDd2A2lvim+Ir+01GdWAwI3+iAaRvjA8RpesVI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YnYEQrA38iJCklND10MoIFUnl31XOsznpKde5vTBAmYP0aZKfGQ+q5odYZQwPd4I/
 lt/uFTriPGgal960lw6ZQt+GG9qhaN0NhOlVwhVyU5teM0kqW4ckvbU13IQFyPaFVr
 gkF0jUMNf4mW79NW2cSINRxk4qEsn5j17+X4hnxgk+a9AVmOKBwc6A1Aprl5j3IHGz
 lpZiE/eLKo8mhiSxORjpFG56VObPslFMYXSujgA0exY1MXbrbRytEOH1tBIgSXuT53
 w8TX4cCBFYQb/4KOaxz3G8jzbGwKWp8qa4VUK5aCAtflnL9F4Hj98LJmdu7kJz3XaW
 H2NzDNmbKhRYg==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 744A517F06A;
 Tue, 24 Nov 2026 15:34:44 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcj8C2nwTdXl; Tue, 24 Nov 2026 15:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530883;
 bh=+TsifUDd2A2lvim+Ir+01GdWAwI3+iAaRvjA8RpesVI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e2AmeA0mXphiqmxBoUGl1ZXhW33MMAwTEUlI+GkpOQ1PJIyp+60cCGUxCtBOnU/Gd
 soclpFJXbZv5gPryixIxwGTJRAgRxGdG0FqEA2/J6rimYodoEQGvT6FaYM3ksyxnJb
 iyccYmsa2J+4kWIH3qh3mz4QzuAYXCWfUKFR9XrYmbHwIrrrfz70QJls9/DSKgIdcG
 ptqZdt0j95CPpScPk684ClNC2gRmz9+Ld3uoY/5m6mQwo6o8cOVfb2Yj4mNnTEXAfC
 rJuVPAqzSJEU9ZxrBTkSuedGQG/l4BP3ObrLBzFZAOWMKLvUlX5r5l9mLqH+Cqlmf/
 qdOIT9oHZeIfw==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 28F0B17F0D0;
 Tue, 24 Nov 2026 15:34:43 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>,
 "Claude Fable 5.2" <noreply@anthropic.com>
Subject: [PATCH v1 7/9] drm/amdkfd: apply queue property updates only after
 unmap
Date: Tue, 24 Nov 2026 15:34:30 +0100
Message-ID: <20261124143433.49736-8-zappel@simple-co.de>
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

pqm_update_queue_properties() drops the references on the old ring
buffer and overwrites the queue properties before update_queue() takes
the queue off the hardware. If the unmap fails, the scheduler keeps
running the old ring, which is no longer protected against being
unmapped, while the driver describes the new one.

Hand the new properties to update_queue() and let it apply them at the
point where the queue is unmapped, under the dqm lock. Swap the ring
buffer reference afterwards, and only if the properties were applied.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 16 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 67 +++++++++++--------
 3 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index feb3062e6..b93870421 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1325,6 +1325,22 @@ static void update_queue_mqd(struct device_queue_manager *dqm, struct queue *q,
 		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
 	bool prev_active = q->properties.is_active;
 
+	/*
+	 * The queue is off the hardware now. Only from here on may its
+	 * properties change, otherwise a failed unmap would leave the
+	 * scheduler running the old ring under the new description.
+	 */
+	if (q->pending_props) {
+		const struct queue_properties *np = q->pending_props;
+
+		q->properties.queue_address = np->queue_address;
+		q->properties.queue_size = np->queue_size;
+		q->properties.queue_percent = np->queue_percent;
+		q->properties.priority = np->priority;
+		q->properties.pm4_target_xcc = np->pm4_target_xcc;
+		q->pending_props = NULL;
+	}
+
 	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 13e9e3ed8..e2110e65e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -673,6 +673,13 @@ struct queue {
 	/* the dqm took the queue off its lists, the pqm has to finish */
 	bool dqm_dequeued;
 
+	/*
+	 * New properties from pqm_update_queue_properties(). Set under
+	 * p->mutex, applied and cleared by update_queue() under the dqm lock
+	 * once the queue is unmapped.
+	 */
+	const struct queue_properties *pending_props;
+
 	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
 	 * TTM evicts it into the hibernation image, and repinned on resume. Set
 	 * while the BO is unpinned so the resume path knows to repin it.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 29827a736..a7070e873 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -644,60 +644,73 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 int pqm_update_queue_properties(struct process_queue_manager *pqm,
 				unsigned int qid, struct queue_properties *p)
 {
-	int retval;
+	struct amdgpu_bo *new_ring_bo = NULL, *old_ring_bo;
 	struct process_queue_node *pqn;
+	struct amdgpu_vm *vm = NULL;
+	struct queue *q;
+	int retval;
 
 	pqn = get_queue_by_qid(pqm, qid);
 	if (!pqn || !pqn->q) {
 		pr_debug("No queue %d exists for update operation\n", qid);
 		return -EFAULT;
 	}
+	q = pqn->q;
 
 	/*
 	 * Update with NULL ring address is used to disable the queue
 	 */
 	if (p->queue_address && p->queue_size) {
+		u64 size = p->queue_size + q->properties.metadata_queue_size;
 		struct kfd_process_device *pdd;
-		struct amdgpu_vm *vm;
-		struct queue *q = pqn->q;
-		int err;
 
 		pdd = kfd_get_process_device_data(q->device, q->process);
 		if (!pdd)
 			return -ENODEV;
 		vm = drm_priv_to_vm(pdd->drm_priv);
-		err = amdgpu_bo_reserve(vm->root.bo, false);
-		if (err)
-			return err;
+		retval = amdgpu_bo_reserve(vm->root.bo, false);
+		if (retval)
+			return retval;
 
-		if (kfd_queue_buffer_get(vm, (void *)p->queue_address, &p->ring_bo,
-					 p->queue_size +
-					 pqn->q->properties.metadata_queue_size)) {
+		retval = kfd_queue_buffer_get(vm, (void *)p->queue_address,
+					      &new_ring_bo, size);
+		amdgpu_bo_unreserve(vm->root.bo);
+		if (retval) {
 			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
 				 p->queue_address, p->queue_size);
-			amdgpu_bo_unreserve(vm->root.bo);
 			return -EFAULT;
 		}
-
-		kfd_queue_unref_bo_va(vm, &pqn->q->properties.ring_bo);
-		kfd_queue_buffer_put(&pqn->q->properties.ring_bo);
-		amdgpu_bo_unreserve(vm->root.bo);
-
-		pqn->q->properties.ring_bo = p->ring_bo;
 	}
 
-	pqn->q->properties.queue_address = p->queue_address;
-	pqn->q->properties.queue_size = p->queue_size;
-	pqn->q->properties.queue_percent = p->queue_percent;
-	pqn->q->properties.priority = p->priority;
-	pqn->q->properties.pm4_target_xcc = p->pm4_target_xcc;
+	/*
+	 * The dqm applies the new properties once the queue is unmapped. If
+	 * it fails before that, the queue still runs on the old ring and
+	 * keeps its old properties.
+	 */
+	q->pending_props = p;
+	retval = q->device->dqm->ops.update_queue(q->device->dqm, q, NULL);
+
+	if (q->pending_props) {
+		/* Not applied. Drop the reference on the new ring. */
+		q->pending_props = NULL;
+		old_ring_bo = new_ring_bo;
+	} else if (new_ring_bo) {
+		old_ring_bo = q->properties.ring_bo;
+		q->properties.ring_bo = new_ring_bo;
+	} else {
+		old_ring_bo = NULL;
+	}
 
-	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q, NULL);
-	if (retval != 0)
-		return retval;
+	/* There is an old ring to drop only if a new one was looked up */
+	if (old_ring_bo) {
+		if (!amdgpu_bo_reserve(vm->root.bo, true)) {
+			kfd_queue_unref_bo_va(vm, &old_ring_bo);
+			amdgpu_bo_unreserve(vm->root.bo);
+		}
+		kfd_queue_buffer_put(&old_ring_bo);
+	}
 
-	return 0;
+	return retval;
 }
 
 int pqm_update_mqd(struct process_queue_manager *pqm,
-- 
2.56.1

