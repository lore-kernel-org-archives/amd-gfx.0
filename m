Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32224FCB61F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 16:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6513A10ED8F;
	Fri,  6 Mar 2026 16:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S4yIUiZJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7283910E300;
 Fri,  6 Mar 2026 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QhyfM3MnCNNbxIL+ugXR9IrHIA0+N+F88/ZuvKu4lcA=; b=S4yIUiZJ2chdgg6UGdm7UxJFS9
 ecjQSSTSh3XEMbN7Oi8KP+exSRwjg3jXUZEBGB6uMEsD7UWltyiNj4bWWXh7nXYqklPdYBdOIrpA6
 hVSaIy8zGopjlICQcO676+fEvpQoYweTQYckVgvuXiaj2an425w8iktGbsi590XCNgCFgs31NVCI8
 vgiZn+0UhjT2t55ZB4UiM1fH4JFDLd6MfWJVcJUHQRR2zxqR40NE5R6IPOlLqHZEv3VmNkvnRlnVF
 l4uz907dia4gaQUihvvVFqwEK5IdvdqKo7Gd8anxr+rHcEWfvFaEcxwzdWMroFVIEG35oU4VIq9JQ
 FDnEtS1w==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vyY8Y-00APRQ-Ov; Fri, 06 Mar 2026 17:34:50 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v7 01/29] drm/sched: Disallow initializing entities with no
 schedulers
Date: Fri,  6 Mar 2026 16:34:17 +0000
Message-ID: <20260306163445.97243-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
References: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
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

Since we have removed the case where amdgpu was initializing entitites
with either no schedulers on the list, or with a single NULL scheduler,
and there appears no other drivers which rely on this, we can simplify the
scheduler by explictly rejecting that early.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe174a4857be..bb7e5fc47f99 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -61,32 +61,27 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 			  unsigned int num_sched_list,
 			  atomic_t *guilty)
 {
-	if (!(entity && sched_list && (num_sched_list == 0 || sched_list[0])))
+	if (!entity || !sched_list || !num_sched_list || !sched_list[0])
 		return -EINVAL;
 
 	memset(entity, 0, sizeof(struct drm_sched_entity));
 	INIT_LIST_HEAD(&entity->list);
 	entity->rq = NULL;
 	entity->guilty = guilty;
-	entity->num_sched_list = num_sched_list;
 	entity->priority = priority;
 	entity->last_user = current->group_leader;
-	/*
-	 * It's perfectly valid to initialize an entity without having a valid
-	 * scheduler attached. It's just not valid to use the scheduler before it
-	 * is initialized itself.
-	 */
+	entity->num_sched_list = num_sched_list;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
-	if (num_sched_list && !sched_list[0]->sched_rq) {
+	if (!sched_list[0]->sched_rq) {
 		/* Since every entry covered by num_sched_list
 		 * should be non-NULL and therefore we warn drivers
 		 * not to do this and to fix their DRM calling order.
 		 */
 		pr_warn("%s: called with uninitialized scheduler\n", __func__);
-	} else if (num_sched_list) {
+	} else {
 		/* The "priority" of an entity cannot exceed the number of run-queues of a
 		 * scheduler. Protect against num_rqs being 0, by converting to signed. Choose
 		 * the lowest priority available.
-- 
2.52.0

