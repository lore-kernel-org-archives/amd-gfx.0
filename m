Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3069CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C804410E42D;
	Tue,  5 Sep 2023 06:04:25 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025CA10E427
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:21 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52c74a2e8edso2986120a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893860; x=1694498660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9d5n3grJEyGrwKuAoASHma4QqT+cwst804XpWW7Fdg=;
 b=rmLKumPoqwjeiCbXqsWL67X/C9P6lbtXkS+KU4aOmqtBZnRe0F3BLQZxWWM9lixYNf
 LyCgN4oCH7m7XpkDLgmcJwEC2EKFXXdqmqO9UCDycormpxPneYG2Ym7tro37AVGnYd9O
 rxD1FdxNXtpDd9iKfJdetnyKOCYo/t30wbvdJ8eT+mwBsPvVqEq3is/7e1nHqkCqgVUr
 mGp5HcXmxGP8AvpQGsooLDS7CMNdh0BslROUATcesf+5UwnqQ0D9NEBxvDpajcqV3+as
 PObiAk2Lb/6uj9NfDj0wLv28IgGbHBvG3UuUngoa9aAdcFJgJFNK31iadnSvakk4Go9X
 qKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893860; x=1694498660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9d5n3grJEyGrwKuAoASHma4QqT+cwst804XpWW7Fdg=;
 b=CHraNfv3l64XiCgJ/t7qXXceA9QiogUQ2y3zEgAPvMQ84lD490n6nIabdsQxSztm5u
 RUyInaflqlMRTHupVhOu6VJnLRo/+Iz9ytoYMW6vCfLheiDPlNGlTB8WN9OI6CQhjg8R
 aFj4ARV1fGzG2odYgTvouK43LWP/tI0RuGdWqpfM+ponDPD41Twk9ruR5lHyJQK5ZFG/
 iWYIsfcgDSvbZZBrpSZFoTdq1ors0PGl4dLPvzaLzbrApnGJ7pdUwf8y1pPWQVDX7HWC
 Ef3gvb4NiDFcPYv6jytxNkR4RIKgQ7Pkh0fUmjx27JZ/mE6hlw7w8urjxlSnK9/bBNm+
 DUKA==
X-Gm-Message-State: AOJu0YxEyU4ijV5fYK4B1h0wejgh3qnGgVhwkTtgrA0+DxFT7pEplqmH
 mxEyx8BSA+7LF6LL3PwPetUTlB+92FGl2eNs
X-Google-Smtp-Source: AGHT+IGUd5HOtCN42bO2/jTNxYhLf87ypOAIap7bXH+S1+S94ItnX2mCwXpv7FQNBtVurDWBNjWzHw==
X-Received: by 2002:a50:ee92:0:b0:52a:3ee9:a78a with SMTP id
 f18-20020a50ee92000000b0052a3ee9a78amr9175325edr.26.1693893860286; 
 Mon, 04 Sep 2023 23:04:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/11] drm/amdgpu: fix and cleanup gmc_v7_0_flush_gpu_tlb_pasid
Date: Tue,  5 Sep 2023 08:04:08 +0200
Message-Id: <20230905060415.1400-5-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 6a6929ac2748..9e19a752f94b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -33,6 +33,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gem.h"
+#include "amdgpu_reset.h"
 
 #include "bif/bif_4_1_d.h"
 #include "bif/bif_4_1_sh_mask.h"
@@ -426,23 +427,23 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
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
 }
 
-- 
2.34.1

