Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC30C54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 20:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689A410E4AE;
	Mon, 16 Jan 2023 20:12:26 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4357510E04D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 20:12:23 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id cf18so64168776ejb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 12:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HFjDO5U6/iRRr8060PjKyCg5Jlp4Qful1+ofUOZVw5o=;
 b=EoZ/HWpSZiO0j9XpxSS26PhRork7cEwqS2akggsoat+efEFDiuvYMG8pbc1qqjHLW7
 pVP2zudawNqW00H/+pBuDUslwUDUfTSqffQoSADyO+xkPrAgnQpAvVNYlB6ZvunbD0wj
 breoV78F5t/xJ4PHrSedF2TlG1OKP1OA0x8dU81xmMfeDT123QhMeB7VGAWoT51tgmLQ
 eg31O7IXAmp2wGa9UvAkgaj8mputGJpu4sCuWNxVIZNALFbBeN5yFBzOS8kCGzHlOSZU
 +978bLXIcpg9xQc7sDo0mGdcUr4psBF8V1nHulKmTWo76je1lE/UligZvPjdQ9bsla2C
 9xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFjDO5U6/iRRr8060PjKyCg5Jlp4Qful1+ofUOZVw5o=;
 b=tkL+/OzKQtf8A57pVkP/EIl89MgH3xBzz65Dgl9/n4FXIwpOmc2Mmx7QN1QRLZG3PX
 5orJMIJ5M5O/VAmV2MFjTKjY7YsIlKz6G/Lgjx9HrmQi6IzacRmrLfXkaFcCXvwtKzmf
 NQxqo6cQ96QKaufVzD5hXxFbZYb1qFzBPImfXcnhAhWmb0gYBsncZrlN1EQBB1qB/3by
 C3/F301rSME8R6GWYALpCmznFkr3CULplcg8VR7Xr3h8BBkJOtmS6XUxACO1mpPZdJJc
 R2PwWMnkfkl3Mqm9BXvOxbCIFuRn+RK7LzC4zoXOYTgGKfVHd0WHsLkX6pE01A8wgqmD
 agWw==
X-Gm-Message-State: AFqh2kouacaWNY9bbddW3q7Q6Z1IzqhmT0PzBPOSMAEdpDhZ89XAgAzh
 N8gMi6kHq0pHsEPcI5b3cE3bp6mW6os=
X-Google-Smtp-Source: AMrXdXtSGL68OSQA139X5el316KArrFyFkU/mj3pp//S0eKJW5iso2NBRqLIWSAYx99b6g13GgNMnA==
X-Received: by 2002:a17:906:fac3:b0:7c1:808e:7660 with SMTP id
 lu3-20020a170906fac300b007c1808e7660mr232853ejb.43.1673899941665; 
 Mon, 16 Jan 2023 12:12:21 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a1709067c4300b007c0a7286ac8sm12238492ejp.69.2023.01.16.12.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jan 2023 12:12:21 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thong.thai@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: simplify and cleanup amdgpu_uvd_send_msg
Date: Mon, 16 Jan 2023 21:12:18 +0100
Message-Id: <20230116201218.5113-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116201218.5113-1-christian.koenig@amd.com>
References: <20230116201218.5113-1-christian.koenig@amd.com>
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

We only need one offset and not an array of it.

We have a wait in the amdgpu_bo_kmap() code for quite a while now, so
waiting here isn't needed any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 38 +++++++------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b67a5fb2ff3e..229419c0c031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1118,30 +1118,26 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
+	uint32_t offset, data[4];
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
-	uint32_t data[4];
 	uint64_t addr;
-	long r;
-	int i;
-	unsigned offset_idx = 0;
-	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
+	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED, &job);
 	if (r)
 		return r;
 
-	if (adev->asic_type >= CHIP_VEGA10) {
-		offset_idx = 1 + ring->me;
-		offset[1] = adev->reg_offset[UVD_HWIP][0][1];
-		offset[2] = adev->reg_offset[UVD_HWIP][1][1];
-	}
+	if (adev->asic_type >= CHIP_VEGA10)
+		offset = adev->reg_offset[UVD_HWIP][ring->me][1];
+	else
+		offset = UVD_BASE_SI;
 
-	data[0] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA0, 0);
-	data[1] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA1, 0);
-	data[2] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_CMD, 0);
-	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
+	data[0] = PACKET0(offset + UVD_GPCOM_VCPU_DATA0, 0);
+	data[1] = PACKET0(offset + UVD_GPCOM_VCPU_DATA1, 0);
+	data[2] = PACKET0(offset + UVD_GPCOM_VCPU_CMD, 0);
+	data[3] = PACKET0(offset + UVD_NO_OP, 0);
 
 	ib = &job->ibs[0];
 	addr = amdgpu_bo_gpu_offset(bo);
@@ -1158,24 +1154,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	ib->length_dw = 16;
 
 	if (direct) {
-		r = dma_resv_wait_timeout(bo->tbo.base.resv,
-					  DMA_RESV_USAGE_KERNEL, false,
-					  msecs_to_jiffies(10));
-		if (r == 0)
-			r = -ETIMEDOUT;
-		if (r < 0)
-			goto err_free;
-
 		r = amdgpu_job_submit_direct(job, ring, &f);
 		if (r)
 			goto err_free;
 	} else {
-		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
-				     AMDGPU_SYNC_ALWAYS,
-				     AMDGPU_FENCE_OWNER_UNDEFINED);
-		if (r)
-			goto err_free;
-
 		r = amdgpu_job_submit(job, &adev->uvd.entity,
 				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
 		if (r)
-- 
2.34.1

