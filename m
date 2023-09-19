Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD773CD5BA3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D5310E39C;
	Tue, 19 Sep 2023 12:08:34 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73C910E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:27 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50308217223so4485254e87.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125306; x=1695730106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZeB2y+24IlgiZeYbu1POFLVYcZD2836633KR4dO/QDg=;
 b=D1bA+zGiB9NHas6Lhk8YmK5Mm0s9YTODmRHJkspqD/rKWEW+8I0tn/+EDEdOW8Osgd
 eN+gXl6OSQ6/2xwXwhMUm34qCS0gKnnKWPRbtHm4fpaqH62F5mnpTT52bfjfkFUVT6vn
 siODf8Iz8cn/BlRVdoTPY/EACW5q1ZJIlUAi7UxTIE1UMMnjHucpf/cY/I3VuAGwfbWT
 LxgISpw73bl3I8Ub5rPtJCkso5urx9KwRD5um05M+DSSZaM8loF2B8aancMJqC4ymN+D
 2gi+Kj+ZgqN23+quk0aV3naM1X3u7rT7gJAaeo5tFp6a4odObdIfM43AJM/mQGJSsL46
 76ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125306; x=1695730106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeB2y+24IlgiZeYbu1POFLVYcZD2836633KR4dO/QDg=;
 b=NpsWSMZ2UKhHycfx/ae68UyMQHpZcT+OCtouSNiVeEOe/OgZCHFXHDE926aZw9l5kZ
 PuQsDpbfa53OKTnvhsmNWUOpOTEFjSssXrYuue8qdzOFS92/2+EJbxM5LcbQBOPTSSiR
 Xi93PvP9L0ND9TwwXDJrW/WOjNK8ze5/omulaxloqKO9xgf5jFA5xjjyxNrSTYot/OZ7
 D4Y9R75DSl1YNqTLs5J6BEVPzo+E+3JHFqjSGBuzl28yR9XzImT2gG7Mea6Jf9Z1X/ar
 YaslSyVweOJ+NwvEP5snsORfUNoT0Uj7V8jLGi41tVWFH5q1DQ4TIL8R1uJf1MVJ/L3N
 sZ0Q==
X-Gm-Message-State: AOJu0Yxq8PmLpp/UcEz2Lj5oYoh/6FLVsp964vm9KfAOkeockj/LNaff
 /KHal1DLbsAVqb843stmXMd9u8RTk/pJRw==
X-Google-Smtp-Source: AGHT+IGWJHYMDvqS0bjnZYPJ0LNsWE9FXx9i+2njG1UAzwXtXErP1dsQcu3+Jwawc9wMaOx5yvce7A==
X-Received: by 2002:ac2:5f99:0:b0:503:970:4dbf with SMTP id
 r25-20020ac25f99000000b0050309704dbfmr5628854lfe.15.1695125305756; 
 Tue, 19 Sep 2023 05:08:25 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/11] drm/amdgpu: fix and cleanup gmc_v7_0_flush_gpu_tlb_pasid
Date: Tue, 19 Sep 2023 14:08:15 +0200
Message-Id: <20230919120822.95241-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919120822.95241-1-christian.koenig@amd.com>
References: <20230919120822.95241-1-christian.koenig@amd.com>
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

Testing for reset is pointless since the reset can start right after the
test. Grab the reset semaphore instead.

The same PASID can be used by more than once VMID, build a mask of VMIDs
to invalidate instead of just restting the first one.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
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

