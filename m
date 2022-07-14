Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66DCC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02E4A4591;
	Thu, 14 Jul 2022 10:39:11 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9617CA4583
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:39:09 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id ss3so2608937ejc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wZ8Vu7VNJkD+ygeFMl3z/sMnW01x6sfrkg28TO8wetE=;
 b=Ms1AVuhQ/DnIV9ikvuxb3Uq4QUaj8+kjRG82/idi/zdAKvQySJMSsqPoMPU3btpqCR
 /sdJhjlkrNUkiikOOjsRhJS3tR0q7TJEtvo1usztv06IwE3jJ9gzOf4i+IXtZD5ecY+M
 JZPHJfgOqUO5VS1ZHnCem+g4U0451YnIg3xdagwdG1US6s9nKg8QwwweIHYoIqkr9HNf
 AmB5tsjTENxbO7/DfHztwcYiCvKUJ2K+VWL7EpYFXmhvd5xbwk0qzxr10gxHVSnmNLuR
 877Y8aUJlC6dmNqN4XqHBKONKvwJ+VKF2ldnw/rDD3kJTCFrqzBLhqCHMqS583sFow59
 hjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wZ8Vu7VNJkD+ygeFMl3z/sMnW01x6sfrkg28TO8wetE=;
 b=PG2XiiHjbKYzyAROWPH3kgGwTCptbnwXPRQbcYfxielPGqBYMsR4wCScK+3qlvPE5K
 IvrRHMQu0IwnabvXUSO/W6p/sL005sumTtjuxMr15x2xEwLRxRHMjCgqu76Hb6ID0Rf8
 eXGce0bg9G8k+nJ/mXXST+98qoxh9o1r8pL7E7nsuuL5Spx3hWxIFk17cm/woooMXqYD
 j+pkDq3YDPuR9igmqaxfO/7+8eqNDujLnfOykzm7MvvvuI4I16yyOqbVFi3No4PkDO5Z
 EPpuhjOZ03d9ZtJgGubDRXnZCQ4HCHX/3CM0ZwgW9pMCIhlsQR/aEqTZ2Wlxb2LI+Aj2
 hChQ==
X-Gm-Message-State: AJIora8MTp0Sygk/mPJmwcdEglUoeLAi8p/ENPobDBCqY8TFirG3bGfX
 IFm+Lg/7abFS+V0KY5vgRc6Yr8p7UN8=
X-Google-Smtp-Source: AGRyM1t4BYisIqsIG0BSY7l0vCOoetn/Li3C4kDZhsHviadWp/aNyiaCwZNzb9OYOPAGSn+gkowBkg==
X-Received: by 2002:a17:906:58d5:b0:722:fc0b:305a with SMTP id
 e21-20020a17090658d500b00722fc0b305amr7964172ejs.251.1657795147974; 
 Thu, 14 Jul 2022 03:39:07 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm799487edq.20.2022.07.14.03.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 03:39:07 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com,
 timur.kristof@gmail.com, andrey.grodzovsky@amd.com,
 Yogesh.Mohanmarimuthu@amd.com
Subject: [PATCH 03/10] drm/amdgpu: revert "partial revert "remove ctx->lock"
 v2"
Date: Thu, 14 Jul 2022 12:38:55 +0200
Message-Id: <20220714103902.7084-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714103902.7084-1-christian.koenig@amd.com>
References: <20220714103902.7084-1-christian.koenig@amd.com>
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
index d8f1335bc68f..a3b8400c914e 100644
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
@@ -1161,9 +1158,6 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 {
 	int i, r;
 
-	/* TODO: Investigate why we still need the context lock */
-	mutex_unlock(&p->ctx->lock);
-
 	for (i = 0; i < p->nchunks; ++i) {
 		struct amdgpu_cs_chunk *chunk;
 
@@ -1174,34 +1168,32 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
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
@@ -1363,7 +1355,6 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto out;
 
 	r = amdgpu_cs_submit(&parser, cs);
-
 out:
 	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2ef5296216d6..53f9268366f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -286,7 +286,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 	kref_init(&ctx->refcount);
 	ctx->mgr = mgr;
 	spin_lock_init(&ctx->ring_lock);
-	mutex_init(&ctx->lock);
 
 	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
 	ctx->reset_counter_query = ctx->reset_counter;
@@ -401,7 +400,6 @@ static void amdgpu_ctx_fini(struct kref *ref)
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

