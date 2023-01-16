Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DDCC46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 20:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E3110E4AB;
	Mon, 16 Jan 2023 20:12:23 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCFD10E04D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 20:12:22 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id az20so51459477ejc.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 12:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F1Kq4zxrPHabG7D+80nrA4guYMJ0Z+ed3fgZG/W2ddY=;
 b=i11g1UISGnVV1bTglALHDxxGTOV35AUoL9jCcTx/8Da3D9BIFtSDisiQP0EDiaWZ3n
 FuNQBN/E1TLEtojgQ05fnGfMAUME3e9JwvuPIssDfuL+NTFjYVqcJTU2Lfr913mxHLPw
 fHcNFuN/GVX67Xt/1h8BQYgA0D7inj/aPndMKb6TgrAdtLuALH1PD5nY37lsJV6GhEfB
 zTFWUIkXt5Q4B+/QM+BaQlsUYC4bqO+pSdD+72YWYahlLXZz75oA42xwnoCJPC1tv2K0
 8ZPLNU8TwV5+a4jeVpyvpLyCVhz3iFkF06H209kVnSxbyajynyMj6KvJ7h8iFya7ZNbc
 vmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1Kq4zxrPHabG7D+80nrA4guYMJ0Z+ed3fgZG/W2ddY=;
 b=YlgvNJP1X8DqmBIJwqfvXAfqcnDEEHJpb6+AsNkmtFFGtfeMlVoaGYXJ6VreXOv+Pa
 dmBw4Z4b4v21RSkWXqT1plI6x9uG+lDUUWpVJpcr7WqdSu7mf8Plac6RuyCs+A1er+co
 LPiVuq7nu10nPOjPWyM55eYYJewbu7cHr5A9qXFtTguAl+rXr6WYLrCvrFfNIGNW3IP6
 LH7RDH7FtyRW89V9eFUYx5X6kdin5ML0z0oacHcEnq7uK10q0ORXNqd9mjy3opY7Eijo
 hCRgPRp0jjOlWWvVnnRUqrj36pfYZevM+aqiwdhnf61KUS6UEDEseEMRFS/CBICvGCfI
 2dtw==
X-Gm-Message-State: AFqh2kpWJcg9eYq5ZiJ56JL7FEADEmd4Ck+c9EmfxdmgJEmVSs/9pLtG
 tmuKYIb+Uy/IeqjpOSIHByuMv/ML5pM=
X-Google-Smtp-Source: AMrXdXuuLnnExH3skVfQ8CYe8f+699oe/7fB+fCcbnfg8fiybIaGvJ68F6B6itTslIkJYgIWSQ4AvA==
X-Received: by 2002:a17:907:c58c:b0:837:3ed3:9c2b with SMTP id
 tr12-20020a170907c58c00b008373ed39c2bmr314102ejc.5.1673899940771; 
 Mon, 16 Jan 2023 12:12:20 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a1709067c4300b007c0a7286ac8sm12238492ejp.69.2023.01.16.12.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jan 2023 12:12:20 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thong.thai@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu_job_free_resources v2
Date: Mon, 16 Jan 2023 21:12:17 +0100
Message-Id: <20230116201218.5113-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It can be that neither fence were initialized when we run out of UVD
streams for example.

v2: fix typo breaking compile

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index f4a3122352de..6b73c074aa25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -154,8 +154,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	struct dma_fence *f;
 	unsigned i;
 
-	/* use sched fence if available */
-	f = job->base.s_fence ? &job->base.s_fence->finished :  &job->hw_fence;
+	/* Check if any fences where initialized */
+	if (job->base.s_fence && job->base.s_fence->finished.ops)
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
2.34.1

