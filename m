Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C7AC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 13:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF312051A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 13:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcPBoPMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF312051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B696ECE2;
	Tue, 21 Jan 2020 13:04:00 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233016ECE2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 13:03:59 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id w15so3116669wru.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 05:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cu5VfbvgJqrG1uG6/aalXkmN1h34m3mrzz1g6Jy1DwU=;
 b=FcPBoPMNn7SU1zkdh3PuABckykv4ekAv9eISiLKYQc0EcWJXORlBNZAjTNuYa/cXYD
 ri4YBSRk/TQp0BGfhwxue7FFy/j34ijorZGoBQ0lwi+336H0OEYMkdziPa3/BBKiOp8d
 0zz0lDK4hn2bhwHzcDSPx/RPBiXzf0+Mmo7h5Xkf7scdVToo27O/zAhKETLJnr1FE2F4
 yVAOyMVqFSPkj3Z22UN86xFK40xp7d0v6BCYVbt6WuNoJE4TKGkJpT2PIc4Rl5P+JFk2
 sIVnP7EwzljpAHeY8OQVxVlDHm9pWI2N623Y2NkmySGTCm5ECcnO5xSfKVtOrV3qqoVT
 jpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cu5VfbvgJqrG1uG6/aalXkmN1h34m3mrzz1g6Jy1DwU=;
 b=mDqx2KSnqNqJekRqOOFh5p+TpOB02FmoRszPPFoOOxmgG/OqTJjBNltnN95OnmBQ/4
 5rZVlFbacAhCoTD6PN3dHUQxRdtjGMWv3rtmO/jnzPjehty+i8lhF0L89UgyRQWqSrJM
 JARBGaQLmGbiKxpfQJb8KkvXLLU51Zv4uZbDQvP8/YlgNk2XK/zXa+ZG6AB/iHEcJG6n
 07aAbn6UTv41E9eQvJqamRXX2fUkUlXcqj2Ukz9CNsYdO9NkZDeJMk37QtlQWUMkxfGS
 1U4v1+Q1x29rPHTalybU3LO1Ct/fipg469evwsv6CJl8bmEcCjGH8YB8uFwVjQw2j4ru
 YhWw==
X-Gm-Message-State: APjAAAUK1wnLFv3fhUfoML8Ooh5c4uqD4FbIje/CABWSbZ9EuHjZIBz/
 z9GuwYJWkkeL8GTcDUBtjhS7zw9km56q3A==
X-Google-Smtp-Source: APXvYqwoPdpvgRSvNzIJmg6uaizIckFAKuL7xoqPF/e09Xw6zbNhmS9GTzzYqtXvFjpkmw3hVEr27A==
X-Received: by 2002:adf:d183:: with SMTP id v3mr5331445wrc.180.1579611837440; 
 Tue, 21 Jan 2020 05:03:57 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2C5700EF9508483D6EB58B.dip0.t-ipconnect.de.
 [2003:c5:8f2c:5700:ef95:848:3d6e:b58b])
 by smtp.gmail.com with ESMTPSA id x132sm4302004wmg.0.2020.01.21.05.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 05:03:56 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: individualize fence allocation per entity
Date: Tue, 21 Jan 2020 14:05:37 +0100
Message-Id: <20200121130537.25156-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate fences for each entity and remove ctx->fences reference as
fences should be bound to amdgpu_ctx_entity instead amdgpu_ctx.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 43 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 -
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 64e2babbc36e..a9b611fd6242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -87,24 +87,24 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->adev = adev;
 
-	ctx->fences = kcalloc(amdgpu_sched_jobs * num_entities,
-			      sizeof(struct dma_fence*), GFP_KERNEL);
-	if (!ctx->fences)
-		return -ENOMEM;
 
 	ctx->entities[0] = kcalloc(num_entities,
 				   sizeof(struct amdgpu_ctx_entity),
 				   GFP_KERNEL);
-	if (!ctx->entities[0]) {
-		r = -ENOMEM;
-		goto error_free_fences;
-	}
+	if (!ctx->entities[0])
+		return -ENOMEM;
+
 
 	for (i = 0; i < num_entities; ++i) {
 		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
 
 		entity->sequence = 1;
-		entity->fences = &ctx->fences[amdgpu_sched_jobs * i];
+		entity->fences = kcalloc(amdgpu_sched_jobs,
+					 sizeof(struct dma_fence*), GFP_KERNEL);
+		if (!entity->fences) {
+			r = -ENOMEM;
+			goto error_cleanup_memory;
+		}
 	}
 	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
 		ctx->entities[i] = ctx->entities[i - 1] +
@@ -181,11 +181,16 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 error_cleanup_entities:
 	for (i = 0; i < num_entities; ++i)
 		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
-	kfree(ctx->entities[0]);
 
-error_free_fences:
-	kfree(ctx->fences);
-	ctx->fences = NULL;
+error_cleanup_memory:
+	for (i = 0; i < num_entities; ++i) {
+		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+		kfree(entity->fences);
+		entity->fences = NULL;
+	}
+
+	kfree(ctx->entities[0]);
+	ctx->entities[0] = NULL;
 	return r;
 }
 
@@ -199,12 +204,16 @@ static void amdgpu_ctx_fini(struct kref *ref)
 	if (!adev)
 		return;
 
-	for (i = 0; i < num_entities; ++i)
+	for (i = 0; i < num_entities; ++i) {
+		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+
 		for (j = 0; j < amdgpu_sched_jobs; ++j)
-			dma_fence_put(ctx->entities[0][i].fences[j]);
-	kfree(ctx->fences);
-	kfree(ctx->entities[0]);
+			dma_fence_put(entity->fences[j]);
+
+		kfree(entity->fences);
+	}
 
+	kfree(ctx->entities[0]);
 	mutex_destroy(&ctx->lock);
 
 	kfree(ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 4ad90a44dc3c..a6cd9d4b078c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -42,7 +42,6 @@ struct amdgpu_ctx {
 	unsigned			reset_counter_query;
 	uint32_t			vram_lost_counter;
 	spinlock_t			ring_lock;
-	struct dma_fence		**fences;
 	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM];
 	bool				preamble_presented;
 	enum drm_sched_priority		init_priority;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
