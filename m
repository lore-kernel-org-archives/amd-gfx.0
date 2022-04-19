Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58846C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 11:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7AC10EF43;
	Tue, 19 Apr 2022 11:06:37 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052FD10EF43
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 11:06:37 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id c64so20741884edf.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OMUJixXKyxBse8EdWgqduQjLz8k4qCnv915o/mb6kYM=;
 b=VzkUrxVMkJ/ZFUjaHiHn4L0713uVoI5wU/jWE/LZQ21FsVfl2X19Ji+wWmcvf6rSf4
 Q5x8rj96vmW7xB+sQ/NrzElMVAsE9D3543dg6bPdGyDXIhc814A35DD13c4BJ80Rws55
 HR3amti8SgtEARS8Qox/hq3C38lB4tyafhF4I/sKCcd53y0KdDtD0ktCoRn7urTAoqiF
 cPdHTrmu6Ryb8k3h2VHhO/YvMzJQwRDdNhfDcS3nnG3ByloHzQAlVkFo1amqxyNhPVJG
 qaOavn1v0jmw/R0PCxMKypYarQ2DEUePrqNbWfmWKM9NiwrHJBdRCqV3/h+940wxRNhw
 lyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OMUJixXKyxBse8EdWgqduQjLz8k4qCnv915o/mb6kYM=;
 b=fxGo3xmlrmcvH19ZI9HxYNpQydu4VXjjZAc6oy9T5whzqk9QOJhfjAzXMph6KqmAMn
 CF5evepXRwF6HoUf5OAECJx7WmTKJtiinbv16p5gFxkewFqsX57sh5gVNB3Vb/sZj2IR
 UblSyREzNHv58drUKBZ/MTXT6yBz0oofklnCjwyJnfsaS91WKGBgIj+6hrJSSUMVf1Cj
 NKv5L9CEetygquNPCESf83h16M/lYfHcz1Q63IFg7gOVqcgruBajw9CItMUg183LgKlI
 +QLr1V14kgHV4LtKyCo1cofAPANNaqboGOZQ+kajHwPf9C7RobFVawXgXZu9NgAFChmK
 gkMA==
X-Gm-Message-State: AOAM531PuGWu1sRvLO204xASmMWEuQBKyCYlzQ2xUfn2LvYrsLDhaHmG
 c8anZ6nlX2DdagdSBZJkebE=
X-Google-Smtp-Source: ABdhPJzFxn4ZKlGUO2zWwBOiNS12wiDAl/+dTUmqUjAz2cU69Coccu0KaMDDzCupTf9y/MQ0vFb3eA==
X-Received: by 2002:a05:6402:448a:b0:41d:793d:8252 with SMTP id
 er10-20020a056402448a00b0041d793d8252mr16520160edb.6.1650366395422; 
 Tue, 19 Apr 2022 04:06:35 -0700 (PDT)
Received: from able.fritz.box (p57b0b9e1.dip0.t-ipconnect.de. [87.176.185.225])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a1709063ad600b006e8867caa5dsm5533708ejd.72.2022.04.19.04.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 04:06:34 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: mikhail.v.gavrilov@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: partial revert "remove ctx->lock" v2
Date: Tue, 19 Apr 2022 13:06:33 +0200
Message-Id: <20220419110633.166236-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

This reverts commit 461fa7b0ac565ef25c1da0ced31005dd437883a7.

We are missing some inter dependencies here so re-introduce the lock
until we have figured out what's missing. Just drop/retake it while
adding dependencies.

v2: still drop the lock while adding dependencies

Signed-off-by: Christian König <christian.koenig@amd.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> (v1)
Fixes: 461fa7b0ac56 ("drm/amdgpu: remove ctx->lock")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 970b065e9a6b..d0d0ea565e3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -128,6 +128,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_chunk;
 	}
 
+	mutex_lock(&p->ctx->lock);
+
 	/* skip guilty context job */
 	if (atomic_read(&p->ctx->guilty) == 1) {
 		ret = -ECANCELED;
@@ -709,6 +711,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 	dma_fence_put(parser->fence);
 
 	if (parser->ctx) {
+		mutex_unlock(&parser->ctx->lock);
 		amdgpu_ctx_put(parser->ctx);
 	}
 	if (parser->bo_list)
@@ -1157,6 +1160,9 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 {
 	int i, r;
 
+	/* TODO: Investigate why we still need the context lock */
+	mutex_unlock(&p->ctx->lock);
+
 	for (i = 0; i < p->nchunks; ++i) {
 		struct amdgpu_cs_chunk *chunk;
 
@@ -1167,32 +1173,34 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
 			r = amdgpu_cs_process_fence_dep(p, chunk);
 			if (r)
-				return r;
+				goto out;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
 			r = amdgpu_cs_process_syncobj_in_dep(p, chunk);
 			if (r)
-				return r;
+				goto out;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
 			r = amdgpu_cs_process_syncobj_out_dep(p, chunk);
 			if (r)
-				return r;
+				goto out;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
 			r = amdgpu_cs_process_syncobj_timeline_in_dep(p, chunk);
 			if (r)
-				return r;
+				goto out;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
 			r = amdgpu_cs_process_syncobj_timeline_out_dep(p, chunk);
 			if (r)
-				return r;
+				goto out;
 			break;
 		}
 	}
 
-	return 0;
+out:
+	mutex_lock(&p->ctx->lock);
+	return r;
 }
 
 static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
@@ -1368,6 +1376,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto out;
 
 	r = amdgpu_cs_submit(&parser, cs);
+
 out:
 	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5981c7d9bd48..8f0e6d93bb9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -237,6 +237,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 
 	kref_init(&ctx->refcount);
 	spin_lock_init(&ctx->ring_lock);
+	mutex_init(&ctx->lock);
 
 	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
 	ctx->reset_counter_query = ctx->reset_counter;
@@ -357,6 +358,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 		drm_dev_exit(idx);
 	}
 
+	mutex_destroy(&ctx->lock);
 	kfree(ctx);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index d0cbfcea90f7..142f2f87d44c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -49,6 +49,7 @@ struct amdgpu_ctx {
 	bool				preamble_presented;
 	int32_t				init_priority;
 	int32_t				override_priority;
+	struct mutex			lock;
 	atomic_t			guilty;
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
-- 
2.25.1

