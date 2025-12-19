Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E814D78777
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 13:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FDD10EFA1;
	Fri, 19 Dec 2025 13:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iP9HutgS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDC710EEE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ewE8yyu8bpi4JEao8wwKysbicUdooyXCi0s63ddvvvA=; b=iP9HutgSrSMmCOMouqJSxfHoNq
 YvYw6MfYb/SqhYjRIDy1UU6tbTCxDzdSJpAzM7HIRmvehCvv2m1Bz2HGQK5XNo+pnXQBCGflgTlJV
 XfVEejdDikm+yLee9l3wyf814H43qK2AmwjssxIosAoMLG0x+tY+QDe7/9F7On9mxhxPZnpf/vgQz
 PGAID8fooyOOQIP+rEdNOOXi/g+D+03C4lciEh0g8mNYCm/vtspwH6j6NX89GuK3vP38LdBPaYfh7
 LUplivfSbKhjJHAW0RfSbAJCUIfYVvzTGC/Lfm+8eCMh75sIl1l7LD0uXiyTxfH3IhNWY2uAlicUO
 tYBAXJkA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vWakE-00EeQf-Fe; Fri, 19 Dec 2025 14:42:10 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 04/12] drm/amdgpu: Remove the bo list mutex
Date: Fri, 19 Dec 2025 13:41:57 +0000
Message-ID: <20251219134205.25450-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
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

The bo list is immutable during command submission since the drm_exec
conversion so we can remove the mutex.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 15 ++++-----------
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 72c5096c3b18..fbac929f711c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -41,7 +41,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
 	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
 						   rhead);
-	mutex_destroy(&list->bo_list_mutex);
+
 	kvfree(list);
 }
 
@@ -133,7 +133,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 
 	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
 
-	mutex_init(&list->bo_list_mutex);
 	*result = list;
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 2b5e7c46a39d..1acf53f8b2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -51,10 +51,6 @@ struct amdgpu_bo_list {
 	unsigned first_userptr;
 	unsigned num_entries;
 
-	/* Protect access during command submission.
-	 */
-	struct mutex bo_list_mutex;
-
 	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 203223fd0b54..bc9cee3fdf27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -881,8 +881,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			return r;
 	}
 
-	mutex_lock(&p->bo_list->bo_list_mutex);
-
 	/* Get userptr backing pages. If pages are updated after registered
 	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
 	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
@@ -998,7 +996,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		amdgpu_hmm_range_free(e->range);
 		e->range = NULL;
 	}
-	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return r;
 }
 
@@ -1381,7 +1378,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	mutex_unlock(&p->adev->notifier_lock);
-	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return 0;
 }
 
@@ -1453,28 +1449,25 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_patch_jobs(&parser);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	r = amdgpu_cs_sync_rings(&parser);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	trace_amdgpu_cs_ibs(&parser);
 
 	r = amdgpu_cs_submit(&parser, data);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	amdgpu_cs_parser_fini(&parser);
 	return 0;
 
-error_backoff:
-	mutex_unlock(&parser.bo_list->bo_list_mutex);
-
 error_fini:
 	amdgpu_cs_parser_fini(&parser);
 	return r;
-- 
2.51.1

