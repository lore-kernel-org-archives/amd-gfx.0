Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5551C63797
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 08:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CDA810E2DE;
	Tue, 17 Jan 2023 08:12:46 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C4110E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 08:12:44 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id b7so3706944wrt.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XwNd7o0ytTGIizBrEDuL/Hmpztb5uuNgYzggwE/V22c=;
 b=eK1F7VutszCBUJdJmjPUefZATQeG7Qjwsvmj8bQC8cDGP47pHn6nfYeP3wYP2X3lIO
 Jbxbsnn6ExIFNu74+o5olj+0b5mDrSs3dyj/ILAiqskTqw/lta4k+cjTbyeM9z366Dsi
 cRtEAE0L5fNrNDnJO1kYXTZ/7YGpJSSBk9V/OhK8NHD2nsAhgASkpw0gn6AT7wIcqmYy
 VW14ADdKZ4//ahzhry1j2FadEqY67K2qklGV65hfJDgqlhVjYWOW5qdMdqMarzACt3+K
 SJG0XG+ytB6ysSBj7tq+RpJqkZTgxVjjcvV+T0lLO/Yz2SLFyrGA+zlXI9g4k3Uq2CZh
 ru9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwNd7o0ytTGIizBrEDuL/Hmpztb5uuNgYzggwE/V22c=;
 b=WH+RgmPPpvbToUDz+CFVtWmNw0OTkOc+va4LBVCSagFR761vUhYlsbzspeagqkaGk+
 11TMr0AeaxyYKfyzd8Yu6bPS/snd3fJn6jW+e1pGVKvgejaTFvQdPDuVyR6FkRf7HnmU
 KeRNPCP+exmX8fClPe7GBdV83s/uct9INeVyY0kSN8s/Lfdojh3IwDemF6bMowqGaIBj
 Aa1j3PjebOZeVxAlbIKTUdle0F6NN9OQMs356P2CP2fVLyR0cD9x095d2prYuwCxhGxE
 2xPWtlh/KlxrK1qfZuq8xBG6/CbCRS+A8T0SWS4X8uR9NzeKVcF7axIzrq0Iu+s3a+iJ
 I5aw==
X-Gm-Message-State: AFqh2kpgb+gKUovU+BDDVnp5RlBIcXORAW3L9HSqIMl0MpJepShB4bVC
 k1CvsJIctdSVBegVwFdL/gPNInRG5sc=
X-Google-Smtp-Source: AMrXdXs5bmk/YAr/YDONs8jUwctNanoclUnYIGwS6VQm8HINXvFaB0RNJJePlAWbUHKG5k5QiYhZCw==
X-Received: by 2002:adf:e647:0:b0:236:6c33:2130 with SMTP id
 b7-20020adfe647000000b002366c332130mr8870732wrn.68.1673943162646; 
 Tue, 17 Jan 2023 00:12:42 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 i10-20020adff30a000000b0024228b0b932sm33917822wro.27.2023.01.17.00.12.41
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jan 2023 00:12:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: stop waiting in amdgpu_uvd_send_msg
Date: Tue, 17 Jan 2023 09:12:39 +0100
Message-Id: <20230117081240.13669-1-christian.koenig@amd.com>
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

We have a wait in the amdgpu_bo_kmap() code for quite a while now, so
waiting here isn't needed any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b67a5fb2ff3e..dd0894c9740d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1122,8 +1122,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	struct amdgpu_ib *ib;
 	uint32_t data[4];
 	uint64_t addr;
-	long r;
-	int i;
+	int i, r;
 	unsigned offset_idx = 0;
 	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
 
@@ -1158,24 +1157,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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

