Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C01C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1CC10EF2C;
	Thu,  3 Mar 2022 08:23:20 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B005A10EF24
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:18 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so8870779ejc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/tLezWwr44srboG5Dvc8GRjXfm6SQUJlMXAycGoy4n4=;
 b=Z+QMg+aQYvLyhOVzNUP0ZUKYcOdtznHXKufwuRCOavbr2GjkNTWVR7iEhQLZGHtan2
 GeuGp6gaSEon49LyH/FCli98PdEydResRwnfDmjn51ZEoZUNyslfAAZMk5WTAq9a9DFK
 /ONhpmI2cqzT7dh7m6wQHjSddVrGzu5b0zAhXscu2pW5oCfg42VUH3ZSddSeYUdBME+2
 /L7d0aMR37AZdRlnHbpVO/YMztn7qo0yg92Pz8fnMYnVx+ZTwuxdgy+Tueecumy/ZhdM
 h76AR2087WHF2hTFFVnYHMs2QIIBkYmkZP4nxOevKA23g+WalWP61h7ffNfDw3/uQ5O0
 GE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/tLezWwr44srboG5Dvc8GRjXfm6SQUJlMXAycGoy4n4=;
 b=wKgE/kFdqqlXgjbzmbCRH5EohEleQ8/2hlnuimAsl8z+WqTzY5m7Qx5/VbvW8TRSA5
 nKSdlbFuXPkx+ElG7KGAWeOAT8uHrZFw6xXQRP12Tks0R2sb8MoNzo2sTVptv6W5SNK+
 Pc57AXoMgHub7ce0FEyPcm12C8BstYVlZ8ddL7YIJiO9xgwJsLUVm+4eC6TI1eoTwUMx
 Bg6XZ+3klMuEn/tiaO8wu5cZE6WBOuZWZc/kmqJNwRdbgEZQ6HysVKe222Xrj2Gh6i4D
 ADa8w3XaRck8XqxHyYtQVxBLNxsUBwsHxaizLjjbJ2fP1e7Thlj6mds0jUDz7Y7vpvxi
 Q2HA==
X-Gm-Message-State: AOAM530h6rWiOj6zUB6ULEmY5jZEUUt3R6EqlbwDAyKclLP/qDSpPPN1
 mUPabwHKR4r65MYJefT+vqahCp4Q06Nt1Q==
X-Google-Smtp-Source: ABdhPJz4KDNon8APLS4GOvU9uL2ryDzZcLB1tuEM+Vax0eatSTC9CY2nRXyiv5AORfcjGkYoY7YoOg==
X-Received: by 2002:a17:906:c0c:b0:6ce:e59c:c38a with SMTP id
 s12-20020a1709060c0c00b006cee59cc38amr25804861ejf.483.1646295797190; 
 Thu, 03 Mar 2022 00:23:17 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:16 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 06/10] drm/amdgpu: properly imbed the IBs into the job
Date: Thu,  3 Mar 2022 09:23:04 +0100
Message-Id: <20220303082308.38217-7-christian.koenig@amd.com>
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

We now have standard macros for that.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 6 ++++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 38c9fd7b7ad4..e4ca62225996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -78,14 +78,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 		     struct amdgpu_job **job, struct amdgpu_vm *vm)
 {
-	size_t size = sizeof(struct amdgpu_job);
-
 	if (num_ibs == 0)
 		return -EINVAL;
 
-	size += sizeof(struct amdgpu_ib) * num_ibs;
-
-	*job = kzalloc(size, GFP_KERNEL);
+	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
 	if (!*job)
 		return -ENOMEM;
 
@@ -95,7 +91,6 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 	 */
 	(*job)->base.sched = &adev->rings[0]->sched;
 	(*job)->vm = vm;
-	(*job)->ibs = (void *)&(*job)[1];
 	(*job)->num_ibs = num_ibs;
 
 	amdgpu_sync_create(&(*job)->sync);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 6d704772ff42..d599c0540b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -25,6 +25,7 @@
 
 #include <drm/gpu_scheduler.h>
 #include "amdgpu_sync.h"
+#include "amdgpu_ring.h"
 
 /* bit set means command submit involves a preamble IB */
 #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
@@ -48,12 +49,10 @@ struct amdgpu_job {
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	sync;
 	struct amdgpu_sync	sched_sync;
-	struct amdgpu_ib	*ibs;
 	struct dma_fence	hw_fence;
 	struct dma_fence	*external_hw_fence;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
-	uint32_t		num_ibs;
 	bool                    vm_needs_flush;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
@@ -69,6 +68,9 @@ struct amdgpu_job {
 
 	/* job_run_counter >= 1 means a resubmit job */
 	uint32_t		job_run_counter;
+
+	uint32_t		num_ibs;
+	struct amdgpu_ib	ibs[];
 };
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
-- 
2.25.1

