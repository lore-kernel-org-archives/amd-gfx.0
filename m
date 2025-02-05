Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDEBC0219B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 22:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722CE10E215;
	Wed,  5 Feb 2025 22:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a70HHEFH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8408210E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7MPcjvqofLx3Mi1KP08MPZFc/WeX+5GFgWowggie5lw=; b=a70HHEFHJUlUxLMxmyAaU50O+F
 Q9ny/YxhCXRjyQHSRrhezZkeIeyy/37GAxc2+GL/77400TZBtWLGbuJKvySM7bXHp2rT9z9S8lyS8
 g/s9AeEDic4gvF23q2c0NgiPDaIO078IsU6WPtuaSwdzk9h/kTWj5YZFoGCFGKjKsDYG+tVpaqy8s
 kjoxyHO1hMoDwGYmKlEfzlpuDJLRjGPjSRN0iuUUqcCszToVB5F4ZwRqJ3MFUAd8dBLR6ufUoCKdv
 bjpga1ngxUQl8L2k/AGvZLc2UEdkNQ0dacw/RJYbsj511ZOj2H4OZU6ZlDn+9bJf6QL+FU/ilp0kZ
 Dg6KUEGQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tfhP9-0041Oj-S1; Wed, 05 Feb 2025 16:33:37 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 4/4] drm/sched: Make the type of
 drm_sched_job->last_dependency consistent
Date: Wed,  5 Feb 2025 15:33:32 +0000
Message-ID: <20250205153332.14852-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:38:15 +0000
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

Dependency tracking via xarray uses xa_limit_32b so there is not need for
the struct member to be unsigned long.

At the same time re-order some struct members and take u32 credits outside
of the pointer sandwich and avoid a hole.

Pahole report before:
        /* size: 160, cachelines: 3, members: 14 */
        /* sum members: 156, holes: 1, sum holes: 4 */
        /* last cacheline: 32 bytes */

And after:
        /* size: 152, cachelines: 3, members: 14 */
        /* last cacheline: 24 bytes */

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 38 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 298513f8c327..20a6c1b3bab1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -338,8 +338,14 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
  * to schedule the job.
  */
 struct drm_sched_job {
-	struct spsc_node		queue_node;
-	struct list_head		list;
+	u64				id;
+
+	/**
+	 * @submit_ts:
+	 *
+	 * When the job was pushed into the entity queue.
+	 */
+	ktime_t                         submit_ts;
 
 	/**
 	 * @sched:
@@ -349,24 +355,30 @@ struct drm_sched_job {
 	 * has finished.
 	 */
 	struct drm_gpu_scheduler	*sched;
+
 	struct drm_sched_fence		*s_fence;
+	struct drm_sched_entity         *entity;
 
+	enum drm_sched_priority		s_priority;
 	u32				credits;
+	/** @last_dependency: tracks @dependencies as they signal */
+	unsigned int			last_dependency;
+	atomic_t			karma;
+
+	struct spsc_node		queue_node;
+	struct list_head		list;
 
 	/*
 	 * work is used only after finish_cb has been used and will not be
 	 * accessed anymore.
 	 */
 	union {
-		struct dma_fence_cb		finish_cb;
-		struct work_struct		work;
+		struct dma_fence_cb	finish_cb;
+		struct work_struct	work;
 	};
 
-	uint64_t			id;
-	atomic_t			karma;
-	enum drm_sched_priority		s_priority;
-	struct drm_sched_entity         *entity;
 	struct dma_fence_cb		cb;
+
 	/**
 	 * @dependencies:
 	 *
@@ -375,16 +387,6 @@ struct drm_sched_job {
 	 * drm_sched_job_add_implicit_dependencies().
 	 */
 	struct xarray			dependencies;
-
-	/** @last_dependency: tracks @dependencies as they signal */
-	unsigned long			last_dependency;
-
-	/**
-	 * @submit_ts:
-	 *
-	 * When the job was pushed into the entity queue.
-	 */
-	ktime_t                         submit_ts;
 };
 
 static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
-- 
2.48.0

