Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4138606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=NaeV0Q5u;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=NaeV0Q5u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B4A112104;
	Thu, 26 Nov 2026 08:09:34 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B27B10FCA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=DPpdPkMyiIFrOvPz357C4R/aMWz5E2GeGz7zbY3a37A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NaeV0Q5uevARqsNsFIdaWzyH2PNS6XsgjnJywap/MjeCcENvFMrNxjtlUlENROrTY
 t1fzQltCneVNxr5vL6yKl2dh+AZJeh/gVjbohvAbmi+SHemPZZ32HUWpfsN18cGuGo
 yGlNsO7PPc2QvCBE/BGl6/M33/hBIqWxx5rrAoWI53EpkIrelvzhaakDkiXv23ShIH
 i3yfNWP1X1kqAF0vA4eCv5psUpWjv6Irdu62ZBmN+T6fr5658mqQi/UsVIj7KL80Jy
 PRVEotqFv7GN3EUieW/RGrjMSmcCJ0rpBVDHPRdp6ZlQtlx43IBj/qHHMO6bWZ4d0C
 7Tg5VXG4oKx+w==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id AFA0617F36E;
 Wed, 25 Nov 2026 15:19:38 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w2ZVQXIQTi0a; Wed, 25 Nov 2026 15:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=DPpdPkMyiIFrOvPz357C4R/aMWz5E2GeGz7zbY3a37A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NaeV0Q5uevARqsNsFIdaWzyH2PNS6XsgjnJywap/MjeCcENvFMrNxjtlUlENROrTY
 t1fzQltCneVNxr5vL6yKl2dh+AZJeh/gVjbohvAbmi+SHemPZZ32HUWpfsN18cGuGo
 yGlNsO7PPc2QvCBE/BGl6/M33/hBIqWxx5rrAoWI53EpkIrelvzhaakDkiXv23ShIH
 i3yfNWP1X1kqAF0vA4eCv5psUpWjv6Irdu62ZBmN+T6fr5658mqQi/UsVIj7KL80Jy
 PRVEotqFv7GN3EUieW/RGrjMSmcCJ0rpBVDHPRdp6ZlQtlx43IBj/qHHMO6bWZ4d0C
 7Tg5VXG4oKx+w==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 206FB17F368;
 Wed, 25 Nov 2026 15:19:38 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 6/9] drm/amdkfd: keep eviction and restore consistent when
 MES fails
Date: Wed, 25 Nov 2026 15:19:29 +0100
Message-ID: <20261125141933.154222-7-zappel@simple-co.de>
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

evict_process_queues_cpsch() returns at the first REMOVE_QUEUE that
fails. The remaining queues are neither removed nor marked inactive and
the TLB flush is skipped, while qpd->evicted is already raised. During a
GPU reset every REMOVE_QUEUE fails with -EIO, so all queues but the
first stay marked active across the reset.

kfd_process_evict_queues() returns the result of the last device. When
an earlier device reported -EIO, the caller is told that everything was
saved, signals the eviction fence and schedules a restore for a process
that still has a queue on the hardware of that device.

restore_process_queues_cpsch() marks a queue active and counts it before
ADD_QUEUE is sent. When a later queue fails, qpd->evicted stays set, and
the retry counts the queues that were restored already and adds them
again. Until the retry, the process is half restored: an eviction that
comes first finds qpd->evicted set and leaves the restored queues
running while their buffers are moved.

Evict every queue and report MES failures as -EIO, which
kfd_process_evict_queues() already takes to mean "evicted, do not add
back", and let it keep that answer when any device gave it. On a failed
restore, take the queues restored in this attempt off the hardware
again, so that the process is fully evicted and the retry starts from a
known state. A queue is counted before ADD_QUEUE is sent, because the
oversubscription check in add_queue_mes() wants to see it, and taken
out of the count again when the command fails.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 57 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 ++-
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c691df753..eb75858bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1984,11 +1984,24 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
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
 
@@ -2201,22 +2214,25 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		if (!QUEUE_IS_ACTIVE(q->properties))
 			continue;
 
-		q->properties.is_active = true;
-		increment_queue_count(dqm, &pdd->qpd, q);
-
 		retval = dqm_repin_mqd_bo(dqm, q);
 		if (retval) {
 			dev_err(dev, "Failed to repin MQD for queue %d\n",
 				q->properties.queue_id);
-			goto out;
+			goto rollback;
 		}
 
+		/* Counted first: add_queue_mes() looks at the active count */
+		q->properties.is_active = true;
+		increment_queue_count(dqm, &pdd->qpd, q);
+
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
 			retval = add_queue_mes(dqm, q, qpd);
 			if (retval) {
 				dev_err(dev, "Failed to restore queue %d\n",
 					q->properties.queue_id);
-				goto out;
+				q->properties.is_active = false;
+				decrement_queue_count(dqm, &pdd->qpd, q);
+				goto rollback;
 			}
 		}
 	}
@@ -2230,6 +2246,27 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 out:
 	dqm_unlock(dqm);
 	return retval;
+
+rollback:
+	/*
+	 * A half restored process is a problem for the next eviction: it
+	 * finds qpd->evicted set and leaves the queues restored so far
+	 * running. Take those off the hardware again, so that the process
+	 * is fully evicted and the retry starts from a known state. A
+	 * removal that cannot be sent (-EIO) leaves the queue mapped and
+	 * marked evicted, as evict_process_queues_cpsch() does.
+	 */
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		q->properties.is_evicted = true;
+		if (!q->properties.is_active)
+			continue;
+
+		q->properties.is_active = false;
+		decrement_queue_count(dqm, qpd, q);
+		if (dqm->dev->kfd->shared_resources.enable_mes)
+			remove_queue_mes(dqm, q, qpd);
+	}
+	goto out;
 }
 
 static int register_process(struct device_queue_manager *dqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 51c3fa39f..546aeef04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2134,7 +2134,7 @@ struct kfd_process *kfd_lookup_process_by_id(const struct mm_struct *mm, u16 id)
  */
 int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 {
-	int r = 0;
+	int r = 0, ret = 0;
 	int i;
 	unsigned int n_evicted = 0;
 
@@ -2155,12 +2155,15 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 			dev_err(dev, "Failed to evict process queues\n");
 			goto fail;
 		}
+		/* One device that could not save its queues is enough */
+		if (r)
+			ret = r;
 		n_evicted++;
 
 		pdd->dev->dqm->is_hws_hang = false;
 	}
 
-	return r;
+	return ret;
 
 fail:
 	/* To keep state consistent, roll back partial eviction by
-- 
2.47.3

