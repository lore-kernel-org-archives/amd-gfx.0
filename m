Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C68C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B37810EF2F;
	Thu,  3 Mar 2022 08:23:21 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AE510EF24
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:19 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id x5so5540636edd.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4mPDTKJe3BYtOLbU3oY4479UkVEWV/wl+DnCd1Z6H64=;
 b=a3wM60CxvFGE0N3c8Jrej60Yr4yK7Gd/hUYyDjzhw/Wbo2g/xNQnKhOBgo/oIiwxsI
 ibgy292FCgQ7noan9K5+dRquj/B7Q/QnwIOYQMed9NARpPVhE3kFgy3c/jfcbNsOL9QY
 3VRGxWbsqTP9vUgg83JBymOyycwgspJPb1AdOwZMzwgPskfabGF6iZALzrhayijmPt1X
 NfRCe3z0cPQmBYhSnqz9zM8+P09YcxMsClepep4Z6D4lWIsroRFGWNArzOAQ3AX//lvW
 /QazR8x6ARA8g19Sal4pUTwSR/xFFQlD7mpcI2np5hZOEzTh4RTFRWkNF2TU8eU+FWAO
 6HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4mPDTKJe3BYtOLbU3oY4479UkVEWV/wl+DnCd1Z6H64=;
 b=Df/UL/3y2lD7N3zeTnUNmPvlxfyR3b/yaqJcjjuuBOCRO4V8YCop6GpsvDmWuqDfNx
 TUjRuc6TZCD8qh1dm4H7et4NEA8UhhzQT8NV9Z8koUgj3HzkLkUuWJepjnSVE29/iw1a
 pBBoy1Ek1xMyLlwo6w+cY/bMsE45q2XcmbeHRqeXGfKN/GtfhQC9f2pvATPKmmSyaR8A
 4QkqGjb9Shu0LEjk3x/X4fQDYDrbFzhF3oZD8iRS+IfRi9jr7IfapjYFhLZE0Yd6leXS
 M+NLOT3kjq1CoZ0pXBUPAc/4FSlf2abITq9kRwSuinz8lHH4TKT0gUaAUwYivlrdJGwr
 FRaQ==
X-Gm-Message-State: AOAM532hXF5xIA2bh35jRUzdWUfnnDSnQGIOHFoa33lKreFTLdXsblB4
 CDCtOl6pBf5kaSC09JBQg/UDxHQzMQwvNw==
X-Google-Smtp-Source: ABdhPJw//rQIoIt2g1h5eGcs0nqXfMhE741k6pzKGK3tmEKnA3ZwujhBBZgVgldyZ+FsoSgPDV4Z7g==
X-Received: by 2002:a05:6402:1bc7:b0:413:7273:770c with SMTP id
 ch7-20020a0564021bc700b004137273770cmr28688839edb.379.1646295797942; 
 Thu, 03 Mar 2022 00:23:17 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:17 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 07/10] drm/amdgpu: move setting the job resources
Date: Thu,  3 Mar 2022 09:23:05 +0100
Message-Id: <20220303082308.38217-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303082308.38217-1-christian.koenig@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
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

Move setting the job resources into amdgpu_job.c

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 ++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  2 ++
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index dd9e708fe97f..c6541f7b8f54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -825,9 +825,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct list_head duplicates;
-	struct amdgpu_bo *gds;
-	struct amdgpu_bo *gws;
-	struct amdgpu_bo *oa;
 	int r;
 
 	INIT_LIST_HEAD(&p->validated);
@@ -941,22 +938,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
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
index e4ca62225996..e07ceae36a5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -118,6 +118,23 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
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
index d599c0540b46..0bab8fe0d419 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -77,6 +77,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
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

