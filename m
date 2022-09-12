Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33624ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F40610E439;
	Mon, 12 Sep 2022 12:37:00 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06B210E466
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:36:47 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id v16so19802177ejr.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=xeBHw6amGR199TcbpZeb5RwHyANX/YZCo2me6gaH4XU=;
 b=JbKp2MKpWD6wziBIfDsXDLCSsHz9NwE819Lne8cZmhlrEFNdp6JhS06EtHr+cZBOAB
 /CWtZtDzALeuw71xT8nF4fOp/yJKTLaNoSkuGM82bZItJyfcUF/Lg9EeADHxtHYZi9/S
 zwPfH/zJ1r6X3/8zSOWte68nEliH1IhcKDhu5TmEP1VmQA/0kga5I7nDADGdBVMJTR7p
 gADzSO0cEUWDlcHc9rq8LMprPikqkoNMGxiTSvcVM/7TXWoWGvfHVLL3n3BzKOBuV5iq
 QsJY8lwdaQVlDMyXo/tz4hLVTdy/4ZGuxK+biay3q+lKsYuZZm4xXX2kAVsLQsyI0YNf
 nKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=xeBHw6amGR199TcbpZeb5RwHyANX/YZCo2me6gaH4XU=;
 b=bwJITe1AoUa5gBAWOULNOOespOXw/pwU7ENKdLdGTj1JEiO6EdxY7foK5LMoC7Oqc+
 OOx7Z3uSxs26CiY83hzDsXzbru4dkiaDVvjefknHoIRpjTIrv/Z8BsL6ry4rCbVB7PIc
 B02V6omBQz8QyhkgfwEcBYH7mWckKI0FG1zAtzCe5X+A05fnJ17fkErkxq3P8e4sclvl
 eilRRk3U/tuZ6bdCuuRSpr4WvlGNNFvnXOT9l179VkEMFdF9EpQubfXl3iT1jP1eYeOX
 4a2YWUOczUj9UbfbMiqdGmvdVcaWlCe5QTvJvm2CBRW6nnCv5eNjdbXt+7v6CS+EazUJ
 TWXw==
X-Gm-Message-State: ACgBeo2eO5IvL6lnerKHNkmtYdVFO5j0icMSpV/UaeDTmOTjPWewGYsT
 vNeTucxDcUujH1ZOOeDj+vMDoBeW0dE=
X-Google-Smtp-Source: AA6agR7EnxysznzShwp9CTNOJ9wTx9bp5JSnyXxuxMuJIKkDyfSyYoGTDO+4SGM91ubr3VxOpYS5sw==
X-Received: by 2002:a17:907:2c4b:b0:77e:2c09:4111 with SMTP id
 hf11-20020a1709072c4b00b0077e2c094111mr2465749ejc.21.1662986205714; 
 Mon, 12 Sep 2022 05:36:45 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 au6-20020a170907092600b00770c8e157ccsm4335639ejc.136.2022.09.12.05.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 05:36:45 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: move setting the job resources
Date: Mon, 12 Sep 2022 14:36:36 +0200
Message-Id: <20220912123640.20058-4-christian.koenig@amd.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move setting the job resources into amdgpu_job.c

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 ++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  2 ++
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 6f80cf2ea9ae..f7bf61d96be5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -495,9 +495,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct list_head duplicates;
-	struct amdgpu_bo *gds;
-	struct amdgpu_bo *gws;
-	struct amdgpu_bo *oa;
 	int r;
 
 	INIT_LIST_HEAD(&p->validated);
@@ -614,22 +611,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
 				     p->bytes_moved_vis);
 
-	gds = p->bo_list->gds_obj;
-	gws = p->bo_list->gws_obj;
-	oa = p->bo_list->oa_obj;
-
-	if (gds) {
-		p->job->gds_base = amdgpu_bo_gpu_offset(gds) >> PAGE_SHIFT;
-		p->job->gds_size = amdgpu_bo_size(gds) >> PAGE_SHIFT;
-	}
-	if (gws) {
-		p->job->gws_base = amdgpu_bo_gpu_offset(gws) >> PAGE_SHIFT;
-		p->job->gws_size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
-	}
-	if (oa) {
-		p->job->oa_base = amdgpu_bo_gpu_offset(oa) >> PAGE_SHIFT;
-		p->job->oa_size = amdgpu_bo_size(oa) >> PAGE_SHIFT;
-	}
+	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
+				 p->bo_list->gws_obj, p->bo_list->oa_obj);
 
 	if (!r && p->uf_entry.tv.bo) {
 		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1062b7ed74ec..877b3c22a8a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -132,6 +132,23 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 	return r;
 }
 
+void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
+			      struct amdgpu_bo *gws, struct amdgpu_bo *oa)
+{
+	if (gds) {
+		job->gds_base = amdgpu_bo_gpu_offset(gds) >> PAGE_SHIFT;
+		job->gds_size = amdgpu_bo_size(gds) >> PAGE_SHIFT;
+	}
+	if (gws) {
+		job->gws_base = amdgpu_bo_gpu_offset(gws) >> PAGE_SHIFT;
+		job->gws_size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
+	}
+	if (oa) {
+		job->oa_base = amdgpu_bo_gpu_offset(oa) >> PAGE_SHIFT;
+		job->oa_size = amdgpu_bo_size(oa) >> PAGE_SHIFT;
+	}
+}
+
 void amdgpu_job_free_resources(struct amdgpu_job *job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index babc0af751c2..2a1961bf1194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -76,6 +76,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 		     struct amdgpu_job **job, struct amdgpu_vm *vm);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 		enum amdgpu_ib_pool_type pool, struct amdgpu_job **job);
+void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
+			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
 void amdgpu_job_free(struct amdgpu_job *job);
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
-- 
2.25.1

