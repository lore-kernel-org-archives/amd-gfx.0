Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE4CD5BA5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AD810E3A1;
	Tue, 19 Sep 2023 12:08:46 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537F010E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:28 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso6903035a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125307; x=1695730107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5YZpgvoBouOl8xWHz6K61FgOTiN2UUu5nUCS8GCe4Ds=;
 b=fOhNXhJ6+IKuPAQ5oAACF78Zk4mLkxwwjeC+tqRsKiPRbxv4LKnRqTiREhlZ+qVox3
 97XoMc6TJzXPfSrMGJNCfE2LUOiXPSQr4nKKdO5x99wmoUCferW9wxdhJkRxsNFeWWIz
 FJLlMIy/ynzMjpN9OsV0tmDaZTUPKJ3p1eB+/TYYfZN1b0+fKLxTQ5xmI9nNHbpDpX2A
 rbANZVyUv16gw0ne2LxBgAPqVhHzLlW9YoaCdqpC5FyPl1NmdJtQwt0U8eW9Zne7I2Pj
 Rsxsrxie+xuJBaylgXACAzWAHotz6CXHUkGqNcLY3Bdgn7uOLkwDQaIMc6M4wbpipwKw
 VFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125307; x=1695730107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YZpgvoBouOl8xWHz6K61FgOTiN2UUu5nUCS8GCe4Ds=;
 b=a+XG2dZuqEQcW7NaZ74f49OxD3p0Mp5VYESxTSUUgcB9NJEa8V4iKXVfGHMxiV3dYD
 Q5wnNEqaYGOxpsV4RvOwSFzAAu+n110up/nqnyaOyNXusnWKlgG7buSmvZWzYaTBIeuN
 GxlLtBTzo4zxjsW/LluU+EwudKBU6SRZpJX+y8u1IB9yO9eeuxoJ15yNkczigfJ6FdFc
 AeB3VRc++Hi0NlTdBc5Rz7FNcwqjGdW7qdG8CXHyqFqAecxvn0wH6IQRUemP9U231HSw
 toWqLjFLyrFBBlw2rViz2MNd75QCSZOWvd9ityIxP/ECpto0bmKWZ+G7ALa38z+/K3EV
 5X5Q==
X-Gm-Message-State: AOJu0YzsfxL5KyMBYG9uuFPYc6Mb5LYnU5LP4Vvo5fydFsY+xr0mrYcb
 onfTF9Q3hons95OUsMqdU/d+io7AQ3YVug==
X-Google-Smtp-Source: AGHT+IEsM516wh6Iii9xg2dlIjCzwddKuOCnBjcAp9nJFEWUIk3EAtKMvtwgukERvETgPupYPx83qw==
X-Received: by 2002:a05:6402:d71:b0:530:9fbc:8df5 with SMTP id
 ec49-20020a0564020d7100b005309fbc8df5mr9858934edb.9.1695125306638; 
 Tue, 19 Sep 2023 05:08:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] drm/amdgpu: fix and cleanup gmc_v8_0_flush_gpu_tlb_pasid
Date: Tue, 19 Sep 2023 14:08:16 +0200
Message-Id: <20230919120822.95241-5-christian.koenig@amd.com>
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

