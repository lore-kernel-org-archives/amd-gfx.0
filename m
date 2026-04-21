Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C70AF8FA72
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FEC10EC68;
	Tue, 21 Apr 2026 12:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ITduVWz+";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7407810EC0B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:25 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so54141225e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776124; x=1777380924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odaBPftj63hd/LndgD6DCJd2fuIj+Mqd7vCkCYo24wQ=;
 b=ITduVWz+4hNv7xXCckY3a8FUJ9bQTPaiUGnbR8MHpPlXNPgqOycbmbS9uCMp8hOWcA
 BQMhBzIWkKRvcqXYktty6HjYjPLftm5Kxt0gv2VaYrkJRPflqZXGuXniMeJ4OD1Nd0Wp
 uBnDTmMxClwe2f3QbeaW+mr3ZOgoNxok+/6iTCJKUC4aZav2MPOvBK4qqq7jQTC6n/cf
 v1bjdqAmw7Rw9x6BUgVwmDxwwWhYVGyWaZUTtmHWuhelB66/hi6WQ+rZ93U1bzqlXgxf
 Mr6moZdQXswlOnpuupqbLcMDbKb8JCCz/Fccusd7V/vEBhJsqmapTXr/7LZm+LwDx4Ql
 fvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776124; x=1777380924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=odaBPftj63hd/LndgD6DCJd2fuIj+Mqd7vCkCYo24wQ=;
 b=VyUdoxcOHBXM/AJ6c/y5WOR6mTKn2efg0dN8tn7Q52KG2WZwcmf9qE+5MD9q/fuBui
 YDX+L6pwPvmppCdW4JSZGN4Pu2XOKhGvYZiPK+w5uF5wWEOWT/WoPttPzRIx/aJuEBB9
 EWYwAMdDZ8+1tC/B+HELxvj/UFgN118BFv7p73s3jX+DJ3IMvwBz3DQlNp7W/ZL00LeW
 J21Ot5zWB6Kzi7V43n+OvsjmVgzBrRbu6ohIAvTRNyzVUmas9wIIb3b5mZrxSjdp/oUS
 NQeIKyjCpSdSjbrZijEbZzahlS8/4dvWEJBoBmKHE3oQllc9aOtRaU3fSAbasvlWOl60
 1Jcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9533d2kw8s42Tn29RcLW6N+Mb3eOgsBzQAhOQa1I2wqVnFltfR+cAtiykmDhn0xo5h4RIJ+Inx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8XfbnUWNjL4icTyCo4lloCPMK1wqbSTbwmuDLfDPJ6iDEgxc9
 EHpO7bBObXjRnym5+JJMlztubY2WbUUFN2edh93VUsDYcFVAhJ+NqoTX
X-Gm-Gg: AeBDiesYjBJQJ2wtfSVovV7ydyl547Ub1oaPavRB9xRxYn2ZTfkxT2uzqrZ6yAgD6Ek
 jYGBfQajre9BrBTQz2E9k5ca7DT0PTTgiWQJwA2jhZO5VKa5/nMijFFx/MS5yxvabkcqH0fsUG5
 GWBv2w0ZVOass6C8rjbEaBkv4Bn25ogIH6PO/aFUMnVEuaGZ8Gpw6s1LMgWAiVqkrorq0IOzWS2
 ZiX9UQvNm0Lt+qsizoAgv+xZTHgoVrgJgcK+CrwUvF3kDrmWLTRUfoKuXG786MlSCVot10bG606
 Mv+gd1qNuckImSea/FioxTFug3Rvwi6yNEeUWTEHlAW68lc4gnWjbvz89WF6MbYasGLt/Q56c80
 sA/Rq7Ah6WYGR3UN456nmVijpCmmoO3nDrVJPQ4DbLCT6waOL8T5nQPW4R3GwPyjw3VFGWk6Ca8
 H2w+m/bxK1MGVG/kHOE2qJJFIofJ2BsO5mbYeJIZxuZSshQAQ=
X-Received: by 2002:a05:600c:1549:b0:48a:761:5808 with SMTP id
 5b1f17b1804b1-48a07615c09mr86953655e9.0.1776776123647; 
 Tue, 21 Apr 2026 05:55:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 06/11] drm/amdgpu: remove almost all calls to
 amdgpu_userq_detect_and_reset_queues
Date: Tue, 21 Apr 2026 14:55:08 +0200
Message-ID: <20260421125513.4545-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421125513.4545-1-christian.koenig@amd.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
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

Well the reset handling seems broken on multiple levels.

As first step of fixing this remove most calls to the hang detection.
That function should only be called after we run into a timeout! And *NOT*
as random check spread over the code in multiple places.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 38 +++++++++--------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8ce001481d42..5ccd53ad8efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -345,23 +345,18 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
-	bool found_hung_queue = false;
-	int r = 0;
+	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		r = userq_funcs->preempt(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			found_hung_queue = true;
+			return r;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
 		}
 	}
-
-	if (found_hung_queue)
-		amdgpu_userq_detect_and_reset_queues(uq_mgr);
-
-	return r;
+	return 0;
 }
 
 static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
@@ -390,24 +385,21 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
-	bool found_hung_queue = false;
-	int r = 0;
+	int r;
 
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
-		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
+	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
+
 		r = userq_funcs->unmap(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			found_hung_queue = true;
+			return r;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
 		}
 	}
 
-	if (found_hung_queue)
-		amdgpu_userq_detect_and_reset_queues(uq_mgr);
-
-	return r;
+	return 0;
 }
 
 static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
@@ -416,19 +408,19 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
-	int r = 0;
+	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			amdgpu_userq_detect_and_reset_queues(uq_mgr);
+			return r;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
 
-	return r;
+	return 0;
 }
 
 static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
@@ -654,7 +646,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
-	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	r = amdgpu_userq_unmap_helper(queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (r) {
@@ -1268,7 +1259,6 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(queue);
@@ -1276,9 +1266,11 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 			ret = r;
 	}
 
-	if (ret)
+	if (ret) {
 		drm_file_err(uq_mgr->file,
 			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
+		amdgpu_userq_detect_and_reset_queues(uq_mgr);
+	}
 	return ret;
 }
 
@@ -1378,7 +1370,6 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		guard(mutex)(&uqm->userq_mutex);
-		amdgpu_userq_detect_and_reset_queues(uqm);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_preempt_helper(queue);
 		else
@@ -1437,7 +1428,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 		    (queue->xcp_id == idx)) {
-			amdgpu_userq_detect_and_reset_queues(uqm);
 			r = amdgpu_userq_preempt_helper(queue);
 			if (r)
 				ret = r;
-- 
2.43.0

