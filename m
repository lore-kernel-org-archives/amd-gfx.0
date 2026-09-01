Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B573CC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 209BA10E3BA;
	Tue,  1 Sep 2026 08:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wx0vUQkw";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246C910E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:28 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4956869750eso30052795e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252086; x=1788856886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hi/7/i+hUgBhIEA5+vfPX3z+aLRbcq4CHmAieRzjaaM=;
 b=Wx0vUQkwV+DdY7onGkU7o+DPwpIg4jIaNsq17v9Mo6e/2wn1X9QShvS3KG1CVhiNCn
 jZSUqSD0rDqSBTZuYMNSKernptbV7NUfwIKfS3tgXIbuMGTqQfD0f0A+hKd8e/nhyL6n
 BWG+t5SCe8kVaBIbh/TbMzTuICuQwIkX2jOiMA3AOddpEQur2EtZ8mJdNtkUMxEd1iq7
 flsVj5Ggt20PmHlJzSkjcMVOs/CoZZ08ay3bt8EvD1tOGZi0JGg2A8lFGzthBNm0kR0V
 h/vWeRrzYoA2wbhRvHdiwtiI9r76TMEYNkmbpydVK11fLC17aJD0AEgqF68bvyyatYDI
 d3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252086; x=1788856886;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hi/7/i+hUgBhIEA5+vfPX3z+aLRbcq4CHmAieRzjaaM=;
 b=i2n9kyVhvodts2s7Ht2qcMmNUEf0FLUHcTm+xd3tilLVGXEbOOTrceWRtgzSBa0k9s
 VthOexFFncQ7IcKCOBcKMMrwdCwOoVyigHQWmKnjQ/KMS2UhtPDB1d3XMuLWzEzeng3j
 sjgHRbBpAEo7SAft2RCgs9JdQ/3hlzEGyuATxmflc0euhynuPYEpJWsHCAadZOk1zk2O
 oz/kQ8gnmc4SEkBUzGCVjxoEcWEw/OUVpYpyEVXu7H7cgb8d3Tcf0eJX9dZhRk7kSRSw
 ibrobqHfvjvmRQb4Q8Qv9E3hV+72a5Zgxp7Tn6zI/fTGsuwkJ6nQeUdLYHpH4kuo3sgf
 YpmA==
X-Gm-Message-State: AFuF++lPjyeF/fBI+fhY2tSXY5CnotKmd7HlfTkFfMiA6JTC6f4464o3
 abXjS/hCfO7+NZoiMAc8VTfnWk2K39hDFjDUCX1LmTNqLF9oJgH4/Qzw/EUYek1LScs=
X-Gm-Gg: AR+sD111DKTcu3ruGP0Z4oOhVERy4geTrst9c/w6qkY2qGWLQc23v4o2DGo4VvBn+Dr
 Mz0R+cBVXuWbWEYJPq0zblx9z7SFzBAb9/cbyh1NUqCeDR/lHgbHlVSaosg7h+97BAh6emOYbUB
 O5Nd5REQRsiqoT/Y4FWka918vY7QRUm+wwNKyv7NU+y0/3USQPf15e+BrQOM3JKv3j4xJgdnD5Y
 0HRG0ubUhbdBzsbqM2QUtgiYRDVtowueSI3K4+g9Mew1EeCW4L8cOGYXa4SjkutA4YBBfQetHdB
 2EPSgMgnhHlHdXgGtsOau0Sn07maYe+eel43B9UglQ6qECwNZPTmqbLJz68z+DTmJHukTJV/F0j
 fZuJWt+K0oDPjzl3Oiu0eB7vPRBQoAI13vL4F1cgvSACPOqE72x1VRNX+2YMhhNVC1Bort65szp
 ZmQ/8qkqBpvvcWWKZC6Z93d/sw2oxYt3gwkKJOyb85h3P9M6YLMvUjHWOwkz3qtgMDqmgkk8Fbu
 aTiZPJSIrIIaFMlMUbl6emiFtPEkVFs7MQ=
X-Received: by 2002:a05:600c:1e0f:b0:49b:9113:e04a with SMTP id
 5b1f17b1804b1-49b91c19c77mr527070715e9.1.1788252086139; 
 Tue, 01 Sep 2026 01:41:26 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/8] drm/amdgpu/sdma: Remove unimplemented soft_reset() for
 SDMA and SI DMA
Date: Tue,  1 Sep 2026 10:41:08 +0200
Message-ID: <20260901084115.262457-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
References: <20260901084115.262457-1-timur.kristof@gmail.com>
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

These functions are not called from anywhere
and don't do anything. Let's delete them.

Also remove the srbm_soft_reset field from amdgpu_sdma
which is not set anywhere anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/si_dma.c      | 7 -------
 7 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 4f4e56022c97..8a78d6967716 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -107,7 +107,6 @@ struct amdgpu_sdma {
 	    int			num_inst_per_aid;
 	    int			num_inst_per_xcc;
 	};
-	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
 	struct amdgpu_sdma_ras	*ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 824ccac9f9f5..7040385a98d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -55,8 +55,6 @@ static void cik_sdma_set_irq_funcs(struct amdgpu_device *adev);
 static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev);
 static int cik_sdma_soft_reset(struct amdgpu_ip_block *ip_block);
 
-u32 amdgpu_cik_gpu_check_soft_reset(struct amdgpu_device *adev);
-
 MODULE_FIRMWARE("amdgpu/bonaire_sdma.bin");
 MODULE_FIRMWARE("amdgpu/bonaire_sdma1.bin");
 MODULE_FIRMWARE("amdgpu/hawaii_sdma.bin");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 6198bc2024e4..0d06e6643ade 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1229,13 +1229,11 @@ static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int sdma_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
+	u32 srbm_soft_reset;
 	u32 tmp;
 
-	if (!adev->sdma.srbm_soft_reset)
-		return 0;
-
-	srbm_soft_reset = adev->sdma.srbm_soft_reset;
+	srbm_soft_reset = SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK |
+			  SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
 
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a0f19f7b39e6..bf71f99f7307 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2046,13 +2046,6 @@ static int sdma_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static int sdma_v4_0_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -2398,7 +2391,6 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 	.suspend = sdma_v4_0_suspend,
 	.resume = sdma_v4_0_resume,
 	.wait_for_idle = sdma_v4_0_wait_for_idle,
-	.soft_reset = sdma_v4_0_soft_reset,
 	.set_clockgating_state = sdma_v4_0_set_clockgating_state,
 	.set_powergating_state = sdma_v4_0_set_powergating_state,
 	.get_clockgating_state = sdma_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 1a2810b6f27c..72ea9db939b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1646,13 +1646,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
 {
 	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
@@ -2104,7 +2097,6 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
 	.suspend = sdma_v4_4_2_suspend,
 	.resume = sdma_v4_4_2_resume,
 	.wait_for_idle = sdma_v4_4_2_wait_for_idle,
-	.soft_reset = sdma_v4_4_2_soft_reset,
 	.set_clockgating_state = sdma_v4_4_2_set_clockgating_state,
 	.set_powergating_state = sdma_v4_4_2_set_powergating_state,
 	.get_clockgating_state = sdma_v4_4_2_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1a022a251011..0da54c335822 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1518,13 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1902,7 +1895,6 @@ static const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
 	.suspend = sdma_v5_0_suspend,
 	.resume = sdma_v5_0_resume,
 	.wait_for_idle = sdma_v5_0_wait_for_idle,
-	.soft_reset = sdma_v5_0_soft_reset,
 	.set_clockgating_state = sdma_v5_0_set_clockgating_state,
 	.set_powergating_state = sdma_v5_0_set_powergating_state,
 	.get_clockgating_state = sdma_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index edebd9109fd4..1df30779dcbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -594,12 +594,6 @@ static int si_dma_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int si_dma_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	drm_info(adev_to_drm(ip_block->adev), "si_dma_soft_reset --- not implemented !!!!!!!\n");
-	return 0;
-}
-
 static int si_dma_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *src,
 					unsigned type,
@@ -726,7 +720,6 @@ static const struct amd_ip_funcs si_dma_ip_funcs = {
 	.suspend = si_dma_suspend,
 	.resume = si_dma_resume,
 	.wait_for_idle = si_dma_wait_for_idle,
-	.soft_reset = si_dma_soft_reset,
 	.set_clockgating_state = si_dma_set_clockgating_state,
 	.set_powergating_state = si_dma_set_powergating_state,
 };
-- 
2.55.0

