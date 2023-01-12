Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2740C54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 13:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F3D10E8EF;
	Thu, 12 Jan 2023 13:48:21 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE2110E8EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 13:48:18 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 z8-20020a05600c220800b003d33b0bda11so4120876wml.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RGQsrm1IJJWRkmth32s3b5ebf1blQsYL76Jhp0hncXE=;
 b=mrFdv6TAaeCM3aFaFz1N7WTp8qOkxUxHuSnaGbsTWQtSqdnvFC78mC5oUVH4nfNaWe
 F/wQY3m7fjjG5NKzhbgSkJue8kYLzO3LaYugN+jWrkkR4siFXCthjFbFQofEZeYtrRKN
 je3vtzfC8zP2dsZGZmBZl1LFSlJeRfDziFFDi4ybS6eWqrz3c1kifsUwYj0F9aGJhgqm
 sjpAN+E8HzMgKIFrCTEDe0VOXNRMj2hIOCNslnwmuOTYq84oQnVgNKtbCAwZBVDHnl/n
 CPN5UXDLyL2rUgc8vm2qvKxEc1Zch0kHpiOpQlfb1i94QFoYwr4qqrA9y/YVhn3ank4m
 aJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RGQsrm1IJJWRkmth32s3b5ebf1blQsYL76Jhp0hncXE=;
 b=PHn5PBahDmBw9jdpiHe3h36K2ZRXYA9B1/GIhrVM6fmfrRPieCfH9AJO0PgWNZ/Z36
 e0n1kVD4dJnU6m95rrXxs/br53Vg6UZzIe/5sWLO0XVmbyvUULHHz96ziUnHP9d2rK8C
 km3vfhmjKCRdj+EZgTJH7+h+gkExeY+uEUBVaRDac/nklcVRNoMSYYD7bK9ib6N0RxMY
 dj8uUDSAOp+6GrGrso6ygx4q8Y0x5okI1kP447oLH5gIWptjPMFCHcVUkP0ULwHHqYvM
 PCtBF9pIAKxCgL+L6GUi8CHcpS2/suw7+D4lw+eQIQ/UYL7A22dCvQKUSeUpXNT8jfPJ
 xgog==
X-Gm-Message-State: AFqh2kpexY1ts51edyw8L5MAHE09QG5nwz5Wp5NABEgd6jjbgciRo/dJ
 VsoWbTNrNIidsfuYftI74Xk=
X-Google-Smtp-Source: AMrXdXsTX6vsZQ7Fr26xXPRhxwarqKz1XSYw51S7iWmujTUcGOH2zpO+l/5FrEGPqof2b4RfCy5Xew==
X-Received: by 2002:a05:600c:1f18:b0:3cf:5583:8b3f with SMTP id
 bd24-20020a05600c1f1800b003cf55838b3fmr53901971wmb.20.1673531296925; 
 Thu, 12 Jan 2023 05:48:16 -0800 (PST)
Received: from EliteBook.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 l14-20020a05600c1d0e00b003da105437besm4140963wms.29.2023.01.12.05.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 05:48:16 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thong.thai@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix amdgpu_job_free_resources
Date: Thu, 12 Jan 2023 14:48:11 +0100
Message-Id: <20230112134811.495086-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

It can be that neither fence were initialized when we run out of UVD
streams for example.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 9e549923622b..28929c6219a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -161,8 +161,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	struct dma_fence *f;
 	unsigned i;
 
-	/* use sched fence if available */
-	f = job->base.s_fence ? &job->base.s_fence->finished :  &job->hw_fence;
+	/* Check if any fences where initialized */
+	if (job->base.s_fence && job->base.s_fence->finished->ops)
+		f = &job->base.s_fence->finished;
+	else if (job->hw_fence.ops)
+		f = &job->hw_fence;
+	else
+		f = NULL;
+
 	for (i = 0; i < job->num_ibs; ++i)
 		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
 }
-- 
2.25.1

