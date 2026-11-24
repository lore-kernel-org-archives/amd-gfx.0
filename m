Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8356606A330
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=qvoA1TNl;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=CLvrRrNQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFB410F74E;
	Tue, 24 Nov 2026 15:54:51 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B189710F69A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530882;
 bh=TpELwyzYFZhbzFuemneA+0JcNdPdVWs2svAqhqw90pM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qvoA1TNle91xEX3M65szNxcr8YlWsvh/tF3f9k6iJo0tDQmft3rjLgKE3Inf3it3g
 rvhuSzA62+ibYFiqY08CNkPhxtYvt/awpU4AqyFH46l40obKjufGbse8A7lqepM6rW
 7A/IZ+D8Aziwux09oHXHSdpJIyQh6XC0Ya3Fiwt57Is7fhu3BNTgiGFt46AGN7ycVf
 fv0udqT6/LB2OozwtZEQn26CR3e6J58XtCMI+bjVThg7bV72HPLcs117Owd0H5usX3
 6tr8A4noiq+oQ2WTd7DyLV0Cjm16TSQcRRghXXFAj5xA59v5S3MzDZbaAS7+9rh6j3
 TJcbDTxGCxXPw==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 47F3317F069;
 Tue, 24 Nov 2026 15:34:42 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PD0LF83Zdhvu; Tue, 24 Nov 2026 15:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530881;
 bh=TpELwyzYFZhbzFuemneA+0JcNdPdVWs2svAqhqw90pM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CLvrRrNQg2NknHc1C/TTEKiEZKdyyZBu4QA+6v3sERfRywmjASVxHM/3kNnTOXf01
 mx8/IbB1SM6oj7wzVGf8f2BP+Vd+OwOnbg7GniyOso7HW6aVFNs0s2r0hSJojWzkGF
 6U4ibq1VpEqcBCemEJsHLv/VETql5+Ao9ILStVOxSizHP7K/tFvcK28bxOmuC4TBzT
 mp5TfXSHbA4mX6J0Q7o9eQdTYQmcRuH7gZ0jz4PtpSpYZckKEbrEDbPfAw9ohPTlZw
 M87+But4MTYb3/7zOaH3aYhMqWiWADz5arCG/1jNIxQ75EJLa3jhPdLL8NNoE+63U8
 XpicY/MAfl/8w==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 6912017F066;
 Tue, 24 Nov 2026 15:34:41 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>,
 "Claude Fable 5.2" <noreply@anthropic.com>
Subject: [PATCH v1 1/9] drm/amdgpu/mes: distinguish rejected from timed out
 commands
Date: Tue, 24 Nov 2026 15:34:24 +0100
Message-ID: <20261124143433.49736-2-zappel@simple-co.de>
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

A command that timed out is still in the MES ring and may be executed
later. Its status writeback slot is freed on timeout and the allocator
is first fit, so a late status write lands in a slot that belongs to
somebody else by then, and the caller cannot find out that the command
completed after all. Add a ticket that the caller of REMOVE_QUEUE can
pass in. When the command is left unanswered, the ticket takes over the
status slot and remembers the fence sequence. The caller can poll it for
a late completion and releases the slot once MES cannot write to it any
more.

Add mes.fw_gen, incremented each time the scheduler pipe has been set up
from scratch. A queue that was added under an older generation does not
exist in the firmware any more, and a ticket from an older generation is
stale. The counter is only incremented on the full init path, behind the
pipe reset: a missed increment delays the release of resources, a
spurious one would be unsafe.

While at it, make mes_v12_1 return -ETIMEDOUT when the MES ring is full.
It returned 0 there, which a caller would take for a completed command.

The ticket and the generation counter have no users yet. The only change
in behaviour is the error code and the log line for rejected commands.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 79 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 44 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 51 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 52 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 57 +++++++++++++++---
 5 files changed, 264 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 7864afab5..dd9366b99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -141,6 +141,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 				adev->gfx.disable_kq ? 0 : adev->gfx.num_compute_rings);
 
 	adev->mes.adev = adev;
+	atomic_set(&adev->mes.fw_gen, 0);
 
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
@@ -345,6 +346,84 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
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
+	    ticket->fw_gen != (u32)atomic_read(&adev->mes.fw_gen))
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
+	/* MES writes the status before the trailing fence. Look again. */
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
+	if (ticket->fw_gen != (u32)atomic_read(&adev->mes.fw_gen))
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
index e5dbcf8ef..ec3b7b306 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -225,6 +225,13 @@ struct amdgpu_mes {
 	uint32_t			gang_ctx_array_size;
 	uint32_t			gang_ctx_array_index;
 	unsigned long			*gang_ctx_bitmap;
+
+	/*
+	 * Incremented each time the scheduler firmware is set up from
+	 * scratch. A queue that was added under an older value does not
+	 * exist in the firmware any more.
+	 */
+	atomic_t			fw_gen;
 };
 
 struct amdgpu_mes_hung_queue_hqd_info {
@@ -326,6 +333,33 @@ struct mes_add_queue_input {
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
+	u32	ring_idx;	/* index into amdgpu_mes::ring[] */
+	u32	seq;		/* fence seq of the trailing status query */
+	u32	status_offs;	/* wb offset of the 64 bit API status */
+	u32	fw_gen;		/* amdgpu_mes::fw_gen at submission */
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
@@ -333,6 +367,8 @@ struct mes_remove_queue_input {
 	uint32_t	queue_type;
 	bool		remove_queue_after_reset;
 	uint32_t	gang_context_array_index;
+	/* Optional. Filled in when the command is left unanswered. */
+	struct amdgpu_mes_cmd_ticket *ticket;
 };
 
 struct mes_map_legacy_queue_input {
@@ -607,6 +643,14 @@ static inline uint32_t amdgpu_mes_ih_int_type(uint32_t context_data)
 	       AMDGPU_MES_IH_INT_TYPE_MASK;
 }
 
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
index 30d3d25d5..cdaab9f57 100644
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
@@ -265,8 +266,17 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
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
@@ -282,7 +292,24 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
+			ticket->ring_idx = 0;
+			ticket->seq = seq;
+			ticket->status_offs = status_offset;
+			ticket->fw_gen = atomic_read(&mes->fw_gen);
+			ticket->valid = true;
+			return r;
+		}
 		goto error_wb_free;
 	}
 
@@ -301,6 +328,14 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
@@ -412,9 +447,10 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
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
@@ -2144,6 +2180,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
+	/* A new scheduler instance is up, it knows none of the old queues */
+	atomic_inc(&adev->mes.fw_gen);
+
 	/*
 	 * QUERY_SCHEDULER_STATUS to get array sizes (N, M).
 	 * MES writes the sizes to the GPU buffer, then we allocate bitmaps.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 988e05823..057b66979 100644
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
@@ -240,8 +241,18 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
@@ -260,7 +271,24 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
+			ticket->ring_idx = pipe;
+			ticket->seq = seq;
+			ticket->status_offs = status_offset;
+			ticket->fw_gen = atomic_read(&mes->fw_gen);
+			ticket->valid = true;
+			return r;
+		}
 		goto error_wb_free;
 	}
 
@@ -279,6 +307,14 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
@@ -388,10 +424,11 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
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
@@ -2232,6 +2269,9 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
+	/* A new scheduler instance is up, it knows none of the old queues */
+	atomic_inc(&adev->mes.fw_gen);
+
 	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x4b)
 		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5c046f64b..a2e0156ae 100644
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
@@ -238,7 +241,18 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
 	if (r < 1 || !*status_ptr) {
-		if (misc_op_str)
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
 				"MES(%d, %d) failed to respond to msg=%s (%s) fence_wait_ret=%ld status=0x%x\n",
 				xcc_id, pipe, op_str, misc_op_str, r, *status_ptr);
@@ -254,7 +268,24 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
+			ticket->ring_idx = MES_PIPE_INST(xcc_id, pipe);
+			ticket->seq = seq;
+			ticket->status_offs = status_offset;
+			ticket->fw_gen = atomic_read(&mes->fw_gen);
+			ticket->valid = true;
+			return r;
+		}
 		goto error_wb_free;
 	}
 
@@ -273,6 +304,14 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
@@ -368,10 +407,11 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
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
@@ -1901,6 +1941,9 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 	if (r)
 		goto failure;
 
+	/* A new scheduler instance is up, it knows none of the old queues */
+	atomic_inc(&adev->mes.fw_gen);
+
 	mes_v12_1_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE, xcc_id);
 	mes_v12_1_init_aggregated_doorbell(&adev->mes, xcc_id);
 
-- 
2.56.1

