Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA5606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=S8Q+nKSo;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=LxjHXugk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD67F11210A;
	Thu, 26 Nov 2026 08:09:42 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEB010FCB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=FLaCKqETDSJNEvIzAOk9IJdDNV/wBtm8TPRKnLCclXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S8Q+nKSoFymp/boL2zvKugZtQ19JJpPU/bh0+6QUNJGpW1bLnkdGF94lzLxDE9/2g
 7AZFHyNDdfx2z5hlmIkmmkRBmQFni10w9GWwyegu4qwSB00TdalGjPu1pMeK1EbX8/
 naTUdGgmm+tTVPyc4GSRUydvdQtsL+Z7K1dA714ipPF7EwbCyjN3aUk8S11ztR7fma
 ra+Ts8VXiacJzLrWHil6RWaC0WHHx2To9zoKQ+Irm1tht7HQc34SxEzzGNd6AZl50C
 /fYS6rvwAzSCvil24h0QcCoGTsFM1cIksbf34DTwk6jrc/14DPL3mBttOoWLH2UKKC
 LHqLUbf9o0NOg==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 3042817F369;
 Wed, 25 Nov 2026 15:19:38 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fLMUTs8kHwtQ; Wed, 25 Nov 2026 15:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616377;
 bh=FLaCKqETDSJNEvIzAOk9IJdDNV/wBtm8TPRKnLCclXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LxjHXugkO0tEbte7MCIahOoIr9lBtcp7wSRI6E4GF7jaj0jcdwnflT4GObCuc6Cwh
 0CJm3ELspWmPJPo75UzvZofF+geWD5bVjQp/lZ7KDV2DSvTTyCv00abU0wB1rmB9bg
 NRUar8FnJq2JYcnIInGIiLMf6eeCdWm2Pky2SlO8p4RJ1Z5jFtA6qNgawnJRjkCpYe
 HzJlRDpvqxyddR215VVqZveT7/dByY1oUbbv6FALDscUy/w/XtxniLO5JRZkvomPZi
 40XtqC0jinDkXQIfWUaVRp3NeRVkkxod7cjSiQ8I+VvqG8wuWKNQSyzsvFFovuxfcN
 +0eux0cHbA+vQ==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 5F77317F362;
 Wed, 25 Nov 2026 15:19:37 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 3/9] drm/amdkfd: track whether MES knows each queue
Date: Wed, 25 Nov 2026 15:19:26 +0100
Message-ID: <20261125141933.154222-4-zappel@simple-co.de>
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

KFD has no record of what MES knows about a queue. is_active is set
before the MES command is sent and is not corrected from its result, and
every failure of ADD_QUEUE or REMOVE_QUEUE is handled the same way. The
consequences:

- REMOVE_QUEUE is sent for queues MES does not have. After a GPU reset
  the firmware starts empty, but queues that were active keep is_active
  and get a REMOVE_QUEUE when their process exits. MES rejects it and
  KFD answers with another GPU reset.
- reset_queues_mes() returns success although the queue that failed was
  not removed, when MES reported other queues as hung and those were
  reset.
- The result of the remove-after-reset command is ignored.
- Queues are added a second time after a halt that failed half way.
- The GPU is reset for a REMOVE_QUEUE that MES completes shortly after
  the 2.1 s poll gave up.

Record a per-queue state (unmapped, mapped, unknown) from the result of
each command, together with the firmware generation the queue was added
under. kfd_mes_queue_retired() answers the one question the rest of the
dqm needs: can MES still reference this queue. It cannot when the queue
was never added, its removal was confirmed, the firmware was restarted
since, or an unanswered REMOVE_QUEUE has completed in the meantime.

With that in place:

- Remove and add do nothing for a queue that is already in the wanted
  state, and an add is refused while a removal is unconfirmed.
- A REMOVE_QUEUE that timed out gets 4 s more to complete before the
  recovery path runs. The wait holds the dqm lock, as the 2.1 s poll
  before it does.
- The recovery path is only entered when MES answered. If the command
  is still unanswered after the grace period, the three commands the
  recovery would send would each time out behind it; MES is fenced off
  instead and the GPU reset takes over.
- When the recovery path returns success and the queue is still in MES,
  it is removed explicitly. Both callers of reset_queues_mes() get that,
  the one that answers a bad queue interrupt included.
- Once a command got no answer, nothing more is sent to MES until it
  answers or is restarted. Commands queued behind it would each time
  out under the dqm lock. This covers ADD_QUEUE and the
  remove-after-reset of a per-queue reset as well; the latter fails the
  per-queue reset when MES did not answer, so that every caller
  escalates to a GPU reset.
- A removal that cannot be sent because the scheduler is halted or
  stopped reports -EIO for a queue MES still has, instead of success.
  The callers keep the storage of such a queue and leave its MQD alone.
  The is_reset shortcut goes away with it: the retired check already
  covers a queue the reset removed, and for one it did not, the
  shortcut was wrong.
- update_queue() does not rewrite the MQD of an inactive queue whose
  removal is unconfirmed.
- The REMOVE_QUEUE that amdgpu_gfx_reset_mes_compute() sends on behalf
  of KFD carries the gang context array index and the ticket of the
  queue like every other one.

Queue storage is still freed as before. The following patches change
that.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 341 +++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  17 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  14 +
 .../amd/amdkfd/kfd_process_queue_manager.c    |   2 +
 4 files changed, 357 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 03d3a739d..550ad428e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/sched.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
@@ -207,6 +208,129 @@ static int convert_to_amdgpu_ring_type(int queue_type)
 	return amdgpu_ring_type;
 }
 
+/*
+ * MES queue state tracking
+ *
+ * The MQD, the gang context, the GART mapping of the write pointer and the
+ * doorbell id of a queue are all addressed by MES directly. q->mes_state
+ * records what MES knows about the queue, taken from the result of every
+ * ADD_QUEUE and REMOVE_QUEUE, so that the rest of the dqm can tell whether
+ * MES may still use that storage.
+ *
+ * All of this is protected by the dqm lock. The lock order is
+ *
+ *   p->mutex -> dqm lock -> reset_domain->sem (read, trylock) -> MES lock
+ *
+ * and none of the helpers below is called with the MES lock held.
+ */
+
+/* Generation of the scheduler instance this node talks to */
+static u32 kfd_mes_gen(struct device_queue_manager *dqm)
+{
+	return amdgpu_mes_fw_gen(&dqm->dev->adev->mes,
+				 ffs(dqm->dev->xcc_mask) - 1);
+}
+
+/*
+ * True when MES cannot reference the storage of @q: the queue was never
+ * added, its removal was confirmed, the firmware instance that knew it has
+ * been replaced, or a REMOVE_QUEUE that timed out has completed since.
+ *
+ * This is the only place where a queue becomes UNMAPPED without a command
+ * that succeeded.
+ */
+static bool kfd_mes_queue_retired(struct device_queue_manager *dqm,
+				  struct queue *q)
+{
+	struct amdgpu_device *adev = dqm->dev->adev;
+
+	if (!dqm->dev->kfd->shared_resources.enable_mes)
+		return true;
+	if (q->mes_state == KFD_MES_QUEUE_UNMAPPED)
+		return true;
+
+	/* The firmware instance that knew the queue is gone */
+	if (q->mes_fw_gen != kfd_mes_gen(dqm))
+		goto retired;
+
+	/* REMOVE_QUEUE completed after the driver stopped waiting for it */
+	if (q->mes_ticket.valid &&
+	    amdgpu_mes_ticket_poll(adev, &q->mes_ticket) ==
+	    AMDGPU_MES_TICKET_DONE)
+		goto retired;
+
+	return false;
+
+retired:
+	amdgpu_mes_ticket_release(adev, &q->mes_ticket);
+	q->mes_state = KFD_MES_QUEUE_UNMAPPED;
+	return true;
+}
+
+/* True while a REMOVE_QUEUE for @q is in the MES ring without an answer */
+static bool kfd_mes_ticket_pending(struct device_queue_manager *dqm,
+				   struct queue *q)
+{
+	return q->mes_ticket.valid &&
+	       amdgpu_mes_ticket_poll(dqm->dev->adev, &q->mes_ticket) ==
+	       AMDGPU_MES_TICKET_PENDING;
+}
+
+/*
+ * Stop talking to MES. Commands are handled in order, so anything sent
+ * behind one that got no answer only adds another timeout under the dqm
+ * lock. With no pending command to watch, only a firmware restart lifts
+ * the fence.
+ */
+static void kfd_mes_fence(struct device_queue_manager *dqm, struct queue *q)
+{
+	dqm->mes_fenced = true;
+	dqm->mes_fence_gen = kfd_mes_gen(dqm);
+	dqm->mes_fence_has_seq = kfd_mes_ticket_pending(dqm, q);
+	if (dqm->mes_fence_has_seq)
+		dqm->mes_fence_ticket = q->mes_ticket;
+}
+
+static bool kfd_mes_fenced(struct device_queue_manager *dqm)
+{
+	if (!dqm->mes_fenced)
+		return false;
+
+	if (dqm->mes_fence_gen != kfd_mes_gen(dqm) ||
+	    (dqm->mes_fence_has_seq &&
+	     amdgpu_mes_ticket_answered(dqm->dev->adev,
+					&dqm->mes_fence_ticket)))
+		dqm->mes_fenced = false;
+
+	return dqm->mes_fenced;
+}
+
+/*
+ * Wait for a REMOVE_QUEUE that timed out to complete after all. Sleeps with
+ * the dqm lock held. reset_domain->sem is not held, so a pending GPU reset
+ * is not held up by the wait.
+ */
+static bool kfd_mes_wait_retired(struct device_queue_manager *dqm,
+				 struct queue *q, unsigned int ms)
+{
+	struct amdgpu_device *adev = dqm->dev->adev;
+	unsigned long end = jiffies + msecs_to_jiffies(ms);
+
+	do {
+		if (kfd_mes_queue_retired(dqm, q))
+			return true;
+		/* Answered with a failure, or nothing left to wait for */
+		if (!kfd_mes_ticket_pending(dqm, q))
+			return false;
+		if (amdgpu_in_reset(adev) || amdgpu_amdkfd_is_fed(adev))
+			return false;
+		usleep_range(KFD_MES_REMOVE_POLL_US,
+			     2 * KFD_MES_REMOVE_POLL_US);
+	} while (time_before(jiffies, end));
+
+	return kfd_mes_queue_retired(dqm, q);
+}
+
 static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			 struct qcm_process_device *qpd)
 {
@@ -215,9 +339,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	struct mes_add_queue_input queue_input;
 	int r, queue_type;
 	uint64_t wptr_addr_off;
+	u32 gen;
 
 	if (!dqm->sched_running || dqm->sched_halt)
 		return 0;
+
+	/*
+	 * MES still has the queue (a halt that failed half way), or an
+	 * earlier REMOVE_QUEUE is unconfirmed. Never add a queue twice.
+	 */
+	if (!kfd_mes_queue_retired(dqm, q))
+		return q->mes_state == KFD_MES_QUEUE_MAPPED ? 0 : -EBUSY;
+	if (kfd_mes_fenced(dqm))
+		return -EIO;
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
@@ -270,14 +404,30 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.vm_cntx_cntl = qpd->vm_cntx_cntl;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 
+	/* Cannot change under us, reset_domain->sem is held for reading */
+	gen = kfd_mes_gen(dqm);
+
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
 	up_read(&adev->reset_domain->sem);
+
+	/* A failed ADD_QUEUE may still be executed, or may have been */
+	q->mes_fw_gen = gen;
+	q->mes_state = r ? KFD_MES_QUEUE_UNKNOWN : KFD_MES_QUEUE_MAPPED;
+
 	if (r) {
 		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		/*
+		 * No answer: anything sent from now on would time out behind
+		 * this command. ADD_QUEUE carries no ticket, so the fence is
+		 * lifted by the firmware restart that the GPU reset asked for
+		 * here performs. A rejection means MES answers, no fence.
+		 */
+		if (r == -ETIMEDOUT)
+			kfd_mes_fence(dqm, q);
 		kfd_hws_hang(dqm);
 		return r;
 	}
@@ -299,24 +449,41 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
-static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
-					    struct qcm_process_device *qpd,
-					    bool is_for_reset,
-					    bool flush_mes_queue)
+/*
+ * Send one REMOVE_QUEUE and record the outcome in q->mes_state.
+ *
+ * Returns 0 without sending anything when MES has let go of the queue
+ * since the caller looked, -EIO when nothing was sent because MES is
+ * fenced off or a GPU reset is in progress, and -ETIMEDOUT when MES did
+ * not answer (this command, or an earlier one for the same queue).
+ */
+static int __remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
+			      bool flush_mes_queue)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
-	int r;
+	struct amdgpu_device *adev = dqm->dev->adev;
 	struct mes_remove_queue_input queue_input;
+	int r;
 
-	/* queue was already removed during reset */
-	if (q->properties.is_reset)
+	/* An earlier REMOVE_QUEUE completed late: a second one is rejected */
+	if (kfd_mes_queue_retired(dqm, q))
 		return 0;
 
-	if (!dqm->sched_running || dqm->sched_halt)
-		return 0;
+	if (kfd_mes_fenced(dqm))
+		return -EIO;
+
+	/*
+	 * An earlier REMOVE_QUEUE for this queue is still in the MES ring.
+	 * Do not send another one behind it, and keep its status slot.
+	 */
+	if (kfd_mes_ticket_pending(dqm, q))
+		return -ETIMEDOUT;
+
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
+	/* The earlier command, if there was one, has been answered */
+	amdgpu_mes_ticket_release(adev, &q->mes_ticket);
+
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
@@ -324,19 +491,91 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	queue_input.remove_queue_after_reset = flush_mes_queue;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 	queue_input.gang_context_array_index = q->gang_ctx_array_index;
+	queue_input.ticket = &q->mes_ticket;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
 	up_read(&adev->reset_domain->sem);
 
-	/* If is_for_reset set, it is a mes internal cleanup */
-	if (!r || is_for_reset)
+	q->mes_state = r ? KFD_MES_QUEUE_UNKNOWN : KFD_MES_QUEUE_UNMAPPED;
+
+	return r;
+}
+
+static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
+					    struct qcm_process_device *qpd,
+					    bool is_for_reset,
+					    bool flush_mes_queue)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int r;
+
+	/* MES does not know the queue, or not any more: nothing to send */
+	if (kfd_mes_queue_retired(dqm, q))
+		return 0;
+
+	/*
+	 * Nothing can be sent while the scheduler is stopped or halted, and
+	 * MES still has the queue. Say so rather than report success: the
+	 * caller then keeps the storage of the queue and leaves its MQD
+	 * alone, and the removal is sent once the scheduler runs again.
+	 */
+	if (!dqm->sched_running || dqm->sched_halt)
+		return -EIO;
+
+	r = __remove_queue_mes(dqm, q, flush_mes_queue);
+	if (!r)
+		return 0;
+
+	if (r == -ETIMEDOUT) {
+		/* Not answered yet. The command is still queued and may complete. */
+		if (kfd_mes_wait_retired(dqm, q, KFD_MES_REMOVE_GRACE_MS)) {
+			dev_warn(adev->dev,
+				 "MES confirmed REMOVE_QUEUE late, doorbell=0x%x\n",
+				 q->properties.doorbell_off);
+			return 0;
+		}
+
+		/*
+		 * Still no answer. MES is not working its ring, and the
+		 * recovery below would only queue three more commands behind
+		 * the unanswered one, each to time out under the dqm lock.
+		 * Stop talking to MES and leave it to the GPU reset.
+		 */
+		if (kfd_mes_ticket_pending(dqm, q))
+			goto hang;
+
+		/* Answered after all, with a failure: a hung queue */
+		r = AMDGPU_MES_CMD_REJECTED;
+	}
+
+	/*
+	 * -EIO: nothing was sent, a GPU reset is under way or MES is fenced
+	 * off. is_for_reset: the cleanup after a per-queue reset, the caller
+	 * decides what its failure means.
+	 */
+	if (is_for_reset || r == -EIO)
 		return r;
 
 	/* remove_hw_queue failure indicates a queue hang. reset the queue */
 	r = reset_queues_mes(dqm, q);
-	if (r && amdgpu_gpu_recovery) {
+	if (!r)
+		return 0;
+
+	/* MES let go of the queue in the meantime, whatever else failed */
+	if (kfd_mes_queue_retired(dqm, q))
+		return 0;
+
+hang:
+	if (r == -ETIMEDOUT || kfd_mes_ticket_pending(dqm, q))
+		kfd_mes_fence(dqm, q);
+
+	/* The caller of a remove-after-reset decides what a failure means */
+	if (is_for_reset)
+		return r;
+
+	if (amdgpu_gpu_recovery) {
 		dev_err(adev->dev, "failed to remove queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
@@ -372,7 +611,8 @@ static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 	list_for_each_entry(cur, &dqm->queues, list) {
 		qpd = cur->qpd;
 		list_for_each_entry(q, &qpd->queues_list, list) {
-			if (q->properties.is_active) {
+			/* An inactive queue can be in MES after a failed evict */
+			if (!kfd_mes_queue_retired(dqm, q)) {
 				retval = remove_queue_mes(dqm, q, qpd);
 				if (retval) {
 					dev_err(dev, "%s: Failed to remove queue %d for dev %d",
@@ -435,9 +675,22 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 						ffs(dqm->dev->xcc_mask) - 1);
 	if (r)
 		return r;
-	/* Proceed remove_queue with reset=true */
-	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
+	/*
+	 * Proceed remove_queue with reset=true. Its result matters: a
+	 * REMOVE_QUEUE that MES did not answer fails this reset, so that the
+	 * caller escalates to a GPU reset instead of sending more commands
+	 * behind it. A rejected cleanup does not fail it, MES answers and
+	 * the queue itself has been reset; the queue stays UNKNOWN and keeps
+	 * its storage until MES is restarted.
+	 */
+	r = remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
 	set_queue_as_reset(dqm, q, &pdd->qpd, true);
+	if (r == -ETIMEDOUT)
+		return r;
+	if (r)
+		dev_warn(adev->dev,
+			 "MES did not remove reset queue doorbell=0x%x (%d), keeping its storage\n",
+			 q->properties.doorbell_off, r);
 	return 0;
 }
 
@@ -476,16 +729,50 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 		goto fail;
 	}
 
+	/* Gone from MES in the meantime, nothing left to reset */
+	if (kfd_mes_queue_retired(dqm, q))
+		return 0;
+
+	/*
+	 * SUSPEND, DETECT_AND_RESET and RESUME would each time out behind
+	 * a command that MES has not answered.
+	 */
+	if (kfd_mes_fenced(dqm)) {
+		r = -EIO;
+		goto fail;
+	}
+	if (kfd_mes_ticket_pending(dqm, q)) {
+		r = -ETIMEDOUT;
+		goto fail;
+	}
+	/* An earlier REMOVE_QUEUE for @q was answered, its slot can go */
+	amdgpu_mes_ticket_release(adev, &q->mes_ticket);
+
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
 	queue_input.queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	queue_input.remove_queue_after_reset = false;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
+	queue_input.gang_context_array_index = q->gang_ctx_array_index;
+	/* The REMOVE_QUEUE sent from there can be left unanswered like any */
+	queue_input.ticket = &q->mes_ticket;
 	/* pass the known bad queue info to the reset function */
 	r = amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NULL, NULL, &num_hung, &queue_input);
-	if (r)
+	if (r) {
+		/* The REMOVE_QUEUE for @q may have been sent and lost */
+		if (q->mes_state == KFD_MES_QUEUE_MAPPED)
+			q->mes_state = KFD_MES_QUEUE_UNKNOWN;
 		goto fail;
+	}
+
+	/*
+	 * With no hung queue reported, amdgpu_gfx_reset_mes_compute() sent
+	 * the REMOVE_QUEUE for @q itself and MES confirmed it.
+	 */
+	if (!num_hung)
+		q->mes_state = KFD_MES_QUEUE_UNMAPPED;
+
 	pdd = kfd_get_process_device_data(q->device, q->process);
 	if (pdd) {
 		ti = amdgpu_vm_get_task_info_pasid(adev, pdd->pasid);
@@ -508,6 +795,17 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	}
 	amdgpu_vm_put_task_info(ti);
 
+	/*
+	 * MES reported other queues as hung, reset those and resumed the
+	 * rest, @q among them: amdgpu_gfx_reset_mes_compute() removes the
+	 * queue it was given only when nothing was reported hung. Both
+	 * callers want @q out of MES, so remove it now that the scheduler
+	 * answers again. If @q itself was among the hung queues, the
+	 * per-queue reset has removed it already and it is retired.
+	 */
+	if (num_hung && !kfd_mes_queue_retired(dqm, q))
+		r = __remove_queue_mes(dqm, q, false);
+
 fail:
 	dqm->detect_hang_count = 0;
 	return r;
@@ -1147,6 +1445,15 @@ static int update_queue_locked(struct device_queue_manager *dqm, struct queue *q
 	/* Save the activity state for queue removal. */
 	prev_active = q->properties.is_active;
 
+	/*
+	 * The queue is inactive but MES has not confirmed its removal, so
+	 * MES may still read and write the MQD. Leave it alone.
+	 */
+	if (!prev_active && !kfd_mes_queue_retired(dqm, q)) {
+		retval = -EBUSY;
+		return retval;
+	}
+
 	/* Make sure the queue is unmapped before updating the MQD */
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) {
 		if (!dqm->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c21da12d3..239168838 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -37,6 +37,13 @@
 #define KFD_MES_PROCESS_QUANTUM		100000
 #define KFD_MES_GANG_QUANTUM		10000
 
+/*
+ * How long to keep waiting for a REMOVE_QUEUE after the 2.1 s command poll
+ * gave up, and the polling interval. The wait runs under the dqm lock.
+ */
+#define KFD_MES_REMOVE_GRACE_MS		4000
+#define KFD_MES_REMOVE_POLL_US		2000
+
 struct device_process_node {
 	struct qcm_process_device *qpd;
 	struct list_head list;
@@ -292,6 +299,16 @@ struct device_queue_manager {
 	/* for per-queue reset with mes */
 	u32 *hung_db_array;
 	struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
+
+	/*
+	 * MES has a command it did not answer. Nothing more is sent until
+	 * it answers or the firmware is restarted. Protected by the dqm lock.
+	 */
+	bool			mes_fenced;
+	bool			mes_fence_has_seq;
+	u32			mes_fence_gen;
+	/* copy of the unanswered ticket, never released through this copy */
+	struct amdgpu_mes_cmd_ticket mes_fence_ticket;
 };
 
 void device_queue_manager_init_cik(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0c276f7eb..b5eae33d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -616,6 +616,13 @@ struct mqd_update_info {
  *
  */
 
+/* What MES knows about a queue, see kfd_mes_queue_retired() */
+enum kfd_mes_queue_state {
+	KFD_MES_QUEUE_UNMAPPED = 0,	/* never added, or removal confirmed */
+	KFD_MES_QUEUE_MAPPED,		/* ADD_QUEUE confirmed */
+	KFD_MES_QUEUE_UNKNOWN,		/* ADD or REMOVE sent, not confirmed */
+};
+
 struct queue {
 	struct list_head list;
 	void *mqd;
@@ -644,6 +651,13 @@ struct queue {
 
 	struct amdgpu_bo *wptr_bo_gart;
 
+	/* MES view of the queue. Protected by the dqm lock. */
+	enum kfd_mes_queue_state mes_state;
+	/* mes.fw_gen of the firmware instance the queue was added to */
+	u32 mes_fw_gen;
+	/* REMOVE_QUEUE that MES has not answered yet */
+	struct amdgpu_mes_cmd_ticket mes_ticket;
+
 	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
 	 * TTM evicts it into the hibernation image, and repinned on resume. Set
 	 * while the BO is unpinned so the resume path knows to repin it.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 89e95b70e..ef9ad6dc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -196,6 +196,8 @@ void kfd_queue_free_mes_resources(struct kfd_node *dev, struct queue *q)
 	if (!dev->kfd->shared_resources.enable_mes)
 		return;
 
+	/* The status slot of an unanswered REMOVE_QUEUE goes with the queue */
+	amdgpu_mes_ticket_release(dev->adev, &q->mes_ticket);
 	amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, q->gang_ctx_array_index);
 	amdgpu_amdkfd_free_kernel_mem(dev->adev, &q->gang_ctx_bo);
 	amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&q->wptr_bo_gart);
-- 
2.47.3

