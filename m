Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B4ECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155DE10E369;
	Mon,  5 Sep 2022 12:32:45 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353E110E369
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:38 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id 29so6097898edv.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=8e8doljTnPyIRj/2PESGhuo6S+B61WP1an/U5wv1D2Y=;
 b=VPZBMMl/9E7m+Wei8U4NYvHjlIWZEB6vd1+ZC8rE5zwdoMPRL6YBf7UOePysbB724+
 HWZl1MzqYjy1nlQOWyerqays27/jfu+tE/wOBhIAQOwWsMQp1Hvxa4vgfsxxYD45pBnR
 M1t+jeo7nI2gYDK/lyAhVNZFwh6eCziAMsmt6c49/R+PiUIU7wM0aVfY1zD8fUl6I2Ds
 8isXO71JTh2FyNFArLypFIUiJuPisxhigOe3NbF6hUdw0u3XVLWJcd6a431wTq/VoSDg
 mrV2WGVELkO8QJV3WWVuf/AoRQaBMGceJF+gLEVGOxYB8S/1WpW/aPRbvh1xybrpQ5jv
 348Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=8e8doljTnPyIRj/2PESGhuo6S+B61WP1an/U5wv1D2Y=;
 b=IG3D8XYzk1hrJ+uGf5zoVP73OceSItZCVfD4PglZeRsWs3zIxUPu/soDu4raqNdtRK
 owVmn4vXJpRwY09MXH6kt2qIfRN5snZKIf3g+5E8x7SfulDRNEWeWvRoIOBNrG+E9fpC
 RfLtmz5Gv33zY7X8y+iak0XOUfFcZbSpDgZlZ0snDX0Ki5mYmv7BBzXPR1E6or7+yj9Q
 7exF+n3gTe13/+VaD8bf5BJ8HKxLyfyDFLsZ9mvbT1/WuPrpS4U7AZFKHRPsTasvy2tv
 0m4YDehECCZDuu59zrKAVkhp4H7bpU6KuN93ccgt4BrmjiDYgcKljIxXY14Bl5yPWRPx
 omLQ==
X-Gm-Message-State: ACgBeo2z10W12FNg9txSi2q+Fx1w6Uwm8nmHuqMCjpcKgQn3AG4N7aFc
 THknUOi6tK9J8pkgW4fzEYnFiokueJkF5w==
X-Google-Smtp-Source: AA6agR7LtUXBXLkH5hv8UkIFOOZb2AHPWQ6ETqr72PQYVsmjAIJqs4b+7p+q25hslRUWV97ywQbtRg==
X-Received: by 2002:a05:6402:4c9:b0:44d:9921:cb6c with SMTP id
 n9-20020a05640204c900b0044d9921cb6cmr8010238edw.176.1662381156540; 
 Mon, 05 Sep 2022 05:32:36 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 03/12] drm/amdgpu: move setting the job resources
Date: Mon,  5 Sep 2022 14:32:23 +0200
Message-Id: <20220905123232.2809-3-christian.koenig@amd.com>
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
index 8f51adf3b329..37dc5ee4153d 100644
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

