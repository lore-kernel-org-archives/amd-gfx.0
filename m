Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F696606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=xrQJKe9u;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=xrQJKe9u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE5C112117;
	Thu, 26 Nov 2026 08:09:58 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB9510FCB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616377;
 bh=iI+wqqGJ+f9XZLAZRxQlUHDtk31NurxIyGvof1HleoI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xrQJKe9usFzZZ7qhL/4jTBhosf/ePXPwILscomt8e9y566INq1vqMiPopuf2MaPD3
 DkZJoEei3m8QXkOdMNMJz2GjJtUhEgZ+uXKRq0K65BtNz4nrMVb9CUD7AEX6Fej1hl
 zpRtPQ57NsVIoNApp1DZp/H75+1a2bs0iFZO6viTjqD4Wtps7xSVl5ZqcmYhbEklfv
 U8x+qynu0fJSL4zrBdzErpFDWOeYd5w2tZIeyzGA1Xsfkq6pzEBQUPxoBjalQ3nZmn
 TFngQccmVw3/lRFFPp6Xi80wh5mfjxMFBjOKWGOOXFWT2f7b1cW/zpBrloLBi27mso
 eMSN31D8ILK4g==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 9D89117F365;
 Wed, 25 Nov 2026 15:19:37 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqYGgMrhOQb2; Wed, 25 Nov 2026 15:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616377;
 bh=iI+wqqGJ+f9XZLAZRxQlUHDtk31NurxIyGvof1HleoI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xrQJKe9usFzZZ7qhL/4jTBhosf/ePXPwILscomt8e9y566INq1vqMiPopuf2MaPD3
 DkZJoEei3m8QXkOdMNMJz2GjJtUhEgZ+uXKRq0K65BtNz4nrMVb9CUD7AEX6Fej1hl
 zpRtPQ57NsVIoNApp1DZp/H75+1a2bs0iFZO6viTjqD4Wtps7xSVl5ZqcmYhbEklfv
 U8x+qynu0fJSL4zrBdzErpFDWOeYd5w2tZIeyzGA1Xsfkq6pzEBQUPxoBjalQ3nZmn
 TFngQccmVw3/lRFFPp6Xi80wh5mfjxMFBjOKWGOOXFWT2f7b1cW/zpBrloLBi27mso
 eMSN31D8ILK4g==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id D5D6317F364;
 Wed, 25 Nov 2026 15:19:36 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 1/9] drm/amdgpu/mes: distinguish rejected from timed out
 commands
Date: Wed, 25 Nov 2026 15:19:24 +0100
Message-ID: <20261125141933.154222-2-zappel@simple-co.de>
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

The MES command path reports two different outcomes as "MES failed to
respond" and -ETIMEDOUT: the fence was not reached within the poll
timeout, or the fence was reached and MES wrote a failure status.
Callers cannot tell a firmware that stopped answering from one that
answered promptly and said no. On an R9700 (gfx 12.0.1) three
REMOVE_QUEUE failures were logged within 644 us of each other, which the
2.1 s poll timeout rules out, yet KFD handled them as a hung scheduler
and reset the GPU.

Return AMDGPU_MES_CMD_REJECTED (-EREMOTEIO) when MES answered with a
failure and print the 64 bit status, whose upper half carries the error
code of the firmware. -ETIMEDOUT now only means that MES did not answer.
No caller compares a MES result against -ETIMEDOUT today.

mes_v12_1 read the status slot as 32 bits, so the error code in the
upper half was never seen there. Read it as 64 bits like mes_v11_0 and
mes_v12_0 do, and print both halves.

A command that timed out is still in the MES ring and may be executed
later. Its status writeback slot is freed on timeout and the allocator
is first fit, so a late status write lands in a slot that belongs to
somebody else by then, and the caller cannot find out that the command
completed after all. Add a ticket that the caller of REMOVE_QUEUE can
pass in. When the command is left unanswered, the ticket takes over the
status slot and remembers the fence sequence. The caller can poll it for
a late completion and releases the slot once MES cannot write to it any
more.

Add mes.fw_gen, incremented each time the scheduler pipe of an XCC has
been set up from scratch. A queue that was added under an older
generation does not exist in the firmware any more, and a ticket from an
older generation is stale. The counter is per XCC because on GC 12.1
every XCC runs its own scheduler instance; a ticket records the XCC it
was submitted on. The counter is only incremented on the full init path,
behind the pipe reset: a missed increment delays the release of
resources, a spurious one would be unsafe.

MES writes the status before the trailing fence. Read the status after
the fence with a dma_rmb() in between, in the command path and in the
ticket poll, so that a weakly ordered CPU cannot see the new fence
together with the old status.

While at it, make mes_v12_1 return -ETIMEDOUT when the MES ring is full.
It returned 0 there, which a caller would take for a completed command.

The ticket and the generation counter have no users yet. The only change
in behaviour is the error code and the log line for rejected commands.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 85 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 53 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 54 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 55 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 89 ++++++++++++++++++++-----
 5 files changed, 308 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 7864afab5..7958e5a23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -141,6 +141,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 				adev->gfx.disable_kq ? 0 : adev->gfx.num_compute_rings);
 
 	adev->mes.adev = adev;
+	for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++)
+		atomic_set(&adev->mes.fw_gen[i], 0);
 
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
@@ -345,6 +347,89 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->mes.dbgext_drain_lock);
 }
 
+/* True when MES has processed the command stream up to @seq. */
+static bool amdgpu_mes_fence_passed(struct amdgpu_ring *ring, u32 seq)
+{
+	u32 cur = le32_to_cpu(READ_ONCE(*ring->fence_drv.cpu_addr));
+
+	return (s32)(seq - cur) <= 0;
+}
+
+/**
+ * amdgpu_mes_ticket_poll - check on a command that timed out earlier
+ *
+ * @adev: amdgpu_device pointer
+ * @ticket: ticket filled in by the command path
+ *
+ * Does not sleep and takes no locks. The caller serialises against
+ * amdgpu_mes_ticket_release() on the same ticket.
+ */
+enum amdgpu_mes_ticket_state
+amdgpu_mes_ticket_poll(struct amdgpu_device *adev,
+		       const struct amdgpu_mes_cmd_ticket *ticket)
+{
+	const u64 *status;
+
+	if (!ticket->valid ||
+	    ticket->fw_gen != amdgpu_mes_fw_gen(&adev->mes, ticket->xcc_id))
+		return AMDGPU_MES_TICKET_STALE;
+
+	status = (const u64 *)&adev->wb.wb[ticket->status_offs];
+	if (lower_32_bits(READ_ONCE(*status)))
+		return AMDGPU_MES_TICKET_DONE;
+
+	if (!amdgpu_mes_fence_passed(&adev->mes.ring[ticket->ring_idx],
+				     ticket->seq))
+		return AMDGPU_MES_TICKET_PENDING;
+
+	/*
+	 * MES writes the status before the trailing fence. Look again, and
+	 * do not let that look be satisfied by a load made before the fence
+	 * was seen.
+	 */
+	dma_rmb();
+	return lower_32_bits(READ_ONCE(*status)) ?
+		AMDGPU_MES_TICKET_DONE : AMDGPU_MES_TICKET_FAILED;
+}
+
+/**
+ * amdgpu_mes_ticket_answered - has MES got past a timed out command
+ *
+ * @adev: amdgpu_device pointer
+ * @ticket: ticket, or a copy of one
+ *
+ * Unlike amdgpu_mes_ticket_poll() this does not look at the status slot,
+ * so it may be used on a copy whose original has been released.
+ */
+bool amdgpu_mes_ticket_answered(struct amdgpu_device *adev,
+				const struct amdgpu_mes_cmd_ticket *ticket)
+{
+	if (ticket->fw_gen != amdgpu_mes_fw_gen(&adev->mes, ticket->xcc_id))
+		return true;
+
+	return amdgpu_mes_fence_passed(&adev->mes.ring[ticket->ring_idx],
+				       ticket->seq);
+}
+
+/**
+ * amdgpu_mes_ticket_release - give back the status slot of a ticket
+ *
+ * @adev: amdgpu_device pointer
+ * @ticket: ticket to release, may be invalid already
+ *
+ * Only call this once MES cannot write the status any more: the command
+ * was answered, or the firmware instance that received it is gone.
+ */
+void amdgpu_mes_ticket_release(struct amdgpu_device *adev,
+			       struct amdgpu_mes_cmd_ticket *ticket)
+{
+	if (!ticket->valid)
+		return;
+
+	amdgpu_wb_free(adev, ticket->status_offs);
+	ticket->valid = false;
+}
+
 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id)
 {
 	struct mes_suspend_gang_input input;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e5dbcf8ef..0d4ef4814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -225,6 +225,15 @@ struct amdgpu_mes {
 	uint32_t			gang_ctx_array_size;
 	uint32_t			gang_ctx_array_index;
 	unsigned long			*gang_ctx_bitmap;
+
+	/*
+	 * Incremented each time the scheduler firmware of an XCC is set up
+	 * from scratch. A queue that was added under an older value does
+	 * not exist in the firmware any more. One counter per XCC: on GC
+	 * 12.1 every XCC runs its own scheduler instance, and a restart of
+	 * one of them says nothing about the queues of the others.
+	 */
+	atomic_t			fw_gen[AMDGPU_MAX_GC_INSTANCES];
 };
 
 struct amdgpu_mes_hung_queue_hqd_info {
@@ -326,6 +335,34 @@ struct mes_add_queue_input {
 	uint32_t	gang_context_array_index;
 };
 
+/*
+ * Returned by the command path when MES answered and reported a failure.
+ * -ETIMEDOUT is kept for commands that MES did not answer at all.
+ */
+#define AMDGPU_MES_CMD_REJECTED		(-EREMOTEIO)
+
+/*
+ * Handle to a command that MES had not answered when the poll timeout
+ * expired. The command is still in the MES ring and the firmware may
+ * complete it later, so the ticket keeps the status writeback slot
+ * allocated until amdgpu_mes_ticket_release() is called.
+ */
+struct amdgpu_mes_cmd_ticket {
+	bool	valid;		/* owns the status slot while true */
+	u32	xcc_id;		/* XCC whose scheduler got the command */
+	u32	ring_idx;	/* index into amdgpu_mes::ring[] */
+	u32	seq;		/* fence seq of the trailing status query */
+	u32	status_offs;	/* wb offset of the 64 bit API status */
+	u32	fw_gen;		/* amdgpu_mes::fw_gen[xcc_id] at submission */
+};
+
+enum amdgpu_mes_ticket_state {
+	AMDGPU_MES_TICKET_PENDING,	/* MES has not processed the command */
+	AMDGPU_MES_TICKET_DONE,		/* processed, success */
+	AMDGPU_MES_TICKET_FAILED,	/* processed, failure */
+	AMDGPU_MES_TICKET_STALE,	/* not valid, or MES was restarted */
+};
+
 struct mes_remove_queue_input {
 	uint32_t        xcc_id;
 	uint32_t	doorbell_offset;
@@ -333,6 +370,8 @@ struct mes_remove_queue_input {
 	uint32_t	queue_type;
 	bool		remove_queue_after_reset;
 	uint32_t	gang_context_array_index;
+	/* Optional. Filled in when the command is left unanswered. */
+	struct amdgpu_mes_cmd_ticket *ticket;
 };
 
 struct mes_map_legacy_queue_input {
@@ -607,6 +646,20 @@ static inline uint32_t amdgpu_mes_ih_int_type(uint32_t context_data)
 	       AMDGPU_MES_IH_INT_TYPE_MASK;
 }
 
+/* Generation of the scheduler firmware instance that runs on @xcc_id */
+static inline u32 amdgpu_mes_fw_gen(struct amdgpu_mes *mes, u32 xcc_id)
+{
+	return (u32)atomic_read(&mes->fw_gen[xcc_id]);
+}
+
+enum amdgpu_mes_ticket_state
+amdgpu_mes_ticket_poll(struct amdgpu_device *adev,
+		       const struct amdgpu_mes_cmd_ticket *ticket);
+bool amdgpu_mes_ticket_answered(struct amdgpu_device *adev,
+				const struct amdgpu_mes_cmd_ticket *ticket);
+void amdgpu_mes_ticket_release(struct amdgpu_device *adev,
+			       struct amdgpu_mes_cmd_ticket *ticket);
+
 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id);
 int amdgpu_mes_resume(struct amdgpu_device *adev, u32 xcc_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 30d3d25d5..e51a41b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -181,9 +181,10 @@ static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
 	return op_str;
 }
 
-static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
-						    void *pkt, int size,
-						    int api_status_off)
+static int mes_v11_0_submit_pkt_ticket(struct amdgpu_mes *mes,
+				       void *pkt, int size,
+				       int api_status_off,
+				       struct amdgpu_mes_cmd_ticket *ticket)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
 	signed long timeout = 2100000; /* 2100 ms */
@@ -264,9 +265,20 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
+	/* The status is written before the fence, read it after the fence */
+	dma_rmb();
 	if (r < 1 || !*status_ptr) {
+		/* The fence was reached, so MES processed the command */
+		bool answered = r >= 1;
 
-		if (misc_op_str)
+		if (answered)
+			dev_err(adev->dev,
+				"MES rejected msg=%s (opcode %d), status 0x%016llx\n",
+				misc_op_str ? misc_op_str :
+				op_str ? op_str : "unknown",
+				x_pkt->header.opcode,
+				(unsigned long long)*status_ptr);
+		else if (misc_op_str)
 			dev_err(adev->dev,
 				"MES failed to respond to msg=%s (%s) fence_wait_ret=%ld status=0x%llx\n",
 				op_str, misc_op_str, r, *status_ptr);
@@ -282,7 +294,25 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		while (halt_if_hws_hang)
 			schedule();
 
+		if (answered) {
+			r = AMDGPU_MES_CMD_REJECTED;
+			goto error_wb_free;
+		}
+
 		r = -ETIMEDOUT;
+		if (ticket) {
+			/*
+			 * The command is still in the ring and MES may write
+			 * the status later. The caller owns the slot now.
+			 */
+			ticket->xcc_id = 0;
+			ticket->ring_idx = 0;
+			ticket->seq = seq;
+			ticket->status_offs = status_offset;
+			ticket->fw_gen = amdgpu_mes_fw_gen(mes, 0);
+			ticket->valid = true;
+			return r;
+		}
 		goto error_wb_free;
 	}
 
@@ -301,6 +331,14 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	return r;
 }
 
+static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
+						    void *pkt, int size,
+						    int api_status_off)
+{
+	return mes_v11_0_submit_pkt_ticket(mes, pkt, size, api_status_off,
+					   NULL);
+}
+
 static int convert_to_mes_queue_type(int queue_type)
 {
 	if (queue_type == AMDGPU_RING_TYPE_GFX)
@@ -412,9 +450,10 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 	if (mes_rev >= 0x60)
 		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
 
-	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+	return mes_v11_0_submit_pkt_ticket(mes,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status),
+			input->ticket);
 }
 
 /* Use MES callbacks directly while holding the MES lock. */
@@ -2144,6 +2183,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
+	/* A new scheduler instance is up, it knows none of the old queues */
+	atomic_inc(&adev->mes.fw_gen[0]);
+
 	/*
 	 * QUERY_SCHEDULER_STATUS to get array sizes (N, M).
 	 * MES writes the sizes to the GPU buffer, then we allocate bitmaps.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 988e05823..2c8db13e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -149,9 +149,10 @@ static const char *mes_v12_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
 	return op_str;
 }
 
-static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
-					    int pipe, void *pkt, int size,
-					    int api_status_off)
+static int mes_v12_0_submit_pkt_ticket(struct amdgpu_mes *mes,
+				       int pipe, void *pkt, int size,
+				       int api_status_off,
+				       struct amdgpu_mes_cmd_ticket *ticket)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
 	signed long timeout = 2100000; /* 2100 ms */
@@ -234,14 +235,26 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
+	/* The status is written before the fence, read it after the fence */
+	dma_rmb();
 
 	/*
 	 * status_ptr[31:0] == 0 (fail) or status_ptr[63:0] == 1 (success).
 	 * If status_ptr[31:0] == 0 then status_ptr[63:32] will have debug error information.
 	 */
 	if (r < 1 || !(lower_32_bits(*status_ptr))) {
+		/* The fence was reached, so MES processed the command */
+		bool answered = r >= 1;
 
-		if (misc_op_str)
+		if (answered)
+			dev_err(adev->dev,
+				"MES(%d) rejected msg=%s (opcode %d), status 0x%016llx\n",
+				pipe,
+				misc_op_str ? misc_op_str :
+				op_str ? op_str : "unknown",
+				x_pkt->header.opcode,
+				(unsigned long long)*status_ptr);
+		else if (misc_op_str)
 			dev_err(adev->dev,
 				"MES(%d) failed to respond to msg=%s (%s) fence_wait_ret=%ld status=0x%x_%x\n",
 				pipe, op_str, misc_op_str, r,
@@ -260,7 +273,25 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		while (halt_if_hws_hang)
 			schedule();
 
+		if (answered) {
+			r = AMDGPU_MES_CMD_REJECTED;
+			goto error_wb_free;
+		}
+
 		r = -ETIMEDOUT;
+		if (ticket) {
+			/*
+			 * The command is still in the ring and MES may write
+			 * the status later. The caller owns the slot now.
+			 */
+			ticket->xcc_id = 0;
+			ticket->ring_idx = pipe;
+			ticket->seq = seq;
+			ticket->status_offs = status_offset;
+			ticket->fw_gen = amdgpu_mes_fw_gen(mes, 0);
+			ticket->valid = true;
+			return r;
+		}
 		goto error_wb_free;
 	}
 
@@ -279,6 +310,14 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	return r;
 }
 
+static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
+					    int pipe, void *pkt, int size,
+					    int api_status_off)
+{
+	return mes_v12_0_submit_pkt_ticket(mes, pipe, pkt, size,
+					   api_status_off, NULL);
+}
+
 static int convert_to_mes_queue_type(int queue_type)
 {
 	if (queue_type == AMDGPU_RING_TYPE_GFX)
@@ -388,10 +427,11 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 	if (mes_rev >= 0x5a)
 		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
 
-	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+	return mes_v12_0_submit_pkt_ticket(mes,
 			AMDGPU_MES_SCHED_PIPE,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status),
+			input->ticket);
 }
 
 int gfx_v12_0_request_gfx_index_mutex(struct amdgpu_device *adev,
@@ -2232,6 +2272,9 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
+	/* A new scheduler instance is up, it knows none of the old queues */
+	atomic_inc(&adev->mes.fw_gen[0]);
+
 	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x4b)
 		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5c046f64b..5fabf05d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -154,9 +154,10 @@ static const char *mes_v12_1_get_misc_op_string(union MESAPI__MISC *x_pkt)
 	return op_str;
 }
 
-static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
-					    int xcc_id, int pipe, void *pkt,
-					    int size, int api_status_off)
+static int mes_v12_1_submit_pkt_ticket(struct amdgpu_mes *mes,
+				       int xcc_id, int pipe, void *pkt,
+				       int size, int api_status_off,
+				       struct amdgpu_mes_cmd_ticket *ticket)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
 	signed long timeout = 2100000; /* 2100 ms */
@@ -169,7 +170,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	unsigned long flags;
 	u64 status_gpu_addr;
 	u32 seq, status_offset;
-	u32 *status_ptr;
+	u64 *status_ptr;
 	signed long r;
 	int ret;
 
@@ -188,7 +189,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		return ret;
 
 	status_gpu_addr = adev->wb.gpu_addr + (status_offset * 4);
-	status_ptr = &adev->wb.wb[status_offset];
+	status_ptr = (u64 *)&adev->wb.wb[status_offset];
 	*status_ptr = 0;
 
 	spin_lock_irqsave(ring_lock, flags);
@@ -200,8 +201,10 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring,
 				      seq - ring->fence_drv.num_fences_mask,
 				      timeout);
-	if (r < 1)
+	if (r < 1) {
+		r = -ETIMEDOUT;
 		goto error_undo;
+	}
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
@@ -237,24 +240,63 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			xcc_id, pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
-	if (r < 1 || !*status_ptr) {
-		if (misc_op_str)
+	/* The status is written before the fence, read it after the fence */
+	dma_rmb();
+
+	/*
+	 * status_ptr[31:0] == 0 (fail) or status_ptr[63:0] == 1 (success).
+	 * If status_ptr[31:0] == 0 then status_ptr[63:32] will have debug error information.
+	 */
+	if (r < 1 || !(lower_32_bits(*status_ptr))) {
+		/* The fence was reached, so MES processed the command */
+		bool answered = r >= 1;
+
+		if (answered)
+			dev_err(adev->dev,
+				"MES(%d, %d) rejected msg=%s (opcode %d), status 0x%016llx\n",
+				xcc_id, pipe,
+				misc_op_str ? misc_op_str :
+				op_str ? op_str : "unknown",
+				x_pkt->header.opcode,
+				(unsigned long long)*status_ptr);
+		else if (misc_op_str)
 			dev_err(adev->dev,
-				"MES(%d, %d) failed to respond to msg=%s (%s) fence_wait_ret=%ld status=0x%x\n",
-				xcc_id, pipe, op_str, misc_op_str, r, *status_ptr);
+				"MES(%d, %d) failed to respond to msg=%s (%s) fence_wait_ret=%ld status=0x%x_%x\n",
+				xcc_id, pipe, op_str, misc_op_str, r,
+				upper_32_bits(*status_ptr), lower_32_bits(*status_ptr));
 		else if (op_str)
 			dev_err(adev->dev,
-				"MES(%d, %d) failed to respond to msg=%s fence_wait_ret=%ld status=0x%x\n",
-				xcc_id, pipe, op_str, r, *status_ptr);
+				"MES(%d, %d) failed to respond to msg=%s fence_wait_ret=%ld status=0x%x_%x\n",
+				xcc_id, pipe, op_str, r,
+				upper_32_bits(*status_ptr), lower_32_bits(*status_ptr));
 		else
 			dev_err(adev->dev,
-				"MES(%d, %d) failed to respond to msg=%d fence_wait_ret=%ld status=0x%x\n",
-				xcc_id, pipe, x_pkt->header.opcode, r, *status_ptr);
+				"MES(%d, %d) failed to respond to msg=%d fence_wait_ret=%ld status=0x%x_%x\n",
+				xcc_id, pipe, x_pkt->header.opcode, r,
+				upper_32_bits(*status_ptr), lower_32_bits(*status_ptr));
 
 		while (halt_if_hws_hang)
 			schedule();
 
+		if (answered) {
+			r = AMDGPU_MES_CMD_REJECTED;
+			goto error_wb_free;
+		}
+
 		r = -ETIMEDOUT;
+		if (ticket) {
+			/*
+			 * The command is still in the ring and MES may write
+			 * the status later. The caller owns the slot now.
+			 */
+			ticket->xcc_id = xcc_id;
+			ticket->ring_idx = MES_PIPE_INST(xcc_id, pipe);
+			ticket->seq = seq;
+			ticket->status_offs = status_offset;
+			ticket->fw_gen = amdgpu_mes_fw_gen(mes, xcc_id);
+			ticket->valid = true;
+			return r;
+		}
 		goto error_wb_free;
 	}
 
@@ -273,6 +315,14 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	return r;
 }
 
+static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
+					    int xcc_id, int pipe, void *pkt,
+					    int size, int api_status_off)
+{
+	return mes_v12_1_submit_pkt_ticket(mes, xcc_id, pipe, pkt, size,
+					   api_status_off, NULL);
+}
+
 static int convert_to_mes_queue_type(int queue_type)
 {
 	if (queue_type == AMDGPU_RING_TYPE_GFX)
@@ -368,10 +418,11 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 
-	return mes_v12_1_submit_pkt_and_poll_completion(mes,
+	return mes_v12_1_submit_pkt_ticket(mes,
 			xcc_id, AMDGPU_MES_SCHED_PIPE,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status),
+			input->ticket);
 }
 
 static int mes_v12_1_reset_hw_queue(struct amdgpu_mes *mes,
@@ -1901,6 +1952,12 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 	if (r)
 		goto failure;
 
+	/*
+	 * A new scheduler instance is up on this XCC, it knows none of the
+	 * old queues. The other XCCs keep theirs.
+	 */
+	atomic_inc(&adev->mes.fw_gen[xcc_id]);
+
 	mes_v12_1_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE, xcc_id);
 	mes_v12_1_init_aggregated_doorbell(&adev->mes, xcc_id);
 
-- 
2.47.3

