Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FEFC61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADB410E3C7;
	Tue,  1 Sep 2026 08:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOG6Mi7R";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7CB10E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:30 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso51508255e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252089; x=1788856889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d9qOpW3raDSS/tRyx15kIe0cNqpqs3Swv/5JTzaIljI=;
 b=HOG6Mi7R9hsQkmW8W7saIcLFuXfQZqz1qARPJk/AiDOW3D6w4RfEHVNAwzkAwbE7Z1
 STcPUFuw45XYFgqmqAqZ9SBAVRn56duMUbrffxHWJseHxa3tbSl8Sgs7DZJrqp685N7P
 UwueWTrsxXa0kAMSzW09TKeQhuQ2yY0r0peKR279yj+kEPQA4orsV/AxvGoTBcwKyg2q
 7v+2mb/dJsy8q9oxKiiB83Uqh/OZC15RNq0pMKGjnbU4uPZKvOMzRzXO/YHAxFgM9SWe
 OdJSU8V6FiGu6m8J37e61r2WSIzHUnk7yGN4c3dFC6OSLiZ4YxEQBzFZndkviC6h/3LP
 plPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252089; x=1788856889;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9qOpW3raDSS/tRyx15kIe0cNqpqs3Swv/5JTzaIljI=;
 b=puULJwHP6XdpDWcv2O/dcFWzvqT/UGgW58o+OZC1M/uDlua6qHtWsZ1IEPsiEZRPzL
 HjMA0pbw9uj6QkSoyQPrs9Xf99I9iZq5LGVyjzgaGpu86Hlp85KnVrSIQUBY33s0Tn7J
 CL+eVMNaKlw8yGl5isUTDHuzX1fCqrV4Wgr3pr7i2f7z4EkdGb0u+FzwlLfhOorDtkA6
 PWlE6bTGO4BBSxm0+eFGGgmYVwOSJtH06PywtCGsHgtNGErbLuHd/DMSm1u9nCxLRiDU
 fdAhfovyT4nKw0ziHylKK3f4vdqcxaJsXpiD5+iCJ01+tk2YtG7oFa2IoEHHelmo3tsT
 Htpw==
X-Gm-Message-State: AFuF++mwZ50iMCKw/iBYQfPIqnGzmyR44dJMO6PxWFvNsnOsZfbddRtc
 jvR5Q8A3XgnHv2h+nzLljYuCNNHvhfnNRgf3DngOienrvAw/5ivuLJFxiC2dkaIkSHU=
X-Gm-Gg: AR+sD11nnNxed/OgOdQEbEMeHkEXFuTFqlMyAzdCSUnS1k1VrRljOhg+2jvfcOIXH/A
 5ynZxHAnO29WK3iJmeIi0LeuaVCE6DLUzJ+vY3O1rTvGYQtcLylX39vOa235AXsOTgnx0fzMtRk
 3zY3PHBODCjAJ0mgBm/gddzaW/KL7RxjHl9aR9wtzW0m2ou3lVHDHBYbEDUrj2xHx1AUCEbOsYZ
 fSJ0/GpPi8HEy8mNfRwiOD3Vvg6LU5l3BIw8RjZlHntaf+0aAYHFxI4xnpO+EmJaeD5RPJ14A+k
 pD3+xL4ZAmVMfomsY0LMh7dn2pTh0ckAUnEnzUr9GhEBMgucGUE4/RtDjfA9KDo0yAJtgFgTnDT
 ustamJpl3l62qNaxBPvli5pypyvssPrBUc0ClAIZLdre0NyAQVEuzniGdweWFNMHfTDjV05k4of
 z1Pz3OjF1Jkf51hoFOTYUp5fuZ/LIsgGPdQn4k89oso/nHY243aqhjyDXi3uTQfaBeG+LreePwc
 JnEMOFMCviLrp9aTUPvTQ/oObYQ+yHeyQ==
X-Received: by 2002:a05:600c:19ca:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-49ccee0f3cdmr298883865e9.16.1788252087874; 
 Tue, 01 Sep 2026 01:41:27 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/8] drm/amdgpu/sdma: Remove superfluous rlc_resume and
 rlc_stop functions
Date: Tue,  1 Sep 2026 10:41:09 +0200
Message-ID: <20260901084115.262457-3-timur.kristof@gmail.com>
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

Every SDMA generation has an rlc_resume and rlc_stop function
which are not doing anything.

Starting from CIK, the SDMA engine supports additional queues
which are called "SDMA compute" or "RLC" queues, and these
queues are used by the KFD, and configured using the HWS.
There is nothing for the kernel driver to do for these.

Let's delete the functions that don't do anything.
In case of SDMA v4.0 and v4.4.2 let's move the init_pg()
call to the start() function.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 30 --------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 30 --------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 30 --------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 32 +--------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 36 +-----------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 27 ------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 27 ------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 27 ------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 27 ------------------
 9 files changed, 2 insertions(+), 264 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 7040385a98d2..8c138f2fc026 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -316,18 +316,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * cik_sdma_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues (CIK).
- */
-static void cik_sdma_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * cik_ctx_switch_enable - stop the async dma engines context switch
  *
@@ -400,7 +388,6 @@ static void cik_sdma_enable(struct amdgpu_device *adev, bool enable)
 
 	if (!enable) {
 		cik_sdma_gfx_stop(adev);
-		cik_sdma_rlc_stop(adev);
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -501,20 +488,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * cik_sdma_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them (CIK).
- * Returns 0 for success, error for failure.
- */
-static int cik_sdma_rlc_resume(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-	return 0;
-}
-
 /**
  * cik_sdma_load_microcode - load the sDMA ME ucode
  *
@@ -577,9 +550,6 @@ static int cik_sdma_start(struct amdgpu_device *adev)
 
 	/* start the gfx rings and rlc compute queues */
 	r = cik_sdma_gfx_resume(adev);
-	if (r)
-		return r;
-	r = cik_sdma_rlc_resume(adev);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 9ef7134149d5..b9e0dbe726f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -349,18 +349,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * sdma_v2_4_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues (VI).
- */
-static void sdma_v2_4_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v2_4_enable - stop the async dma engines
  *
@@ -376,7 +364,6 @@ static void sdma_v2_4_enable(struct amdgpu_device *adev, bool enable)
 
 	if (!enable) {
 		sdma_v2_4_gfx_stop(adev);
-		sdma_v2_4_rlc_stop(adev);
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -477,20 +464,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * sdma_v2_4_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them (VI).
- * Returns 0 for success, error for failure.
- */
-static int sdma_v2_4_rlc_resume(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-	return 0;
-}
-
 
 /**
  * sdma_v2_4_start - setup and start the async dma engines
@@ -509,9 +482,6 @@ static int sdma_v2_4_start(struct amdgpu_device *adev)
 
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v2_4_gfx_resume(adev);
-	if (r)
-		return r;
-	r = sdma_v2_4_rlc_resume(adev);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 0d06e6643ade..8e83a309062b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -526,18 +526,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * sdma_v3_0_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues (VI).
- */
-static void sdma_v3_0_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v3_0_ctx_switch_enable - stop the async dma engines context switch
  *
@@ -614,7 +602,6 @@ static void sdma_v3_0_enable(struct amdgpu_device *adev, bool enable)
 
 	if (!enable) {
 		sdma_v3_0_gfx_stop(adev);
-		sdma_v3_0_rlc_stop(adev);
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -752,20 +739,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * sdma_v3_0_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them (VI).
- * Returns 0 for success, error for failure.
- */
-static int sdma_v3_0_rlc_resume(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-	return 0;
-}
-
 /**
  * sdma_v3_0_start - setup and start the async dma engines
  *
@@ -784,9 +757,6 @@ static int sdma_v3_0_start(struct amdgpu_device *adev)
 
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v3_0_gfx_resume(adev);
-	if (r)
-		return r;
-	r = sdma_v3_0_rlc_resume(adev);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index bf71f99f7307..961f67a5983e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -933,18 +933,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
 	}
 }
 
-/**
- * sdma_v4_0_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues (VEGA10).
- */
-static void sdma_v4_0_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v4_0_page_stop - stop the page async dma engines
  *
@@ -1047,7 +1035,6 @@ static void sdma_v4_0_enable(struct amdgpu_device *adev, bool enable)
 
 	if (!enable) {
 		sdma_v4_0_gfx_enable(adev, enable);
-		sdma_v4_0_rlc_stop(adev);
 		if (adev->sdma.has_page_queue)
 			sdma_v4_0_page_stop(adev);
 	}
@@ -1312,21 +1299,6 @@ static void sdma_v4_0_init_pg(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * sdma_v4_0_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them (VEGA10).
- * Returns 0 for success, error for failure.
- */
-static int sdma_v4_0_rlc_resume(struct amdgpu_device *adev)
-{
-	sdma_v4_0_init_pg(adev);
-
-	return 0;
-}
-
 /**
  * sdma_v4_0_load_microcode - load the sDMA ME ucode
  *
@@ -1426,9 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 		sdma_v4_0_ctx_switch_enable(adev, true);
 		sdma_v4_0_enable(adev, true);
 	} else {
-		r = sdma_v4_0_rlc_resume(adev);
-		if (r)
-			return r;
+		sdma_v4_0_init_pg(adev);
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 72ea9db939b4..06b4bd8fca00 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -520,20 +520,6 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 	}
 }
 
-/**
- * sdma_v4_4_2_inst_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- * @inst_mask: mask of dma engine instances to be disabled
- *
- * Stop the compute async dma queues.
- */
-static void sdma_v4_4_2_inst_rlc_stop(struct amdgpu_device *adev,
-				      uint32_t inst_mask)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v4_4_2_inst_page_stop - stop the page async dma engines
  *
@@ -632,7 +618,6 @@ static void sdma_v4_4_2_inst_enable(struct amdgpu_device *adev, bool enable,
 
 	if (!enable) {
 		sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
-		sdma_v4_4_2_inst_rlc_stop(adev, inst_mask);
 		if (adev->sdma.has_page_queue)
 			sdma_v4_4_2_inst_page_stop(adev, inst_mask);
 
@@ -888,23 +873,6 @@ static void sdma_v4_4_2_init_pg(struct amdgpu_device *adev)
 
 }
 
-/**
- * sdma_v4_4_2_inst_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- * @inst_mask: mask of dma engine instances to be enabled
- *
- * Set up the compute DMA queues and enable them.
- * Returns 0 for success, error for failure.
- */
-static int sdma_v4_4_2_inst_rlc_resume(struct amdgpu_device *adev,
-				       uint32_t inst_mask)
-{
-	sdma_v4_4_2_init_pg(adev);
-
-	return 0;
-}
-
 /**
  * sdma_v4_4_2_inst_load_microcode - load the sDMA ME ucode
  *
@@ -1019,9 +987,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		sdma_v4_4_2_inst_ctx_switch_enable(adev, true, inst_mask);
 		sdma_v4_4_2_inst_enable(adev, true, inst_mask);
 	} else {
-		r = sdma_v4_4_2_inst_rlc_resume(adev, inst_mask);
-		if (r)
-			return r;
+		sdma_v4_4_2_init_pg(adev);
 	}
 
 	tmp_mask = inst_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 0da54c335822..b7bda6361ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -574,18 +574,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev, uint32_t inst_mask)
 	}
 }
 
-/**
- * sdma_v5_0_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues (NAVI10).
- */
-static void sdma_v5_0_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v5_0_ctx_switch_enable - stop the async dma engines context switch
  *
@@ -661,7 +649,6 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!enable) {
 		sdma_v5_0_gfx_stop(adev, 1 << inst_mask);
-		sdma_v5_0_rlc_stop(adev);
 	}
 
 	if (amdgpu_sriov_vf(adev))
@@ -858,19 +845,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * sdma_v5_0_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them (NAVI10).
- * Returns 0 for success, error for failure.
- */
-static int sdma_v5_0_rlc_resume(struct amdgpu_device *adev)
-{
-	return 0;
-}
-
 /**
  * sdma_v5_0_load_microcode - load the sDMA ME ucode
  *
@@ -951,7 +925,6 @@ static int sdma_v5_0_start(struct amdgpu_device *adev)
 	r = sdma_v5_0_gfx_resume(adev);
 	if (r)
 		return r;
-	r = sdma_v5_0_rlc_resume(adev);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 5543e381dcca..d063babab833 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -424,18 +424,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev,  uint32_t inst_mask)
 	}
 }
 
-/**
- * sdma_v5_2_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues.
- */
-static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
  *
@@ -510,7 +498,6 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!enable) {
 		sdma_v5_2_gfx_stop(adev, inst_mask);
-		sdma_v5_2_rlc_stop(adev);
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
@@ -705,19 +692,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * sdma_v5_2_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them.
- * Returns 0 for success, error for failure.
- */
-static int sdma_v5_2_rlc_resume(struct amdgpu_device *adev)
-{
-	return 0;
-}
-
 /**
  * sdma_v5_2_load_microcode - load the sDMA ME ucode
  *
@@ -851,7 +825,6 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	r = sdma_v5_2_gfx_resume(adev);
 	if (r)
 		return r;
-	r = sdma_v5_2_rlc_resume(adev);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3fd3e530c76b..22043a29fbb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -407,18 +407,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * sdma_v6_0_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues.
- */
-static void sdma_v6_0_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v6_0_ctxempty_int_enable - enable or disable context empty interrupts
  *
@@ -457,7 +445,6 @@ static void sdma_v6_0_enable(struct amdgpu_device *adev, bool enable)
 
 	if (!enable) {
 		sdma_v6_0_gfx_stop(adev);
-		sdma_v6_0_rlc_stop(adev);
 	}
 
 	if (amdgpu_sriov_vf(adev))
@@ -642,19 +629,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * sdma_v6_0_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them.
- * Returns 0 for success, error for failure.
- */
-static int sdma_v6_0_rlc_resume(struct amdgpu_device *adev)
-{
-	return 0;
-}
-
 /**
  * sdma_v6_0_load_microcode - load the sDMA ME ucode
  *
@@ -832,7 +806,6 @@ static int sdma_v6_0_start(struct amdgpu_device *adev)
 	r = sdma_v6_0_gfx_resume(adev);
 	if (r)
 		return r;
-	r = sdma_v6_0_rlc_resume(adev);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 745ec8b67b59..e8824d37a14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -409,18 +409,6 @@ static void sdma_v7_0_gfx_stop(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * sdma_v7_0_rlc_stop - stop the compute async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute async dma queues.
- */
-static void sdma_v7_0_rlc_stop(struct amdgpu_device *adev)
-{
-	/* XXX todo */
-}
-
 /**
  * sdma_v7_0_ctx_switch_enable - stop the async dma engines context switch
  *
@@ -448,7 +436,6 @@ static void sdma_v7_0_enable(struct amdgpu_device *adev, bool enable)
 
 	if (!enable) {
 		sdma_v7_0_gfx_stop(adev);
-		sdma_v7_0_rlc_stop(adev);
 	}
 
 	if (amdgpu_sriov_vf(adev))
@@ -643,19 +630,6 @@ static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
 
 }
 
-/**
- * sdma_v7_0_rlc_resume - setup and start the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Set up the compute DMA queues and enable them.
- * Returns 0 for success, error for failure.
- */
-static int sdma_v7_0_rlc_resume(struct amdgpu_device *adev)
-{
-	return 0;
-}
-
 static void sdma_v12_0_free_ucode_buffer(struct amdgpu_device *adev)
 {
 	int i;
@@ -850,7 +824,6 @@ static int sdma_v7_0_start(struct amdgpu_device *adev)
 	r = sdma_v7_0_gfx_resume(adev);
 	if (r)
 		return r;
-	r = sdma_v7_0_rlc_resume(adev);
 
 	return r;
 }
-- 
2.55.0

