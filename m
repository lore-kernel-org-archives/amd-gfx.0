Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA08FC54EE9
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B14310E364;
	Mon,  5 Sep 2022 12:32:52 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8240C10E36B
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:39 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id p16so16783166ejb.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=oFhiX5OrD2xKjocCqCe65ElofuDat+YfEZDe+lTq+Ec=;
 b=IZK8UL65gpZy7Lya6rQE1Xr+1OrxmqhqbeciD8V6uFTCx/mOIO/cUz8E8hkI2UrB7w
 bIl9McU/AatIl/isncTUSpNwKBA2l4iar5K2L8hRshvEzo3+jUCEFjMIPlUow+wMW8LM
 ubMyJJj2lesT8In70/SPtafdfnxPuHGyKOkrkf1E5BLzz2czX3/iKQGHqWWJtfqZqLqU
 SRlTnoJ8PGMMDEux5QsJ8d3+z/ZO3xQSJXwP/DvH6F3bce82uKuJrt8a0V+b8VyWwWjI
 1qnbD4Z1G9AtMB2QRnyGTx4JWP2ZR9wEgMTZmBzrbDuJ0ilFuFkZM+5snU0rnysjTK+C
 5s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=oFhiX5OrD2xKjocCqCe65ElofuDat+YfEZDe+lTq+Ec=;
 b=FwAey1u602EXAr9t9mQ5hb6jSyhtBadkho2+2MQRu3uoA+VjWFuPGvmYjYPqqmLklM
 0ZUS0HoUQYU7WU/s7vBPmgPqtXC2N9MATdKhIDx3NxsQqPUzaur6ei0u7zRSSJIdXex7
 WvmyDG914MBkjNtVuZ0AgSCe7Nr0C7Sy6fOsc7LXyAZr6sWBazXaVYczcOrYOu6syjzm
 1u/3iRbX5GarW5SasZ5/icU4TYeEbjKGim+hBirrBNCf4wpGeWr8XZ229uQntmV//0iW
 7riLJSQRdbgRs3OfRS0AWsQqZuaBbSW0FQ4kZmVWJCZQ6OnP+sO2zT3aXVD8acdo3WC7
 zGCA==
X-Gm-Message-State: ACgBeo345yVqdGKCRSpsV/rWkiqJdwvh/0quXS3cD7J9c9BeMRCumMTz
 AjEFGJ01VWgjuKspG9iUI8YelzsAWWdRIQ==
X-Google-Smtp-Source: AA6agR69u67zbln6HUg1V6J8svIFKeFjh9YurV37G2mOJeHy1H8UzbeJH1SaHhQv8jDhQO/2hp7c4A==
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id
 xf9-20020a17090731c900b00740ef932ffdmr30946672ejb.584.1662381157389; 
 Mon, 05 Sep 2022 05:32:37 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 04/12] drm/amdgpu: revert "partial revert "remove ctx->lock"
 v2"
Date: Mon,  5 Sep 2022 14:32:24 +0200
Message-Id: <20220905123232.2809-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905123232.2809-1-christian.koenig@amd.com>
References: <20220905123232.2809-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 94f4c4965e5513ba624488f4b601d6b385635aec.

We found that the bo_list is missing a protection for its list entries.
Since that is fixed now this workaround can be removed again.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 -
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f7bf61d96be5..52ba6325944e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -128,8 +128,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_chunk;
 	}
 
-	mutex_lock(&p->ctx->lock);
-
 	/* skip guilty context job */
 	if (atomic_read(&p->ctx->guilty) == 1) {
 		ret = -ECANCELED;
@@ -691,7 +689,6 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 	dma_fence_put(parser->fence);
 
 	if (parser->ctx) {
-		mutex_unlock(&parser->ctx->lock);
 		amdgpu_ctx_put(parser->ctx);
 	}
 	if (parser->bo_list)
@@ -1138,9 +1135,6 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 {
 	int i, r;
 
-	/* TODO: Investigate why we still need the context lock */
-	mutex_unlock(&p->ctx->lock);
-
 	for (i = 0; i < p->nchunks; ++i) {
 		struct amdgpu_cs_chunk *chunk;
 
@@ -1151,34 +1145,32 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
 			r = amdgpu_cs_process_fence_dep(p, chunk);
 			if (r)
-				goto out;
+				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
 			r = amdgpu_cs_process_syncobj_in_dep(p, chunk);
 			if (r)
-				goto out;
+				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
 			r = amdgpu_cs_process_syncobj_out_dep(p, chunk);
 			if (r)
-				goto out;
+				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
 			r = amdgpu_cs_process_syncobj_timeline_in_dep(p, chunk);
 			if (r)
-				goto out;
+				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
 			r = amdgpu_cs_process_syncobj_timeline_out_dep(p, chunk);
 			if (r)
-				goto out;
+				return r;
 			break;
 		}
 	}
 
-out:
-	mutex_lock(&p->ctx->lock);
-	return r;
+	return 0;
 }
 
 static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
@@ -1340,7 +1332,6 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto out;
 
 	r = amdgpu_cs_submit(&parser, cs);
-
 out:
 	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8ee4e8491f39..168337d8d4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -315,7 +315,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 	kref_init(&ctx->refcount);
 	ctx->mgr = mgr;
 	spin_lock_init(&ctx->ring_lock);
-	mutex_init(&ctx->lock);
 
 	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
 	ctx->reset_counter_query = ctx->reset_counter;
@@ -407,7 +406,6 @@ static void amdgpu_ctx_fini(struct kref *ref)
 		drm_dev_exit(idx);
 	}
 
-	mutex_destroy(&ctx->lock);
 	kfree(ctx);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index cc7c8afff414..0fa0e56daf67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -53,7 +53,6 @@ struct amdgpu_ctx {
 	bool				preamble_presented;
 	int32_t				init_priority;
 	int32_t				override_priority;
-	struct mutex			lock;
 	atomic_t			guilty;
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
-- 
2.25.1

