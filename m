Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290F606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=nT8nztzH;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=VHHlUmIo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA821120FF;
	Thu, 26 Nov 2026 08:09:33 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25BCC10FCB5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616379;
 bh=jwXgEkMqdgoY7NLUWF0GYGufzxz824nLivVfiidPbvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nT8nztzHZBiiJtElpq1qdZn+vT6xbkqtIzUgyza/cS0GEhyDMsNGKstG5RRCWrBL4
 8iPVAgANj7f+4B2vE2gQ8Ghm2GJ9NDsargbpfhgVkFkzYkVstfh7pBbAs5WH6AW5fR
 EhkUa/CDghPBnfapYUhAAlUhsUDFhcjXx3OO2lMpi6kghytHrh266R1j5mdcwuQrpn
 Hn94P8cgfmccGQeK7oFvMqVdHxEbfMpU65Poy1K+0OchPd2UnP2IW8qCDyGx0qmyoo
 T/ijqFLmCARMzXnqNjXlu+aoBSpQkdm49EdmWRWvRoN7FOhSAaUPEeUDIQc8aICRPM
 +nBtv3I9Y7SMA==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 0800817F370;
 Wed, 25 Nov 2026 15:19:39 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VF86FBIYGc7; Wed, 25 Nov 2026 15:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=jwXgEkMqdgoY7NLUWF0GYGufzxz824nLivVfiidPbvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VHHlUmIoJOpUtpY3FRK81YyZyon4jAtoa2H1kO2rcRR0lHX/U65se/MGpc6xoK67g
 scuaYrTcchtrbyjjFfRk2oWSJp5aGTIK6jHgskemw3Dy6/E4DhwdpJ/bpFYgeG2J2L
 ZGgz6ebaNJAGiF0oRjhA5zO+jJpq6qYq0ai+p1gDPUBulHpSuGhQZ6rt1FPW7WwpFm
 vwCF/5Tk20TVgjXSqY6x4NJUA0IEyzL668Id42ydDLLvPlAHhNBaNZ1YHm/ATCxK1k
 KUDJKvLTT45eoYWZJEsIYI/9z9XTJ4RMgU/EApUR09W30xrvE3x0cvlCScX35PveW9
 tJ1FP5pY3hoWw==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 5674B17F362;
 Wed, 25 Nov 2026 15:19:38 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 7/9] drm/amdkfd: apply queue property updates only after
 unmap
Date: Wed, 25 Nov 2026 15:19:30 +0100
Message-ID: <20261125141933.154222-8-zappel@simple-co.de>
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

pqm_update_queue_properties() drops the references on the old ring
buffer and overwrites the queue properties before update_queue() takes
the queue off the hardware. If the unmap fails, the scheduler keeps
running the old ring, which is no longer protected against being
unmapped, while the driver describes the new one.

Hand the new properties to update_queue() in the mqd_update_info of the
call and let it apply them at the point where the queue is unmapped,
under the dqm lock. Swap the ring buffer reference afterwards, and only
if the properties were applied. The properties travel with the call and
not in the queue, because set_perfcount() updates every queue of every
process under the dqm lock alone, and must not apply the properties of
an update that is in flight for one of them.

A queue that is updated while the scheduler is stopped, in the no-HWS
debug mode, now gets -EBUSY. The update is not applied in that state;
it returned success before.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  6 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 69 +++++++++++--------
 3 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index eb75858bd..a75c88356 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1411,6 +1411,24 @@ static void update_queue_mqd(struct device_queue_manager *dqm, struct queue *q,
 		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
 	bool prev_active = q->properties.is_active;
 
+	/*
+	 * The queue is off the hardware now. Only from here on may its
+	 * properties change, otherwise a failed unmap would leave the
+	 * scheduler running the old ring under the new description. The
+	 * new properties travel with the update that carries them, so an
+	 * update of another kind (perfcount, debug) cannot apply them.
+	 */
+	if (minfo && minfo->new_props) {
+		const struct queue_properties *np = minfo->new_props;
+
+		q->properties.queue_address = np->queue_address;
+		q->properties.queue_size = np->queue_size;
+		q->properties.queue_percent = np->queue_percent;
+		q->properties.priority = np->priority;
+		q->properties.pm4_target_xcc = np->pm4_target_xcc;
+		minfo->new_props = NULL;
+	}
+
 	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
 
 	/*
@@ -1489,7 +1507,8 @@ static int update_queue_locked(struct device_queue_manager *dqm, struct queue *q
 
 		if (!dqm->sched_running) {
 			WARN_ONCE(1, "Update non-HWS queue while stopped\n");
-			return retval;
+			/* Nothing was applied, say so */
+			return -EBUSY;
 		}
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 23fc74aa0..081085f3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -581,6 +581,12 @@ struct mqd_update_info {
 		} cu_mask;
 	};
 	enum mqd_update_flag update_flag;
+	/*
+	 * New properties from pqm_update_queue_properties(). Applied by
+	 * update_queue() under the dqm lock once the queue is unmapped, and
+	 * cleared to report that it did.
+	 */
+	const struct queue_properties *new_props;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index e44ccc803..b3705edcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -654,60 +654,75 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 int pqm_update_queue_properties(struct process_queue_manager *pqm,
 				unsigned int qid, struct queue_properties *p)
 {
-	int retval;
+	struct amdgpu_bo *new_ring_bo = NULL, *old_ring_bo;
 	struct process_queue_node *pqn;
+	struct mqd_update_info minfo = {0};
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
+	 * keeps its old properties. The flag keeps the GWS state of the MQD
+	 * as it is, see pqm_set_gws().
+	 */
+	minfo.new_props = p;
+	minfo.update_flag = q->gws ? UPDATE_FLAG_IS_GWS : 0;
+	retval = q->device->dqm->ops.update_queue(q->device->dqm, q, &minfo);
+
+	if (minfo.new_props) {
+		/* Not applied. Drop the reference on the new ring. */
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
2.47.3

