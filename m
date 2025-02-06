Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74399C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F23810EB4F;
	Fri,  7 Feb 2025 15:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EmFqLgSa";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004FA10E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l1TnGilL/LuZh5vSOutYwyAWyL/ix8b8Dh8AFc/Vs2c=; b=EmFqLgSay4wG3ukI92lx9Huiji
 E1KY977mwXe5h/Y6Fo8Gir/Rd48keBGikT6CKSAjWFUQ97kM8bBcdD72i4G/TJ5ZevKFZUYZLTmiw
 8eBasxQtVc5xhSiOdYbSC9aBETgbeBK6zmRgSO1SDPue6dvAQRfuRKzU6QznRzSZfK9yZiBB9c5dd
 yvQD51vKgF8wXjcxISOtMbJAcbneDp+Yt/ooH4G5TnIXxrHNOy2WUMuCWRHukHmgsHBsUGcuWIGxE
 DiyA3Ch7zvWKikLFgap50S9clAsaoZk0nlOvBhcDLwZW4jIKV5ecq1Cn9TMewkapwf2TKwBYEIcdc
 4Bs+pi4A==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tg4vW-0055Zw-BU; Thu, 06 Feb 2025 17:40:36 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Pop jobs from the queue more robustly
Date: Thu,  6 Feb 2025 16:40:30 +0000
Message-ID: <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:29:43 +0000
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

Replace a copy of DRM scheduler's to_drm_sched_job with a copy of a newly
added __drm_sched_entity_queue_pop.

This allows breaking the hidden dependency that queue_node has to be the
first element in struct drm_sched_job.

A comment is also added with a reference to the mailing list discussion
explaining the copied helper will be removed when the whole broken
amdgpu_job_stop_all_jobs_on_sched is removed.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..22cb48bab24d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -411,8 +411,24 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
-#define to_drm_sched_job(sched_job)		\
-		container_of((sched_job), struct drm_sched_job, queue_node)
+/*
+ * This is a duplicate function from DRM scheduler sched_internal.h.
+ * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is removed, due
+ * latter being incorrect and racy.
+ *
+ * See https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
+ */
+static struct drm_sched_job *
+__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
+{
+	struct spsc_node *node;
+
+	node = spsc_queue_pop(&entity->job_queue);
+	if (!node)
+		return NULL;
+
+	return container_of(node, struct drm_sched_job, queue_node);
+}
 
 void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 {
@@ -425,7 +441,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 		struct drm_sched_rq *rq = sched->sched_rq[i];
 		spin_lock(&rq->lock);
 		list_for_each_entry(s_entity, &rq->entities, list) {
-			while ((s_job = to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
+			while ((s_job = __drm_sched_entity_queue_pop(s_entity))) {
 				struct drm_sched_fence *s_fence = s_job->s_fence;
 
 				dma_fence_signal(&s_fence->scheduled);
-- 
2.48.0

