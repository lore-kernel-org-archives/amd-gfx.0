Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0693606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=MUptrTl3;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=HIsD9GMJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6327411210B;
	Thu, 26 Nov 2026 08:09:44 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A20010FCB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616379;
 bh=chO9yvXw/TivF129xs/UCzp+GMRoKnQsGGd2z+393ew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MUptrTl3ztUWFKI2sgYbxSq7GrOi3ARDipZ1S8M2TkjpcfHKtrbTZi5TNzu/qKL0Y
 eM+F7ohvOi4uX2XeBqYgbCZqgFbZeetyixtl5jybsYzDUizcnBt3+gbmUqQaxWVNgU
 jBdT6Kfo/mYwjEcKcz4gv6196qf26hDivnv4jTZagvdWiiFYiIu2x6CSEqCl9P1OuG
 j0Dm9mB3S0BzQbfh7+xtLfsU3M1FAZZjABhNA5KRX9lc0OfU+JGSnBWRj294amClSF
 WJ4Lat3/R1hZZ+zOSDAoHsAoGbMFjTGiohf89Wvj6rUVxhiCZ5m7x0z0WViXHcIRtq
 SUQkt70ABohKw==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 5075617F362;
 Wed, 25 Nov 2026 15:19:39 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2en2fwTIPW9V; Wed, 25 Nov 2026 15:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=chO9yvXw/TivF129xs/UCzp+GMRoKnQsGGd2z+393ew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HIsD9GMJPTS4Eo9fWatGwwx06VNYfqvRjI6pUPWkoJQQVvSvES7643UGYu7e3zIRo
 3m7+y1D4G08bTrUnZrSV14Y91yKfTMPzQJQXQZjifMVGw6aloH/PwV2rZilpPDCmKu
 20wdjOK29ljYQVaUg92VqzSyg+B5DlFNvBHXZ3g08YZOk3dw3UF6OTVRstj7yPrYFF
 QxCPf8/n122Lu5/8PO2MJaZgXkwmE8sfuo96JYpNz8qVBj91P5K0XWJ0yL4rByS3sb
 nratYelrBxtg0yE5o2n96usgDaXf9Y2DZup48/DPCiF8wAd5MFz/j6A2CU/RbBbXUl
 /aJWuIMiAn6EQ==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 9141817F36A;
 Wed, 25 Nov 2026 15:19:38 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 8/9] drm/amdkfd: reconcile queue state with MES after a
 restart
Date: Wed, 25 Nov 2026 15:19:31 +0100
Message-ID: <20261125141933.154222-9-zappel@simple-co.de>
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
that belongs to an earlier firmware instance, release the status slots
of commands that were lost with it, and lift the fence that was raised
for such a command.

The queues are inactive by then. Every path that restarts the firmware
with live processes evicts them first, through kgd2kfd_pre_reset() or
kgd2kfd_suspend(), and set_queue_as_reset() takes care of what a
partial eviction left active. The reconcile does not deactivate queues
itself; a queue it finds still marked active is reported, because a
restart path has then forgotten to evict.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a75c88356..41e97f74e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2756,6 +2756,66 @@ static int init_dequeue_wait_counts_mes(struct device_queue_manager *dqm)
 	return 0;
 }
 
+/*
+ * Bring the queue bookkeeping in line with MES when the scheduler starts.
+ *
+ * If the MES firmware was set up from scratch since a queue was added (GPU
+ * reset, resume), it has no record of that queue. A GPU reset cannot evict
+ * cleanly: the REMOVE_QUEUE commands fail with -EIO while the reset is
+ * running. The next REMOVE_QUEUE for such a queue, typically when its
+ * process exits, is rejected by the new firmware instance and that failure
+ * is escalated to another GPU reset.
+ *
+ * So drop the stale MES state here, return the status slots of commands
+ * that were lost with the old firmware, and lift the fence raised for one
+ * of them. The queues themselves are inactive at this point: every path
+ * that restarts the firmware with live processes evicts them first, and
+ * set_queue_as_reset() deactivates what a partial eviction left active.
+ * A queue that is still marked active means a restart path forgot to
+ * evict; say so, but leave the counters to the paths that own them.
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
+			if (q->properties.is_active)
+				active++;
+		}
+	}
+
+	if (active)
+		dev_warn(dev,
+			 "MES was restarted with %u queue(s) still marked active, they were not evicted\n",
+			 active);
+	if (stale)
+		dev_info(dev, "MES was restarted, forgot %u user queue(s)\n",
+			 stale);
+}
+
 static int start_cpsch(struct device_queue_manager *dqm)
 {
 	struct device *dev = dqm->dev->adev->dev;
@@ -2820,6 +2880,8 @@ static int start_cpsch(struct device_queue_manager *dqm)
 		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
 		GFP_KERNEL);
 
+	kfd_dqm_reconcile_mes_queues(dqm);
+
 	/* A restart of the MES firmware retires every quarantined queue */
 	if (!list_empty(&dqm->zombie_queues))
 		mod_delayed_work(system_dfl_wq, &dqm->zombie_work, 0);
-- 
2.47.3

