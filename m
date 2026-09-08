Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60DEC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53BE910E8B0;
	Tue,  8 Sep 2026 18:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BOt2vrSX";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4359D10E8B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso61928055e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891067; x=1789495867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a40DLe9vdT7Cbap8+hBjBOANFKPprFSbtVqTHu/PdSA=;
 b=BOt2vrSXuXdoVHK01FEasscTxw+9o6ssnlTDcJB1erhwDslrJ9BH4PEOUEQyfMkzwm
 Km8vqjZdCT5ljgxPwhQSMROLoYSwQ7P4XN/Ff4fPpUDChrNRkr82kk5J2p27Cvhpkf/g
 xxV1tqs6CONVw1QqPLKmpqFGRnqvTYzmJKyT1qFnSqYRYXl2HD5k6QDy4TSJZJ7P4a5w
 ZiSlkQ82ZVBCxcRHb7VrqjyC1PiKt018dB1XzT6i5m150mvtripvdMJa6B2iK6+FsHR+
 9gHAR/Xr7D53AEq6h4QEsvnwSoOownLpFaHCeOTHwjDae0r/8L+FJtp1JZF4sgZTNHtL
 Aobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891067; x=1789495867;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a40DLe9vdT7Cbap8+hBjBOANFKPprFSbtVqTHu/PdSA=;
 b=Zz09VqAdLHxr2p4d1Qol13TrrTRthBYz4QkQdLFxUrNbShr7BJnbT4L/EoOnX+nYER
 wWgQWnmF7diifuhVOw9stMkCkqdwWaW8wkOgs6Ezd9L3LMCjpmT+eVG6TNVNn7JbrViv
 wxHtFWo5s2djxdqVjeD/Obfs6jTSn4fEHc0c09ZZh3lV1161pZyhFTe5ECOanCW2GZYp
 G/EmZZ5jjA44wflmPIo5ZPQ9sluSvbU7+QnDjE2Dn65wnoLjJzGRKJXOXFMcgv1jgT/U
 k70o2iSMEnnw6iYETMdjP82KQsiGPCJOftDxrl6IKTAmeSQa5Ayifi3AW2WKfrp4TASJ
 GV0A==
X-Gm-Message-State: AFuF++n0eiBz5Bel0J1XiFfBYkmghGKioVGAP6dwdDlhspWxIPBzr6zY
 59j2JkpgwJ3genPBav477ioWDvSr3FIlgfM7G25cofBJuqnUUhraIRkhMi+DglQO
X-Gm-Gg: AYBFou0OyyH3zm98Nknk0y+UrnY1BoQwXkgQhcZJ5ksWfKh9mplOOqrLx7OEk+q/5xW
 9sZYT2sXRnhSQRfhgk9zp6b+4b/G3ELNzSpYBwmMe+KaMqeVWGR94MpFpVV26bjoIMtu+ly2dtT
 GaHXXbqa5Jz3cd74IDfiJcjh6BRJlSrAJ0CbXGmBd7BwgHNtK66XWNWmwUHfkuhIUuSHT9yuGfB
 lxzDYcxbIF4X/Mn9k/lXd9rH49wol+yBrJ/1f3ReKwIbwkk6iq2nA7rIuP9zg/z+mGN+EtB501P
 Mm9tP64CJaMvkPQrCAxoiJXvdKSEKfXEMJY1tW90pFqHTtBp6tiDu5Zd4D634ZIrb8YYukTRCun
 dJvMbZTmcv1bpwiMFF3egazT27yumlI3/8pfJkwB3oLu62MOYFeQuw2TG3wH6ATh2lZ0crG8BC8
 QEuPM8iM6aYakyQU/U+3BbgAHVmJ/A/OFkPJVm9lfIQtIosoarcN6KTabf7PtqKxHiOntXnwm8R
 fCYW3gtvupwVgSW9/dX
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id
 5b1f17b1804b1-49cfc6cc10bmr274967005e9.26.1788891066214; 
 Tue, 08 Sep 2026 11:11:06 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:05 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/9] drm/amdgpu/sdma: Remove superfluous rlc_resume and
 rlc_stop functions
Date: Tue,  8 Sep 2026 20:10:45 +0200
Message-ID: <20260908181052.381126-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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
index 511c9dd3778d..f444207fa550 100644
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
index 657ef6c93c61..7c8acdf73d44 100644
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
index 63c94fe52b3c..e929d62721b3 100644
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
index ded1f8abfb08..bdd140887e10 100644
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
index 5212ea6c46a2..7e8d528cf422 100644
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
index a6fcef36c501..d24659a69382 100644
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
index 35cdf6c149f8..76e1f9f39525 100644
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
index 303fd7d1b7c8..52a141d0b356 100644
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
index d5552f206e4d..231bc347df2a 100644
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

