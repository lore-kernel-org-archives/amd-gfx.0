Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E869FC54755
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 09:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4588910E815;
	Thu, 15 May 2025 09:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CzVQTOY9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75EF310E1AF;
 Thu, 15 May 2025 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WxXAf4KUqwU8dybGJiNaAxYGwYm+8UhaEKMKuKOvWBw=; b=CzVQTOY9SqjNdGEZVWidswA5FD
 9DFQ8k1BPRin0LTHNopSFwKQVQrxK92PC28CLnCtruQ+ZGJV4l82or6mzO6t/5ect/ouVMFvu4hKs
 KmVJa3bZdc324tvnwaciddLiZFLGO0idPTYCN64HDn8OrfuBTWz/lycugOg1gZA9kmGRsiFGGkKO8
 /b9SsZLw6WYoq+XQO0J6NCb/rMV39e0lOGbRHsEaj9zbB3h0+pA18BTyPhxhLsvrZlq6MmpGhTJ08
 Baud1A07a1NhFsXxfuNYHSmTvrNsueCE3/Td2UrswsfZiNgdi77ieGzdu/DOvrr4YvTkq9UNGMB/E
 qtpz4wzA==;
Received: from [81.79.92.254] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uFV8S-008ZR7-0K; Thu, 15 May 2025 11:50:10 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 5/9] drm/i915: Use dma-fence driver and timeline name
 helpers
Date: Thu, 15 May 2025 10:50:00 +0100
Message-ID: <20250515095004.28318-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250515095004.28318-1-tvrtko.ursulin@igalia.com>
References: <20250515095004.28318-1-tvrtko.ursulin@igalia.com>
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

Access the dma-fence internals via the previously added helpers.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/i915/gt/intel_gt_requests.c | 4 ++--
 drivers/gpu/drm/i915/i915_request.c         | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c        | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
index d1a382dfaa1d..ae3557ed6c1e 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
@@ -252,8 +252,8 @@ void intel_gt_watchdog_work(struct work_struct *work)
 			struct dma_fence *f = &rq->fence;
 
 			pr_notice("Fence expiration time out i915-%s:%s:%llx!\n",
-				  f->ops->get_driver_name(f),
-				  f->ops->get_timeline_name(f),
+				  dma_fence_driver_name(f),
+				  dma_fence_timeline_name(f),
 				  f->seqno);
 			i915_request_cancel(rq, -EINTR);
 		}
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index c3d27eadc0a7..4874c4f1e4ab 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -2184,7 +2184,7 @@ void i915_request_show(struct drm_printer *m,
 		       const char *prefix,
 		       int indent)
 {
-	const char *name = rq->fence.ops->get_timeline_name((struct dma_fence *)&rq->fence);
+	const char *name = dma_fence_timeline_name((struct dma_fence *)&rq->fence);
 	char buf[80] = "";
 	int x = 0;
 
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 1d4cc91c0e40..e51ca7e50a4e 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -435,8 +435,8 @@ static void timer_i915_sw_fence_wake(struct timer_list *t)
 		return;
 
 	pr_notice("Asynchronous wait on fence %s:%s:%llx timed out (hint:%ps)\n",
-		  cb->dma->ops->get_driver_name(cb->dma),
-		  cb->dma->ops->get_timeline_name(cb->dma),
+		  dma_fence_driver_name(cb->dma),
+		  dma_fence_timeline_name(cb->dma),
 		  cb->dma->seqno,
 		  i915_sw_fence_debug_hint(fence));
 
-- 
2.48.0

