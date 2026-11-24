Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2A606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=qAA0N6Fl;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=qAA0N6Fl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459C810F750;
	Tue, 24 Nov 2026 15:54:53 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D1D10F695
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530883;
 bh=jYxpl8Kcv9++o2kq+/bu6LS4POndnGvXhqghNsoU6qY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qAA0N6FlEp7XO2/MqFDX8zsCAbRS7L8L4OyNy3yMlnFpWx8DQgO9PCThEZYFAISJs
 Luu/1NVf15BT2gDvbXcAAEkFxdmGddXNHLk2/nKWOYZv+dNzo9X/uy3D6MZo+W4QY2
 pxtR05N5M9b+hXvhqkwZ3QDuU9K4n6oZ+AA8y1aFQWHKbDNPFrML3AGKOGF9WhAoWL
 HpDLTpi1t+JEk3epBcpyZVtmpqox1ND1PQ/u9QK3XBGVh+xfkdEpq5KTAJdERw4R+M
 ht3q/I/xyG+wwx7c04Q0HWodGJnbHnwwLZpLmhu9WymIYAh82PMJiJPRYfeUYLNoMX
 LKvc3qtrA7B8A==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id A07AA17F0D2;
 Tue, 24 Nov 2026 15:34:43 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4FE3FDSOFVM; Tue, 24 Nov 2026 15:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530883;
 bh=jYxpl8Kcv9++o2kq+/bu6LS4POndnGvXhqghNsoU6qY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qAA0N6FlEp7XO2/MqFDX8zsCAbRS7L8L4OyNy3yMlnFpWx8DQgO9PCThEZYFAISJs
 Luu/1NVf15BT2gDvbXcAAEkFxdmGddXNHLk2/nKWOYZv+dNzo9X/uy3D6MZo+W4QY2
 pxtR05N5M9b+hXvhqkwZ3QDuU9K4n6oZ+AA8y1aFQWHKbDNPFrML3AGKOGF9WhAoWL
 HpDLTpi1t+JEk3epBcpyZVtmpqox1ND1PQ/u9QK3XBGVh+xfkdEpq5KTAJdERw4R+M
 ht3q/I/xyG+wwx7c04Q0HWodGJnbHnwwLZpLmhu9WymIYAh82PMJiJPRYfeUYLNoMX
 LKvc3qtrA7B8A==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id D92C417F06B;
 Tue, 24 Nov 2026 15:34:42 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>,
 "Claude Fable 5.2" <noreply@anthropic.com>
Subject: [PATCH v1 6/9] drm/amdkfd: keep eviction and restore consistent when
 MES fails
Date: Tue, 24 Nov 2026 15:34:29 +0100
Message-ID: <20261124143433.49736-7-zappel@simple-co.de>
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

evict_process_queues_cpsch() returns at the first REMOVE_QUEUE that
fails. The remaining queues are neither removed nor marked inactive and
the TLB flush is skipped, while qpd->evicted is already raised. During a
GPU reset every REMOVE_QUEUE fails with -EIO, so all queues but the
first stay marked active across the reset.

restore_process_queues_cpsch() marks a queue active and counts it before
ADD_QUEUE is sent. When a later queue fails, qpd->evicted stays set, and
the retry counts the queues that were restored already and adds them
again.

Evict every queue and report MES failures as -EIO, which
kfd_process_evict_queues() already takes to mean "evicted, do not add
back". Mark a queue active only after MES accepted it, and skip the ones
an earlier attempt restored.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e85bead1b..feb3062e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1900,11 +1900,24 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		decrement_queue_count(dqm, qpd, q);
 
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
-			retval = remove_queue_mes(dqm, q, qpd);
-			if (retval) {
-				dev_err(dev, "Failed to evict queue %d\n",
-					q->properties.queue_id);
-				goto out;
+			int r = remove_queue_mes(dqm, q, qpd);
+
+			if (r) {
+				/*
+				 * -EIO means a GPU reset is under way or MES
+				 * is fenced off, both reported already.
+				 */
+				if (r != -EIO)
+					dev_err(dev, "Failed to evict queue %d\n",
+						q->properties.queue_id);
+				/*
+				 * Keep going so that every queue ends up in
+				 * the evicted state. The caller treats -EIO
+				 * as evicted, not to be added back. MES may
+				 * still use this MQD, so it stays pinned.
+				 */
+				retval = -EIO;
+				continue;
 			}
 		}
 
@@ -2117,13 +2130,15 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		if (!QUEUE_IS_ACTIVE(q->properties))
 			continue;
 
-		q->properties.is_active = true;
-		increment_queue_count(dqm, &pdd->qpd, q);
+		/* Restored by an earlier attempt that failed further down */
+		if (q->properties.is_active)
+			continue;
 
 		retval = dqm_repin_mqd_bo(dqm, q);
 		if (retval) {
 			dev_err(dev, "Failed to repin MQD for queue %d\n",
 				q->properties.queue_id);
+			q->properties.is_evicted = true;
 			goto out;
 		}
 
@@ -2132,9 +2147,14 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			if (retval) {
 				dev_err(dev, "Failed to restore queue %d\n",
 					q->properties.queue_id);
+				q->properties.is_evicted = true;
 				goto out;
 			}
 		}
+
+		/* Count the queue as active only once MES has taken it */
+		q->properties.is_active = true;
+		increment_queue_count(dqm, &pdd->qpd, q);
 	}
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		retval = execute_queues_cpsch(dqm,
-- 
2.56.1

