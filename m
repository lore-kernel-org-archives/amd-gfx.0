Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EA6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 12:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8205F89E2A;
	Mon, 22 Nov 2021 12:39:31 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10DBE89E2A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 12:39:30 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id d27so32466853wrb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 04:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1KmLb1Ww0wXfrPMRuZLQYiAQrIRhFuIGzvVNm/EvLHc=;
 b=d6ktOMJbMcAuWrnTNqW1gFfbMWxTQ4DuL+zzx1cRfYrgeFM2C8NldXTSvL/KJkr6Cc
 uVSEfNhc0rj+utFqcElOFb0LMD97OB0HeiNWQvWjSidhxlAcZyWKYKR4wnh+MJoGqnR9
 tZGmlHWDAWvzDxr0CXF3Xi4E/wDONxdX27kVR69lFTzvGwje6+Z8yVJFAsddmK4VqV1y
 QxnmKvl3OXgsaWmeUlef+RMjNHVS0Cx0yuuA4B7hpzvn32u7IyouX2bBb5l+fMCcUw1A
 NICocPVna6ajWVO4ZwNt9J/d3owTraja+Vwd40N1R01hSWq+8WxM3nLkLjcfK1/E+IY0
 l3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1KmLb1Ww0wXfrPMRuZLQYiAQrIRhFuIGzvVNm/EvLHc=;
 b=elSEtoRC+HvGYtT+drlHhPCAhn0cvXL2bmmGrFbdbcXzi2y2TfCJ3CtdvC7gRMccoQ
 v9d+sw0styZXZA64zfy+nk3b/SoLh5F55w2he8usRsrV7OOQF7HVQ1nSAmtyyVfn5+M1
 uPthRXkBCt0WQYg3kX5dMA/SeVT3kojjMZl7sdr1qPogpnDks57O7+QddioYfSZFTb1z
 fNxYdXuinzVGyUBo4D/ke+5y17sbLPUz3+F/XFxaJfM5P3lUylbc1Mf+RT9D/oLcZeE8
 uCYWTKXcGYw6/AZm4Dv3pqs7cda2wh/RwytoRuc/wSToZhSVm7wySuFtHCmhj1qiHJ8d
 6Asw==
X-Gm-Message-State: AOAM530yu/YUIAazMrDx9yYd0ruQM5GxqtWzYNxfw74/Zo5V0YZ64ukR
 hc8jjTuhxHmcFQBZlBHcGfQyzZNCPBA=
X-Google-Smtp-Source: ABdhPJzFvcu8HrHJrD1Mfm6NehuA0Pa6uAxf425oaGja4M8eNNdy+3BpiXhE39j9uU1yTf3smDVZOA==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr37195409wrq.161.1637584768622; 
 Mon, 22 Nov 2021 04:39:28 -0800 (PST)
Received: from abel.fritz.box (p57b0b77b.dip0.t-ipconnect.de. [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id y142sm9412106wmc.40.2021.11.22.04.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 04:39:28 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alex.sierra@amd.com, philip.yang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: partially revert "svm bo enable_signal call
 condition"
Date: Mon, 22 Nov 2021 13:39:26 +0100
Message-Id: <20211122123926.385017-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Partially revert commit 5f319c5c21b5909abb43d8aadc92a8aa549ee443.

First of all this is illegal use of RCU to call dma_fence_enable_sw_signaling()
since we don't hold a reference to the fence in question and can crash badly.

Then the code doesn't seem to have the intended effect since only the
exclusive fence is handled, but the KFD fences are always added as shared fence.

Only keep the handling to throw away the content of SVM BOs.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 30b7dde496fc..b9cd32d25bc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -113,17 +113,8 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 
 	abo = ttm_to_amdgpu_bo(bo);
 	if (abo->flags & AMDGPU_AMDKFD_CREATE_SVM_BO) {
-		struct dma_fence *fence;
-		struct dma_resv *resv = &bo->base._resv;
-
-		rcu_read_lock();
-		fence = rcu_dereference(resv->fence_excl);
-		if (fence && !fence->ops->signaled)
-			dma_fence_enable_sw_signaling(fence);
-
 		placement->num_placement = 0;
 		placement->num_busy_placement = 0;
-		rcu_read_unlock();
 		return;
 	}
 
-- 
2.25.1

