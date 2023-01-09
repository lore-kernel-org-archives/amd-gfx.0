Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1BDC5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 13:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A582D10E41A;
	Mon,  9 Jan 2023 13:01:26 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0155A10E42B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 13:01:23 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id v6so12343165edd.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Jan 2023 05:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i4gqMnKDopaFHkJb8E6nSB23uxz4iPjmbpTs65Dmhig=;
 b=PfxRBffRr77K/b0eYpBswHaj/VKN0Xwsh0Mgc1Tb4iQAQ5fzR1QI8/dKKYzTcZwro9
 aL8PKX/YsT2NN5z4eVXhjUmrKvTUooJ/saM0dS029RzK8cIY3PlGQsRHPVT2xCTwQHN+
 LO5XANCdQ136FzYe7OuFbTDUWpfDNyuVe7HYYj2oFM/cZfRELcPjiNmxS8oEB25pF9ZZ
 PisU0UTtVr8jIEpynMgp7j1FpGK3WejTKEeEbcW+zaLNyAGKpq6+aUE6o2zufWFtfA/h
 wmlysAFX/qRmiVMztTb3pKFwJEJXhpkcDvEQVzPcoCn1nMTrn5QgGsazw7+z5rXd1uV6
 Qa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i4gqMnKDopaFHkJb8E6nSB23uxz4iPjmbpTs65Dmhig=;
 b=hvc8ltLQegsk9+8sEWCFBPqYF19kOy9DUG6Vdj3Nnrg+8JCCqlb8vdNWlQ2BCPmKXz
 FVniGxT2wpiaX/BkMJ1KEHZ/L4rzPxPMCOyF6KzMhANdYfzRcTueidxKmFRLiDfcQ+GL
 wnDoZ86XvAtyUD7LeERqhNhutQJTC+IS8ZD1prF3LYLPnIoXClEoKpzkPW2ZjrANr6hD
 BpRgpzTGnSMaoqmA0iqi+hOacY0vtB8RD9HFe+QoLDY5hXUqXo68j5ze6OA3bT9Ov3mc
 OGsK96+bSw0CT+dDOblmR6foKaARkVU32eEGnDIE8CLEYT4d3j9lf8cebTR6YlpXsxSp
 R0HA==
X-Gm-Message-State: AFqh2kryTWrm6p+rwCHRzoEPGTpnwpQFYRbylRAP3rwucT/BMhMAeiY4
 1ARfwn7ZqrXggHcYGWPZ2hHrpPF1Yus=
X-Google-Smtp-Source: AMrXdXssIWr5+kh6uQApBNgzF5s4YysUhC3uMFsXo4WWCYuJgAEdkyQgCPpx22oVC7hlHw2rXB4ZjQ==
X-Received: by 2002:a50:ee86:0:b0:493:1a5e:f617 with SMTP id
 f6-20020a50ee86000000b004931a5ef617mr12964431edr.18.1673269282227; 
 Mon, 09 Jan 2023 05:01:22 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 ca20-20020aa7cd74000000b0046267f8150csm3644764edb.19.2023.01.09.05.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jan 2023 05:01:21 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix pipeline sync v2
Date: Mon,  9 Jan 2023 14:01:20 +0100
Message-Id: <20230109130120.73389-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes a potential memory leak of dma_fence objects in the CS code
as well as glitches in firefox because of missing pipeline sync.

v2: use the scheduler instead of the fence context for the test

Signed-off-by: Christian König <christian.koenig@amd.com>
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2323
Fixes: 1b2d5eda5ad7 ("drm/amdgpu: move explicit sync check into the CS")
Tested-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 46 +++++++++++++++++---------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 47763ac0d14a..7b5ce00f0602 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -61,6 +61,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 		amdgpu_ctx_put(p->ctx);
 		return -ECANCELED;
 	}
+
+	amdgpu_sync_create(&p->sync);
 	return 0;
 }
 
@@ -452,18 +454,6 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 	}
 
 	r = amdgpu_sync_fence(&p->sync, fence);
-	if (r)
-		goto error;
-
-	/*
-	 * When we have an explicit dependency it might be necessary to insert a
-	 * pipeline sync to make sure that all caches etc are flushed and the
-	 * next job actually sees the results from the previous one.
-	 */
-	if (fence->context == p->gang_leader->base.entity->fence_context)
-		r = amdgpu_sync_fence(&p->gang_leader->explicit_sync, fence);
-
-error:
 	dma_fence_put(fence);
 	return r;
 }
@@ -1188,10 +1178,19 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct drm_gpu_scheduler *sched;
 	struct amdgpu_bo_list_entry *e;
+	struct dma_fence *fence;
 	unsigned int i;
 	int r;
 
+	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
+	if (r) {
+		if (r != -ERESTARTSYS)
+			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
+		return r;
+	}
+
 	list_for_each_entry(e, &p->validated, tv.head) {
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 		struct dma_resv *resv = bo->tbo.base.resv;
@@ -1211,10 +1210,24 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
-	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
-	if (r && r != -ERESTARTSYS)
-		DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
-	return r;
+	sched = p->gang_leader->base.entity->rq->sched;
+	while ((fence = amdgpu_sync_get_fence(&p->sync))) {
+		struct drm_sched_fence *s_fence = to_drm_sched_fence(fence);
+
+		/*
+		 * When we have an dependency it might be necessary to insert a
+		 * pipeline sync to make sure that all caches etc are flushed and the
+		 * next job actually sees the results from the previous one
+		 * before we start executing on the same scheduler ring.
+		 */
+		if (!s_fence || s_fence->sched != sched)
+			continue;
+
+		r = amdgpu_sync_fence(&p->gang_leader->explicit_sync, fence);
+		if (r)
+			return r;
+	}
+	return 0;
 }
 
 static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
@@ -1347,6 +1360,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
 	unsigned i;
 
+	amdgpu_sync_free(&parser->sync);
 	for (i = 0; i < parser->num_post_deps; i++) {
 		drm_syncobj_put(parser->post_deps[i].syncobj);
 		kfree(parser->post_deps[i].chain);
-- 
2.34.1

