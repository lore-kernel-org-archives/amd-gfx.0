Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEEBC54EE9
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1115D10E388;
	Mon,  5 Sep 2022 12:32:56 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F78310E369
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:41 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id 29so6098129edv.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=K8gzM//Gr6Y2At9qVAjIKTTUGxfe8BIJZGFT2I/R1m8=;
 b=fJj5CGpKMfaXbR1ZDWlRl8ca0r5C3/R2T9cq7Bsq4erbiBH7h8yToR5zdVmGFFek0V
 WJYguwkR/bjl+Gk6j5GrBNLCpPs7K7tIXp3O6QgUxkwkFtpx9E2KJbZAiwb06lL76M5e
 O2RYQ3T6QPNVQT0dnOEJw5cjypLfDQYUuCCCn1qH6KEdylKQSQZj9Ehjw13uBGnbXbuJ
 PG2bkBPp+kYFaIW6e0fE5gimltDiVO4Oe2ClEQXhnrhy2YTDdR6nD3MuMyauS/NEkLbf
 qjQpZyQka1E5msUt96SoKiPXzLqqxd+1NLh5BvKxKiffaU2eTZlDEGQEI7W4LhQJsFuU
 1R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=K8gzM//Gr6Y2At9qVAjIKTTUGxfe8BIJZGFT2I/R1m8=;
 b=JW77auFTJSmwT9tbi0PSOFGgUKsWh/1wy4o0L9hlGdgr0HC4fdx1wMP0OOTkKnQTAV
 oO8GzKamW0lSbhjK9pp+sDnjAJsHGBjmMFTNunpXsXufWT4aPEzXxG2JQy0ZVn5kvN0X
 rWbfO2G8ng7CyBya5FZUHlnzpxJBCeYP61fEp5FSitkg5nMS7u/Tc19RY5sgaeIJqnGH
 WqnnVjtN++F4ZhlxA0DNsUO5OVkXKqFX8trxCMDBThqA7aEhDhjkpYANjzC+AMhZWlKt
 mBLKAsi0vw+0zux7UG25RQYi6nWwrCbYctFFKOw1m0mbZeQwpBKfdJNzMHGQD+HzsQ3T
 Dn5w==
X-Gm-Message-State: ACgBeo1o11RnvDhjgFD/AH63/TUfv5N/o7h8kAY5jg0X07XgaY708zkR
 DrDxTlV3i0jpTPQfVrvfDre5lzl/NyKHEA==
X-Google-Smtp-Source: AA6agR7BiuoD1hggDnMd/yJZh4A/gigCIeqEchyYOGkHq8/MXa3dueWcm0GLH41otaHnSi0dubrTTg==
X-Received: by 2002:a05:6402:f21:b0:446:19c5:59ea with SMTP id
 i33-20020a0564020f2100b0044619c559eamr43865315eda.371.1662381160608; 
 Mon, 05 Sep 2022 05:32:40 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:40 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 07/12] drm/amdgpu: move entity selection and job init earlier
 during CS
Date: Mon,  5 Sep 2022 14:32:27 +0200
Message-Id: <20220905123232.2809-7-christian.koenig@amd.com>
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

Initialize the entity for the CS and scheduler job much earlier.

v2: fix job initialisation order and use correct scheduler instance

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 54 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  5 +++
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 05df1727e348..72147032bda9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -68,6 +68,25 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
 			   struct drm_amdgpu_cs_chunk_ib *chunk_ib,
 			   unsigned int *num_ibs)
 {
+	struct drm_sched_entity *entity;
+	int r;
+
+	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
+				  chunk_ib->ip_instance,
+				  chunk_ib->ring, &entity);
+	if (r)
+		return r;
+
+	/* Abort if there is no run queue associated with this entity.
+	 * Possibly because of disabled HW IP*/
+	if (entity->rq == NULL)
+		return -EINVAL;
+
+	/* Currently we don't support submitting to multiple entities */
+	if (p->entity && p->entity != entity)
+		return -EINVAL;
+
+	p->entity = entity;
 	++(*num_ibs);
 	return 0;
 }
@@ -250,6 +269,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	if (ret)
 		goto free_all_kdata;
 
+	ret = drm_sched_job_init(&p->job->base, p->entity, &fpriv->vm);
+	if (ret)
+		goto free_all_kdata;
+
 	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
 		ret = -ECANCELED;
 		goto free_all_kdata;
@@ -286,32 +309,11 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 {
 	struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_ring *ring = amdgpu_job_ring(p->job);
 	struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
 	struct amdgpu_vm *vm = &fpriv->vm;
-	struct drm_sched_entity *entity;
-	struct amdgpu_ring *ring;
 	int r;
 
-	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
-				  chunk_ib->ip_instance,
-				  chunk_ib->ring, &entity);
-	if (r)
-		return r;
-
-	/*
-	 * Abort if there is no run queue associated with this entity.
-	 * Possibly because of disabled HW IP.
-	 */
-	if (entity->rq == NULL)
-		return -EINVAL;
-
-	/* Currently we don't support submitting to multiple entities */
-	if (p->entity && p->entity != entity)
-		return -EINVAL;
-
-	p->entity = entity;
-
-	ring = to_amdgpu_ring(entity->rq->sched);
 	/* MM engine doesn't support user fences */
 	if (p->job->uf_addr && ring->funcs->no_user_fence)
 		return -EINVAL;
@@ -982,8 +984,8 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
 
 static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
 	struct amdgpu_job *job = p->job;
+	struct amdgpu_ring *ring = amdgpu_job_ring(job);
 	unsigned int i;
 	int r;
 
@@ -1171,10 +1173,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	job = p->job;
 	p->job = NULL;
 
-	r = drm_sched_job_init(&job->base, p->entity, &fpriv->vm);
-	if (r)
-		goto error_unlock;
-
 	drm_sched_job_arm(&job->base);
 
 	/* No memory allocation is allowed while holding the notifier lock.
@@ -1231,8 +1229,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 error_abort:
 	drm_sched_job_cleanup(&job->base);
 	mutex_unlock(&p->adev->notifier_lock);
-
-error_unlock:
 	amdgpu_job_free(job);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2a1961bf1194..866d35bbe073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -72,6 +72,11 @@ struct amdgpu_job {
 	struct amdgpu_ib	ibs[];
 };
 
+static inline struct amdgpu_ring *amdgpu_job_ring(struct amdgpu_job *job)
+{
+	return to_amdgpu_ring(job->base.entity->rq->sched);
+}
+
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 		     struct amdgpu_job **job, struct amdgpu_vm *vm);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
-- 
2.25.1

