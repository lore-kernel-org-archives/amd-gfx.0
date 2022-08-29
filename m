Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFC0ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0E610F26C;
	Mon, 29 Aug 2022 13:18:58 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E013510F1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:32 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id m1so10096755edb.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=6ely/zyCRI//8bh/OU07uSxwGd55BtVTSOo2hQ2u1fg=;
 b=X5aRHF/J25MVMni9R0gYMBHa39oW5E6SlPfu8SLZBYp4U1CwoFDG1m510Y3wOcuivo
 j7HeNbuQ32jwSOQ6mJUV8efgv6cO/1wOGdUHt77trnoO7B50TLkQGlpMP8HQ1vBzOHSE
 JDYqLC7kXmHRYgF/ZDVoT0zgfeHIcKDTzB9h6vXcKMOu0McftlxRVmZEiIyZVwifi5//
 48k+/5PqShS9hYDLm5Wl2y9QtsWLcdQxfZ+lTxlP4iG+4r+Tr/Nwhs22m9yPLkz2cXDx
 hM7ahvVnZ/Sl5A2jVwzPu11FwLN+ZTtl0cOOtE0otEXmQkQ6y1BRjHG1KpnXkCopRMWj
 x49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=6ely/zyCRI//8bh/OU07uSxwGd55BtVTSOo2hQ2u1fg=;
 b=QUKsOT7ZjEsB8sh8vrcdMAD6RBVyLoGaNwBxFa1mqVjnXzwamhWFGvFK3zf7FJ1zCc
 GSJQfrkKuTAqrIceY1ague/JeYSVfhDZVQ4RsrON3z91kD3JraPkOiKEtol6dYojv5EI
 xcrvIwYHxitpYHUzNOhLVX+aLCNvEFAUhfoASL0GtD/cWRi35rR+3En6zIVXv+BBapSV
 RQKUO9bRd/muxbnFEajyY6BB5wLQ6gsKHkuzyaAZ7eGhHYHNVznjLwZ+FFC5mgMoDGpH
 YX91QlPkMMjyCKSf0L9FihjxkGl+ayFjlWsnQ0x7ApRgoK5fLeIC7WgRGBpibbyAal/i
 79VQ==
X-Gm-Message-State: ACgBeo3WuX+yJFrbmbAq22l1j69NuJ/GAhT8neHdM4nmY3PsWvxxRQGP
 hkXiCmJRahpDhLf/hqfEKgk=
X-Google-Smtp-Source: AA6agR7uvk2ImP3G19QiwPeAHOqvWfmUPOzKR6N6naObKOpiLn23RW9QANZA8dpzyMaS9+1iqtJD8w==
X-Received: by 2002:a05:6402:5193:b0:43e:1d52:fd70 with SMTP id
 q19-20020a056402519300b0043e1d52fd70mr16472621edd.150.1661779111414; 
 Mon, 29 Aug 2022 06:18:31 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:30 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] drm/amdgpu: move setting the job resources
Date: Mon, 29 Aug 2022 15:18:16 +0200
Message-Id: <20220829131821.2049-7-christian.koenig@amd.com>
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
index 73845eea66b4..9821299dfb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -828,9 +828,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct list_head duplicates;
-	struct amdgpu_bo *gds;
-	struct amdgpu_bo *gws;
-	struct amdgpu_bo *oa;
 	int r;
 
 	INIT_LIST_HEAD(&p->validated);
@@ -947,22 +944,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
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
 
 	if (p->uf_entry.tv.bo) {
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
index 6183b5421e8d..866d35bbe073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -81,6 +81,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
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

