Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B507606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=l5nigABE;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=CN8Yl4/b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E8210F75D;
	Tue, 24 Nov 2026 15:55:02 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F69C10F61A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530884;
 bh=RuNvG0POF61Wg4R4c+nC8660KgYbvD3VNZ2aCVpWNDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l5nigABEEHIa4t/gX7OGGy7v1b3B9zHknWM5Ji95ebw9JmfZUo9DLzGAK6m94EVlT
 6HJP/NKOTDzvXLB50ez7SFKTvZzyzaMm1/g1qqWrk2RYiY3hzJXgnbVsfQWPbXJaiD
 d4LfTKUw/hmAZmPTgvh6314fpC+Rzk7wkJTNL5QM7dq2NvYMHDCPLFRIxbKDs/TCue
 xrgoEug/L6e89I3Euu+YLFSXR08tUWrCmai2AKFk98E0tu0BNZg+1ueEQotLVU358x
 /TufkWAOvtdcE9EdNAvk0lPZE0JXfgrbZzPIAPTxGa6//0fVMFYSgxO5eppj/ycIsA
 ROznTbH5HhpdA==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 1B47417F067;
 Tue, 24 Nov 2026 15:34:44 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4KD9z0mYwkg; Tue, 24 Nov 2026 15:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530883;
 bh=RuNvG0POF61Wg4R4c+nC8660KgYbvD3VNZ2aCVpWNDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CN8Yl4/baKdPlUY/fOsbAOVGS+Sj+GH1KoCkhYjjpzKeDt4mou5AkVLdoI8o6jJYO
 O3yfTbm/jVbTcnmmwuLEOGnLxR84YJkZSs5UdiwlZlOHF7eZN6PnQ/xpf3nRSu9ikD
 gnOw9uKZiFpH//QT9jZRvzu0J2KQVkzfApJCebsGXNn7uUIFUDBHRFBs4sYQQp/81i
 fpk0yE1y/L9hNO+/FfJvT2rROn+vz34GypAtd8UxJACTNOQBlasAg31LI2u608vswR
 MpA+cQoaF3BQuy1TLD43T48gYqlZSpqZTpM2U2HR7NJpAhabVv5kqpxQQER//fVoXs
 /9pneNxcXIi3g==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 6BFA917F06A;
 Tue, 24 Nov 2026 15:34:43 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>,
 "Claude Fable 5.2" <noreply@anthropic.com>
Subject: [PATCH v1 8/9] drm/amdkfd: reconcile queue state with MES after a
 restart
Date: Tue, 24 Nov 2026 15:34:31 +0100
Message-ID: <20261124143433.49736-9-zappel@simple-co.de>
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

A GPU reset restarts the MES firmware, which then knows no user queues.
KFD keeps its processes, in an evicted state, until they exit. Their
queues cannot be removed cleanly on the way into the reset, because
every REMOVE_QUEUE fails with -EIO at that point.

On an R9700 this showed up as resets that come in pairs. A process that
had lived through a GPU reset exited 62 s later. KFD sent REMOVE_QUEUE
for queues the new firmware had never seen, MES rejected each command
within a fraction of a millisecond, and KFD reset the GPU again.

The per-queue MES state already stops those commands one queue at a
time. Put the driver state right in one place as well: when the
scheduler starts, walk the queues of every process, drop the MES state
that belongs to an earlier firmware instance and release the status
slots of commands that were lost with it. A queue that is still counted
as running is deactivated and marked evicted together with its process.
That is the state kgd2kfd_pre_reset() leaves queues in when eviction
works, and after a system resume kfd_resume_all_processes() maps the
queues again from it.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b93870421..03f341c45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2652,6 +2652,74 @@ static int init_dequeue_wait_counts_mes(struct device_queue_manager *dqm)
 	return 0;
 }
 
+/*
+ * Bring the queue bookkeeping in line with MES when the scheduler starts.
+ *
+ * If the MES firmware was set up from scratch since a queue was added (GPU
+ * reset, resume), it has no record of that queue. A GPU reset cannot evict
+ * cleanly: the REMOVE_QUEUE commands fail with -EIO while the reset is
+ * running, and whatever was not marked inactive at that point stays active
+ * in the driver. The next REMOVE_QUEUE for such a queue, typically when its
+ * process exits, is rejected by the new firmware instance and that failure
+ * is escalated to another GPU reset.
+ *
+ * So drop the stale MES state here, and deactivate every queue that the
+ * driver still counts as running although MES has lost it. KFD does not
+ * resume processes after a GPU reset. Such a queue is marked evicted, and
+ * its process with it, which is the state kgd2kfd_pre_reset() leaves all
+ * the queues in that it did manage to evict. After a system resume
+ * kfd_resume_all_processes() maps the queues again from that state.
+ *
+ * dqm lock held.
+ */
+static void kfd_dqm_reconcile_mes_queues(struct device_queue_manager *dqm)
+{
+	struct device *dev = dqm->dev->adev->dev;
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	unsigned int stale = 0, active = 0;
+	struct queue *q;
+
+	if (!dqm->dev->kfd->shared_resources.enable_mes)
+		return;
+
+	/* A command that got no answer died with the old firmware */
+	kfd_mes_fenced(dqm);
+
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			/* Not in MES, or added to the instance now running */
+			if (q->mes_state == KFD_MES_QUEUE_UNMAPPED ||
+			    q->mes_fw_gen == kfd_mes_gen(dqm))
+				continue;
+
+			/* Also returns the status slot of a lost command */
+			kfd_mes_queue_retired(dqm, q);
+			stale++;
+
+			if (!q->properties.is_active)
+				continue;
+
+			q->properties.is_active = false;
+			q->properties.is_evicted = true;
+			decrement_queue_count(dqm, qpd, q);
+			/* The process stays evicted from here on */
+			if (!qpd->evicted)
+				qpd->evicted = 1;
+			active++;
+		}
+	}
+
+	if (active)
+		dev_warn(dev,
+			 "MES was restarted with %u queue(s) still marked active, evicted them\n",
+			 active);
+	if (stale)
+		dev_info(dev, "MES was restarted, forgot %u user queue(s)\n",
+			 stale);
+}
+
 static int start_cpsch(struct device_queue_manager *dqm)
 {
 	struct device *dev = dqm->dev->adev->dev;
@@ -2716,6 +2784,8 @@ static int start_cpsch(struct device_queue_manager *dqm)
 		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
 		GFP_KERNEL);
 
+	kfd_dqm_reconcile_mes_queues(dqm);
+
 	/* A restart of the MES firmware retires every quarantined queue */
 	if (!list_empty(&dqm->zombie_queues))
 		mod_delayed_work(system_dfl_wq, &dqm->zombie_work, 0);
-- 
2.56.1

