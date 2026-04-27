Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B0DFF886C
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2586110E8C7;
	Mon, 27 Apr 2026 18:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kSxG0KMN";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC0E10E8BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:27:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso87498515e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777314447; x=1777919247; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uXB3/9FETBlos37eVWtdYdlI4ll1hlwoX7ljbq5btc8=;
 b=kSxG0KMN2wZGVU2sLcTq1bSEejVSdtkhFlXtI2rFvgAFv3mWvgt2c7ONzDfEkPU+GU
 VV7Cyk3f389wuRziUK5oPWo4+m4fJA8NbheR9pV41lEn+ut9NR6pV0oXJuQhWMs2NCCh
 euLnUoVQ8h8eRmXtJvcGbzSaQ9eEb0J0P67mjgOJhKF7cVruBWZ1BQv55UV1R+x3YtQH
 p6TyVZXHX59/0K3lylco4GxJdnmL0GBFMSbcmQ/TuiWF+SBXjHWloxzFq6gkOmffZ1Ux
 koBqy/Cv//8lT6oMjrpJTv5i7b5+ZBfqknnoLlS5/E0oW2tht00aauIB/G9aFU7pzNeR
 Mbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314447; x=1777919247;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXB3/9FETBlos37eVWtdYdlI4ll1hlwoX7ljbq5btc8=;
 b=BofqRV6EkDzLOljDDd24BbtnrecvhE585NzpeescNx7MYWcuGRvOdHbV5ZZ9aI3kF2
 eZizszpia3GKgZjN6pcnbXxkd4QNPBXbSe7PaTphkODPYeHl6a0jRZplUxFu2rVBiDdW
 rTW80XDso0Zgf6e3s/vrn1RR074MEere3FaLItCpMIhbbDQ6FK7h3qG3bTVWd8yB8qyL
 2Ndbwl5UVW3xAClYoF9UKM9KDyGQj8+6haVudd952910CfwnkLRktFM60HwuSIVpQz/c
 9yiAIQ6JaFQ3HiKPiXLkWsZVhGsdjz6tbEnN1miYumuDBkxl9A+4We9TP6yjGZpTBG2O
 jEzA==
X-Gm-Message-State: AOJu0Ywa7AANT7w2iS9tJ/GC8Bw7JJ9hceGu/pCryCxR710NC+yBfKLO
 XcIQM+HEQIzKSuHySFMFVWedDwoJ7evFvq44RAn7dn57o/S6BkbTsyR2
X-Gm-Gg: AeBDieuZ3SdNI1PjmcCbfdOsyrPiV6yvKNr2OK7jdvO5soHJ9S6Q/7WiS0Sz8Tf4k+2
 L6uWjlD6P5LEfmUu9ZV+RaabHVWkAeSpcSSbSshSljpUBJTQ/cjKUTC+QKWYdEOZMdR6bqLpKxH
 VQ+9dzjcbrGg9B8L0QEDfkhZRs/28gDZF6Rrw9J1EpDZ9c4Fsg4ECnp5ophtaCMCN0oecGXANSL
 Mx7JSn3QgrIkV4a9urrnQQYUI+vOPnl9ez0V9PcrmDX3d8R3Z0DIDfwJHWbJmkNI2QZf+M2ENyw
 Z4ZU4Md+/bxRCWM4+AsNpt0hGOm175tBrPJB7XChA/gY1/j9uH31hADYQXDddB2P6XiI7IEc3e/
 Gq35m+5vGIXSt0nvtpdZCxFFQ1I7M/V3+kQ1EkJ7VDUwrYziPXBiqPfvPAZnBZ06/4Rz2MI4SH4
 UIJH3/l16uaQKIe4jJOCYvC/jNHzrPX/rthAxlgBVVpdJxFg==
X-Received: by 2002:a05:600c:4798:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-48a76f7a538mr3649975e9.14.1777314447109; 
 Mon, 27 Apr 2026 11:27:27 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:153b:d200:96aa:46be:4d7:72d2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af5c5sm6046165e9.5.2026.04.27.11.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:27:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: remove almost all calls to
 amdgpu_userq_detect_and_reset_queues
Date: Mon, 27 Apr 2026 20:27:19 +0200
Message-ID: <20260427182723.1715-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427182723.1715-1-christian.koenig@amd.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well the reset handling seems broken on multiple levels.

As first step of fixing this remove most calls to the hang detection.
That function should only be called after we run into a timeout! And *NOT*
as random check spread over the code in multiple places.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 38 +++++++++--------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 62d155d6e4ed..fb3c0425cf22 100644
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
@@ -1270,7 +1261,6 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(queue);
@@ -1278,9 +1268,11 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
 
@@ -1380,7 +1372,6 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		guard(mutex)(&uqm->userq_mutex);
-		amdgpu_userq_detect_and_reset_queues(uqm);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_preempt_helper(queue);
 		else
@@ -1439,7 +1430,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 		    (queue->xcp_id == idx)) {
-			amdgpu_userq_detect_and_reset_queues(uqm);
 			r = amdgpu_userq_preempt_helper(queue);
 			if (r)
 				ret = r;
-- 
2.43.0

