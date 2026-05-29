Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D95FCD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D10010FDC9;
	Fri, 29 May 2026 11:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YB560B71";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFF610FDC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so146336785e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054839; x=1780659639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iBxEfAs2fActUgm1QLS/igexKg1K59YHb56AEtjQ8tA=;
 b=YB560B71HwAXG2G4iuMGPTh38VxfjbZsGNukBp2NHIYyV/15xPTd6Bl8AR0STx7afL
 CK6OSDn7fzFr1Ef0rBbauj/y0Ascje/3Mcayc+QXlraS8n9T3uFRMOBCpVAcVDop+xwD
 Qkj5KxX6PpsS2FbgC9lR+K8QPBU3aXsuaagig2T7ySXosenBG9yjfYpThQnFK8xlfmlT
 KmtcEAdtkdnE5aFTm6bW1e8O+BERfB4EeELJS+PoZQznm597VswkZUudyAm3xJp0Pv6b
 B0pkVdQSGwD3PV3P9xGZb1x5eeo6l0KQEWTNgCHocDHoC6W5zoLmrarG1MesH1bQhw+N
 MfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054839; x=1780659639;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBxEfAs2fActUgm1QLS/igexKg1K59YHb56AEtjQ8tA=;
 b=nT7dPL9AV/6hPFUa+ahyTPi7rXN6Sff5kxKCV9+LnI1hMwjtBEC1eKfRibKCo+vXzR
 wd8KehyyGvwVsfncax2F5qzuLXTki94BrhKDb+i28zq4AzE/zciPfryL8CeP52FFPdnJ
 CB0wkCquDdsv0cs0+ufRXlraK8xizGPNVPE4kSfzuEXQxGHgbn5sWo4YcvoDaJV5h6UJ
 tnv3g7T3pk5IvBEldxx2Xi81IoT/AkrlMoqqqkooo1lvmqk8xh2bXKYQu+mXgNi5nvug
 hgSrNDg2NwvbbRxZ3uoGjpHmOWnfR880hI1D+ZQ9KUMWLtmcmcoy6WHSLYddIWnqb9y8
 L3/A==
X-Gm-Message-State: AOJu0YxNm2FqqDXZ5myC/l07dp/OoCDlEFBIX4tCr5lGg8u3fLe1dVt0
 B4J8aDrOIWC1jo5jcfiFm04qtZxGPWvWUl96AaDAJXzNZ+X8SysS03N4
X-Gm-Gg: Acq92OH4Ywue94VRJl38E1NLbkkIHFhOk1U3gLs3HONEKFjlqC3mBmaqBwey1OJ4Q6q
 ZidRwJmC3gutngAgCirSQCXM1zHZiAClqg0qVVLbKm1RMy/Sa4GgCSa69mFXABEv636aV0HjGPk
 /cJ2hNkcy5/70DOWj3RrW1jTaJKCUZpb4MPmbHBOWmkasrasqrryydDXtGXuyrcqQPqN0mhkE6b
 zp1RJSHuYO4RYOX1I/2uf3GYtnMrcQOqy2DIFtzhPdGUY7u+F2wQUUln+FzXxuv0CAAIHuMon1g
 5fyxJvUiAg+O5Qv9TNgg4XoFxHm77q31bBJTOufu/BnWhaVkCJ1F7ZBduv/lf1nTUXSZe1dOnvu
 CqChStf4O9bKsJwmSJBZ4D8qEJ/rn5+aGcmP3Yp9k47wsupuDi5htEffdh2RJTo/73LijT1prlS
 5uJDrd71MFRUr/SeIEIbp9WH1XdAxfGMMZ4xlXLjkHDSY=
X-Received: by 2002:a05:600c:8508:b0:490:3fdd:d353 with SMTP id
 5b1f17b1804b1-4909c09e27bmr42937315e9.8.1780054839292; 
 Fri, 29 May 2026 04:40:39 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:38 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/13] drm/amdgpu: use correct gfp_t for job allocation
Date: Fri, 29 May 2026 13:24:07 +0200
Message-ID: <20260529114031.3714-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For job allocation in GPU reset and page fault handling we must use
GFP_ATOMIC to guarantee that we don't cycle back and depend on a
dma_fence submission for the memory allocation.

Co-developed by Claude Sonnet 4.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 ++
 6 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 44751d71b741..c425f960361c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -696,7 +696,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 		goto err;
 	}
 
-	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, 0, &job);
+	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, 0, GFP_KERNEL,
+			       &job);
 	if (ret)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fdf01d824d66..3ed2cb9dfa38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -275,7 +275,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	for (i = 0; i < p->gang_size; ++i) {
 		ret = amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
 				       num_ibs[i], p->filp->client_id,
-				       &p->jobs[i]);
+				       GFP_KERNEL, &p->jobs[i]);
 		if (ret)
 			goto free_all_kdata;
 		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 60e4c3985029..83a802cf5837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -416,6 +416,17 @@ void amdgpu_ib_pool_fini(struct amdgpu_device *adev)
 	adev->ib_pool_ready = false;
 }
 
+/**
+ * amdgpu_ib_pool_gfp_flags - Returns the gfp flags to use for each pool
+ * @adev: amdgpu device pointer
+ * @type: the IB pool type
+ */
+gfp_t amdgpu_ib_pool_gfp_flags(struct amdgpu_device *adev,
+			       enum amdgpu_ib_pool_type type)
+{
+	return adev->ib_pools[type].gfp_flags;
+}
+
 /**
  * amdgpu_ib_ring_tests - test IBs on the rings
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 71c1ba735a6b..b4b424d84479 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -188,7 +188,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, u64 drm_client_id,
-		     struct amdgpu_job **job)
+		     gfp_t gfp_flags, struct amdgpu_job **job)
 {
 	struct amdgpu_fence *af;
 	int r;
@@ -196,18 +196,18 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (num_ibs == 0)
 		return -EINVAL;
 
-	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
+	*job = kzalloc(struct_size(*job, ibs, num_ibs), gfp_flags);
 	if (!*job)
 		return -ENOMEM;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence), gfp_flags);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_job;
 	}
 	(*job)->hw_fence = af;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence), gfp_flags);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_fence;
@@ -246,6 +246,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 	int r;
 
 	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, k_job_id,
+			     amdgpu_ib_pool_gfp_flags(adev, pool_type),
 			     job);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 6b7cf594714c..44fe40f9e8df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -113,7 +113,7 @@ static inline struct amdgpu_ring *amdgpu_job_ring(struct amdgpu_job *job)
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, u64 drm_client_id,
-		     struct amdgpu_job **job);
+		     gfp_t gfp_flags, struct amdgpu_job **job);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 1a063a0a4280..4bf9734acc18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -582,6 +582,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		       struct dma_fence **f);
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
+gfp_t amdgpu_ib_pool_gfp_flags(struct amdgpu_device *adev,
+			       enum amdgpu_ib_pool_type type);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
 void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
-- 
2.43.0

