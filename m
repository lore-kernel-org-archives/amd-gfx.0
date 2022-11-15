Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606CBC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 09:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B45510E126;
	Tue, 15 Nov 2022 09:42:15 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099EC10E126
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 09:42:10 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id bj12so34556075ejb.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 01:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EF0/lMN9Rkk5PKUamW21+gNQpgIiteuhgstRDRq8mys=;
 b=bu7l8+bub5+4I47cfCu0uw9nFl2SN4B3P28ktdrRiB9digTIW3D/FIPgx7IfLnYToB
 L44I9VT+8XFe7B9BUtxOYBbCc8V4JF2mDpYTtsPtV7UusLXkSs5+5V5sqysWAUEWxKMl
 +mvMP0GJkY2ek5xYXCx9zVU3j7zH2oqo4YHIcKksTvWNlXirKon6cQVjv02npNOfbXJ9
 XkJBb/u0F1x92wkSKYLxFVk49GrZ/7Bi66X5mZ/0Yvx/Ynzdn0uATolnN/MKE+2SmLUc
 bRPtWrmyu8w0j4DtAqErTdWqx/E+B/Vlg3nklDT546sSXiCrXQyyjsyH5NrJGBtHF2Kt
 Ldcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EF0/lMN9Rkk5PKUamW21+gNQpgIiteuhgstRDRq8mys=;
 b=ImFQ5oKivuP74u6z1BlaN5mC6grkik9cSqhPa8iKajRQj9mnfXVW4fNIqn4h2S1Dd7
 H0mSloxq9e+M91ih3sOtBmk91RAhP4C8/0g+gDSBFZU05iZ7OVdqz/I/tjtnfQZWXigF
 nMaeoHXgI7Jho4d7I08OymhiuwhZssLJ6axr5KQAv+5BCybu6gR0bQXGWW7YLBp8YKsc
 92SuvmCNIgnAEpyHWHXSDqqIyKm6p53GFoOOP74UinJTcsiO+7eM7jJgFcne2Z4g1Ima
 PIUvRlCw5tKuPkoV39Rv5np6vAD4Bs3t+ukYhtu8NKv8PcCFByzrB1ERrafwbG68086g
 oHog==
X-Gm-Message-State: ANoB5pkU51+TfiBjtABUraYKDUuuD6dTX3hevfUzKU4+9+hTH8YsweIb
 5sWY0mDfptxsxJ+pUmKbnO0UG10kXPE=
X-Google-Smtp-Source: AA0mqf6SW59V2eaWriUVcKhOkmMa+6bE7tE47mQeepfN1cfYtM8yJWuiiIlSV3lhwAayuSg8iMSQyA==
X-Received: by 2002:a17:906:4dc2:b0:7ae:50c6:fd0a with SMTP id
 f2-20020a1709064dc200b007ae50c6fd0amr12915964ejw.184.1668505328410; 
 Tue, 15 Nov 2022 01:42:08 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 up22-20020a170907cc9600b007acbac07f07sm5306900ejc.51.2022.11.15.01.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Nov 2022 01:42:07 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use the last IB as gang leader v2
Date: Tue, 15 Nov 2022 10:42:06 +0100
Message-Id: <20221115094206.6181-1-christian.koenig@amd.com>
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
Cc: timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It turned out that not the last IB specified is the gang leader,
but instead the last job allocated.

This is a bit unfortunate and not very intuitive for the CS
interface, so try to fix this.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1bbd39b3b0fc..fbdf139cf497 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -109,6 +109,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
 		return r;
 
 	++(num_ibs[r]);
+	p->gang_leader_idx = r;
 	return 0;
 }
 
@@ -300,7 +301,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		if (ret)
 			goto free_all_kdata;
 	}
-	p->gang_leader = p->jobs[p->gang_size - 1];
+	p->gang_leader = p->jobs[p->gang_leader_idx];
 
 	if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
 		ret = -ECANCELED;
@@ -1194,16 +1195,18 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
-	for (i = 0; i < p->gang_size - 1; ++i) {
+	for (i = 0; i < p->gang_size; ++i) {
+		if (p->jobs[i] == leader)
+			continue;
+
 		r = amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync);
 		if (r)
 			return r;
 	}
 
-	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size - 1]);
+	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
-
 	return r;
 }
 
@@ -1237,9 +1240,12 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	for (i = 0; i < p->gang_size; ++i)
 		drm_sched_job_arm(&p->jobs[i]->base);
 
-	for (i = 0; i < (p->gang_size - 1); ++i) {
+	for (i = 0; i < p->gang_size; ++i) {
 		struct dma_fence *fence;
 
+		if (p->jobs[i] == leader)
+			continue;
+
 		fence = &p->jobs[i]->base.s_fence->scheduled;
 		r = amdgpu_sync_fence(&leader->sync, fence);
 		if (r)
@@ -1275,7 +1281,10 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	list_for_each_entry(e, &p->validated, tv.head) {
 
 		/* Everybody except for the gang leader uses READ */
-		for (i = 0; i < (p->gang_size - 1); ++i) {
+		for (i = 0; i < p->gang_size; ++i) {
+			if (p->jobs[i] == leader)
+				continue;
+
 			dma_resv_add_fence(e->tv.bo->base.resv,
 					   &p->jobs[i]->base.s_fence->finished,
 					   DMA_RESV_USAGE_READ);
@@ -1285,7 +1294,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		e->tv.num_shared = 0;
 	}
 
-	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1],
+	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_idx],
 				   p->fence);
 	amdgpu_cs_post_dependencies(p);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index cbaa19b2b8a3..f80adf9069ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -54,6 +54,7 @@ struct amdgpu_cs_parser {
 
 	/* scheduler job objects */
 	unsigned int		gang_size;
+	unsigned int		gang_leader_idx;
 	struct drm_sched_entity	*entities[AMDGPU_CS_GANG_SIZE];
 	struct amdgpu_job	*jobs[AMDGPU_CS_GANG_SIZE];
 	struct amdgpu_job	*gang_leader;
-- 
2.34.1

