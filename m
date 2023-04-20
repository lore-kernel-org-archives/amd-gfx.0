Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4693C77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAED10E27C;
	Thu, 20 Apr 2023 11:57:59 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8567610E253
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:57:58 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id dm2so5730847ejc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991876; x=1684583876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6GCi1A7TjKrLwQuz1ZXDIR4idqtCYtlZDH/jTLuAfw=;
 b=PeVLrSPFOy1eyghrsVudAlplST3XcyXRJk2BYWRrva2oSjGRlqAY6CIE5Nq0UgztP1
 lpXIGJ6Ay8ii+qSH+cqlmuFizforkDWZZizzF0LKSQUOuvOwSf97GKPBqi08TLV/n+dU
 mRs51ahm6dUDmIzVzuKqOdbTegpMmUIONAyzn1/Bb44nULpVy+DMR+SYubK61wUjyLEN
 BvfeTudZi7CjvO6ZO8MveIMl6kR2zRIKt+vx9DSzfMppcOKPVmgstHbzrMQnGo0zCTmi
 xuHhfB4DZy+nSbhM+0mBGYd4cmbEFlUuMTOPRagr6ovUpSdROun1HOHPTehpMdqY6hen
 nN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991876; x=1684583876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6GCi1A7TjKrLwQuz1ZXDIR4idqtCYtlZDH/jTLuAfw=;
 b=hMFfAxUvWU0/uyeZaW4CAwpq92R0fE/aj2EZ3mIoCh6VwJOxBA7srup6hlBf6jrr/H
 iTb4PXPkU9nbCNzjyDRirtoVdMW7XjgCtf8Vi2wuJdw+pYm4H6tcWEioBuMAvStf89n8
 gfSWOPvqHYmCPhM82f+GG1W67y2dJU7fVT2rodMTRLdd3pC4hDwlwqamGQ86Bw/ckoQ9
 ljVp8xKuN5WikRSfTKDSOr2sgt2jYcLUHSqdOvewUg6jlw3RPeSUBFftVN+fdODEwpY0
 zOh47oAykjW7mveQKylRmQ/PQjPXE+vb1g5t2ZiATFjuV4zhnPAptBrKpA+jRm+s5bfs
 ItbA==
X-Gm-Message-State: AAQBX9c0opPIxXKqHVIxYoUT0ovrdr9Qa3tQoWO1oWyMfuzJz6+seIrg
 6LOj0ggFRnd7OdPNA7eHsk84EDA70hx2iQ==
X-Google-Smtp-Source: AKy350YGZCAMi+nFTEFN/eOHpOkX0GMotq52KH2m4BWc4wENztOAEucIoMesBoRrtQ1IEngr5cQBTA==
X-Received: by 2002:a17:906:1dd6:b0:94f:928a:af0f with SMTP id
 v22-20020a1709061dd600b0094f928aaf0fmr1194252ejh.47.1681991875719; 
 Thu, 20 Apr 2023 04:57:55 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:57:55 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/scheduler: add drm_sched_entity_error and use rcu for
 last_scheduled
Date: Thu, 20 Apr 2023 13:57:46 +0200
Message-Id: <20230420115752.31470-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420115752.31470-1-christian.koenig@amd.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to using RCU handling for the last scheduled job and add a
function to return the error code of it.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 39 +++++++++++++++++++-----
 include/drm/gpu_scheduler.h              |  3 +-
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index eaf71fe15ed3..d3f4ada6a68e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -72,7 +72,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->num_sched_list = num_sched_list;
 	entity->priority = priority;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
-	entity->last_scheduled = NULL;
+	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
 	if(num_sched_list)
@@ -140,6 +140,27 @@ bool drm_sched_entity_is_ready(struct drm_sched_entity *entity)
 	return true;
 }
 
+/**
+ * drm_sched_entity_error - return error of last scheduled job
+ * @entity: scheduler entity to check
+ *
+ * Opportunistically return the error of the last scheduled job. Result can
+ * change any time when new jobs are pushed to the hw.
+ */
+int drm_sched_entity_error(struct drm_sched_entity *entity)
+{
+	struct dma_fence *fence;
+	int r;
+
+	rcu_read_lock();
+	fence = rcu_dereference(entity->last_scheduled);
+	r = fence ? fence->error : 0;
+	rcu_read_unlock();
+
+	return r;
+}
+EXPORT_SYMBOL(drm_sched_entity_error);
+
 static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
 {
 	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
@@ -191,7 +212,9 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	/* Make sure this entity is not used by the scheduler at the moment */
 	wait_for_completion(&entity->entity_idle);
 
-	prev = dma_fence_get(entity->last_scheduled);
+	/* The entity is guaranteed to not be used by the scheduler */
+	prev = rcu_dereference_check(entity->last_scheduled, true);
+	dma_fence_get(prev);
 	while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
 		struct drm_sched_fence *s_fence = job->s_fence;
 
@@ -278,8 +301,8 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
 		entity->dependency = NULL;
 	}
 
-	dma_fence_put(entity->last_scheduled);
-	entity->last_scheduled = NULL;
+	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
+	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 }
 EXPORT_SYMBOL(drm_sched_entity_fini);
 
@@ -421,9 +444,9 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	if (entity->guilty && atomic_read(entity->guilty))
 		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
 
-	dma_fence_put(entity->last_scheduled);
-
-	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
+	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
+	rcu_assign_pointer(entity->last_scheduled,
+			   dma_fence_get(&sched_job->s_fence->finished));
 
 	/*
 	 * If the queue is empty we allow drm_sched_entity_select_rq() to
@@ -471,7 +494,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	 */
 	smp_rmb();
 
-	fence = entity->last_scheduled;
+	fence = rcu_dereference_check(entity->last_scheduled, true);
 
 	/* stay on the same engine if the previous job hasn't finished */
 	if (fence && !dma_fence_is_signaled(fence))
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 5c1df6b12ced..6084459b2def 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -190,7 +190,7 @@ struct drm_sched_entity {
 	 * by the scheduler thread, can be accessed locklessly from
 	 * drm_sched_job_arm() iff the queue is empty.
 	 */
-	struct dma_fence                *last_scheduled;
+	struct dma_fence __rcu		*last_scheduled;
 
 	/**
 	 * @last_user: last group leader pushing a job into the entity.
@@ -561,6 +561,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job);
 void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 				   enum drm_sched_priority priority);
 bool drm_sched_entity_is_ready(struct drm_sched_entity *entity);
+int drm_sched_entity_error(struct drm_sched_entity *entity);
 
 struct drm_sched_fence *drm_sched_fence_alloc(
 	struct drm_sched_entity *s_entity, void *owner);
-- 
2.34.1

