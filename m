Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEC6C3601E
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 20:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFAF10E486;
	Mon, 31 Mar 2025 20:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="m2PR0MJE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA8810E481;
 Mon, 31 Mar 2025 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/NMBC9IFn5tcRJoB+UhKNHMuDWkd6EHsyJqiwFGPQe8=; b=m2PR0MJE16kIQDNf+PZgD9BJ0E
 +1/bwL4O3jv/6Jf0tPYaCrGYSjXCDlaiOkngdRuY5HYpBNmMkTEsGV98fBVb5l4Gxpip8BNz+4+9B
 fiFi/y/gd2FDHw5s3detvHBuNy3LvR4hVaTe0MVALrY4y9aoznwKRwUvJ+0g4V84N3pdVv1D0r4YI
 oMJEaAjvHU0/vfmb4dmhPa0XH9zDG/vceao0A3OQIVugSZqz0dm3MEJnI4yLUBTqGrmWZHlZNEmS0
 FabA5IFbqoJ2WGdF3G2rm0GyQhzv+HIrp8zqsj88tyIvswzTntGed/l/cPmF29K9GR2Rxa4wMX8cY
 blGPUB1Q==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tzLZZ-009M34-Lg; Mon, 31 Mar 2025 22:17:29 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [RFC v3 05/14] drm/sched: Consolidate drm_sched_rq_select_entity_rr
Date: Mon, 31 Mar 2025 21:16:56 +0100
Message-ID: <20250331201705.60663-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250331201705.60663-1-tvrtko.ursulin@igalia.com>
References: <20250331201705.60663-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extract out two copies of the identical code to function epilogue to make
it smaller and more readable.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 48 +++++++++++---------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 357133e6d4d0..600904271b01 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -268,38 +268,14 @@ drm_sched_rq_select_entity_rr(struct drm_gpu_scheduler *sched,
 	entity = rq->current_entity;
 	if (entity) {
 		list_for_each_entry_continue(entity, &rq->entities, list) {
-			if (drm_sched_entity_is_ready(entity)) {
-				/* If we can't queue yet, preserve the current
-				 * entity in terms of fairness.
-				 */
-				if (!drm_sched_can_queue(sched, entity)) {
-					spin_unlock(&rq->lock);
-					return ERR_PTR(-ENOSPC);
-				}
-
-				rq->current_entity = entity;
-				reinit_completion(&entity->entity_idle);
-				spin_unlock(&rq->lock);
-				return entity;
-			}
+			if (drm_sched_entity_is_ready(entity))
+				goto found;
 		}
 	}
 
 	list_for_each_entry(entity, &rq->entities, list) {
-		if (drm_sched_entity_is_ready(entity)) {
-			/* If we can't queue yet, preserve the current entity in
-			 * terms of fairness.
-			 */
-			if (!drm_sched_can_queue(sched, entity)) {
-				spin_unlock(&rq->lock);
-				return ERR_PTR(-ENOSPC);
-			}
-
-			rq->current_entity = entity;
-			reinit_completion(&entity->entity_idle);
-			spin_unlock(&rq->lock);
-			return entity;
-		}
+		if (drm_sched_entity_is_ready(entity))
+			goto found;
 
 		if (entity == rq->current_entity)
 			break;
@@ -308,6 +284,22 @@ drm_sched_rq_select_entity_rr(struct drm_gpu_scheduler *sched,
 	spin_unlock(&rq->lock);
 
 	return NULL;
+
+found:
+	if (!drm_sched_can_queue(sched, entity)) {
+		/*
+		 * If scheduler cannot take more jobs signal the caller to not
+		 * consider lower priority queues.
+		 */
+		entity = ERR_PTR(-ENOSPC);
+	} else {
+		rq->current_entity = entity;
+		reinit_completion(&entity->entity_idle);
+	}
+
+	spin_unlock(&rq->lock);
+
+	return entity;
 }
 
 /**
-- 
2.48.0

