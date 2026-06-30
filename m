Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5238BC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 13:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E559C10E1FC;
	Tue, 30 Jun 2026 13:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAYe0Maa";
	dkim-atps=neutral
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFA510EB38
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 07:28:59 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id
 98e67ed59e1d1-37fc01881f2so2536113a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782804539; x=1783409339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ul3/ISJIxQCHD0fhKywsEwyygt0y3z6uVSVG5ItbopQ=;
 b=LAYe0MaaDPouoMXfRg4Nlvzwm3f9JQ9BVL21g+3LcehYE1xpGRIh/eMzncghPmgKYL
 02sSuDer9d4CBl6oTp7IZfkmgpShxTU7Sx7r2dGDULXN2KxLi3+BgD7S4eYesOxtHBJ/
 7dYnLyB+ThG2Br2N3Z1zGbNL2WCObnLl5p9mKvsyOJEQHyretnOnnNRIoT93mP60MYY6
 S/XJ/Cm4gcyn0cboAFYCRaD9zBgU4dU6YM6WDaetK7nex2h64IX170pEgkR1MhIi7E3p
 ZN9iJS5PYJ3iMp4Q8B8dTGUneI56yA53Ghouwi8WZQKVnxZeKzLmp9+PDfjAGBXrN8qq
 H62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782804539; x=1783409339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ul3/ISJIxQCHD0fhKywsEwyygt0y3z6uVSVG5ItbopQ=;
 b=gn0FcpZPSc8WDxrb09sb0GuEhbQGQ1pyh7Z9d90uAbAmgDY9ApSgPubp6B8rZf8x3e
 EnaSqFXSO7ICytxrSCUGkPmQ65HamRDcVlwzUWuT9+P1HGpFCHyuqZGICGGg1Psj/zsD
 oSs4edgwNTYJzd3+PUJnHYOb/iY7S/gGW0sxym6OexFx903O71UR5D6/AbxeWBA/2DcM
 mTLcrz5yChBbXkcPC5xdHjJV0E8Jjn2PwwltH18vPTYEKzz47RUxAZPTtm6SMHsvZloy
 yW3RmiHgO7M5/X2ZXSipWAZ8IUW5yRbAPChOAd2kej119mco+ged5IQ9ZVom5mVbE5nM
 GjsQ==
X-Gm-Message-State: AOJu0YzQpHrdUPGolFhDOGpMT6sjUo3pjMi+ehVdTAC+EPPvwSuk1zIT
 Uv8lBMDrUd/NsZ4UlbWN5AIUtIAzxZ0xLBbp/dZXOQDm5TB6pysw/6Yu
X-Gm-Gg: AfdE7cnepjb9V1jmRtlpTUSroO+rPl1AcBiu/Pd3EGmOllKQCQJx6dQL2FT1pv++MpX
 rXWhDH/d1IdiAWqlugQBtvfefZgWwEPSzisNtg7viKrCC2Z8PK06Lgo6jEtStfbaFTwminr07u9
 ekqqrNAiRPq9GZYieER8avcSWFScff/xEub0nSa1kORXM7sgmwy8sKhFj3tMbLkCwyhx/fuC+5X
 1A34ENFWs1uMK+6+Su2FffHJhiR5Y3ul2Ulvy/FlINWsA02tpG62d0vn5pxm6jVa2pxqJingIki
 fgaJz3Dtm3giEOuOqFkMlEdJdjPGTPA/pF/qHAQ+mQj72HGcJmIxWL3B6P9emsnezpemDI8MXnH
 kjjYPyPWwi/V/meCpTN39mdHyrinmTWc+zgNTXAdSJ0Zvqaxd+zlOqB3TFzYb26wq2J0pVBZf+P
 QpN6GoSgQPsy4X46IOTQw9IhfyBvrsRg==
X-Received: by 2002:a17:90b:1d02:b0:37f:9ce1:cda9 with SMTP id
 98e67ed59e1d1-380527daa2dmr1895486a91.31.1782804539506; 
 Tue, 30 Jun 2026 00:28:59 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f32869sm1137101a91.11.2026.06.30.00.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 00:28:59 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, pierre-eric.pelloux-prayer@amd.com, lijo.lazar@amd.com,
 felix.kuehling@amd.com, srinivasan.shanmugam@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ke.zhao.kernel@gmail.com
Subject: [PATCH] drm/amdgpu: Fix typo in comment
Date: Tue, 30 Jun 2026 15:28:38 +0800
Message-ID: <20260630072838.67086-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 13:06:25 +0000
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

It should be doorbell.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 16c060badaee..b7be28d74e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2187,7 +2187,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* Create a boorbell page for kernel usages */
+	/* Create a doorbell page for kernel usages */
 	r = amdgpu_doorbell_create_kernel_doorbells(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to initialize kernel doorbells.\n");
-- 
2.43.0

