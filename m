Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76818C6FA83
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04EC10E459;
	Mon, 12 Sep 2022 12:37:41 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E3810E459
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:36:48 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id u9so19896804ejy.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=k4GyqQX+yUY0Oekmh2aQqzhrorQEtSTytHJH7k9McM4=;
 b=ZyAU+vMNhB7XNbhneDHcsLXNq1CyzfV046+qEV1jiBghdOXkxGqPPR5mZWTOeekgmd
 ezU3jV/8WSwE6UTpDw/0uc5DdVo1M58HSqK2eX1r2LQaOjsPCUh9KxPEquvAi8vvZAf2
 mX/7AbnhtcUxnOwNzwzjWTLGJMbwFVj4raK96l8oucw82jQLgwnadiHXeCzfIpSz+UqO
 IEbNa5/2RRugKYdocwxID0zZ5ixrcE97aS1wLW5AdcgFDy2SmZLBFf1npW5ZP3t+hZS2
 6BairM6Y+MAfFNh6jI4smpWV5enQby93diLTeYG6dXcFGIOXV2sH06HfQG9RiyyQh4Tc
 IGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=k4GyqQX+yUY0Oekmh2aQqzhrorQEtSTytHJH7k9McM4=;
 b=HiBrKlUW1Q/HBnuENGS/y2cR3Q/Z8bw6WxraeSQ21+nQyUaP4LzTjRPWVvCQ9Oc8cI
 i04ZUdIRDlM/10c6GCkPEJP8KrByvS3ZjaGuKWUOrz6wB01ejCCLDDSK/Hu1P1/y8eeM
 lPjVhPKPwpcm5uJpsRv+52ui692nIEUL0JvDyjp4d3w9fua2s0pFP29GSWPtNo/6Z+wk
 kVXVW4rJjeOxP74EO9nNliDvXQ1uZKOMsSXlwUjk2W/n3j8UWObj/cxFR3Rc7jqqOtJ7
 c6pYW+7Dko1a8eW0Wge9aSLAD3PpjVXKA5clyWOYMC/h0Hk9UX9R5JvbW9JUwnVF7kzu
 Fa+A==
X-Gm-Message-State: ACgBeo0uvtJBUt87gtOdvSiak5pLs6PqnHCWCSuQMQWQlYS8kwaaM3bB
 3j59j/SBukD3lE2h1op6Rio=
X-Google-Smtp-Source: AA6agR4OdUoh8W/fcZL0Tr/lmT1mbUJRfF6v4bDxjXZCibOKcIb6FpCXh/2lvAnWLvV5S0xaeoNoAA==
X-Received: by 2002:a17:906:8a45:b0:77c:dd3:cebd with SMTP id
 gx5-20020a1709068a4500b0077c0dd3cebdmr5658758ejc.668.1662986206574; 
 Mon, 12 Sep 2022 05:36:46 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 au6-20020a170907092600b00770c8e157ccsm4335639ejc.136.2022.09.12.05.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 05:36:46 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: revert "partial revert "remove ctx->lock" v2"
Date: Mon, 12 Sep 2022 14:36:37 +0200
Message-Id: <20220912123640.20058-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912123640.20058-1-christian.koenig@amd.com>
References: <20220912123640.20058-1-christian.koenig@amd.com>
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
index 6ea8980c8ad7..5fc3da020a55 100644
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

