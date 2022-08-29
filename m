Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C511FECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDC110F1CA;
	Mon, 29 Aug 2022 13:18:37 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF2BC10F1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:27 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id u9so15650353ejy.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=Qb+gNWsEp4HhG0RoUYRA0wpdMKzvjjwfjBFlL+r1ILg=;
 b=e80C0Przpm3WPsDaqRnqc5zZQIgw+R1AS3TxGg946L1zlN/AjWm3Inzs45c+Q5wxff
 YL0+EPC0asGQ2hSI88jik+5rl3igMESw10TrSdRrwkQ+hub65U9/m7dcDH1kRpTkq58f
 LgATOSXyF2dE3vj8dBRzaS647md2dtsPnQsGoz5tgQUtSp/FMLiPFGv41wZp7guvYA6w
 vXkYQYnJXmvPMx9tVykNN++J6nWtcSKamqJQ1gt885S6QCn0zTuaL6GZdKgM1BVBWf/D
 EPrW/UsNacU69FQ8WhR0/wu1NDKk3Bxu8xZkUShd5zTsSmQ5RQqUj78IDWl17TmS8rSf
 hC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=Qb+gNWsEp4HhG0RoUYRA0wpdMKzvjjwfjBFlL+r1ILg=;
 b=G5PWMxi/efoumXD4rYH/ZdziWW++o6rZ95n7/ZtQJn+WhuqC28WJtMnFp/s72aY6NG
 MIiVHLYKEeYU2TZVLlGeQALyOHPrIhGhQz+StuiFB5ge+rE24j5IhTpkM8dcgDNwiDTU
 jBBi6CMmmQvEBHDcYNzQbA8iAu+bd0laNziBauG5h5/ZT2211TJDNHtsnoHKLV4fOFDz
 P6sMtXsp+bbinvtcEu+d80NBxRXIMBxpOcGxnvt+dWBpE0KQ2TwEgaz1M6B4L4qM92SM
 g1OwI9FXS1EbFN4szWTX53TKjeudLimlTBeNSOnuBdR7z7YUW/ulIihB2xrpVxJckTIr
 XtPQ==
X-Gm-Message-State: ACgBeo0envf1aNcBBzcFzHUs2tGAVDuKjGUOmDJ0dVJzQSToF2hLRYeZ
 RTYrLrHme14zKtmtNOFBND9nbD03mKA=
X-Google-Smtp-Source: AA6agR70beMfKyarN1VDMKx6Om72J2rDUdbIOwS1MWMX3boyuH2BShRyqa7yTiUh/8KdVlCdrfbxnA==
X-Received: by 2002:a17:907:6d03:b0:741:9b9d:ad8b with SMTP id
 sa3-20020a1709076d0300b007419b9dad8bmr2564685ejc.197.1661779106460; 
 Mon, 29 Aug 2022 06:18:26 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] drm/amdgpu: revert "partial revert "remove ctx->lock"
 v2"
Date: Mon, 29 Aug 2022 15:18:12 +0200
Message-Id: <20220829131821.2049-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829131821.2049-1-christian.koenig@amd.com>
References: <20220829131821.2049-1-christian.koenig@amd.com>
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

