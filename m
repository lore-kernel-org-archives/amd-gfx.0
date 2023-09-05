Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C93CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2198210E433;
	Tue,  5 Sep 2023 06:04:31 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868B310E427
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:22 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso2737703a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893861; x=1694498661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhK2Af0acazU83JATi5DFULdeYKxEI+yy3mu6CtruwY=;
 b=nk7zBjrZ5XahCSmJKRx4D7DFmxo+41uhzO1e0W7mloA9mvrnLK62JT7u5hTrErYBP4
 eLnWchLujvNG1hUtAEPWJ97W8TUV7156+eAExlY1wtEVbNxpyHZKIXrNXapBDGr973ST
 LASAHQ8/ua2CP5hyAfCp+Kj9+oVKfEuMKGPyIzAvdNi2fP8Ffy9TIgrhd2QmKFSqTIEL
 jwW3KCOrtkaKfnVkEqmfljFZ3DVlR9TyoIFxwulXUreRHmLTzc+GT+gOEeElBerJqkuJ
 EEkSaQs/e0ygNpu4K0ISFvy5IThIVeYjXFePO+NoBk9IVU+3olCgjmO9YOQQRLaM3E3w
 EejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893861; x=1694498661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhK2Af0acazU83JATi5DFULdeYKxEI+yy3mu6CtruwY=;
 b=Vxb7aUwHKeNqXardP0KjIMFpW9bxPcvVFIuEzBull5Mr0dWAy0N4BUsro5M+Mz+mTA
 S1A0PniSwzDnV0fQ4glGA54l3+fK9stz/oBe1Aijz8xhAptMfyPxqmDE5BjzDbWaQ2Td
 652JIi2TzXPemZe/Y3LSYwkXB9JtcOClem1QoFip2bNWr5PfewVTC77zXtkT9VcAvs1B
 ZK5OMR3/VgnY1VBkEQ/JCQZrOlbbDt31XmroUAYRvQwy6ePq9p24i1zJI+kctSoPQbns
 L+T9I67+WKMRZLgfdt3v0BUaA+Qfjf6yDeolON97u6z3lxEk+3yHQ/0xSBCH9yETxtkB
 r3MA==
X-Gm-Message-State: AOJu0YyCwzukeqdKo+fZNHEzmYUfPngY2ZIHfNF4IAUPYqhjYyJgeDQc
 l19ZJk+VhS2pQhj+JkKxb7SMCjBPMbuWv5ip
X-Google-Smtp-Source: AGHT+IGjxkyJ/lWVXjd+B9quozaq0HN7fG7vAvslcVLz2VQPZIsyFUE40IRrenQQWExtpYk/q2zZxQ==
X-Received: by 2002:aa7:c3d4:0:b0:523:19f0:b113 with SMTP id
 l20-20020aa7c3d4000000b0052319f0b113mr8710406edr.31.1693893860967; 
 Mon, 04 Sep 2023 23:04:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] drm/amdgpu: fix and cleanup gmc_v8_0_flush_gpu_tlb_pasid
Date: Tue,  5 Sep 2023 08:04:09 +0200
Message-Id: <20230905060415.1400-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905060415.1400-1-christian.koenig@amd.com>
References: <20230905060415.1400-1-christian.koenig@amd.com>
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Testing for reset is pointless since the reset can start right after the
test. Grab the reset semaphore instead.

The same PASID can be used by more than once VMID, build a mask of VMIDs
to reset instead of just restting the first one.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 5af235202513..2d51531a1f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -31,6 +31,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gem.h"
+#include "amdgpu_reset.h"
 
 #include "gmc/gmc_8_1_d.h"
 #include "gmc/gmc_8_1_sh_mask.h"
@@ -616,25 +617,24 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
 					bool all_hub, uint32_t inst)
 {
+	u32 mask = 0x0;
 	int vmid;
-	unsigned int tmp;
 
-	if (amdgpu_in_reset(adev))
-		return -EIO;
+	if(!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
 
 	for (vmid = 1; vmid < 16; vmid++) {
+		u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
 
-		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
 		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
-			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
-			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-			RREG32(mmVM_INVALIDATE_RESPONSE);
-			break;
-		}
+		    (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid)
+			mask |= 1 << vmid;
 	}
 
+	WREG32(mmVM_INVALIDATE_REQUEST, mask);
+	RREG32(mmVM_INVALIDATE_RESPONSE);
+	up_read(&adev->reset_domain->sem);
 	return 0;
-
 }
 
 /*
-- 
2.34.1

