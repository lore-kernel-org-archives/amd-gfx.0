Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B6DC3F6B0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E77010E042;
	Thu, 25 Aug 2022 13:31:59 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BDB10E02C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:49 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id gb36so39523560ejc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=Qb+gNWsEp4HhG0RoUYRA0wpdMKzvjjwfjBFlL+r1ILg=;
 b=FhEfK3sjqsjwNllVd3uno2Iom6ByaGTQ68qeJvMIACAKqlTzbD5wRNlesdWc1T9Sqe
 SH87DUqjyFl4D13RItmT/xui6jvGMB3kpgmJ78yjs3S7tifLIyMjD8Gpljy8bmjwYTuF
 otxjwG5WFrlDq8tc9cqgBiYW2a8sqcMBVEOLCO6L+AuV43qYo1MUK3LLrqF7sYjwjosQ
 oVRG0Ve4tYZhvsNWOpLm7vul+GSUSAKSfSNveFgLwJSVnKNiZcuyfJZ0eKNIxkvZ78J9
 SpCw/X/bg1zovwZIVjDOxwbjwe3KIZNi/fgxhu/is7kAnQByb1eYtyb3hfqlIeEdD5pv
 jrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=Qb+gNWsEp4HhG0RoUYRA0wpdMKzvjjwfjBFlL+r1ILg=;
 b=T/dIipuk/4TQ7EkTGmOqFFfow58TfwKb4HsPUxP9qldEB3du+dUrfOiey8kzwRx2PI
 3z57ASruG+Li3H6gaKN43AIn+E4QFGl5K1+2HpeLpsyw7j2NQAkG6F6ZLA3A2Zsa7zFy
 2GUbr4dA1iunuGRmll9KygLykWFyGeLt0NI2nzfD+biLgOTY/pS/f999B3A+VFsv5y/5
 +NHN8O6bm+FOWmxFAIdvATjt5FSViBQhoKeEi7trZA1H817dqJ8a/8vTwdQYAX4VcWHv
 sTFaZD8doIkhPcRyBcC4Zdk8MBbs6lOCiIqC4wXfc37oR7660tJsTEZWnu4cxBJsyG5d
 wGMQ==
X-Gm-Message-State: ACgBeo3DfsO6KdtbEn/tCCvD1ilxKwS9CuJu9hB6dq3xtEsGeLrVz589
 Y7NYBd6TvtnOd3UC75tgUsgHQx4rDp5RtA==
X-Google-Smtp-Source: AA6agR6sELo5OxUnEyzOf72t8byJD5Q/83hWYyg5tE5SuUDSNS+zFHKB8IhCIbOwMW0C/QnwE7I0jQ==
X-Received: by 2002:a17:907:7e8a:b0:732:ff29:d1d6 with SMTP id
 qb10-20020a1709077e8a00b00732ff29d1d6mr2614515ejc.175.1661434307759; 
 Thu, 25 Aug 2022 06:31:47 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:47 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] drm/amdgpu: revert "partial revert "remove ctx->lock"
 v2"
Date: Thu, 25 Aug 2022 15:31:33 +0200
Message-Id: <20220825133142.8272-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
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
index b7bae833c804..75fab438ba4d 100644
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
@@ -708,7 +706,6 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 	dma_fence_put(parser->fence);
 
 	if (parser->ctx) {
-		mutex_unlock(&parser->ctx->lock);
 		amdgpu_ctx_put(parser->ctx);
 	}
 	if (parser->bo_list)
@@ -1157,9 +1154,6 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 {
 	int i, r;
 
-	/* TODO: Investigate why we still need the context lock */
-	mutex_unlock(&p->ctx->lock);
-
 	for (i = 0; i < p->nchunks; ++i) {
 		struct amdgpu_cs_chunk *chunk;
 
@@ -1170,34 +1164,32 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
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
@@ -1359,7 +1351,6 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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

