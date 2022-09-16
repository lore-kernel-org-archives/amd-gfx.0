Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD5CC54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF0710ECFD;
	Fri, 16 Sep 2022 09:09:08 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB87910ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:54 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id e16so34948885wrx.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=G1JVBDiFQLTFkxlKlGBHhre+ozNuKBoovs5ip/V3yjg=;
 b=R/PSbqeg4Cr/W+miQS/03zI0uJXN8Ilyli2PKmHOyFdoUoIAwBHIlDA7X29VWcz/QB
 /8PZxK76kDkm5fSdbltsBGZaI9Fyeq37WI6nKdzt6/LlnWEtlrtjE2REs9gHNks/tSxx
 JHKWMbjvFBFWWuOIVLt1DVYGrh3urE4Glwgeheb0bgPK+XX42p0e/ITfi/EYyJFsogmz
 EWSH/tdWCgD+7ET4Om/+hKf/gSEMj0OhYQWNrqVkn1dxfOzkyc+kfMyoJG6s/M5f2/Og
 /pCp2ea/7GugtAEYPomMbx8spz2PSTERP6fp17pXXC5+O0JhFLOSKfY8/x+ZZUpTt6rP
 GgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=G1JVBDiFQLTFkxlKlGBHhre+ozNuKBoovs5ip/V3yjg=;
 b=iKhoAkGUwLbvse+7dqKmRtjeyqFbcpl3v5QvlBbAWHGefWyoBTwalSLhX7y3Vfzpsb
 qKKeTgwFw1A/dxerx8x8qQRbYXm6WgkwvVYTTvKcELE0sbg9vr0puK9IXdg6OG9/hnf6
 mbKyFUiIRnvTeo8wcw6GYN2SmgzJGJ2uZYqxsr2bBDLz1rTfhvCvp2YW8xYa1vsBFIQf
 dpqifilXKYhKSbOaXs+HhmWZDJnAzpdvjCFP4WDMM5LuU3DDrJaIlQX0ZoFO3NBlFmwD
 0ngM9tSKAV7jYis61RZc+8ciheHrkCi1nxALbaLIsGi+3kuAxuykCJ1qtdeEGo1x/saU
 j2lg==
X-Gm-Message-State: ACrzQf2+i9ZHO09ku3jhuwQ0+j18gblpvd7zP+DK14yuxkCHdsi86wTD
 D0xN7XH2NZZvwTa1NolR40uAJbn+TshRMQ==
X-Google-Smtp-Source: AMsMyM7X3q22j5d3GJG91anRdTosFvNvyo2A7eLhHdk6SJuX5TQMQaKvfoLedtyfEiF0ry91bG0qbg==
X-Received: by 2002:a5d:64c3:0:b0:226:de7e:d3eb with SMTP id
 f3-20020a5d64c3000000b00226de7ed3ebmr2109164wri.95.1663319333221; 
 Fri, 16 Sep 2022 02:08:53 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 4/8] drm/amdgpu: move entity selection and job init earlier
 during CS
Date: Fri, 16 Sep 2022 11:08:41 +0200
Message-Id: <20220916090845.3336-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916090845.3336-1-christian.koenig@amd.com>
References: <20220916090845.3336-1-christian.koenig@amd.com>
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
Cc: bas@basnieuwenhuizen.nl,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 timur.kristof@gmail.com
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
index 265ed2118a80..58088c663125 100644
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
 	if (p->uf_entry.tv.bo && ring->funcs->no_user_fence)
 		return -EINVAL;
@@ -978,8 +980,8 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
 
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

